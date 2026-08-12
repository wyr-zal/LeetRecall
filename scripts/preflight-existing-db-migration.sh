#!/usr/bin/env bash
# Safely adopt a legacy LeetRecall MySQL database into Flyway before V2 runs.
# Default mode is read-only except for a timestamped mysqldump backup.

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
env_file="$project_root/.env"
compose_file="$project_root/deploy/docker-compose.yml"
backup_dir="$project_root/backups/$(date +%Y%m%d-%H%M%S)-before-flyway"

fail() { printf '[LeetRecall] 错误：%s\n' "$*" >&2; exit 1; }
log() { printf '[LeetRecall] %s\n' "$*"; }

[[ -f "$env_file" ]] || fail '找不到 .env；请先执行 scripts/start-local.sh 一次，或从 .env.example 创建。'
command -v docker >/dev/null 2>&1 || fail '未找到 Docker。'
docker info >/dev/null 2>&1 || fail '无法连接 Docker daemon。'

if docker compose version >/dev/null 2>&1; then
  compose_command=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  compose_command=(docker-compose)
else
  fail '未找到 docker compose 或 docker-compose。'
fi

env_value() { awk -F '=' -v key="$1" '$1 == key {sub(/^[^=]*=/, ""); sub(/\r$/, ""); print; exit}' "$env_file"; }
mysql_database="$(env_value MYSQL_DATABASE)"
mysql_user="$(env_value MYSQL_USER)"
mysql_password="$(env_value MYSQL_PASSWORD)"
[[ -n "$mysql_database" && -n "$mysql_user" && -n "$mysql_password" ]] || fail '.env 中缺少 MySQL 配置。'

compose() { "${compose_command[@]}" --env-file "$env_file" -f "$compose_file" "$@"; }
mysql_query() { compose exec -T mysql mysql -u"$mysql_user" -p"$mysql_password" -Nse "$1" "$mysql_database"; }

required_tables=(problem tag problem_tag recall_question problem_mistake problem_progress review_record dictation_template dictation_record dictation_answer_view)
for table in "${required_tables[@]}"; do
  found="$(mysql_query "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = '$table';")"
  [[ "$found" == '1' ]] || fail "数据库结构不兼容：缺少 $table。不会执行 Flyway 基线。"
done

history_exists="$(mysql_query "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'flyway_schema_history';")"
if [[ "$history_exists" != '0' ]]; then
  fail '已存在 flyway_schema_history；请先检查现有迁移状态，脚本不会覆盖。'
fi

problem_count="$(mysql_query 'SELECT COUNT(*) FROM problem;')"
mkdir -p "$backup_dir"
backup_file="$backup_dir/${mysql_database}.sql"
log "结构检查通过，当前 problem 行数：$problem_count。正在创建备份：${backup_file#$project_root/}"
compose exec -T mysql mysqldump -u"$mysql_user" -p"$mysql_password" --single-transaction --routines --events --no-tablespaces "$mysql_database" > "$backup_file"
[[ -s "$backup_file" ]] || fail '备份文件为空，停止后续操作。'
grep -q '^CREATE TABLE `problem`' "$backup_file" || fail '备份中没有 problem 表定义，停止后续操作。'
log '备份完成。当前没有改动数据库。'

if [[ "${1:-}" == '--apply' ]]; then
  log '开始以 1.2 为基线启动服务；Flyway 只会执行 V2 及后续迁移。'
  FLYWAY_BASELINE_ON_MIGRATE=true compose up -d --build server
  log '已提交启动。请执行 docker compose logs -f server 确认 Flyway 成功。'
else
  log '如确认备份可用，执行：scripts/preflight-existing-db-migration.sh --apply'
fi
