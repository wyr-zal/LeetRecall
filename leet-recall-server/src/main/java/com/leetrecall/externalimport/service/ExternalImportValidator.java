package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.leetrecall.common.enums.Language;
import com.leetrecall.externalimport.model.ExternalImportPayload;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.importdata.dto.ProblemLearningMaterialsImportDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
@RequiredArgsConstructor
public class ExternalImportValidator {
    private static final Set<String> ROOT_FIELDS = Set.of("leetcodeNumber", "noteMarkdown", "coreIdea", "hint", "mistakes",
            "fullCode", "keyCode", "recallQuestions", "dictation");
    private static final Set<String> PROTECTED_OFFICIAL_FIELDS = Set.of("title", "difficulty", "descriptionMarkdown", "tags", "officialTags");
    private static final Set<String> QUESTION_FIELDS = Set.of("question", "answer");
    private static final Set<String> DICTATION_FIELDS = Set.of("language", "templateCode", "answers", "keywords");
    private static final Pattern BLANK_PATTERN = Pattern.compile("\\{\\{([a-z][a-z0-9_]*)}}");
    private static final Pattern CLASS_PATTERN = Pattern.compile("\\bclass\\s+([A-Za-z_$][A-Za-z0-9_$]*)");
    private static final Pattern METHOD_PATTERN = Pattern.compile("\\bpublic\\s+(?:static\\s+)?(?:<[^>]+>\\s*)?[A-Za-z_$][A-Za-z0-9_$<>\\[\\], ?]*\\s+([A-Za-z_$][A-Za-z0-9_$]*)\\s*\\(([^)]*)\\)");
    private static final Pattern FENCE_PATTERN = Pattern.compile("^\\s{0,3}(`{3,}|~{3,})(.*)$");
    private static final int MAX_NOTE_LENGTH = 100_000;

    private final ObjectMapper objectMapper;
    private final JavaCompileService javaCompileService;

