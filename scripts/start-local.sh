#!/usr/bin/env bash
# 在 WSL/Linux 中一键启动 LeetRecall 本地完整环境。

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
compose_file="$project_root/deploy/docker-compose.yml"
env_file="$project_root/.env"
compose_file_arg="$compose_file"
env_file_arg="$env_file"
web_source_hash_file="$project_root/.leetrecall-state/web-source.sha256"
server_source_hash_file="$project_root/.leetrecall-state/server-source.sha256"

log() {
  printf '[LeetRecall] %s\n' "$*"
}

fail() {
  printf '[LeetRecall] 错误：%s\n' "$*" >&2
  exit 1
}

docker_ready() {
  if command -v timeout >/dev/null 2>&1; then
    timeout 15s "$@" info >/dev/null 2>&1
  else
    "$@" info >/dev/null 2>&1
  fi
}

using_windows_docker=false
windows_docker='/mnt/c/Program Files/Docker/Docker/resources/bin/docker.exe'

if [[ -x /init && -x "$windows_docker" ]] && docker_ready /init "$windows_docker" docker; then
  docker_command=(/init "$windows_docker" docker)
  compose_file_arg="$(wslpath -w "$compose_file")"
  env_file_arg="$(wslpath -w "$env_file")"
  using_windows_docker=true
  log '已连接 Docker Desktop CLI。'
elif command -v docker >/dev/null 2>&1 && docker_ready docker; then
  docker_command=(docker)
else
  fail '无法连接 Docker daemon。请确认 Docker Desktop 已启动且已启用 WSL Integration。'
fi

if "${docker_command[@]}" compose version >/dev/null 2>&1; then
  compose_command=("${docker_command[@]}" compose)
elif [[ "$using_windows_docker" == false ]] && command -v docker-compose >/dev/null 2>&1; then
  compose_command=(docker-compose)
else
  fail '未找到 docker compose 或 docker-compose。'
fi

if [[ ! -f "$env_file" ]]; then
  cp "$project_root/.env.example" "$env_file"
  chmod 600 "$env_file"
  log '已从 .env.example 创建 .env，请在方便时修改其中的数据库密码。'
fi

compose() {
  "${compose_command[@]}" --env-file "$env_file_arg" -f "$compose_file_arg" "$@"
}

compose_with_ports() {
  local server_port="$1"
  local web_port="$2"
  local app_port="$3"
  local shared_env="${WSLENV:-}"
  local variable
  local -a env_command=(env "SERVER_PORT=$server_port" "WEB_PORT=$web_port" "APP_PORT=$app_port")
  shift 3

  if [[ "$using_windows_docker" == true ]]; then
    for variable in SERVER_PORT WEB_PORT APP_PORT; do
      if [[ ":$shared_env:" != *":$variable:"* ]]; then
        shared_env="${shared_env:+${shared_env}:}${variable}"
      fi
    done
    env_command+=("WSLENV=$shared_env")
  fi

  "${env_command[@]}" "${compose_command[@]}" \
    --env-file "$env_file_arg" -f "$compose_file_arg" "$@"
}

env_value() {
  local key="$1"
  awk -F '=' -v key="$key" '$1 == key {sub(/^[^=]*=/, ""); sub(/\r$/, ""); print; exit}' "$env_file"
}

valid_port() {
  [[ "$1" =~ ^[1-9][0-9]{0,4}$ ]] && (( "$1" <= 65535 ))
}

port_in_use() {
  command -v ss >/dev/null 2>&1 || return 1
  ss -H -ltn "sport = :$1" 2>/dev/null | grep -q .
}

available_port() {
  local candidate="$1"
  while port_in_use "$candidate"; do
    candidate=$((candidate + 1))
    (( candidate <= 65535 )) || fail '没有可用的本地端口。'
  done
  printf '%s' "$candidate"
}

web_source_hash() {
  command -v sha256sum >/dev/null 2>&1 || return 1
  (
    cd "$project_root/leet-recall-web"
    find . \
      \( -path './node_modules' -o -path './dist' -o -path './coverage' \
      -o -path './.git' -o -path './.idea' -o -path './.vscode' \) -prune -o \
      -type f ! -name '*.log' \
      -print0 |
      sort -z |
      xargs -0 sha256sum |
      sha256sum |
      awk '{print $1}'
  )
}

record_web_source_hash() {
  local source_hash="$1"
  [[ -n "$source_hash" ]] || return 0
  mkdir -p "$(dirname "$web_source_hash_file")"
  printf '%s\n' "$source_hash" >"$web_source_hash_file"
}

server_source_hash() {
  command -v sha256sum >/dev/null 2>&1 || return 1
  (
    cd "$project_root/leet-recall-server"
    find . \
      \( -path './target' -o -path './.git' -o -path './.idea' -o -path './.vscode' \) -prune -o \
      -type f ! -name '*.log' \
      -print0 |
      sort -z |
      xargs -0 sha256sum |
      sha256sum |
      awk '{print $1}'
  )
}

record_server_source_hash() {
  local source_hash="$1"
  [[ -n "$source_hash" ]] || return 0
  mkdir -p "$(dirname "$server_source_hash_file")"
  printf '%s\n' "$source_hash" >"$server_source_hash_file"
}

read_recorded_hash() {
  local hash_file="$1"
  [[ -f "$hash_file" ]] || return 0
  tr -d '\r\n' <"$hash_file"
}

