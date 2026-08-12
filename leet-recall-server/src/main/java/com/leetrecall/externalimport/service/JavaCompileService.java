package com.leetrecall.externalimport.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service
public class JavaCompileService {
    private static final Pattern CLASS_PATTERN = Pattern.compile("\\bclass\\s+(\\w+)");
    private static final Pattern PUBLIC_CLASS_PATTERN = Pattern.compile("\\bpublic\\s+class\\s+(\\w+)");

    public CompileResult compile(String code) {
        if (code == null || code.isBlank()) return new CompileResult(false, "Java 代码为空");
        Path directory = null;
        try {
            directory = Files.createTempDirectory("leetrecall-java-");
            String source = prepare(code);
            Path sourceFile = directory.resolve(primaryClass(code) + ".java");
            Path outputFile = directory.resolve("javac-output.txt");
            Files.writeString(sourceFile, source, StandardCharsets.UTF_8);
            Process process = new ProcessBuilder("javac", "--release", "21", "-proc:none", "-Xlint:none", "-d", directory.toString(), sourceFile.toString())
                    .redirectErrorStream(true)
                    .redirectOutput(outputFile.toFile())
                    .start();
            boolean finished = process.waitFor(8, TimeUnit.SECONDS);
            if (!finished) {
                process.destroyForcibly();
                process.waitFor(1, TimeUnit.SECONDS);
                return new CompileResult(false, "Java 编译超过 8 秒限制");
            }
            String output = Files.readString(outputFile, StandardCharsets.UTF_8).strip();
            return new CompileResult(process.exitValue() == 0, limitOutput(output, directory));
        } catch (InterruptedException exception) {
            Thread.currentThread().interrupt();
            return new CompileResult(false, "Java 编译被中断");
        } catch (IOException exception) {
            return new CompileResult(false, "Java 编译超时或失败：" + exception.getMessage());
        } finally {
            if (directory != null) {
                try (var files = Files.walk(directory)) {
                    files.sorted(java.util.Comparator.reverseOrder()).forEach(path -> {
                        try { Files.deleteIfExists(path); } catch (IOException ignored) { }
                    });
                } catch (IOException ignored) { }
            }
        }
    }

    private String prepare(String code) {
        String withoutImports = code.replaceAll("(?m)^\\s*import\\s+[^;]+;\\s*", "");
        StringBuilder prefix = new StringBuilder("import java.util.*;\nimport java.util.stream.*;\n");
        String commentsRemoved = stripCommentsAndLiterals(withoutImports);
        if (commentsRemoved.matches("(?s).*\\bListNode\\b.*") && !commentsRemoved.matches("(?s).*\\bclass\\s+ListNode\\b.*")) {
            prefix.append("class ListNode { int val; ListNode next; ListNode(){} ListNode(int v){val=v;} ListNode(int v,ListNode n){val=v;next=n;} }\n");
        }
        if (commentsRemoved.matches("(?s).*\\bTreeNode\\b.*") && !commentsRemoved.matches("(?s).*\\bclass\\s+TreeNode\\b.*")) {
            prefix.append("class TreeNode { int val; TreeNode left,right; TreeNode(){} TreeNode(int v){val=v;} TreeNode(int v,TreeNode l,TreeNode r){val=v;left=l;right=r;} }\n");
        }
        if (commentsRemoved.matches("(?s).*\\bNode\\b.*") && !commentsRemoved.matches("(?s).*\\bclass\\s+Node\\b.*")) {
            prefix.append("class Node { int val; Node next,random; List<Node> neighbors,children; Node(){} Node(int v){val=v;} Node(int v,List<Node> n){val=v;neighbors=n;} }\n");
        }
        return prefix + withoutImports;
    }

    private String primaryClass(String code) {
        String withoutComments = stripCommentsAndLiterals(code);
        var publicClassMatcher = PUBLIC_CLASS_PATTERN.matcher(withoutComments);
        if (publicClassMatcher.find()) return publicClassMatcher.group(1);
        var matcher = CLASS_PATTERN.matcher(withoutComments);
        return matcher.find() ? matcher.group(1) : "Solution";
    }

    private String stripCommentsAndLiterals(String code) {
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
                if (current == delimiter) { sanitized.append(delimiter); stringLiteral = false; charLiteral = false; }
                else sanitized.append(current == '\n' ? '\n' : ' ');
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

    private String limitOutput(String output, Path directory) {
        String masked = output.replace(directory.toString(), "临时源文件");
        return masked.length() <= 4_000 ? masked : masked.substring(0, 4_000) + "\n（编译诊断已截断）";
    }

    public record CompileResult(boolean passed, String output) { }
}