    public ValidationResult validateRaw(String raw, Hot100Manifest.Hot100Problem expected, Hot100OfficialSource.OfficialProblem official) {
        List<String> errors = new ArrayList<>();
        if (raw == null || raw.isBlank()) {
            return new ValidationResult(null, List.of("JSON 内容为空：请粘贴或选择一个 JSON 文件"), false, "");
        }
        String stripped = raw.strip();
        if (stripped.startsWith("```") || stripped.startsWith("~~~")) {
            return new ValidationResult(null, List.of("JSON 第 1 行：检测到 Markdown 代码围栏；请删除开头和结尾的 ```json / ```，只保留 { ... }"), false, "");
        }
        if (!stripped.startsWith("{")) {
            return new ValidationResult(null, List.of("JSON 根节点必须是对象：首个非空字符应为 {，实际为 “" + stripped.charAt(0) + "”"), false, "");
        }
        try {
            JsonNode root = objectMapper.reader()
                    .with(DeserializationFeature.FAIL_ON_TRAILING_TOKENS)
                    .readTree(raw);
            if (root == null || !root.isObject()) {
                return new ValidationResult(null, List.of("JSON 根节点必须是对象 { ... }"), false, "");
            }
            for (String field : PROTECTED_OFFICIAL_FIELDS) {
                if (root.has(field)) {
                    errors.add(field + "：属于官方题目资料，禁止通过外部导入修改；只需提供 leetcodeNumber 和学习资料字段");
                }
            }
            ExternalImportPayload payload = objectMapper.readerFor(ExternalImportPayload.class)
                    .with(DeserializationFeature.FAIL_ON_TRAILING_TOKENS)
                    .without(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
                    .readValue(root);
            return validate(payload, errors, expected, official);
        } catch (java.io.IOException exception) {
            String message = exception instanceof JsonProcessingException jsonException
                    ? jsonError(jsonException)
                    : "JSON 读取失败：" + exception.getMessage();
            return new ValidationResult(null, List.of(message), false, "");
        }
    }

    public ValidationResult validate(ExternalImportPayload payload, Hot100Manifest.Hot100Problem expected,
                                     Hot100OfficialSource.OfficialProblem official) {
        return validate(payload, new ArrayList<>(), expected, official);
    }

    /** 草稿只保留导入白名单字段，额外字段会被忽略且不会进入数据库。 */
    public String sanitizeForStorage(String raw) {
        if (raw == null || raw.isBlank()) return null;
        try {
            JsonNode root = objectMapper.readTree(raw);
            if (!(root instanceof ObjectNode source)) return null;
            ObjectNode sanitized = objectMapper.createObjectNode();
            copyFields(source, sanitized, ROOT_FIELDS.stream()
                    .filter(field -> !"recallQuestions".equals(field) && !"dictation".equals(field))
                    .collect(java.util.stream.Collectors.toSet()));

            JsonNode questions = source.get("recallQuestions");
            if (questions instanceof ArrayNode questionArray) {
                ArrayNode sanitizedQuestions = sanitized.putArray("recallQuestions");
                for (JsonNode question : questionArray) {
                    if (question instanceof ObjectNode questionObject) {
                        ObjectNode sanitizedQuestion = sanitizedQuestions.addObject();
                        copyFields(questionObject, sanitizedQuestion, QUESTION_FIELDS);
                    }
                }
            }
            JsonNode dictation = source.get("dictation");
            if (dictation instanceof ObjectNode dictationObject) {
                ObjectNode sanitizedDictation = sanitized.putObject("dictation");
                copyFields(dictationObject, sanitizedDictation, DICTATION_FIELDS);
            }
            return objectMapper.writeValueAsString(sanitized);
        } catch (JsonProcessingException exception) {
            return null;
        }
    }

    private ValidationResult validate(ExternalImportPayload payload, List<String> errors,
                                      Hot100Manifest.Hot100Problem expected, Hot100OfficialSource.OfficialProblem official) {
        if (payload == null) return new ValidationResult(null, List.of("缺少 JSON 内容"), false, "");
        if (!Integer.valueOf(expected.leetcodeNumber()).equals(payload.leetcodeNumber())) {
            errors.add("leetcodeNumber：必须为 " + expected.leetcodeNumber() + "，实际为 " + displayValue(payload.leetcodeNumber()));
        }
        validateNoteMarkdown(payload.noteMarkdown(), errors);
        required(payload.coreIdea(), "缺少核心思路", errors);
        required(payload.hint(), "缺少提示", errors);
        validateTextList(payload.mistakes(), 500, "mistakes", errors);
        required(payload.fullCode(), "缺少完整 Java 代码", errors);
        required(payload.keyCode(), "缺少关键代码", errors);
        if (!blank(payload.fullCode()) && containsDisallowedTopLevelDeclaration(payload.fullCode())) {
            errors.add("fullCode：不能包含 package 或 native 声明");
        }
        validateQuestions(payload.recallQuestions(), errors);
        validateDictation(payload, errors);
        validateSignature(payload.fullCode(), official.javaStarterCode(), errors);
        JavaCompileService.CompileResult compileResult = blank(payload.fullCode())
                ? new JavaCompileService.CompileResult(false, "完整 Java 代码为空")
                : javaCompileService.compile(payload.fullCode());
        if (!compileResult.passed()) errors.add("Java 21 编译未通过" + (compileResult.output().isBlank() ? "" : "：" + compileResult.output()));
        return new ValidationResult(payload, List.copyOf(errors), compileResult.passed(), compileResult.output());
    }

    public ProblemLearningMaterialsImportDTO toLearningMaterials(ExternalImportPayload payload) {
        return new ProblemLearningMaterialsImportDTO(
                payload.leetcodeNumber(),
                payload.noteMarkdown(),
                payload.coreIdea(),
                payload.hint(),
                payload.mistakes(),
                payload.fullCode(),
                payload.keyCode(),
                payload.recallQuestions().stream()
                        .map(question -> new ProblemLearningMaterialsImportDTO.RecallQuestion(question.question(), question.answer()))
                        .toList(),
                payload.dictation().templateCode(),
                payload.dictation().answers(),
                payload.dictation().keywords()
        );
    }

    private void copyFields(ObjectNode source, ObjectNode target, Set<String> allowed) {
        for (String field : allowed) {
            JsonNode value = source.get(field);
            if (value != null) target.set(field, value);
        }
    }

    private void validateQuestions(List<ExternalImportPayload.RecallQuestion> questions, List<String> errors) {
        if (questions == null || questions.isEmpty()) {
            errors.add("recallQuestions：至少需要 1 组问答，否则回忆复习页面没有可展示内容");
            return;
        }
        if (questions.size() > 5) {
            errors.add("recallQuestions：最多 5 组，当前 " + questions.size() + " 组；快速复习页编辑保存同样最多支持 5 组");
        }
        for (int index = 0; index < questions.size(); index++) {
            ExternalImportPayload.RecallQuestion question = questions.get(index);
            int number = index + 1;
            if (question == null) {
                errors.add("recallQuestions[" + index + "]：必须是包含 question 和 answer 的对象");
                continue;
            }
            if (blank(question.question())) errors.add("第 " + number + " 组回忆问答：question 不能为空");
            if (blank(question.answer())) errors.add("第 " + number + " 组回忆问答：answer 不能为空");
            if (blank(question.question()) || blank(question.answer())) continue;
            if (question.question().length() > 500) errors.add("第 " + number + " 组回忆问答：question 当前 " + question.question().length() + " 字，数据库最多保存 500 字");
        }
    }

    private void validateDictation(ExternalImportPayload payload, List<String> errors) {
        ExternalImportPayload.Dictation dictation = payload.dictation();
        if (dictation == null) { errors.add("dictation：缺少默写内容对象"); return; }
        if (!Language.JAVA.name().equals(dictation.language())) errors.add("dictation.language：必须为 JAVA，实际为 " + displayValue(dictation.language()));
        if (blank(dictation.templateCode())) errors.add("dictation.templateCode：不能为空");
        if (dictation.answers() == null) errors.add("dictation.answers：不能为空");
        if (blank(dictation.templateCode()) || dictation.answers() == null) return;
        Matcher matcher = BLANK_PATTERN.matcher(dictation.templateCode());
        Set<String> keys = new LinkedHashSet<>();
        int count = 0;
        while (matcher.find()) {
            count++;
            if (!keys.add(matcher.group(1))) errors.add("dictation.templateCode：占位符 {{" + matcher.group(1) + "}} 重复出现，每个空位只能出现一次");
        }
        if (count == 0) errors.add("dictation.templateCode：没有识别到 {{blank_1}} 形式的默写空位");
        if (!keys.equals(dictation.answers().keySet())) {
            Set<String> missing = new LinkedHashSet<>(keys);
            missing.removeAll(dictation.answers().keySet());
            Set<String> extra = new LinkedHashSet<>(dictation.answers().keySet());
            extra.removeAll(keys);
            errors.add("dictation.answers：键与模板空位不一致"
                    + (missing.isEmpty() ? "" : "，缺少 " + formatBlankKeys(missing))
                    + (extra.isEmpty() ? "" : "，多出 " + formatBlankKeys(extra)));
        }
        for (Map.Entry<String, String> entry : dictation.answers().entrySet()) {
            if (blank(entry.getKey())) errors.add("dictation.answers：不能包含空键名");
            else if (blank(entry.getValue())) errors.add("dictation.answers." + entry.getKey() + "：答案不能为空");
        }
        validateTextList(dictation.keywords(), 50, "dictation.keywords", errors);
        String restored = dictation.templateCode();
        for (String key : keys) {
            String answer = dictation.answers().get(key);
            if (answer != null) restored = restored.replace("{{" + key + "}}", answer);
        }
        if (!restored.equals(payload.fullCode())) {
            int difference = firstDifference(restored, payload.fullCode());
            errors.add("dictation：答案回填后与 fullCode 不一致，首个差异位于 " + lineAndColumn(restored, difference));
        }
    }

    private void validateSignature(String fullCode, String starterCode, List<String> errors) {
        if (blank(fullCode) || blank(starterCode)) return;
        String starter = stripComments(starterCode);
        String source = stripComments(fullCode);
        Matcher classMatcher = CLASS_PATTERN.matcher(starter);
        if (!classMatcher.find()) return;
        String className = classMatcher.group(1);
        if (!Pattern.compile("\\bclass\\s+" + Pattern.quote(className) + "\\b").matcher(source).find()) {
            errors.add("完整代码必须包含官方类名 " + className);
            return;
        }
        String starterBody = classBody(starter, className);
        String sourceBody = classBody(source, className);
        for (String expectedSignature : methodSignatures(starterBody)) {
            if (!methodSignatures(sourceBody).contains(expectedSignature)) {
                errors.add("完整代码缺少或修改了官方 public 方法签名：" + expectedSignature);
            }
        }
        for (String expectedConstructor : constructorSignatures(starterBody, className)) {
            if (!constructorSignatures(sourceBody, className).contains(expectedConstructor)) {
                errors.add("完整代码缺少或修改了官方构造器签名：" + expectedConstructor);
            }
        }
    }

    private Set<String> methodSignatures(String classBody) {
        Set<String> signatures = new LinkedHashSet<>();
        String structuralCode = stripComments(classBody);
        Matcher matcher = METHOD_PATTERN.matcher(structuralCode);
        while (matcher.find()) {
            if (braceDepthAt(structuralCode, matcher.start()) == 0) signatures.add(normalizeSignature(matcher.group()));
        }
        return signatures;
    }

    private Set<String> constructorSignatures(String classBody, String className) {
        Set<String> signatures = new LinkedHashSet<>();
        String structuralCode = stripComments(classBody);
        Matcher matcher = Pattern.compile("\\bpublic\\s+" + Pattern.quote(className) + "\\s*\\(([^)]*)\\)").matcher(structuralCode);
        while (matcher.find()) {
            if (braceDepthAt(structuralCode, matcher.start()) == 0) signatures.add(normalizeSignature(matcher.group()));
        }
        return signatures;
    }

    private int braceDepthAt(String code, int endExclusive) {
        int depth = 0;
        for (int index = 0; index < endExclusive; index++) {
            if (code.charAt(index) == '{') depth++;
            if (code.charAt(index) == '}') depth--;
        }
        return depth;
    }

    private String classBody(String code, String className) {
        Matcher classMatcher = Pattern.compile("\\bclass\\s+" + Pattern.quote(className) + "\\b").matcher(code);
        if (!classMatcher.find()) return "";
        int openingBrace = code.indexOf('{', classMatcher.end());
        if (openingBrace < 0) return "";
        String structuralCode = stripComments(code);
        int depth = 0;
        for (int index = openingBrace; index < code.length(); index++) {
            char current = structuralCode.charAt(index);
            if (current == '{') depth++;
            if (current == '}' && --depth == 0) return code.substring(openingBrace + 1, index);
        }
        return "";
    }

    private String normalizeSignature(String signature) {
        return signature.replaceAll("\\s+", "");
    }

    private boolean containsDisallowedTopLevelDeclaration(String code) {
        String withoutCommentsAndStrings = stripComments(code).replaceAll("\"(?:\\\\.|[^\"])*\"", "");
        return Pattern.compile("(?m)^\\s*package\\s+|\\bnative\\b").matcher(withoutCommentsAndStrings).find();
    }

    private void validateTextList(List<String> values, int maxLength, String name, List<String> errors) {
        if (values == null) return;
        for (int index = 0; index < values.size(); index++) {
            String value = values.get(index);
            if (blank(value)) errors.add(name + "[" + index + "]：不能为空");
            else if (value.length() > maxLength) {
                errors.add(name + "[" + index + "]：当前 " + value.length() + " 字，数据库最多保存 " + maxLength + " 字");
            }
        }
    }

    private void required(String value, String error, List<String> errors) { if (blank(value)) errors.add(error); }
    private boolean blank(String value) { return value == null || value.isBlank(); }
    private String jsonError(JsonProcessingException exception) {
        String location = exception.getLocation() == null
                ? ""
                : "第 " + exception.getLocation().getLineNr() + " 行第 " + exception.getLocation().getColumnNr() + " 列：";
        String path = exception instanceof JsonMappingException mapping && !mapping.getPath().isEmpty()
                ? mapping.getPath().stream()
                        .map(reference -> reference.getFieldName() != null ? reference.getFieldName() : "[" + reference.getIndex() + "]")
                        .collect(java.util.stream.Collectors.joining("."))
                : "";
        String detail = exception.getOriginalMessage();
        if (!path.isBlank()) return "JSON 字段 " + path + " 类型不正确：" + detail;
        return "JSON " + location + detail;
    }

    /** 笔记是可选字段：缺省或全空白视为不导入笔记，只在有内容时按 Markdown 校验。 */
    private void validateNoteMarkdown(String markdown, List<String> errors) {
        if (blank(markdown)) return;
        if (markdown.length() > MAX_NOTE_LENGTH) {
            errors.add("noteMarkdown：当前 " + markdown.length() + " 字，最多允许 " + MAX_NOTE_LENGTH + " 字");
        }
        validateMarkdownFence(markdown, "noteMarkdown", errors);
    }

    private void validateMarkdownFence(String markdown, String field, List<String> errors) {
        String[] lines = markdown.replace("\r\n", "\n").split("\n", -1);
        Character openingCharacter = null;
        int openingLength = 0;
        int openingLine = 0;
        String openingMarker = null;
        for (int index = 0; index < lines.length; index++) {
            Matcher fence = FENCE_PATTERN.matcher(lines[index]);
            if (!fence.matches()) continue;
            String marker = fence.group(1);
            String suffix = fence.group(2);
            if (openingCharacter == null) {
                openingCharacter = marker.charAt(0);
                openingLength = marker.length();
                openingLine = index + 1;
                openingMarker = marker;
            } else if (marker.charAt(0) == openingCharacter && marker.length() >= openingLength && suffix.isBlank()) {
                openingCharacter = null;
                openingLength = 0;
                openingLine = 0;
                openingMarker = null;
            }
        }
        if (openingCharacter != null) {
            errors.add(field + " 第 " + openingLine + " 行：代码围栏 " + openingMarker + " 未闭合，请在代码块末尾补上同类型围栏");
        }
    }

    private int firstDifference(String left, String right) {
        if (left == null || right == null) return 0;
        int limit = Math.min(left.length(), right.length());
        for (int index = 0; index < limit; index++) if (left.charAt(index) != right.charAt(index)) return index;
        return limit;
    }

    private String lineAndColumn(String text, int index) {
        if (text == null) return "第 1 行第 1 列";
        int line = 1;
        int column = 1;
        for (int current = 0; current < Math.min(index, text.length()); current++) {
            if (text.charAt(current) == '\n') { line++; column = 1; }
            else column++;
        }
        return "第 " + line + " 行第 " + column + " 列";
    }

    private String formatBlankKeys(Set<String> keys) {
        return keys.stream().map(key -> "{{" + key + "}}").collect(java.util.stream.Collectors.joining("、"));
    }

    private String displayValue(Object value) {
        if (value == null) return "（缺失）";
        String text = value.toString();
        if (text.length() > 80) text = text.substring(0, 77) + "...";
        return "“" + text + "”";
    }

    /**
     * 结构校验不需要字符串或字符字面量的内容；逐字符屏蔽它们，避免把 URL 的 //
     * 或字符常量中的大括号误解为注释和代码块边界。
     */
    private String stripComments(String code) {
        StringBuilder sanitized = new StringBuilder(code.length());
        boolean lineComment = false;
        boolean blockComment = false;
        boolean stringLiteral = false;
        boolean charLiteral = false;
        for (int index = 0; index < code.length(); index++) {
            char current = code.charAt(index);
            char next = index + 1 < code.length() ? code.charAt(index + 1) : '\0';
            if (lineComment) {
                if (current == '\n') { lineComment = false; sanitized.append(current); }
                else sanitized.append(' ');
                continue;
            }
            if (blockComment) {
                if (current == '*' && next == '/') { blockComment = false; sanitized.append("  "); index++; }
                else sanitized.append(current == '\n' ? '\n' : ' ');
                continue;
            }
            if (stringLiteral || charLiteral) {
                char delimiter = stringLiteral ? '"' : '\'';
                if (current == '\\' && index + 1 < code.length()) { sanitized.append("  "); index++; continue; }
                if (current == delimiter) {
                    sanitized.append(delimiter);
                    stringLiteral = false;
                    charLiteral = false;
                } else sanitized.append(current == '\n' ? '\n' : ' ');
                continue;
            }
            if (current == '/' && next == '/') { lineComment = true; sanitized.append("  "); index++; continue; }
            if (current == '/' && next == '*') { blockComment = true; sanitized.append("  "); index++; continue; }
            if (current == '"') { stringLiteral = true; sanitized.append(current); continue; }
            if (current == '\'') { charLiteral = true; sanitized.append(current); continue; }
            sanitized.append(current);
        }
        return sanitized.toString();
    }

    public record ValidationResult(ExternalImportPayload payload, List<String> errors, boolean compilePassed, String compileOutput) {
        public boolean ready() { return payload != null && errors.isEmpty() && compilePassed; }
    }
}
