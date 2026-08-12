package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.leetrecall.common.enums.Language;
import com.leetrecall.externalimport.model.ExternalImportPayload;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.importdata.dto.ProblemCreateDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
@RequiredArgsConstructor
public class ExternalImportValidator {
    private static final Set<String> ROOT_FIELDS = Set.of("leetcodeNumber", "title", "difficulty", "descriptionMarkdown", "tags",
            "coreIdea", "hint", "mistakes", "fullCode", "keyCode", "recallQuestions", "dictation");
    private static final Set<String> QUESTION_FIELDS = Set.of("question", "answer");
    private static final Set<String> DICTATION_FIELDS = Set.of("language", "templateCode", "answers", "keywords");
    private static final Set<String> FORBIDDEN_FIELDS = Set.of("sourceRefs", "sourceTrace", "sourceAssociations", "provider", "model",
            "prompt", "sourceUrl", "solutionUrl", "referenceUrls", "author", "platform");
    private static final Pattern BLANK_PATTERN = Pattern.compile("\\{\\{([a-z][a-z0-9_]*)}}");
    private static final Pattern CLASS_PATTERN = Pattern.compile("\\bclass\\s+([A-Za-z_$][A-Za-z0-9_$]*)");
    private static final Pattern METHOD_PATTERN = Pattern.compile("\\bpublic\\s+(?:static\\s+)?(?:<[^>]+>\\s*)?[A-Za-z_$][A-Za-z0-9_$<>\\[\\], ?]*\\s+([A-Za-z_$][A-Za-z0-9_$]*)\\s*\\(([^)]*)\\)");
    private static final Set<String> GENERIC_QUESTIONS = Set.of("这题怎么做", "这题的核心思路是什么", "本题的核心思路是什么", "时间复杂度是多少", "有什么易错点", "这题难点是什么");

    private final ObjectMapper objectMapper;
    private final JavaCompileService javaCompileService;

    public ValidationResult validateRaw(String raw, Hot100Manifest.Hot100Problem expected, Hot100OfficialSource.OfficialProblem official) {
        return validateRaw(raw, expected, official, Set.of());
    }

    public ValidationResult validateRaw(String raw, Hot100Manifest.Hot100Problem expected,
                                        Hot100OfficialSource.OfficialProblem official, Set<String> otherQuestionKeys) {
        List<String> errors = new ArrayList<>();
        if (raw == null || raw.isBlank() || !raw.strip().startsWith("{") || raw.strip().startsWith("```")) {
            return new ValidationResult(null, List.of("只接受纯 JSON 对象，不能包含 Markdown 代码围栏或说明文字"), false, "");
        }
        try {
            JsonNode root = objectMapper.readTree(raw);
            validateShape(root, errors);
            ExternalImportPayload payload = objectMapper.readerFor(ExternalImportPayload.class)
                    .without(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES)
                    .readValue(root);
            return validate(payload, errors, expected, official, otherQuestionKeys);
        } catch (Exception exception) {
            return new ValidationResult(null, List.of("JSON 格式不合法或字段类型不正确"), false, "");
        }
    }

    public ValidationResult validate(ExternalImportPayload payload, Hot100Manifest.Hot100Problem expected,
                                     Hot100OfficialSource.OfficialProblem official) {
        return validate(payload, new ArrayList<>(), expected, official, Set.of());
    }