wait_for_api() {
  local app_port="$1"
  local app_url="http://127.0.0.1:${app_port}"

  if ! command -v curl >/dev/null 2>&1; then
    log "服务已提交启动，未安装 curl，无法自动健康检查：${app_url}"
    return 0
  fi

  for attempt in $(seq 1 60); do
    if curl --noproxy '*' --connect-timeout 2 --max-time 3 -fsS \
      "${app_url}/api/reviews/today" -o /dev/null; then
      log "启动完成：${app_url}"
      return 0
    fi
    sleep 1
  done

  compose logs --tail=100 server nginx >&2 || true
  fail "服务在 60 秒内未就绪，请检查上方日志。"
}

show_result() {
  local app_port="$1"
  log "应用入口：http://127.0.0.1:${app_port}"
  log "查看状态：${compose_command[*]} --env-file .env -f deploy/docker-compose.yml ps"
  log "查看日志：${compose_command[*]} --env-file .env -f deploy/docker-compose.yml logs -f"
}

published_port() {
  local service="$1"
  local container_port="$2"
  local container_id

  container_id="$(compose ps -q "$service" 2>/dev/null || true)"
  [[ -n "$container_id" ]] || return 1
  "${docker_command[@]}" port "$container_id" "${container_port}/tcp" 2>/dev/null |
    awk -F ':' 'NR == 1 {print $NF}'
}

# 运行中的实例可能使用了自动避让端口。保留这些端口并重建变化的服务，
# 避免源码更新后仍由旧容器提供页面或接口。
running_nginx_id="$(compose ps -q nginx 2>/dev/null || true)"
if [[ -n "$running_nginx_id" ]] && [[ "$("${docker_command[@]}" inspect -f '{{.State.Running}}' "$running_nginx_id" 2>/dev/null || true)" == 'true' ]]; then
  existing_server_port="$(published_port server 8080 || true)"
  existing_web_port="$(published_port web 80 || true)"
  existing_app_port="$(published_port nginx 80 || true)"

  if valid_port "$existing_server_port" && valid_port "$existing_web_port" && valid_port "$existing_app_port"; then
    current_web_source_hash="$(web_source_hash || true)"
    recorded_web_source_hash="$(read_recorded_hash "$web_source_hash_file")"
    current_server_source_hash="$(server_source_hash || true)"
    recorded_server_source_hash="$(read_recorded_hash "$server_source_hash_file")"
    services_to_update=()

    if [[ -z "$current_server_source_hash" ]] || [[ "$current_server_source_hash" != "$recorded_server_source_hash" ]]; then
      services_to_update+=(server)
    fi
    if [[ -z "$current_web_source_hash" ]] || [[ "$current_web_source_hash" != "$recorded_web_source_hash" ]]; then
      services_to_update+=(web)
    fi

    if (( ${#services_to_update[@]} == 0 )); then
      log '检测到已运行的 LeetRecall 实例，前后端源码均未变化，复用当前容器。'
    else
      log "检测到源码变化，正在保留当前端口并更新：${services_to_update[*]}…"
      compose_with_ports "$existing_server_port" "$existing_web_port" "$existing_app_port" \
        build "${services_to_update[@]}"
      compose_with_ports "$existing_server_port" "$existing_web_port" "$existing_app_port" \
        up -d --no-deps "${services_to_update[@]}"

      if [[ " ${services_to_update[*]} " == *' server '* ]]; then
        record_server_source_hash "$current_server_source_hash"
      fi
      if [[ " ${services_to_update[*]} " == *' web '* ]]; then
        record_web_source_hash "$current_web_source_hash"
      fi

      # 重新创建 Nginx 可同时刷新 web 容器地址与跨 WSL/Windows 的绑定挂载。
      compose_with_ports "$existing_server_port" "$existing_web_port" "$existing_app_port" \
        up -d --no-deps --force-recreate nginx
    fi

    wait_for_api "$existing_app_port"
    show_result "$existing_app_port"
    exit 0
  fi

  fail '检测到运行中的实例，但无法读取完整端口映射。请执行 docker compose ps 后重试。'
fi

requested_server_port="${SERVER_PORT:-$(env_value SERVER_PORT)}"
requested_web_port="${WEB_PORT:-$(env_value WEB_PORT)}"
requested_app_port="${APP_PORT:-$(env_value APP_PORT)}"

valid_port "$requested_server_port" || requested_server_port=8080
valid_port "$requested_web_port" || requested_web_port=5173
valid_port "$requested_app_port" || requested_app_port=8088

server_port="$(available_port "$requested_server_port")"
web_port="$(available_port "$requested_web_port")"
app_port="$(available_port "$requested_app_port")"

for port_setting in SERVER_PORT WEB_PORT APP_PORT; do
  requested_name="requested_${port_setting,,}"
  selected_name="${port_setting,,}"
  if [[ "${!requested_name}" != "${!selected_name}" ]]; then
    log "${port_setting}=${!requested_name} 已占用，本次临时使用 ${!selected_name}。"
  fi
done

log '正在构建并启动 MySQL、后端、前端和 Nginx…'
compose_with_ports "$server_port" "$web_port" "$app_port" up -d --build
record_server_source_hash "$(server_source_hash || true)"
record_web_source_hash "$(web_source_hash || true)"

wait_for_api "$app_port"
show_result "$app_port"