    /**
     * 草稿只保留格式白名单内的数据。字段非法时仍会在本次校验响应中报告，
     * 但来源、模型、提示词等值不会进入数据库。
     */
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
                                      Hot100Manifest.Hot100Problem expected, Hot100OfficialSource.OfficialProblem official,
                                      Set<String> otherQuestionKeys) {
        if (payload == null) return new ValidationResult(null, List.of("缺少 JSON 内容"), false, "");
        if (!Integer.valueOf(expected.leetcodeNumber()).equals(payload.leetcodeNumber())) errors.add("题号必须与所选 Hot100 题目一致");
        if (!expected.title().equals(payload.title())) errors.add("题目标题必须与所选 Hot100 题目一致");
        if (expected.difficulty() != payload.difficulty()) errors.add("题目难度必须与所选 Hot100 题目一致");
        if (!sameText(official.descriptionMarkdown(), payload.descriptionMarkdown())) errors.add("题目描述必须原样使用系统任务包中的中文题面");
        listSize(payload.tags(), 1, 10, "标签", errors);
        required(payload.coreIdea(), "缺少核心思路", errors);
        required(payload.hint(), "缺少提示", errors);
        if (payload.hint() != null && payload.hint().length() > 100) errors.add("提示不能超过 100 个字符");
        listSize(payload.mistakes(), 2, 4, "易错点", errors);
        listText(payload.mistakes(), 6, 500, "易错点", errors);
        required(payload.fullCode(), "缺少完整 Java 代码", errors);
        required(payload.keyCode(), "缺少关键代码", errors);
        if (!blank(payload.fullCode()) && !blank(payload.keyCode()) && !payload.fullCode().contains(payload.keyCode())) {
            errors.add("关键代码必须是完整 Java 代码中的连续片段");
        }
        if (!blank(payload.fullCode()) && (payload.fullCode().contains("TODO") || payload.fullCode().contains("{{"))) {
            errors.add("完整 Java 代码不能包含 TODO 或默写占位符");
        }
        if (!blank(payload.fullCode()) && containsDisallowedTopLevelDeclaration(payload.fullCode())) {
            errors.add("完整 Java 代码不能包含 package 或 native 声明");
        }
        validateQuestions(payload.recallQuestions(), otherQuestionKeys, errors);
        validateDictation(payload, errors);
        validateSignature(payload.fullCode(), official.javaStarterCode(), errors);
        JavaCompileService.CompileResult compileResult = blank(payload.fullCode())
                ? new JavaCompileService.CompileResult(false, "完整 Java 代码为空")
                : javaCompileService.compile(payload.fullCode());
        if (!compileResult.passed()) errors.add("Java 21 编译未通过" + (compileResult.output().isBlank() ? "" : "：" + compileResult.output()));
        return new ValidationResult(payload, List.copyOf(errors), compileResult.passed(), compileResult.output());
    }

    public ProblemCreateDTO toProblemCreate(ExternalImportPayload payload) {
        return new ProblemCreateDTO(payload.leetcodeNumber(), payload.title(), payload.difficulty(), payload.descriptionMarkdown(),
                payload.tags(), payload.coreIdea(), payload.hint(), payload.mistakes(), payload.fullCode(), payload.keyCode(),
                payload.recallQuestions().stream().map(ExternalImportPayload.RecallQuestion::question).toList(),
                payload.dictation().templateCode(), payload.dictation().answers(), payload.dictation().keywords());
    }

    public List<String> recallAnswers(ExternalImportPayload payload) {
        return payload.recallQuestions().stream().map(ExternalImportPayload.RecallQuestion::answer).toList();
    }

    private void validateShape(JsonNode root, List<String> errors) {
        if (root == null || !root.isObject()) {
            errors.add("JSON 根节点必须是对象");
            return;
        }
        validateFieldNames(root, ROOT_FIELDS, "根对象", errors);
        JsonNode questions = root.get("recallQuestions");
        if (questions != null && questions.isArray()) for (JsonNode question : questions) validateFieldNames(question, QUESTION_FIELDS, "recallQuestions 项", errors);
        JsonNode dictation = root.get("dictation");
        if (dictation != null) validateFieldNames(dictation, DICTATION_FIELDS, "dictation", errors);
    }

    private void validateFieldNames(JsonNode node, Set<String> allowed, String scope, List<String> errors) {
        if (!node.isObject()) {
            errors.add(scope + "必须是对象");
            return;
        }
        node.fieldNames().forEachRemaining(field -> {
            if (!allowed.contains(field)) {
                errors.add((FORBIDDEN_FIELDS.contains(field) ? "禁止保存来源或模型字段：" : "不允许的字段：") + field);
            }
        });
    }

    private void copyFields(ObjectNode source, ObjectNode target, Set<String> allowed) {
        for (String field : allowed) {
            JsonNode value = source.get(field);
            if (value != null) target.set(field, value);
        }
    }

    private void validateQuestions(List<ExternalImportPayload.RecallQuestion> questions, Set<String> otherQuestionKeys,
                                   List<String> errors) {
        listSize(questions, 3, 5, "回忆复习问答", errors);
        if (questions == null) return;
        Set<String> normalized = new HashSet<>();
        for (ExternalImportPayload.RecallQuestion question : questions) {
            if (question == null || blank(question.question()) || blank(question.answer())) {
                errors.add("每组回忆复习问答都必须有 question 和 answer");
                continue;
            }
            if (question.question().length() < 8 || question.question().length() > 180 || question.answer().length() > 800) {
                errors.add("回忆问题长度应为 8 到 180 字，答案不能超过 800 字");
            }
            String normalizedQuestion = normalizeQuestion(question.question());
            if (!normalized.add(normalizedQuestion)) errors.add("同一题内不能有重复的回忆问题");
            if (otherQuestionKeys.contains(normalizedQuestion)) errors.add("回忆问题不能与已导入的其他题目重复：" + question.question());
            if (GENERIC_QUESTIONS.contains(normalizedQuestion)) errors.add("回忆问题不能使用通用套话：" + question.question());
        }
    }

    private void validateDictation(ExternalImportPayload payload, List<String> errors) {
        ExternalImportPayload.Dictation dictation = payload.dictation();
        if (dictation == null) { errors.add("缺少默写内容"); return; }
        if (!Language.JAVA.name().equals(dictation.language())) errors.add("默写语言必须为 JAVA");
        if (blank(dictation.templateCode()) || dictation.answers() == null) { errors.add("默写模板和答案不能为空"); return; }
        Matcher matcher = BLANK_PATTERN.matcher(dictation.templateCode());
        Set<String> keys = new LinkedHashSet<>();
        int count = 0;
        while (matcher.find()) {
            count++;
            if (!keys.add(matcher.group(1))) errors.add("每个默写空位只能出现一次");
        }
        if (count < 3 || count > 6) errors.add("默写必须包含 3 到 6 个空位");
        if (!keys.equals(dictation.answers().keySet())) errors.add("默写空位和答案键集合必须完全一致");
        for (Map.Entry<String, String> entry : dictation.answers().entrySet()) {
            if (blank(entry.getKey()) || blank(entry.getValue()) || entry.getValue().length() > 240) {
                errors.add("默写答案必须是长度不超过 240 的非空 Java 片段");
                break;
            }
        }
        if (dictation.keywords() == null || dictation.keywords().isEmpty() || dictation.keywords().size() > 10) errors.add("默写关键词数量必须为 1 到 10 个");
        String restored = dictation.templateCode();
        for (String key : keys) restored = restored.replace("{{" + key + "}}", dictation.answers().get(key));
        if (!restored.equals(payload.fullCode())) errors.add("默写答案回填后必须逐字符恢复完整 Java 代码");
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

    private void listSize(List<?> values, int min, int max, String name, List<String> errors) {
        if (values == null || values.size() < min || values.size() > max) errors.add(name + "数量必须为 " + min + " 到 " + max + " 条");
    }

    private void listText(List<String> values, int minLength, int maxLength, String name, List<String> errors) {
        if (values == null) return;
        if (values.stream().anyMatch(value -> blank(value) || value.length() < minLength || value.length() > maxLength)) errors.add(name + "每条长度必须为 " + minLength + " 到 " + maxLength + " 字");
    }

    private void required(String value, String error, List<String> errors) { if (blank(value)) errors.add(error); }
    private boolean blank(String value) { return value == null || value.isBlank(); }
    private boolean sameText(String first, String second) { return normalizeText(first).equals(normalizeText(second)); }
    private String normalizeText(String text) { return text == null ? "" : text.replace("\r\n", "\n").strip(); }
    private String normalizeQuestion(String text) { return text == null ? "" : text.replaceAll("[？?！!。,.，、\\s]", "").strip(); }
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

    public String questionKey(String question) { return normalizeQuestion(question); }

    public record ValidationResult(ExternalImportPayload payload, List<String> errors, boolean compilePassed, String compileOutput) {
        public boolean ready() { return payload != null && errors.isEmpty() && compilePassed; }
    }
}
