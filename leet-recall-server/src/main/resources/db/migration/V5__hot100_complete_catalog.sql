SET NAMES utf8mb4;

ALTER TABLE problem
    ADD COLUMN hot100_order INT NULL AFTER leetcode_number,
    ADD UNIQUE KEY uk_problem_hot100_order (hot100_order);

ALTER TABLE recall_question
    ADD UNIQUE KEY uk_recall_question_problem_order (problem_id, sort_order);

ALTER TABLE problem_mistake
    ADD UNIQUE KEY uk_problem_mistake_problem_order (problem_id, sort_order);

-- Hot100-1: #1 两数之和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    1, 1, CONVERT(FROM_BASE64('5Lik5pWw5LmL5ZKM') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDlkozkuIDkuKrmlbTmlbDnm67moIflgLwgYHRhcmdldGDvvIzor7fkvaDlnKjor6XmlbDnu4TkuK3mib7lh7oqKuWSjOS4uuebruagh+WAvCoqKmB0YXJnZXRgKiAg55qE6YKjKirkuKTkuKoqKuaVtOaVsO+8jOW5tui/lOWbnuWug+S7rOeahOaVsOe7hOS4i+agh+OAggoK5L2g5Y+v5Lul5YGH6K6+5q+P56eN6L6T5YWl5Y+q5Lya5a+55bqU5LiA5Liq562U5qGI77yM5bm25LiU5L2g5LiN6IO95L2/55So5Lik5qyh55u45ZCM55qE5YWD57Sg44CCCgrkvaDlj6/ku6XmjInku7vmhI/pobrluo/ov5Tlm57nrZTmoYjjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMiw3LDExLDE1XSwgdGFyZ2V0ID0gOQrovpPlh7rvvJpbMCwxXQrop6Pph4rvvJrlm6DkuLogbnVtc1swXSArIG51bXNbMV0gPT0gOSDvvIzov5Tlm54gWzAsIDFdIOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMywyLDRdLCB0YXJnZXQgPSA2Cui+k+WHuu+8mlsxLDJdCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFszLDNdLCB0YXJnZXQgPSA2Cui+k+WHuu+8mlswLDFdCmBgYCoq5o+Q56S677yaKiotIGAyIDw9IG51bXMubGVuZ3RoIDw9IDEwNGAKLSBgLTEwOSA8PSBudW1zW2ldIDw9IDEwOWAKLSBgLTEwOSA8PSB0YXJnZXQgPD0gMTA5YAotKirlj6rkvJrlrZjlnKjkuIDkuKrmnInmlYjnrZTmoYgqKioq6L+b6Zi277yaKirkvaDlj6/ku6Xmg7Plh7rkuIDkuKrml7bpl7TlpI3mnYLluqblsI/kuo4gYE8objIpYCDnmoTnrpfms5XlkJfvvJ8KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy90d28tc3VtLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy90d28tc3VtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55So5ZOI5biM6KGoIGluZGV4TWFwIOe7tOaKpOKAnOW3sue7j+mBjeWOhui/h+eahOaVsOWAvCAtPiDlr7nlupTkuIvmoIfigJ3jgILpgY3ljoYgbnVtcyDml7bvvIzlhYjorqHnrpflvZPliY3mlbAgbnVtc1tpXSDmiYDpnIDnmoTooaXmlbAgY29tcGxlbWVudCA9IHRhcmdldCAtIG51bXNbaV3vvIzoi6Xlk4jluIzooajkuK3lrZjlnKggY29tcGxlbWVudO+8jOWImeivpeS4i+agh+S4jiBpIOWNs+S4uuetlOahiO+8m+WQpuWImeWGjeWwhuW9k+WJjeaVsOWPiuWFtuS4i+agh+WKoOWFpeWTiOW4jOihqOOAguW+queOr+S4jeWPmOmHj+aYr++8muWkhOeQhuS4i+aghyBpIOWJje+8jGluZGV4TWFwIOWPquS/neWtmOaJgOacieS4i+agh+Wwj+S6jiBpIOeahOWFg+e0oO+8jOWboOatpOaJvuWIsOeahOihpeaVsOS4i+agh+S4gOWumuS4jeWQjOS6jiBp77yM5LiU5Lik5pWw5LmL5ZKM5oGw5aW95Li6IHRhcmdldOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5LuO5bem5Yiw5Y+z5omr5o+P44CC5a+55b2T5YmN5YC8IHjvvIzkuI3lv4XmnprkuL7lj6bkuIDkuKrmlbDvvJvmg7Pmg7MgdGFyZ2V0IC0geCDlupTor6Xljrvlk6rph4zlv6vpgJ/mn6Xmib7jgII=') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoOyBpKyspIHsKICAgICAgICAgICAgaW50IGNvbXBsZW1lbnQgPSB0YXJnZXQgLSBudW1zW2ldOwogICAgICAgICAgICBpZiAoaW5kZXhNYXAuY29udGFpbnNLZXkoY29tcGxlbWVudCkpIHsKICAgICAgICAgICAgICAgIHJldHVybiBuZXcgaW50W117aW5kZXhNYXAuZ2V0KGNvbXBsZW1lbnQpLCBpfTsKICAgICAgICAgICAgfQogICAgICAgICAgICBpbmRleE1hcC5wdXQobnVtc1tpXSwgaSk7CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHR3b1N1bShpbnRbXSBudW1zLCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgamF2YS51dGlsLk1hcDxJbnRlZ2VyLCBJbnRlZ2VyPiBpbmRleE1hcCA9IG5ldyBqYXZhLnV0aWwuSGFzaE1hcDw+KCk7CgogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbnVtcy5sZW5ndGg7IGkrKykgewogICAgICAgICAgICBpbnQgY29tcGxlbWVudCA9IHRhcmdldCAtIG51bXNbaV07CiAgICAgICAgICAgIGlmIChpbmRleE1hcC5jb250YWluc0tleShjb21wbGVtZW50KSkgewogICAgICAgICAgICAgICAgcmV0dXJuIG5ldyBpbnRbXXtpbmRleE1hcC5nZXQoY29tcGxlbWVudCksIGl9OwogICAgICAgICAgICB9CiAgICAgICAgICAgIGluZGV4TWFwLnB1dChudW1zW2ldLCBpKTsKICAgICAgICB9CgogICAgICAgIHJldHVybiBuZXcgaW50WzBdOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4) WHERE p.leetcode_number = 1
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 1
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 1
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6YGN5Y6G5Yiw5LiL5qCHIGkg5YmN77yM5ZOI5biM6KGo5Lit57u05oqk55qE5qC45b+D54q25oCB5LiO5b6q546v5LiN5Y+Y6YeP5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('57u05oqk5bey6YGN5Y6G5YWD57Sg55qE4oCc5pWw5YC8IC0+IOS4i+agh+KAneaYoOWwhO+8m+WkhOeQhiBpIOWJje+8jOihqOS4reaJgOacieS4i+agh+mDveWwj+S6jiBp44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b2T5YmN5YWD57Sg55qE6KGl5pWw5aaC5L2V6K6h566X77yM5p+l6K+i5ZKM5o+S5YWl55qE6aG65bqP5Li65LuA5LmI5LiN6IO96aKg5YCS77yf') USING utf8mb4), CONVERT(FROM_BASE64('6KGl5pWw5Li6IHRhcmdldCAtIG51bXNbaV3vvJvlv4XpobvlhYjmn6XooaXmlbDlho3mj5LlhaXlvZPliY3lhYPntKDvvIzkv53or4HkuI3kvJrkvb/nlKjlkIzkuIDkuKrkuIvmoIfkuKTmrKHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l6Kej5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzlk4jluIzooajmn6Xmib7lkozmj5LlhaXlnYfmkYogTygxKe+8m+epuumXtOWkjeadguW6piBPKG4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5p+l6K+i6KGl5pWw44CB5ZCO5o+S5YWl5b2T5YmN5YWD57Sg77yb6Iul5YWI5o+S5YWl5YaN5p+l6K+i77yMdGFyZ2V0IOS4uuWBtuaVsOS4lOW9k+WJjeWAvOetieS6jiB0YXJnZXQgLyAyIOaXtuWPr+iDvemUmeivr+WcsOWkjeeUqOWQjOS4gOS4i+agh+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5ZOI5biM6KGo5bqU5L+d5a2Y4oCc5pWw5YC85Yiw5LiL5qCH4oCd55qE5pig5bCE77yM6ICM5LiN5piv5Y+q5L+d5a2Y5pWw5YC877yb6L+U5Zue562U5qGI5pe26ZyA6KaB55So5bey5L+d5a2Y55qE6KGl5pWw5LiL5qCH5ZKM5b2T5YmN5LiL5qCH57uE5oiQ5pWw57uE44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHR3b1N1bShpbnRbXSBudW1zLCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgamF2YS51dGlsLk1hcDxJbnRlZ2VyLCBJbnRlZ2VyPiBpbmRleE1hcCA9IHt7YmxhbmtfMX19OwoKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoOyBpKyspIHsKICAgICAgICAgICAgaW50IGNvbXBsZW1lbnQgPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICByZXR1cm4gbmV3IGludFtde2luZGV4TWFwLmdldChjb21wbGVtZW50KSwgaX07CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaW5kZXhNYXAucHV0KG51bXNbaV0sIGkpOwogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIG5ldyBpbnRbMF07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibmV3IGphdmEudXRpbC5IYXNoTWFwPD4oKSIsImJsYW5rXzIiOiJ0YXJnZXQgLSBudW1zW2ldIiwiYmxhbmtfMyI6ImluZGV4TWFwLmNvbnRhaW5zS2V5KGNvbXBsZW1lbnQpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlk4jluIzooagiLCLmlbDlgLzliLDkuIvmoIciLCLooaXmlbAiLCLlhYjmn6XlkI7lrZgiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 1
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-2: #49 字母异位词分组

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    49, 2, CONVERT(FROM_BASE64('5a2X5q+N5byC5L2N6K+N5YiG57uE') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5a2X56ym5Liy5pWw57uE77yM6K+35L2g5bCGIOWtl+avjeW8guS9jeivjSDnu4TlkIjlnKjkuIDotbfjgILlj6/ku6XmjInku7vmhI/pobrluo/ov5Tlm57nu5PmnpzliJfooajjgIIqKuekuuS+iyAxOioqKirovpPlhaU6KipzdHJzID0gWyJlYXQiLCAidGVhIiwgInRhbiIsICJhdGUiLCAibmF0IiwgImJhdCJdKirovpPlh7o6KipbWyJiYXQiXSxbIm5hdCIsInRhbiJdLFsiYXRlIiwiZWF0IiwidGVhIl1dKirop6Pph4rvvJoqKi0g5ZyoIHN0cnMg5Lit5rKh5pyJ5a2X56ym5Liy5Y+v5Lul6YCa6L+H6YeN5paw5o6S5YiX5p2l5b2i5oiQIGAiYmF0ImDjgIIKLSDlrZfnrKbkuLIgYCJuYXQiYCDlkowgYCJ0YW4iYCDmmK/lrZfmr43lvILkvY3or43vvIzlm6DkuLrlroPku6zlj6/ku6Xph43mlrDmjpLliJfku6XlvaLmiJDlvbzmraTjgIIKLSDlrZfnrKbkuLIgYCJhdGUiYCDvvIxgImVhdCJgIOWSjCBgInRlYSJgIOaYr+Wtl+avjeW8guS9jeivje+8jOWboOS4uuWug+S7rOWPr+S7pemHjeaWsOaOkuWIl+S7peW9ouaIkOW9vOatpOOAgioq56S65L6LIDI6KioqKui+k+WFpToqKnN0cnMgPSBbIiJdKirovpPlh7o6KipbWyIiXV0qKuekuuS+iyAzOioqKirovpPlhaU6KipzdHJzID0gWyJhIl0qKui+k+WHujoqKltbImEiXV0qKuaPkOekuu+8mioqLSBgMSA8PSBzdHJzLmxlbmd0aCA8PSAxMDRgCi0gYDAgPD0gc3Ryc1tpXS5sZW5ndGggPD0gMTAwYAotIGBzdHJzW2ldYCDku4XljIXlkKvlsI/lhpnlrZfmr40KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9ncm91cC1hbmFncmFtcy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZ3JvdXAtYW5hZ3JhbXMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5ZOI5biM6KGo5oyJ4oCc6KeE6IyD6ZSu4oCd5YiG57uE77ya5bCG5q+P5Liq5a2X56ym5Liy55qE5a2X56ym5o6S5bqP77yM5o6S5bqP5ZCO55qE5a2X56ym5Liy5L2c5Li6IGtleeOAguWtl+avjeW8guS9jeivjeeahOWtl+espuenjeexu+WSjOasoeaVsOWujOWFqOebuOWQjO+8jOWboOatpOaOkuW6j+e7k+aenOW/heeEtuebuOWQjO+8m+WPjeS5i++8jOebuOWQjOaOkuW6j+e7k+aenOeahOWtl+espuS4suS5n+W/heS4uuW8guS9jeivjeOAgumhuuW6j+mBjeWOhiBzdHJz77yM5a+55q+P5Liq5a2X56ym5Liy55Sf5oiQIGtlee+8jOW5tuWwhuWOn+Wtl+espuS4suWKoOWFpSBtYXAg5Lit6K+lIGtleSDlr7nlupTnmoTliJfooajjgILpgY3ljobnu5PmnZ/lkI7vvIxtYXAg55qE5omA5pyJIHZhbHVlIOWNs+S4uuWIhue7hOe7k+aenOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5aaC5L2V6K6p5Lu75oSP5o6S5YiX6aG65bqP55qE5byC5L2N6K+N5pig5bCE5Li65ZCM5LiA5Liq5ZOI5biM6ZSu77yf5Y+v5YWI5oqK5q+P5Liq5Y2V6K+N6L2s5o2i5oiQ57uf5LiA55qE6KeE6IyD5b2i5byP44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChTdHJpbmcgc3RyIDogc3RycykgewogICAgICAgICAgICBjaGFyW10gY2hhcnMgPSBzdHIudG9DaGFyQXJyYXkoKTsKICAgICAgICAgICAgQXJyYXlzLnNvcnQoY2hhcnMpOwogICAgICAgICAgICBTdHJpbmcga2V5ID0gbmV3IFN0cmluZyhjaGFycyk7CiAgICAgICAgICAgIGdyb3Vwcy5jb21wdXRlSWZBYnNlbnQoa2V5LCBrIC0+IG5ldyBBcnJheUxpc3Q8PigpKS5hZGQoc3RyKTsKICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC4qOwoKY2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxTdHJpbmc+PiBncm91cEFuYWdyYW1zKFN0cmluZ1tdIHN0cnMpIHsKICAgICAgICBNYXA8U3RyaW5nLCBMaXN0PFN0cmluZz4+IGdyb3VwcyA9IG5ldyBIYXNoTWFwPD4oKTsKCiAgICAgICAgZm9yIChTdHJpbmcgc3RyIDogc3RycykgewogICAgICAgICAgICBjaGFyW10gY2hhcnMgPSBzdHIudG9DaGFyQXJyYXkoKTsKICAgICAgICAgICAgQXJyYXlzLnNvcnQoY2hhcnMpOwogICAgICAgICAgICBTdHJpbmcga2V5ID0gbmV3IFN0cmluZyhjaGFycyk7CiAgICAgICAgICAgIGdyb3Vwcy5jb21wdXRlSWZBYnNlbnQoa2V5LCBrIC0+IG5ldyBBcnJheUxpc3Q8PigpKS5hZGQoc3RyKTsKICAgICAgICB9CgogICAgICAgIHJldHVybiBuZXcgQXJyYXlMaXN0PD4oZ3JvdXBzLnZhbHVlcygpKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4) WHERE p.leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5ZOI5biM6KGo55qE6ZSu5piv5LuA5LmI77yM5Li65LuA5LmI5a6D6IO95oqK5a2X5q+N5byC5L2N6K+N5YiG5Yiw5ZCM5LiA57uE77yf') USING utf8mb4), CONVERT(FROM_BASE64('6ZSu5piv5a2X56ym5Liy5a2X56ym5o6S5bqP5ZCO55qE57uT5p6c44CC5byC5L2N6K+N55qE5q+P56eN5a2X56ym5Y+K5Ye6546w5qyh5pWw55u45ZCM77yM5o6S5bqP5ZCO5b6X5Yiw5a6M5YWo55u45ZCM55qE6KeE6IyD5a2X56ym5Liy44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bCG5a2X56ym5Liy5pS+5YWl5YiG57uE5YiX6KGo5pe277yM5YWz6ZSu55qE5pu05paw5YaZ5rOV5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5L2/55SoIGdyb3Vwcy5jb21wdXRlSWZBYnNlbnQoa2V5LCBrIC0+IG5ldyBBcnJheUxpc3Q8PigpKS5hZGQoc3RyKe+8jOWFiOWcqOmUruS4jeWtmOWcqOaXtuWIm+W7uuWIl+ihqO+8jOWGjeaKiuW9k+WJjeWtl+espuS4suWKoOWFpeivpeWIl+ihqOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K6+IG4g5Li65a2X56ym5Liy5pWw6YeP44CBayDkuLrljZXkuKrlrZfnrKbkuLLmnIDlpKfplb/luqbvvIzml7bpl7Tlkoznqbrpl7TlpI3mnYLluqbmmK/lpJrlsJHvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqm5Li6IE8obsK3ayBsb2cgaynvvIzmr4/kuKrlrZfnrKbkuLLmjpLluo/kuIDmrKHvvJvnqbrpl7TlpI3mnYLluqbkuLogTyhuwrdrKe+8jOeUqOS6juWTiOW4jOihqOmUruWSjOWIhue7hOe7k+aenOOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5o6S5bqP5ZCO5b+F6aG755SoIG5ldyBTdHJpbmcoY2hhcnMpIOS9nOS4uiBrZXnvvJvkuI3og73nm7TmjqXmioogY2hhcltdIOaUvuWFpSBIYXNoTWFw77yM5Zug5Li65pWw57uE5oyJ5byV55So5q+U6L6D77yM5YaF5a6555u45ZCM55qE5pWw57uE5LiN5Lya6Ieq5Yqo6KeG5Li65ZCM5LiA5Liq6ZSu44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6LCD55SoIGNvbXB1dGVJZkFic2VudChrZXksIGsgLT4gbmV3IEFycmF5TGlzdDw+KCkpIOWQjuimgeeri+WIuyBhZGQoc3RyKSDliLDov5Tlm57nmoTliJfooajvvJvoi6Xlj6rlnKgga2V5IOS4jeWtmOWcqOaXtua3u+WKoO+8jOS8mua8j+aOieWQjOe7hOWQjue7reWtl+espuS4suOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC4qOwoKY2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxTdHJpbmc+PiBncm91cEFuYWdyYW1zKFN0cmluZ1tdIHN0cnMpIHsKICAgICAgICBNYXA8U3RyaW5nLCBMaXN0PFN0cmluZz4+IGdyb3VwcyA9IHt7YmxhbmtfMX19OwoKICAgICAgICBmb3IgKFN0cmluZyBzdHIgOiBzdHJzKSB7CiAgICAgICAgICAgIGNoYXJbXSBjaGFycyA9IHt7YmxhbmtfMn19OwogICAgICAgICAgICB7e2JsYW5rXzN9fQogICAgICAgICAgICBTdHJpbmcga2V5ID0gbmV3IFN0cmluZyhjaGFycyk7CiAgICAgICAgICAgIHt7YmxhbmtfNH19CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gbmV3IEFycmF5TGlzdDw+KGdyb3Vwcy52YWx1ZXMoKSk7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibmV3IEhhc2hNYXA8PigpIiwiYmxhbmtfMiI6InN0ci50b0NoYXJBcnJheSgpIiwiYmxhbmtfMyI6IkFycmF5cy5zb3J0KGNoYXJzKTsiLCJibGFua180IjoiZ3JvdXBzLmNvbXB1dGVJZkFic2VudChrZXksIGsgLT4gbmV3IEFycmF5TGlzdDw+KCkpLmFkZChzdHIpOyJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmjpLluo/op4TojIPplK4iLCJIYXNoTWFwIOWIhue7hCIsImNvbXB1dGVJZkFic2VudCIsIuaOkuW6j+WQjui9rCBTdHJpbmciXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 49
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-3: #128 最长连续序列

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    128, 3, CONVERT(FROM_BASE64('5pyA6ZW/6L+e57ut5bqP5YiX') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pyq5o6S5bqP55qE5pW05pWw5pWw57uEIGBudW1zYCDvvIzmib7lh7rmlbDlrZfov57nu63nmoTmnIDplb/luo/liJfvvIjkuI3opoHmsYLluo/liJflhYPntKDlnKjljp/mlbDnu4TkuK3ov57nu63vvInnmoTplb/luqbjgIIKCuivt+S9oOiuvuiuoeW5tuWunueOsOaXtumXtOWkjeadguW6puS4uiBgTyhuKWAqKueahOeul+azleino+WGs+atpOmXrumimOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxMDAsNCwyMDAsMSwzLDJdCui+k+WHuu+8mjQK6Kej6YeK77ya5pyA6ZW/5pWw5a2X6L+e57ut5bqP5YiX5pivIFsxLCAyLCAzLCA0XeOAguWug+eahOmVv+W6puS4uiA044CCCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFswLDMsNywyLDUsOCw0LDYsMCwxXQrovpPlh7rvvJo5CmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDAsMSwyXQrovpPlh7rvvJozCmBgYCoq5o+Q56S677yaKiotIGAwIDw9IG51bXMubGVuZ3RoIDw9IDEwNWAKLSBgLTEwOSA8PSBudW1zW2ldIDw9IDEwOWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9sb25nZXN0LWNvbnNlY3V0aXZlLXNlcXVlbmNlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9sb25nZXN0LWNvbnNlY3V0aXZlLXNlcXVlbmNlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5bCG5omA5pyJ5pWw5a2X5pS+5YWlIEhhc2hTZXQg5Y676YeN77yM5L6/5LqOIE8oMSkg5pyf5pyb5pe26Ze05Yik5pat5p+Q5Liq5pWw5piv5ZCm5a2Y5Zyo44CC6YGN5Y6G6ZuG5ZCI5Lit55qE5q+P5LiqIG51be+8jOWPquacieW9kyBzZXQg5Lit5LiN5a2Y5ZyoIG51bSAtIDEg5pe277yMbnVtIOaJjeWPr+iDveaYr+S4gOautei/nue7reW6j+WIl+eahOi1t+eCue+8m+S7juivpei1t+eCueS4jeaWreajgOafpSBjdXJyZW50ICsgMSDmmK/lkKblrZjlnKjvvIzlubblkJHlj7PmianlsZXjgIHntK/orqHplb/luqbjgILnlLHkuo7pnZ7otbfngrnnmoTmlbDlrZfkuI3kvJrop6blj5HmianlsZXvvIzmr4/kuKrov57nu63luo/liJflj6rkvJrooqvlrozmlbTmiavmj4/kuIDmrKHvvIzlm6DmraTmgLvml7bpl7TkuLogTyhuKSDmnJ/mnJvlpI3mnYLluqbjgII=') USING utf8mb4), CONVERT(FROM_BASE64('55So6ZuG5ZCI5Y676YeN5bm25b+r6YCf5p+l5om+44CC5Y+q5pyJ5om+5LiN5YiwIG51bS0xIOeahOaVsOaJjeaYr+i/nue7reautei1t+eCue+8jOWGjeS4jeaWreafpeaJviBudW0rMeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBpbnQgbG9uZ2VzdCA9IDA7CiAgICAgICAgZm9yIChpbnQgbnVtIDogc2V0KSB7CiAgICAgICAgICAgIGlmICghc2V0LmNvbnRhaW5zKG51bSAtIDEpKSB7CiAgICAgICAgICAgICAgICBpbnQgY3VycmVudCA9IG51bTsKICAgICAgICAgICAgICAgIGludCBsZW5ndGggPSAxOwoKICAgICAgICAgICAgICAgIHdoaWxlIChzZXQuY29udGFpbnMoY3VycmVudCArIDEpKSB7CiAgICAgICAgICAgICAgICAgICAgY3VycmVudCsrOwogICAgICAgICAgICAgICAgICAgIGxlbmd0aCsrOwogICAgICAgICAgICAgICAgfQoKICAgICAgICAgICAgICAgIGxvbmdlc3QgPSBNYXRoLm1heChsb25nZXN0LCBsZW5ndGgpOwogICAgICAgICAgICB9CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5IYXNoU2V0OwppbXBvcnQgamF2YS51dGlsLlNldDsKCmNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBpbnQgbG9uZ2VzdENvbnNlY3V0aXZlKGludFtdIG51bXMpIHsKICAgICAgICBTZXQ8SW50ZWdlcj4gc2V0ID0gbmV3IEhhc2hTZXQ8PigpOwogICAgICAgIGZvciAoaW50IG51bSA6IG51bXMpIHsKICAgICAgICAgICAgc2V0LmFkZChudW0pOwogICAgICAgIH0KCiAgICAgICAgaW50IGxvbmdlc3QgPSAwOwogICAgICAgIGZvciAoaW50IG51bSA6IHNldCkgewogICAgICAgICAgICBpZiAoIXNldC5jb250YWlucyhudW0gLSAxKSkgewogICAgICAgICAgICAgICAgaW50IGN1cnJlbnQgPSBudW07CiAgICAgICAgICAgICAgICBpbnQgbGVuZ3RoID0gMTsKCiAgICAgICAgICAgICAgICB3aGlsZSAoc2V0LmNvbnRhaW5zKGN1cnJlbnQgKyAxKSkgewogICAgICAgICAgICAgICAgICAgIGN1cnJlbnQrKzsKICAgICAgICAgICAgICAgICAgICBsZW5ndGgrKzsKICAgICAgICAgICAgICAgIH0KCiAgICAgICAgICAgICAgICBsb25nZXN0ID0gTWF0aC5tYXgobG9uZ2VzdCwgbGVuZ3RoKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbG9uZ2VzdDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM') USING utf8mb4) WHERE p.leetcode_number = 128
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm25p+l6ZuG') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm25p+l6ZuG') USING utf8mb4) WHERE p.leetcode_number = 128
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 128
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 128
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('SGFzaFNldCDop6Pms5XkuK3vvIzku4DkuYjmlbDlrZfmiY3kvJrkvZzkuLrkuIDmrKHov57nu63luo/liJfmianlsZXnmoTotbfngrnvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5Y+q5pyJIHNldCDkuK3kuI3lrZjlnKggbnVtIC0gMSDnmoQgbnVtIOaJjeaYr+i1t+eCue+8m+i/meagt+avj+S4qui/nue7reW6j+WIl+WPquS8muS7juWFtuacgOWwj+WAvOW8gOWni+aJqeWxleS4gOasoeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LuO6LW354K55omp5bGV5pe277yMY3VycmVudCDlkowgbGVuZ3RoIOWmguS9leWIneWni+WMluWPiuabtOaWsO+8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5Yid5aeL5YyWIGN1cnJlbnQgPSBudW3jgIFsZW5ndGggPSAx77yb5b2TIHNldC5jb250YWlucyhjdXJyZW50ICsgMSkg5pe277yM5L6d5qyh5omn6KGMIGN1cnJlbnQrKyDlkowgbGVuZ3RoKyvjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqm5Li6IE8obikg5pyf5pyb5aSN5p2C5bqm77yM56m66Ze05aSN5p2C5bqm5Li6IE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5LuO6ZuG5ZCI5Lit5q+P5Liq5pWw5a2X6YO95ZCR5ZCO5omp5bGV77yb5b+F6aG75YWI5Yik5pat5LiN5a2Y5ZyoIG51bSAtIDHvvIzlkKbliJnlpoIgWzEsMiwzLDRdIOS8mumHjeWkjeaJq+aPj+WQjue8gO+8jOacgOWdj+mAgOWMluS4uiBPKG7CsinjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omp5bGV5pe25Yid5aeL5YyW5bqU5Li6IGN1cnJlbnQgPSBudW3jgIFsZW5ndGggPSAx77yb5b6q546v5p2h5Lu25qOA5p+lIGN1cnJlbnQgKyAx77yM6ZqP5ZCO5YaN5omn6KGMIGN1cnJlbnQrKyDlkowgbGVuZ3RoKyvvvIzlkKbliJnkvJrmvI/nrpfotbfngrnmiJbmnKvlsL7lhYPntKDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5IYXNoU2V0OwppbXBvcnQgamF2YS51dGlsLlNldDsKCmNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBpbnQgbG9uZ2VzdENvbnNlY3V0aXZlKGludFtdIG51bXMpIHsKICAgICAgICBTZXQ8SW50ZWdlcj4gc2V0ID0ge3tibGFua18xfX07CiAgICAgICAgZm9yIChpbnQgbnVtIDogbnVtcykgewogICAgICAgICAgICBzZXQuYWRkKG51bSk7CiAgICAgICAgfQoKICAgICAgICBpbnQgbG9uZ2VzdCA9IDA7CiAgICAgICAgZm9yIChpbnQgbnVtIDogc2V0KSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgaW50IGN1cnJlbnQgPSBudW07CiAgICAgICAgICAgICAgICBpbnQgbGVuZ3RoID0gMTsKCiAgICAgICAgICAgICAgICB3aGlsZSAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgICAgICAgICB7e2JsYW5rXzR9fTsKICAgICAgICAgICAgICAgICAgICBsZW5ndGgrKzsKICAgICAgICAgICAgICAgIH0KCiAgICAgICAgICAgICAgICBsb25nZXN0ID0ge3tibGFua181fX07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGxvbmdlc3Q7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibmV3IEhhc2hTZXQ8PigpIiwiYmxhbmtfMiI6IiFzZXQuY29udGFpbnMobnVtIC0gMSkiLCJibGFua18zIjoic2V0LmNvbnRhaW5zKGN1cnJlbnQgKyAxKSIsImJsYW5rXzQiOiJjdXJyZW50KysiLCJibGFua181IjoiTWF0aC5tYXgobG9uZ2VzdCwgbGVuZ3RoKSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJIYXNoU2V0IOWOu+mHjSIsIui/nue7reautei1t+eCuSIsIuS4jeWtmOWcqCBudW0tMSIsIuWQkeWPs+aJqeWxlSIsIk8obikg5pyf5pybIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 128
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-4: #283 移动零

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    283, 4, CONVERT(FROM_BASE64('56e75Yqo6Zu2') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pWw57uEIGBudW1zYO+8jOe8luWGmeS4gOS4quWHveaVsOWwhuaJgOaciSBgMGAg56e75Yqo5Yiw5pWw57uE55qE5pyr5bC+77yM5ZCM5pe25L+d5oyB6Z2e6Zu25YWD57Sg55qE55u45a+56aG65bqP44CCKiror7fms6jmhI8qKu+8jOW/hemhu+WcqOS4jeWkjeWItuaVsOe7hOeahOaDheWGteS4i+WOn+WcsOWvueaVsOe7hOi/m+ihjOaTjeS9nOOAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFswLDEsMCwzLDEyXQrovpPlh7o6IFsxLDMsMTIsMCwwXQpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IG51bXMgPSBbMF0K6L6T5Ye6OiBbMF0KYGBgKirmj5DnpLoqKjoKCi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTA0YAotIGAtMjMxIDw9IG51bXNbaV0gPD0gMjMxIC0gMWAqKui/m+mYtu+8mioq5L2g6IO95bC96YeP5YeP5bCR5a6M5oiQ55qE5pON5L2c5qyh5pWw5ZCX77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbW92ZS16ZXJvZXMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL21vdmUtemVyb2VzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55So5Y+M5oyH6ZKI77yac2xvdyDmjIflkJHkuIvkuIDkuKrlupTmlL7nva7pnZ7pm7blhYPntKDnmoTkvY3nva7vvIxmYXN0IOS7juW3puWIsOWPs+aJq+aPj+aVsOe7hOOAguW+queOr+S4jeWPmOmHj+aYr++8mm51bXNbMC4uc2xvdy0xXSDlp4vnu4jmmK/mjInljp/nm7jlr7npobrluo/mjpLliJfnmoTpnZ7pm7blhYPntKDvvJtudW1zW3Nsb3cuLmZhc3QtMV0g5Z2H5Li65bey5omr5o+P5L2G5bCa5pyq56e75Yqo5Yiw5pyr5bC+55qE6Zu244CC6YGH5Yiw6Z2e6Zu2IG51bXNbZmFzdF0g5pe277yM5bCG5YW25Lqk5o2i5YiwIHNsb3fvvJvoi6Ugc2xvdz09ZmFzdCDliJnml6DpnIDkuqTmjaLvvIzpmo/lkI4gc2xvdyDlj7Pnp7vjgILmiavmj4/nu5PmnZ/lkI7vvIzmiYDmnInpnZ7pm7blhYPntKDlt7LnqLPlrprlnLDkvY3kuo7liY3pg6jvvIzpm7boh6rnhLbnlZnlnKjmnKvlsL7jgII=') USING utf8mb4), CONVERT(FROM_BASE64('6K6p5LiA5Liq5oyH6ZKI5omr5o+P5YWo6YOo5YWD57Sg77yM5Y+m5LiA5Liq5oyH6ZKI5Y+q6K6w5b2V5LiL5LiA5Liq6Z2e6Zu25YWD57Sg5bqU5pS+55qE5L2N572u77yb6YGH5Yiw6Z2e6Zu25pe25YaN5aSE55CG5Lqk5o2i44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgZmFzdCA9IDA7IGZhc3QgPCBudW1zLmxlbmd0aDsgZmFzdCsrKSB7CiAgICAgICAgICAgIGlmIChudW1zW2Zhc3RdICE9IDApIHsKICAgICAgICAgICAgICAgIGlmIChzbG93ICE9IGZhc3QpIHsKICAgICAgICAgICAgICAgICAgICBpbnQgdGVtcCA9IG51bXNbc2xvd107CiAgICAgICAgICAgICAgICAgICAgbnVtc1tzbG93XSA9IG51bXNbZmFzdF07CiAgICAgICAgICAgICAgICAgICAgbnVtc1tmYXN0XSA9IHRlbXA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBzbG93Kys7CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgbW92ZVplcm9lcyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IHNsb3cgPSAwOwoKICAgICAgICBmb3IgKGludCBmYXN0ID0gMDsgZmFzdCA8IG51bXMubGVuZ3RoOyBmYXN0KyspIHsKICAgICAgICAgICAgaWYgKG51bXNbZmFzdF0gIT0gMCkgewogICAgICAgICAgICAgICAgaWYgKHNsb3cgIT0gZmFzdCkgewogICAgICAgICAgICAgICAgICAgIGludCB0ZW1wID0gbnVtc1tzbG93XTsKICAgICAgICAgICAgICAgICAgICBudW1zW3Nsb3ddID0gbnVtc1tmYXN0XTsKICAgICAgICAgICAgICAgICAgICBudW1zW2Zhc3RdID0gdGVtcDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIHNsb3crKzsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 283
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 283
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('c2xvdyDmjIfpkojlnKjpgY3ljobov4fnqIvkuK3ooajnpLrku4DkuYjvvIzlhbblt6bkvqfmu6HotrPku4DkuYjkuI3lj5jph4/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('c2xvdyDooajnpLrkuIvkuIDkuKrpnZ7pm7blhYPntKDlupTmlL7lhaXnmoTkvY3nva7vvJtudW1zWzAuLnNsb3ctMV0g5aeL57uI5piv5bey5omr5o+P6Z2e6Zu25YWD57Sg5oyJ5Y6f55u45a+56aG65bqP57uE5oiQ55qE5YmN57yA44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+R546wIG51bXNbZmFzdF0g6Z2e6Zu25pe277yM5Li65LuA5LmI6KaB5YWI5Yik5patIHNsb3cgIT0gZmFzdO+8jOWGjeS6pOaNouW5tuenu+WKqCBzbG9377yf') USING utf8mb4), CONVERT(FROM_BASE64('c2xvdz09ZmFzdCDooajnpLror6XpnZ7pm7blhYPntKDlt7LlnKjnm67moIfkvY3nva7vvIzml6DpnIDoh6rkuqTmjaLvvJvlkKbliJnkuqTmjaIgbnVtc1tzbG93XSDlkowgbnVtc1tmYXN0Xe+8jOWGjeaJp+ihjCBzbG93KyvvvIzkvb/kuIvkuIDkuKrkvY3nva7nrYnlvoXlkI7nu63pnZ7pm7blhYPntKDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l5Y+M5oyH6ZKI566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqm5Li6IE8obinvvIzmr4/kuKrlhYPntKDoh7PlpJrooqsgZmFzdCDmiavmj4/kuIDmrKHvvJvnqbrpl7TlpI3mnYLluqbkuLogTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6IO95Zyo6YGH5YiwIDAg5pe256uL5Yi75LiO5ZCO5LiA5Liq5YWD57Sg5Lqk5o2i77yM5ZCm5YiZ5Y+v6IO956C05Z2P5aSa5Liq6Z2e6Zu25YWD57Sg5LmL6Ze055qE55u45a+56aG65bqP77yb5bqU5Y+q5ZyoIGZhc3Qg6YGH5Yiw6Z2e6Zu25YWD57Sg5pe256e75Yqo5a6D44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Lqk5o2i5YmN6KaB5Yik5patIHNsb3cgIT0gZmFzdO+8m+W9k+S4pOS4quaMh+mSiOebuOetieaXtuW9k+WJjemdnumbtuWFg+e0oOacrOadpeWwseWcqOato+ehruS9jee9ru+8jOi3s+i/h+iHquS6pOaNouWPr+WHj+WwkeaXoOaEj+S5ieWGmeaTjeS9nOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgbW92ZVplcm9lcyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IHt7YmxhbmtfMX19ID0gMDsKCiAgICAgICAgZm9yIChpbnQgZmFzdCA9IDA7IGZhc3QgPCBudW1zLmxlbmd0aDsgZmFzdCsrKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICAgICAgaW50IHRlbXAgPSBudW1zW3Nsb3ddOwogICAgICAgICAgICAgICAgICAgIG51bXNbc2xvd10gPSBudW1zW2Zhc3RdOwogICAgICAgICAgICAgICAgICAgIG51bXNbZmFzdF0gPSB0ZW1wOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAge3tibGFua180fX07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoic2xvdyIsImJsYW5rXzIiOiJudW1zW2Zhc3RdICE9IDAiLCJibGFua18zIjoic2xvdyAhPSBmYXN0IiwiYmxhbmtfNCI6InNsb3crKyJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlj4zmjIfpkogiLCJzbG93IOaUvumdnumbtiIsImZhc3Qg5omr5o+PIiwi56iz5a6a6aG65bqPIiwi6Lez6L+H6Ieq5Lqk5o2iIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 283
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-5: #11 盛最多水的容器

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    11, 5, CONVERT(FROM_BASE64('55ub5pyA5aSa5rC055qE5a655Zmo') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq6ZW/5bqm5Li6IGBuYCDnmoTmlbTmlbDmlbDnu4QgYGhlaWdodGAg44CC5pyJIGBuYCDmnaHlnoLnur/vvIznrKwgYGlgIOadoee6v+eahOS4pOS4querr+eCueaYryBgKGksIDApYCDlkowgYChpLCBoZWlnaHRbaV0pYCDjgIIKCuaJvuWHuuWFtuS4reeahOS4pOadoee6v++8jOS9v+W+l+Wug+S7rOS4jiBgeGAg6L205YWx5ZCM5p6E5oiQ55qE5a655Zmo5Y+v5Lul5a6557qz5pyA5aSa55qE5rC044CCCgrov5Tlm57lrrnlmajlj6/ku6XlgqjlrZjnmoTmnIDlpKfmsLTph4/jgIIqKuivtOaYju+8mioq5L2g5LiN6IO95YC+5pac5a655Zmo44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYWxpeXVuLWxjLXVwbG9hZC5vc3MtY24taGFuZ3pob3UuYWxpeXVuY3MuY29tL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDE4LzA3LzI1L3F1ZXN0aW9uXzExLmpwZykKCmBgYHRleHQK6L6T5YWl77yaWzEsOCw2LDIsNSw0LDgsMyw3XQrovpPlh7rvvJo0OQrop6Pph4rvvJrlm77kuK3lnoLnm7Tnur/ku6PooajovpPlhaXmlbDnu4QgWzEsOCw2LDIsNSw0LDgsMyw3XeOAguWcqOatpOaDheWGteS4i++8jOWuueWZqOiDveWkn+Wuuee6s+awtO+8iOihqOekuuS4uuiTneiJsumDqOWIhu+8ieeahOacgOWkp+WAvOS4usKgNDnjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpoZWlnaHQgPSBbMSwxXQrovpPlh7rvvJoxCmBgYCoq5o+Q56S677yaKiotIGBuID09IGhlaWdodC5sZW5ndGhgCi0gYDIgPD0gbiA8PSAxMDVgCi0gYDAgPD0gaGVpZ2h0W2ldIDw9IDEwNGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9jb250YWluZXItd2l0aC1tb3N0LXdhdGVyLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9jb250YWluZXItd2l0aC1tb3N0LXdhdGVyLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5bem5Y+z5oyH6ZKI5LuO5pWw57uE5Lik56uv5byA5aeL77yM5q+P5qyh6K6h566X5b2T5YmN5a655Zmo6Z2i56evIHdpZHRoICogbWluKGhlaWdodFtsZWZ0XSwgaGVpZ2h0W3JpZ2h0XSkg5bm25pu05paw5pyA5aSn5YC844CC5b2T5YmN5a695bqm5LiL77yM55+t5p2/5Yaz5a6a5rC05L2N77yb56e75Yqo6L6D6auY55qE5LiA5L6n5LiN5Lya5o+Q6auY5rC05L2N5LiU5a695bqm5Y+Y5bCP77yM6Z2i56ev5LiN5Y+v6IO95Y+Y5aSn77yM5Zug5q2k5Y+q6IO956e75Yqo6L6D55+t55qE5LiA5L6n5p2l5bCd6K+V5om+5Yiw5pu06auY55+t5p2/44CC5Lik56uv5ZCR5Lit6Ze05pS257yp77yM5omA5pyJ5Y+v6IO95oiQ5Li65pu05LyY6Kej55qE5YCZ6YCJ6YO95LiN5Lya6KKr6YGX5ryP44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5oqK5Lik56uv5L2c5Li65a655Zmo6L6555WM44CC6Z2i56ev55Sx5a695bqm5ZKM6L6D55+t6auY5bqm5Yaz5a6a77yb5oCd6ICD5Li65L2V5q+P6L2u5b+F6aG75Lii5byD55+t5p2/77yM6ICM5LiN5piv6ZW/5p2/44CC') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGxlZnQgPCByaWdodCkgewogICAgICAgICAgICBpbnQgYXJlYSA9IChyaWdodCAtIGxlZnQpICogTWF0aC5taW4oaGVpZ2h0W2xlZnRdLCBoZWlnaHRbcmlnaHRdKTsKICAgICAgICAgICAgbWF4QXJlYSA9IE1hdGgubWF4KG1heEFyZWEsIGFyZWEpOwoKICAgICAgICAgICAgaWYgKGhlaWdodFtsZWZ0XSA8IGhlaWdodFtyaWdodF0pIHsKICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhBcmVhKGludFtdIGhlaWdodCkgewogICAgICAgIGludCBsZWZ0ID0gMDsKICAgICAgICBpbnQgcmlnaHQgPSBoZWlnaHQubGVuZ3RoIC0gMTsKICAgICAgICBpbnQgbWF4QXJlYSA9IDA7CgogICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgaW50IGFyZWEgPSAocmlnaHQgLSBsZWZ0KSAqIE1hdGgubWluKGhlaWdodFtsZWZ0XSwgaGVpZ2h0W3JpZ2h0XSk7CiAgICAgICAgICAgIG1heEFyZWEgPSBNYXRoLm1heChtYXhBcmVhLCBhcmVhKTsKCiAgICAgICAgICAgIGlmIChoZWlnaHRbbGVmdF0gPCBoZWlnaHRbcmlnaHRdKSB7CiAgICAgICAgICAgICAgICBsZWZ0Kys7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICByaWdodC0tOwogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gbWF4QXJlYTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 11
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4) WHERE p.leetcode_number = 11
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 11
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+M5oyH6ZKI5q+P6L2u6K6h566X55qE6Z2i56ev5YWs5byP5Y+K55+t5p2/5LiN5Y+Y6YeP5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6Z2i56ev5Li6IChyaWdodCAtIGxlZnQpICogbWluKGhlaWdodFtsZWZ0XSwgaGVpZ2h0W3JpZ2h0XSnvvJvlnKjlm7rlrprlt6blj7PovrnnlYzml7bvvIzovoPnn63nur/lhrPlrprlrrnlmajmsLTkvY3jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5pu05paw5pyA5aSn6Z2i56ev5ZCO77yM5oyH6ZKI5bqU5aaC5L2V56e75Yqo77yM5Li65LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('56e75Yqo6L6D55+t57q/5omA5Zyo5oyH6ZKI77yb56e75Yqo6L6D6ZW/57q/5Lya6K6p5a695bqm57yp5bCP5LiU55+t5p2/5LiN5Y+Y5oiW5pu05L2O77yM5LiN5Y+v6IO95b6X5Yiw5pu05aSn6Z2i56ev44CC55u4562J5pe25Lu76YCJ5LiA5L6n56e75Yqo44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzmr4/kuKrmjIfpkojoh7PlpJrnp7vliqggbiDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6Z2i56ev5b+F6aG75L2/55SoIChyaWdodCAtIGxlZnQpICogTWF0aC5taW4oaGVpZ2h0W2xlZnRdLCBoZWlnaHRbcmlnaHRdKe+8jOWuveW6puaYr+S4i+agh+W3ru+8jOS4jeaYryByaWdodCAtIGxlZnQgKyAx44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+U6L6D5a6M5Lik56uv6auY5bqm5ZCO5Y+q56e75Yqo6L6D55+t5L6n77yb6auY5bqm55u4562J5pe256e75Yqo5Lu75oSP5LiA5L6n5Y2z5Y+v77yM5L2G5LiN6IO95Lik5L6n6YO95LiN5Yqo77yM5ZCm5YiZ5b6q546v5peg5rOV57uT5p2f44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhBcmVhKGludFtdIGhlaWdodCkgewogICAgICAgIGludCBsZWZ0ID0ge3tibGFua18xfX07CiAgICAgICAgaW50IHJpZ2h0ID0ge3tibGFua18yfX07CiAgICAgICAgaW50IG1heEFyZWEgPSAwOwoKICAgICAgICB3aGlsZSAobGVmdCA8IHJpZ2h0KSB7CiAgICAgICAgICAgIGludCBhcmVhID0ge3tibGFua18zfX07CiAgICAgICAgICAgIG1heEFyZWEgPSBNYXRoLm1heChtYXhBcmVhLCBhcmVhKTsKCiAgICAgICAgICAgIGlmICh7e2JsYW5rXzR9fSkgewogICAgICAgICAgICAgICAge3tibGFua181fX0KICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgIHJldHVybiBtYXhBcmVhOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiMCIsImJsYW5rXzIiOiJoZWlnaHQubGVuZ3RoIC0gMSIsImJsYW5rXzMiOiIocmlnaHQgLSBsZWZ0KSAqIE1hdGgubWluKGhlaWdodFtsZWZ0XSwgaGVpZ2h0W3JpZ2h0XSkiLCJibGFua180IjoiaGVpZ2h0W2xlZnRdIDwgaGVpZ2h0W3JpZ2h0XSIsImJsYW5rXzUiOiJsZWZ0Kys7In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6blj7PlpLnpgLwiLCLnn63mnb/lhrPlrprmsLTkvY0iLCLlhYjnrpfpnaLnp68iLCLnp7vliqjnn63mnb8iLCLlrr3luqbkuIvmoIflt64iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 11
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-6: #15 三数之和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    15, 6, CONVERT(FROM_BASE64('5LiJ5pWw5LmL5ZKM') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzliKTmlq3mmK/lkKblrZjlnKjkuInlhYPnu4QgYFtudW1zW2ldLCBudW1zW2pdLCBudW1zW2tdXWAg5ruh6LazIGBpICE9IGpg44CBYGkgIT0ga2Ag5LiUIGBqICE9IGtgIO+8jOWQjOaXtui/mOa7oei2syBgbnVtc1tpXSArIG51bXNbal0gKyBudW1zW2tdID09IDBgIOOAguivt+S9oOi/lOWbnuaJgOacieWSjOS4uiBgMGAg5LiU5LiN6YeN5aSN55qE5LiJ5YWD57uE44CCKirms6jmhI/vvJoqKuetlOahiOS4reS4jeWPr+S7peWMheWQq+mHjeWkjeeahOS4ieWFg+e7hOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFstMSwwLDEsMiwtMSwtNF0K6L6T5Ye677yaW1stMSwtMSwyXSxbLTEsMCwxXV0K6Kej6YeK77yaCm51bXNbMF0gKyBudW1zWzFdICsgbnVtc1syXSA9ICgtMSkgKyAwICsgMSA9IDAg44CCCm51bXNbMV0gKyBudW1zWzJdICsgbnVtc1s0XSA9IDAgKyAxICsgKC0xKSA9IDAg44CCCm51bXNbMF0gKyBudW1zWzNdICsgbnVtc1s0XSA9ICgtMSkgKyAyICsgKC0xKSA9IDAg44CCCuS4jeWQjOeahOS4ieWFg+e7hOaYryBbLTEsMCwxXSDlkowgWy0xLC0xLDJdIOOAggrms6jmhI/vvIzovpPlh7rnmoTpobrluo/lkozkuInlhYPnu4TnmoTpobrluo/lubbkuI3ph43opoHjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzAsMSwxXQrovpPlh7rvvJpbXQrop6Pph4rvvJrllK/kuIDlj6/og73nmoTkuInlhYPnu4TlkozkuI3kuLogMCDjgIIKYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzAsMCwwXQrovpPlh7rvvJpbWzAsMCwwXV0K6Kej6YeK77ya5ZSv5LiA5Y+v6IO955qE5LiJ5YWD57uE5ZKM5Li6IDAg44CCCmBgYCoq5o+Q56S677yaKiotIGAzIDw9IG51bXMubGVuZ3RoIDw9IDMwMDBgCi0gYC0xMDUgPD0gbnVtc1tpXSA8PSAxMDVgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvM3N1bS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvM3N1bS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5o6S5bqP77yM5p6a5Li+5LiJ5YWD57uE55qE56ys5LiA5Liq5pWwIG51bXNbaV3jgILlr7nmr4/kuKogae+8jOWcqOWMuumXtCBbaSsxLCBuLTFdIOS9v+eUqOW3puWPs+aMh+mSiOWvu+aJvuS4pOaVsOS5i+WSjOetieS6jiAtbnVtc1tpXe+8muWSjOWwj+WImeW3puaMh+mSiOWPs+enu++8jOWSjOWkp+WImeWPs+aMh+mSiOW3puenu++8jOWSjOetieS6jiAwIOWImeiusOW9leetlOahiOW5tui3s+i/h+W3puWPs+S4pOS+p+mHjeWkjeWAvOOAguaOkuW6j+WQjuWPjOaMh+mSiOenu+WKqOWFt+acieWNleiwg+aAp++8m+WbuuWumiBpIOaXtu+8jOavj+WvuSBsZWZ044CBcmlnaHQg5Y+q5Lya6KKr6K6/6Zeu5LiA5qyh44CC6Lez6L+H6YeN5aSN55qEIGnvvIzku6Xlj4rlkb3kuK3nrZTmoYjlkI7ot7Pov4fph43lpI3nmoQgbGVmdC9yaWdodO+8jOS/neivgeavj+S4quS4ieWFg+e7hOWPquWKoOWFpeS4gOasoeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5o6S5bqP5bm25Zu65a6a56ys5LiA5Liq5pWw77yb5Ymp5L2Z5Yy66Ze055So5bem5Y+z5oyH6ZKI5aS56YC844CC5oCd6ICD5ZOq5Lqb5L2N572u5b+F6aG76Lez6L+H6YeN5aSN5YC844CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBBcnJheXMuc29ydChudW1zKTsKCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBudW1zLmxlbmd0aCAtIDI7IGkrKykgewogICAgICAgICAgICBpZiAoaSA+IDAgJiYgbnVtc1tpXSA9PSBudW1zW2kgLSAxXSkgewogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKG51bXNbaV0gPiAwKSB7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgfQoKICAgICAgICAgICAgaW50IGxlZnQgPSBpICsgMSwgcmlnaHQgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgICAgIGxvbmcgc3VtID0gKGxvbmcpIG51bXNbaV0gKyBudW1zW2xlZnRdICsgbnVtc1tyaWdodF07CiAgICAgICAgICAgICAgICBpZiAoc3VtIDwgMCkgewogICAgICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoc3VtID4gMCkgewogICAgICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIHJlc3VsdC5hZGQoQXJyYXlzLmFzTGlzdChudW1zW2ldLCBudW1zW2xlZnRdLCBudW1zW3JpZ2h0XSkpOwogICAgICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgICAgICAgICByaWdodC0tOwogICAgICAgICAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQgJiYgbnVtc1tsZWZ0XSA9PSBudW1zW2xlZnQgLSAxXSkgewogICAgICAgICAgICAgICAgICAgICAgICBsZWZ0Kys7CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQgJiYgbnVtc1tyaWdodF0gPT0gbnVtc1tyaWdodCArIDFdKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheUxpc3Q7CmltcG9ydCBqYXZhLnV0aWwuQXJyYXlzOwppbXBvcnQgamF2YS51dGlsLkxpc3Q7CgpjbGFzcyBTb2x1dGlvbiB7CiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiB0aHJlZVN1bShpbnRbXSBudW1zKSB7CiAgICAgICAgTGlzdDxMaXN0PEludGVnZXI+PiByZXN1bHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBBcnJheXMuc29ydChudW1zKTsKCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBudW1zLmxlbmd0aCAtIDI7IGkrKykgewogICAgICAgICAgICBpZiAoaSA+IDAgJiYgbnVtc1tpXSA9PSBudW1zW2kgLSAxXSkgewogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKG51bXNbaV0gPiAwKSB7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgfQoKICAgICAgICAgICAgaW50IGxlZnQgPSBpICsgMSwgcmlnaHQgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgICAgIGxvbmcgc3VtID0gKGxvbmcpIG51bXNbaV0gKyBudW1zW2xlZnRdICsgbnVtc1tyaWdodF07CiAgICAgICAgICAgICAgICBpZiAoc3VtIDwgMCkgewogICAgICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoc3VtID4gMCkgewogICAgICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIHJlc3VsdC5hZGQoQXJyYXlzLmFzTGlzdChudW1zW2ldLCBudW1zW2xlZnRdLCBudW1zW3JpZ2h0XSkpOwogICAgICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgICAgICAgICByaWdodC0tOwogICAgICAgICAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQgJiYgbnVtc1tsZWZ0XSA9PSBudW1zW2xlZnQgLSAxXSkgewogICAgICAgICAgICAgICAgICAgICAgICBsZWZ0Kys7CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQgJiYgbnVtc1tyaWdodF0gPT0gbnVtc1tyaWdodCArIDFdKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiByZXN1bHQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 15
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 15
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 15
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5o6S5bqP5ZCO77yM5Zu65a6aIG51bXNbaV0g5pe277yMbGVmdCDlkowgcmlnaHQg57u05oqk55qE5qC45b+D5pCc57Si5LiN5Y+Y6YeP5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('bGVmdOOAgXJpZ2h0IOWni+e7iOS9jeS6jiBpIOWPs+S+p+S4lCBsZWZ0IDwgcmlnaHTvvJvlvZPliY3lnKjmnInluo/ljLrpl7TkuK3mkJzntKIgbnVtc1tsZWZ0XSArIG51bXNbcmlnaHRdID0gLW51bXNbaV3vvIzlkozlgY/lsI/ml7blt6bnp7sgbGVmdO+8jOWSjOWBj+Wkp+aXtuWPs+enuyByaWdodOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5om+5YiwIHN1bSA9PSAwIOeahOS4ieWFg+e7hOWQju+8jOaMh+mSiOabtOaWsOWSjOWOu+mHjemhuuW6j+aYr+S7gOS5iO+8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI6K6w5b2V5LiJ5YWD57uE77yM5YaN5omn6KGMIGxlZnQrKyDlkowgcmlnaHQtLe+8jOmaj+WQjuWIhuWIq+WcqCBsZWZ0IDwgcmlnaHQg5p2h5Lu25LiL6Lez6L+H5LiO5YmN5LiA5L2N572u55u45ZCM55qEIGxlZnQg5YC844CB5LiO5ZCO5LiA5L2N572u55u45ZCM55qEIHJpZ2h0IOWAvOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5o6S5bqP5Li6IE8obiBsb2cgbinvvIzlpJblsYLmnprkuL7phY3lkIjlj4zmjIfpkojkuLogTyhuXjIp77yM5oC75pe26Ze0IE8obl4yKe+8m+mZpOi/lOWbnue7k+aenOWklumineWkluepuumXtOS4uiBPKDEp77yM5o6S5bqP5qCI56m66Ze06YCa5bi45LiN6K6h5YWl44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aSW5bGCIGkg5Y676YeN5b+F6aG75YaZ5Zyo6K6/6ZeuIG51bXNbaV0g5ZCO44CB5Y+M5oyH6ZKI5byA5aeL5YmN77yaaWYgKGkgPiAwICYmIG51bXNbaV0gPT0gbnVtc1tpIC0gMV0pIGNvbnRpbnVlO++8jOWQpuWImeebuOWQjOmmluWFg+e0oOS8muS6p+eUn+mHjeWkjeS4ieWFg+e7hOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5om+5Yiw5LiA57uE562U5qGI5ZCO77yM5LiN6IO95Y+q56e75YqoIGxlZnQg5oiWIHJpZ2h077yb5bqU5YWI5ZCM5pe2IGxlZnQrK+OAgXJpZ2h0LS3vvIzlho3liIbliKvot7Pov4fph43lpI3lgLzvvIzlkKbliJnlj6/og73ph43lpI3liqDlhaXlkIzkuIDkuInlhYPnu4TmiJbpgZfmvI/lkI7nu63nu4TlkIjjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheUxpc3Q7CmltcG9ydCBqYXZhLnV0aWwuQXJyYXlzOwppbXBvcnQgamF2YS51dGlsLkxpc3Q7CgpjbGFzcyBTb2x1dGlvbiB7CiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiB0aHJlZVN1bShpbnRbXSBudW1zKSB7CiAgICAgICAgTGlzdDxMaXN0PEludGVnZXI+PiByZXN1bHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICB7e2JsYW5rXzF9fQoKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoIC0gMjsgaSsrKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKG51bXNbaV0gPiAwKSB7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgfQoKICAgICAgICAgICAge3tibGFua18zfX0KICAgICAgICAgICAgd2hpbGUgKGxlZnQgPCByaWdodCkgewogICAgICAgICAgICAgICAgbG9uZyBzdW0gPSB7e2JsYW5rXzR9fTsKICAgICAgICAgICAgICAgIGlmIChzdW0gPCAwKSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdCsrOwogICAgICAgICAgICAgICAgfSBlbHNlIGlmIChzdW0gPiAwKSB7CiAgICAgICAgICAgICAgICAgICAgcmlnaHQtLTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgcmVzdWx0LmFkZChBcnJheXMuYXNMaXN0KG51bXNbaV0sIG51bXNbbGVmdF0sIG51bXNbcmlnaHRdKSk7CiAgICAgICAgICAgICAgICAgICAgbGVmdCsrOwogICAgICAgICAgICAgICAgICAgIHJpZ2h0LS07CiAgICAgICAgICAgICAgICAgICAgd2hpbGUgKGxlZnQgPCByaWdodCAmJiBudW1zW2xlZnRdID09IG51bXNbbGVmdCAtIDFdKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgd2hpbGUgKGxlZnQgPCByaWdodCAmJiBudW1zW3JpZ2h0XSA9PSBudW1zW3JpZ2h0ICsgMV0pIHsKICAgICAgICAgICAgICAgICAgICAgICAgcmlnaHQtLTsKICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHJlc3VsdDsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiQXJyYXlzLnNvcnQobnVtcyk7IiwiYmxhbmtfMiI6ImkgPiAwICYmIG51bXNbaV0gPT0gbnVtc1tpIC0gMV0iLCJibGFua18zIjoiaW50IGxlZnQgPSBpICsgMSwgcmlnaHQgPSBudW1zLmxlbmd0aCAtIDE7IiwiYmxhbmtfNCI6Iihsb25nKSBudW1zW2ldICsgbnVtc1tsZWZ0XSArIG51bXNbcmlnaHRdIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmjpLluo8iLCLlm7rlrprpppblhYPntKAiLCLlt6blj7PmjIfpkogiLCLkuInlpITljrvph40iLCLlkoznmoTljZXosIPnp7vliqgiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 15
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-7: #42 接雨水

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    42, 7, CONVERT(FROM_BASE64('5o6l6Zuo5rC0') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5a6aIGBuYCDkuKrpnZ7otJ/mlbTmlbDooajnpLrmr4/kuKrlrr3luqbkuLogYDFgIOeahOafseWtkOeahOmrmOW6puWbvu+8jOiuoeeul+aMieatpOaOkuWIl+eahOafseWtkO+8jOS4i+mbqOS5i+WQjuiDveaOpeWkmuWwkembqOawtOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAxOC8xMC8yMi9yYWlud2F0ZXJ0cmFwLnBuZykKCmBgYHRleHQK6L6T5YWl77yaaGVpZ2h0ID0gWzAsMSwwLDIsMSwwLDEsMywyLDEsMiwxXQrovpPlh7rvvJo2Cuino+mHiu+8muS4iumdouaYr+eUseaVsOe7hCBbMCwxLDAsMiwxLDAsMSwzLDIsMSwyLDFdIOihqOekuueahOmrmOW6puWbvu+8jOWcqOi/meenjeaDheWGteS4i++8jOWPr+S7peaOpSA2IOS4quWNleS9jeeahOmbqOawtO+8iOiTneiJsumDqOWIhuihqOekuumbqOawtO+8ieOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmhlaWdodCA9IFs0LDIsMCwzLDIsNV0K6L6T5Ye677yaOQpgYGAqKuaPkOekuu+8mioqLSBgbiA9PSBoZWlnaHQubGVuZ3RoYAotIGAxIDw9IG4gPD0gMiAqIDEwNGAKLSBgMCA8PSBoZWlnaHRbaV0gPD0gMTA1YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3RyYXBwaW5nLXJhaW4td2F0ZXIvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3RyYXBwaW5nLXJhaW4td2F0ZXIvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55So5Y+M5oyH6ZKI5LuO5Lik56uv5ZCR5Lit6Ze05pS257yp44CCbGVmdE1heCDooajnpLrlt6bmjIfpkojlj4rlhbblt6bkvqfmnIDpq5jmn7HvvIxyaWdodE1heCDooajnpLrlj7PmjIfpkojlj4rlhbblj7PkvqfmnIDpq5jmn7HjgILoi6UgaGVpZ2h0W2xlZnRdIDw9IGhlaWdodFtyaWdodF3vvIzliJkgbGVmdCDkvY3nva7nmoTlj7PkvqfkuIDlrprlrZjlnKjpq5jluqboh7PlsJHkuLogaGVpZ2h0W2xlZnRdIOeahOi+ueeVjO+8jOWboOatpOivpeS9jee9ruiDveaOpeeahOawtOWPqueUsSBsZWZ0TWF4IOWGs+Wumu+8mue0r+WKoCBsZWZ0TWF4IC0gaGVpZ2h0W2xlZnRd77yM5oiW5pu05pawIGxlZnRNYXjvvJvlj7PkvqflkIznkIbjgILmr4/ova7lpITnkIbkuIDkuKrkvY3nva7lkI7np7vliqjlr7nlupTmjIfpkojvvIznm7TliLDkuKTmjIfpkojnm7jpgYfjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5bem5Y+z5ZCE57u05oqk5bey6KeB5pyA6auY5p+x44CC5q+P5qyh5LyY5YWI5aSE55CG6L6D55+u55qE5LiA56uv77yM5Zug5Li65Y+m5LiA56uv5b2T5YmN5p+x5bey6IO95L+d6K+B5b2i5oiQ5Y+zL+W3pui+ueeVjOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICB3aGlsZSAobGVmdCA8IHJpZ2h0KSB7CiAgICAgICAgICAgIGlmIChoZWlnaHRbbGVmdF0gPD0gaGVpZ2h0W3JpZ2h0XSkgewogICAgICAgICAgICAgICAgaWYgKGhlaWdodFtsZWZ0XSA+PSBsZWZ0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdE1heCA9IGhlaWdodFtsZWZ0XTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgd2F0ZXIgKz0gbGVmdE1heCAtIGhlaWdodFtsZWZ0XTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGlmIChoZWlnaHRbcmlnaHRdID49IHJpZ2h0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgcmlnaHRNYXggPSBoZWlnaHRbcmlnaHRdOwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICB3YXRlciArPSByaWdodE1heCAtIGhlaWdodFtyaWdodF07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByaWdodC0tOwogICAgICAgICAgICB9CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCB0cmFwKGludFtdIGhlaWdodCkgewogICAgICAgIGludCBsZWZ0ID0gMDsKICAgICAgICBpbnQgcmlnaHQgPSBoZWlnaHQubGVuZ3RoIC0gMTsKICAgICAgICBpbnQgbGVmdE1heCA9IDA7CiAgICAgICAgaW50IHJpZ2h0TWF4ID0gMDsKICAgICAgICBpbnQgd2F0ZXIgPSAwOwoKICAgICAgICB3aGlsZSAobGVmdCA8IHJpZ2h0KSB7CiAgICAgICAgICAgIGlmIChoZWlnaHRbbGVmdF0gPD0gaGVpZ2h0W3JpZ2h0XSkgewogICAgICAgICAgICAgICAgaWYgKGhlaWdodFtsZWZ0XSA+PSBsZWZ0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdE1heCA9IGhlaWdodFtsZWZ0XTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgd2F0ZXIgKz0gbGVmdE1heCAtIGhlaWdodFtsZWZ0XTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGlmIChoZWlnaHRbcmlnaHRdID49IHJpZ2h0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgcmlnaHRNYXggPSBoZWlnaHRbcmlnaHRdOwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICB3YXRlciArPSByaWdodE1heCAtIGhlaWdodFtyaWdodF07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByaWdodC0tOwogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gd2F0ZXI7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4) WHERE p.leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+M5oyH6ZKI6Kej5rOV57u05oqk55qE5qC45b+D54q25oCB5LiO5b6q546v5LiN5Y+Y6YeP5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('57u05oqkIGxlZnTjgIFyaWdodOOAgWxlZnRNYXjjgIFyaWdodE1heCDlkowgd2F0ZXLjgIJsZWZ0TWF4L3JpZ2h0TWF4IOWIhuWIq+aYr+S4pOerr+W3suaJq+aPj+WMuuWfn+eahOacgOmrmOafse+8m+avj+asoeWkhOeQhui+g+efruW9k+WJjeafseeahOS4gOS+p++8jOivpeS9jee9ruWPr+eUseacrOS+p+acgOWkp+mrmOW6puehruWumuiThOawtOmHj+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Li65LuA5LmIIGhlaWdodFtsZWZ0XSA8PSBoZWlnaHRbcmlnaHRdIOaXtuWPr+S7pee7k+eul+W3puS+p++8jOS4lOabtOaWsOmhuuW6j+aYr+S7gOS5iO+8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5Y+z5L6n5b2T5YmN5p+x6Iez5bCR5LiO5bem5p+x562J6auY77yM5Y+z5L6n5b+F5a2Y5Zyo6Laz5aSf6L6555WM77yM5omA5Lul5bem5L6n5rC06YeP5Y+q5Y+XIGxlZnRNYXgg6ZmQ5Yi244CC5YWI5pu05pawIGxlZnRNYXgg5oiW57Sv5YqgIGxlZnRNYXggLSBoZWlnaHRbbGVmdF3vvIzlho3miafooYwgbGVmdCsr44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l6Kej5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzmr4/kuKrmjIfpkojmnIDlpJrnp7vliqggbiDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+U6L6D55qE5pivIGhlaWdodFtsZWZ0XSDlkowgaGVpZ2h0W3JpZ2h0Xe+8jOS4jeaYr+avlOi+gyBsZWZ0TWF4IOS4jiByaWdodE1heO+8m+i+g+efruW9k+WJjeafseaJgOWcqOeahOS4gOS+p+aJjeWPr+WuieWFqOe7k+eul+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aSE55CG5p+Q5L6n5pe25bqU5YWI55So6K+l5L6nIG1heCDkuI7lvZPliY3pq5jluqborqHnrpfmsLTph4/miJbmm7TmlrAgbWF477yM5YaN56e75Yqo6K+l5L6n5oyH6ZKI77yb5o+Q5YmN56e75Yqo5Lya5ryP566X6L6555WM5L2N572u44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCB0cmFwKGludFtdIGhlaWdodCkgewogICAgICAgIGludCBsZWZ0ID0gMDsKICAgICAgICBpbnQgcmlnaHQgPSBoZWlnaHQubGVuZ3RoIC0gMTsKICAgICAgICB7e2JsYW5rXzF9fQogICAgICAgIGludCByaWdodE1heCA9IDA7CiAgICAgICAgaW50IHdhdGVyID0gMDsKCiAgICAgICAgd2hpbGUgKGxlZnQgPCByaWdodCkgewogICAgICAgICAgICB7e2JsYW5rXzJ9fQogICAgICAgICAgICAgICAgaWYgKGhlaWdodFtsZWZ0XSA+PSBsZWZ0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdE1heCA9IGhlaWdodFtsZWZ0XTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAge3tibGFua18zfX0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGlmIChoZWlnaHRbcmlnaHRdID49IHJpZ2h0TWF4KSB7CiAgICAgICAgICAgICAgICAgICAgcmlnaHRNYXggPSBoZWlnaHRbcmlnaHRdOwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICB3YXRlciArPSByaWdodE1heCAtIGhlaWdodFtyaWdodF07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB7e2JsYW5rXzR9fQogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gd2F0ZXI7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaW50IGxlZnRNYXggPSAwOyIsImJsYW5rXzIiOiJpZiAoaGVpZ2h0W2xlZnRdIDw9IGhlaWdodFtyaWdodF0pIHsiLCJibGFua18zIjoid2F0ZXIgKz0gbGVmdE1heCAtIGhlaWdodFtsZWZ0XTsiLCJibGFua180IjoicmlnaHQtLTsifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6blj7Plj4zmjIfpkogiLCLkuKTkvqfmnIDpq5jmn7EiLCLlpITnkIbovoPnn67nq68iLCLlhYjnu5PnrpflkI7np7vliqgiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 42
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-8: #3 无重复字符的最长子串

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    3, 8, CONVERT(FROM_BASE64('5peg6YeN5aSN5a2X56ym55qE5pyA6ZW/5a2Q5Liy') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5a2X56ym5LiyIGBzYCDvvIzor7fkvaDmib7lh7rlhbbkuK3kuI3lkKvmnInph43lpI3lrZfnrKbnmoQqKuacgOmVvyDlrZDkuLIqKioqKirnmoTplb/luqbjgIIqKuekuuS+iyAxOioqYGBgdGV4dArovpPlhaU6IHMgPSAiYWJjYWJjYmIiCui+k+WHujogMwrop6Pph4o6IOWboOS4uuaXoOmHjeWkjeWtl+espueahOacgOmVv+WtkOS4suaYryAiYWJjIu+8jOaJgOS7peWFtumVv+W6puS4uiAz44CC5rOo5oSPICJiY2EiIOWSjCAiY2FiIiDkuZ/mmK/mraPnoa7nrZTmoYjjgIIKYGBgKirnpLrkvosgMjoqKmBgYHRleHQK6L6T5YWlOiBzID0gImJiYmJiIgrovpPlh7o6IDEK6Kej6YeKOiDlm6DkuLrml6Dph43lpI3lrZfnrKbnmoTmnIDplb/lrZDkuLLmmK8gImIi77yM5omA5Lul5YW26ZW/5bqm5Li6IDHjgIIKYGBgKirnpLrkvosgMzoqKmBgYHRleHQK6L6T5YWlOiBzID0gInB3d2tldyIK6L6T5Ye6OiAzCuino+mHijog5Zug5Li65peg6YeN5aSN5a2X56ym55qE5pyA6ZW/5a2Q5Liy5pivwqAid2tlIu+8jOaJgOS7peWFtumVv+W6puS4uiAz44CCCsKgICAgIOivt+azqOaEj++8jOS9oOeahOetlOahiOW/hemhu+aYryDlrZDkuLIg55qE6ZW/5bqm77yMInB3a2UiwqDmmK/kuIDkuKrlrZDluo/liJfvvIzkuI3mmK/lrZDkuLLjgIIKYGBgKirmj5DnpLrvvJoqKi0gYDAgPD0gcy5sZW5ndGggPD0gMTA1YAotIGBzYCDnlLHoi7HmloflrZfmr43jgIHmlbDlrZfjgIHnrKblj7flkoznqbrmoLznu4TmiJAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9sb25nZXN0LXN1YnN0cmluZy13aXRob3V0LXJlcGVhdGluZy1jaGFyYWN0ZXJzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9sb25nZXN0LXN1YnN0cmluZy13aXRob3V0LXJlcGVhdGluZy1jaGFyYWN0ZXJzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5ZOI5biM6KGoIGxhc3Qg6K6w5b2V5q+P5Liq5a2X56ym5pyA6L+R5LiA5qyh5Ye6546w55qE5LiL5qCH77yM5ruR5Yqo56qX5Y+j5aeL57uI6KGo56S65Li6IFtsZWZ0LCByaWdodF3vvIzlubbkv53mjIHlhbbkuK3msqHmnInph43lpI3lrZfnrKbjgILmjIkgcmlnaHQg5LuO5bem5Yiw5Y+z5omp5bGV56qX5Y+j77ya6Iul5b2T5YmN5a2X56ymIGMg5LiK5qyh5Ye6546w55qE5L2N572u5LuN5Zyo56qX5Y+j5YaF77yIbGFzdC5nZXQoYykgPj0gbGVmdO+8ie+8jOWImeW/hemhu+WwhiBsZWZ0IOi3s+WIsOivpemHjeWkjeWtl+espuS4iuasoeS9jee9rueahOWQjuS4gOS9je+8m+maj+WQjuabtOaWsCBjIOeahOacgOaWsOS9jee9ru+8jOW5tueUqOW9k+WJjeeql+WPo+mVv+W6piByaWdodCAtIGxlZnQgKyAxIOabtOaWsOetlOahiOOAgmxlZnQg5Y+q5Lya5Y+z56e777yM5Zug5q2k5q+P5Liq5a2X56ym5pyA5aSa6KKr5bem5Y+z5oyH6ZKI5ZCE5aSE55CG5LiA5qyh44CC') USING utf8mb4), CONVERT(FROM_BASE64('57u05oqk5peg6YeN5aSN56qX5Y+j55qE5bem6L6555WM44CC5a2X56ym6YeN5aSN5pe277yM5Y+q5pyJ5YW25LiK5qyh5L2N572u5LuN5Zyo5b2T5YmN56qX5Y+j5YaF77yM5omN56e75Yqo5bem6L6555WM44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgcmlnaHQgPSAwOyByaWdodCA8IHMubGVuZ3RoKCk7IHJpZ2h0KyspIHsKICAgICAgICAgICAgY2hhciBjID0gcy5jaGFyQXQocmlnaHQpOwogICAgICAgICAgICBpZiAobGFzdC5jb250YWluc0tleShjKSAmJiBsYXN0LmdldChjKSA+PSBsZWZ0KSB7CiAgICAgICAgICAgICAgICBsZWZ0ID0gbGFzdC5nZXQoYykgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGxhc3QucHV0KGMsIHJpZ2h0KTsKICAgICAgICAgICAgbWF4ID0gTWF0aC5tYXgobWF4LCByaWdodCAtIGxlZnQgKyAxKTsKICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5IYXNoTWFwOwppbXBvcnQgamF2YS51dGlsLk1hcDsKCmNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBpbnQgbGVuZ3RoT2ZMb25nZXN0U3Vic3RyaW5nKFN0cmluZyBzKSB7CiAgICAgICAgTWFwPENoYXJhY3RlciwgSW50ZWdlcj4gbGFzdCA9IG5ldyBIYXNoTWFwPD4oKTsKICAgICAgICBpbnQgbGVmdCA9IDA7CiAgICAgICAgaW50IG1heCA9IDA7CgogICAgICAgIGZvciAoaW50IHJpZ2h0ID0gMDsgcmlnaHQgPCBzLmxlbmd0aCgpOyByaWdodCsrKSB7CiAgICAgICAgICAgIGNoYXIgYyA9IHMuY2hhckF0KHJpZ2h0KTsKICAgICAgICAgICAgaWYgKGxhc3QuY29udGFpbnNLZXkoYykgJiYgbGFzdC5nZXQoYykgPj0gbGVmdCkgewogICAgICAgICAgICAgICAgbGVmdCA9IGxhc3QuZ2V0KGMpICsgMTsKICAgICAgICAgICAgfQogICAgICAgICAgICBsYXN0LnB1dChjLCByaWdodCk7CiAgICAgICAgICAgIG1heCA9IE1hdGgubWF4KG1heCwgcmlnaHQgLSBsZWZ0ICsgMSk7CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gbWF4OwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4) WHERE p.leetcode_number = 3
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 3
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 3
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5ZOI5biM6KGoIGxhc3Qg5ZKM5ruR5Yqo56qX5Y+jIFtsZWZ0LCByaWdodF0g5YiG5Yir57u05oqk5LuA5LmI54q25oCB77yf') USING utf8mb4), CONVERT(FROM_BASE64('bGFzdCDorrDlvZXmr4/kuKrlrZfnrKbmnIDov5HkuIDmrKHlh7rnjrDnmoTkuIvmoIfvvJvnqpflj6MgW2xlZnQsIHJpZ2h0XSDlp4vnu4jkv53mjIHkuI3lkKvph43lpI3lrZfnrKbjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6YGH5Yiw5a2X56ymIGMg5pe277yM5LuA5LmI5p2h5Lu25LiL56e75YqoIGxlZnTvvIznp7vliqjliLDlk6rph4zvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5b2TIGxhc3Qg5YyF5ZCrIGMg5LiUIGxhc3QuZ2V0KGMpID49IGxlZnQg5pe277yM6K+05piOIGMg5Zyo5b2T5YmN56qX5Y+j5YaF6YeN5aSN77yM5bCGIGxlZnQg5pu05paw5Li6IGxhc3QuZ2V0KGMpICsgMeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzmr4/kuKogcmlnaHQg5Y+q6YGN5Y6G5LiA5qyh5LiUIGxlZnQg5Y2V6LCD5Y+z56e777yb56m66Ze05aSN5p2C5bqmIE8obWluKG4sIOWtl+espumbhuWkp+Wwjykp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6IO95Y+q6KaB5a2X56ym5Ye6546w6L+H5bCx56e75YqoIGxlZnTvvJvlj6rmnIkgbGFzdC5nZXQoYykgPj0gbGVmdCDml7bvvIzor6Xph43lpI3lrZfnrKbmiY3kvY3kuo7lvZPliY3nqpflj6PlhoXjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5pu05pawIGxlZnQg5ZCO5YaN6K6h566X56qX5Y+j6ZW/5bqm77yM5bm25Zyo5pyA5ZCO5omn6KGMIGxhc3QucHV0KGMsIHJpZ2h0KSDorrDlvZXlvZPliY3lrZfnrKbnmoTmnIDmlrDkuIvmoIfjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5IYXNoTWFwOwppbXBvcnQgamF2YS51dGlsLk1hcDsKCmNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBpbnQgbGVuZ3RoT2ZMb25nZXN0U3Vic3RyaW5nKFN0cmluZyBzKSB7CiAgICAgICAgTWFwPENoYXJhY3RlciwgSW50ZWdlcj4gbGFzdCA9IG5ldyBIYXNoTWFwPD4oKTsKICAgICAgICBpbnQgbGVmdCA9IHt7YmxhbmtfMX19OwogICAgICAgIGludCBtYXggPSAwOwoKICAgICAgICBmb3IgKGludCByaWdodCA9IDA7IHJpZ2h0IDwgcy5sZW5ndGgoKTsgcmlnaHQrKykgewogICAgICAgICAgICBjaGFyIGMgPSBzLmNoYXJBdChyaWdodCk7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgbGVmdCA9IHt7YmxhbmtfM319OwogICAgICAgICAgICB9CiAgICAgICAgICAgIHt7YmxhbmtfNH19OwogICAgICAgICAgICBtYXggPSB7e2JsYW5rXzV9fTsKICAgICAgICB9CgogICAgICAgIHJldHVybiBtYXg7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiMCIsImJsYW5rXzIiOiJsYXN0LmNvbnRhaW5zS2V5KGMpICYmIGxhc3QuZ2V0KGMpID49IGxlZnQiLCJibGFua18zIjoibGFzdC5nZXQoYykgKyAxIiwiYmxhbmtfNCI6Imxhc3QucHV0KGMsIHJpZ2h0KSIsImJsYW5rXzUiOiJNYXRoLm1heChtYXgsIHJpZ2h0IC0gbGVmdCArIDEpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmnIDov5Hlh7rnjrDkuIvmoIciLCLnqpflj6Pml6Dph43lpI0iLCJsZWZ0IOWNleiwg+WPs+enuyIsIumHjeWkjei3s+i/h+aXp+S9jee9riIsInJpZ2h0LWxlZnQrMSJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 3
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-9: #438 找到字符串中所有字母异位词

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    438, 9, CONVERT(FROM_BASE64('5om+5Yiw5a2X56ym5Liy5Lit5omA5pyJ5a2X5q+N5byC5L2N6K+N') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5Lik5Liq5a2X56ym5LiyIGBzYCDlkowgYHBg77yM5om+5YiwIGBzYCoqKirkuK3miYDmnIkgYHBgKioqKueahCoq5byC5L2N6K+NKirnmoTlrZDkuLLvvIzov5Tlm57ov5nkupvlrZDkuLLnmoTotbflp4vntKLlvJXjgILkuI3ogIPomZHnrZTmoYjovpPlh7rnmoTpobrluo/jgIIqKuekuuS+iyAxOioqYGBgdGV4dArovpPlhaU6IHMgPSAiY2JhZWJhYmFjZCIsIHAgPSAiYWJjIgrovpPlh7o6IFswLDZdCuino+mHijoK6LW35aeL57Si5byV562J5LqOIDAg55qE5a2Q5Liy5pivICJjYmEiLCDlroPmmK8gImFiYyIg55qE5byC5L2N6K+N44CCCui1t+Wni+e0ouW8leetieS6jiA2IOeahOWtkOS4suaYryAiYmFjIiwg5a6D5pivICJhYmMiIOeahOW8guS9jeivjeOAggpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IHMgPSAiYWJhYiIsIHAgPSAiYWIiCui+k+WHujogWzAsMSwyXQrop6Pph4o6Cui1t+Wni+e0ouW8leetieS6jiAwIOeahOWtkOS4suaYryAiYWIiLCDlroPmmK8gImFiIiDnmoTlvILkvY3or43jgIIK6LW35aeL57Si5byV562J5LqOIDEg55qE5a2Q5Liy5pivICJiYSIsIOWug+aYryAiYWIiIOeahOW8guS9jeivjeOAggrotbflp4vntKLlvJXnrYnkuo4gMiDnmoTlrZDkuLLmmK8gImFiIiwg5a6D5pivICJhYiIg55qE5byC5L2N6K+N44CCCmBgYCoq5o+Q56S6OioqLSBgMSA8PSBzLmxlbmd0aCwgcC5sZW5ndGggPD0gMyAqIDEwNGAKLSBgc2Ag5ZKMIGBwYCDku4XljIXlkKvlsI/lhpnlrZfmr40KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9maW5kLWFsbC1hbmFncmFtcy1pbi1hLXN0cmluZy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZmluZC1hbGwtYW5hZ3JhbXMtaW4tYS1zdHJpbmcvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55So6ZW/5bqm5Zu65a6a5Li6IHAubGVuZ3RoKCkg55qE5ruR5Yqo56qX5Y+j44CCY291bnRbY10g6KGo56S65b2T5YmN56qX5Y+j55u45a+5IHAg6L+Y57y65bCR77yI5q2j5pWw77yJ5oiW5aSa5L2Z77yI6LSf5pWw77yJ55qE5a2X56ymIGPvvJvlhYjlsIYgcCDnmoTlrZfnrKborqHlhaUgY291bnTjgILlj7PmjIfpkojliqDlhaXlrZfnrKbml7bpgJLlh48gY291bnTvvIzoi6XpgJLlh4/liY0gY291bnQg5aSn5LqOIDDvvIzor7TmmI7ooaXkuIrkuobkuIDkuKrmiYDpnIDlrZfnrKbvvIx2YWxpZCsr44CC56qX5Y+j6LaF6L+HIHAg6ZW/5bqm5pe256e75Ye65bem5a2X56ym77yM6Iul6YCS5aKe5YmNIGNvdW50IOWkp+S6juetieS6jiAw77yM6K+05piO56e76LWw5LqG5LiA5Liq5Y6f5pys5Yy56YWN55qE5a2X56ym77yMdmFsaWQtLeOAgueql+WPo+mVv+W6puaBsOS4uiBwLmxlbmd0aCgpIOS4lCB2YWxpZCDnrYnkuo4gcC5sZW5ndGgoKSDml7bvvIznqpflj6PlhoXlrZfnrKblpJrph43pm4blkIjkuI4gcCDlrozlhajnm7jlkIzjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI6K6w5b2VIHAg5Lit5ZCE5a2X56ym6ZyA5rGC77yb56qX5Y+j5Y+z5omp5pe257uf6K6h6KGl6b2Q55qE5a2X56ym5pWw77yM6LaF6L+HIHAg6ZW/5bqm5bCx5bem57yp44CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBpbnQgbGVmdCA9IDA7CiAgICAgICAgaW50IHZhbGlkID0gMDsKICAgICAgICBmb3IgKGludCByaWdodCA9IDA7IHJpZ2h0IDwgcy5sZW5ndGgoKTsgcmlnaHQrKykgewogICAgICAgICAgICBpZiAoY291bnRbcy5jaGFyQXQocmlnaHQpIC0gJ2EnXS0tID4gMCkgewogICAgICAgICAgICAgICAgdmFsaWQrKzsKICAgICAgICAgICAgfQoKICAgICAgICAgICAgaWYgKHJpZ2h0IC0gbGVmdCArIDEgPiBwLmxlbmd0aCgpKSB7CiAgICAgICAgICAgICAgICBpZiAoY291bnRbcy5jaGFyQXQobGVmdCsrKSAtICdhJ10rKyA+PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgdmFsaWQtLTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQoKICAgICAgICAgICAgaWYgKHZhbGlkID09IHAubGVuZ3RoKCkpIHsKICAgICAgICAgICAgICAgIHJlc3VsdC5hZGQobGVmdCk7CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gZmluZEFuYWdyYW1zKFN0cmluZyBzLCBTdHJpbmcgcCkgewogICAgICAgIExpc3Q8SW50ZWdlcj4gcmVzdWx0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgaW50W10gY291bnQgPSBuZXcgaW50WzI2XTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IHAubGVuZ3RoKCk7IGkrKykgewogICAgICAgICAgICBjb3VudFtwLmNoYXJBdChpKSAtICdhJ10rKzsKICAgICAgICB9CgogICAgICAgIGludCBsZWZ0ID0gMDsKICAgICAgICBpbnQgdmFsaWQgPSAwOwogICAgICAgIGZvciAoaW50IHJpZ2h0ID0gMDsgcmlnaHQgPCBzLmxlbmd0aCgpOyByaWdodCsrKSB7CiAgICAgICAgICAgIGlmIChjb3VudFtzLmNoYXJBdChyaWdodCkgLSAnYSddLS0gPiAwKSB7CiAgICAgICAgICAgICAgICB2YWxpZCsrOwogICAgICAgICAgICB9CgogICAgICAgICAgICBpZiAocmlnaHQgLSBsZWZ0ICsgMSA+IHAubGVuZ3RoKCkpIHsKICAgICAgICAgICAgICAgIGlmIChjb3VudFtzLmNoYXJBdChsZWZ0KyspIC0gJ2EnXSsrID49IDApIHsKICAgICAgICAgICAgICAgICAgICB2YWxpZC0tOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CgogICAgICAgICAgICBpZiAodmFsaWQgPT0gcC5sZW5ndGgoKSkgewogICAgICAgICAgICAgICAgcmVzdWx0LmFkZChsZWZ0KTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gcmVzdWx0OwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4) WHERE p.leetcode_number = 438
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 438
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 438
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('Y291bnQg5pWw57uE5ZKMIHZhbGlkIOWIhuWIq+ihqOekuuS7gOS5iOS4jeWPmOmHj++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('Y291bnRbY10g6KGo56S65b2T5YmN56qX5Y+j55u45a+5IHAg5a+55a2X56ymIGMg55qE5Ymp5L2Z6ZyA5rGC77ya5q2j5pWw5Li657y65bCR77yM6LSf5pWw5Li65aSa5L2Z77ybdmFsaWQg6KGo56S656qX5Y+j5Lit5bey5Yy56YWN5Yiw55qE44CB5oyJ6YeN5pWw6K6h566X55qEIHAg5a2X56ym5oC75pWw44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bem56uv5a2X56ym56e75Ye656qX5Y+j5pe277yM5Li65LuA5LmI5Yik5pat6KaB5YaZ5oiQIGNvdW50W3JlbW92ZV0rKyA+PSAw77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5aKe5YmNIGNvdW50ID49IDAg6K+05piO6K+l5a2X56ym5Zyo56qX5Y+j5Lit5bGe5LqO5bey5Yy56YWN55qE6ZyA5rGC5a2X56ym77yM56e76LWw5ZCOIHZhbGlkIOW/hemhu+WHj+S4gO+8m+iLpemAkuWinuWJjeS4uui0n+aVsO+8jOenu+i1sOeahOaYr+WkmuS9meWtl+espu+8jOS4jeW9seWTjSB2YWxpZOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8ofHN8K3xwfCnvvIzmr4/kuKrmjIfpkojmnIDlpJrnp7vliqjkuIDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTygxKe+8jOWtl+espuiuoeaVsOaVsOe7hOWkp+Wwj+WbuuWumuS4uiAyNuOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('56e75Ye65bem56uv5a2X56ym5pe25b+F6aG75YWI5Yik5patIGNvdW50W3JlbW92ZV0gPj0gMCDlho3miafooYwgKyvvvJvoi6XlhYggKysg5YaN5Yik5pat77yM5Lya5oqK5Y6f5pys5aSa5L2Z55qE5a2X56ym6K+v6K6h5Li65pyJ5pWI5Yy56YWN44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5ZG95Lit562U5qGI5YmN5b+F6aG75L+d6K+B56qX5Y+j6ZW/5bqm562J5LqOIHAubGVuZ3RoKCnvvJvlj6rliKTmlq0gdmFsaWQgPT0gcC5sZW5ndGgoKSDogIzkuI3mjqfliLbnqpflj6Pplb/luqbvvIzkvJrmiormm7Tplb/nqpflj6Por6/liqDlhaXnu5PmnpzjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gZmluZEFuYWdyYW1zKFN0cmluZyBzLCBTdHJpbmcgcCkgewogICAgICAgIExpc3Q8SW50ZWdlcj4gcmVzdWx0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgaW50W10gY291bnQgPSB7e2JsYW5rXzF9fTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IHAubGVuZ3RoKCk7IGkrKykgewogICAgICAgICAgICB7e2JsYW5rXzJ9fQogICAgICAgIH0KCiAgICAgICAgaW50IGxlZnQgPSAwOwogICAgICAgIGludCB2YWxpZCA9IDA7CiAgICAgICAgZm9yIChpbnQgcmlnaHQgPSAwOyByaWdodCA8IHMubGVuZ3RoKCk7IHJpZ2h0KyspIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICB2YWxpZCsrOwogICAgICAgICAgICB9CgogICAgICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzV9fSkgewogICAgICAgICAgICAgICAgICAgIHZhbGlkLS07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KCiAgICAgICAgICAgIGlmICh2YWxpZCA9PSBwLmxlbmd0aCgpKSB7CiAgICAgICAgICAgICAgICByZXN1bHQuYWRkKGxlZnQpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiByZXN1bHQ7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibmV3IGludFsyNl0iLCJibGFua18yIjoiY291bnRbcC5jaGFyQXQoaSkgLSAnYSddKys7IiwiYmxhbmtfMyI6ImNvdW50W3MuY2hhckF0KHJpZ2h0KSAtICdhJ10tLSA+IDAiLCJibGFua180IjoicmlnaHQgLSBsZWZ0ICsgMSA+IHAubGVuZ3RoKCkiLCJibGFua181IjoiY291bnRbcy5jaGFyQXQobGVmdCsrKSAtICdhJ10rKyA+PSAwIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlm7rlrprplb/luqbnqpflj6MiLCLpnIDmsYLlt67liIbmlbDnu4QiLCJ2YWxpZCDljLnphY3mlbAiLCLlt6bnp7vlhYjliKTlkI7liqAiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 438
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-10: #560 和为 K 的子数组

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    560, 10, CONVERT(FROM_BASE64('5ZKM5Li6IEsg55qE5a2Q5pWw57uE') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDlkozkuIDkuKrmlbTmlbAgYGtgIO+8jOivt+S9oOe7n+iuoeW5tui/lOWbniAq6K+l5pWw57uE5Lit5ZKM5Li6IGBrYCoqKirnmoTlrZDmlbDnu4TnmoTkuKrmlbAq44CCCgrlrZDmlbDnu4TmmK/mlbDnu4TkuK3lhYPntKDnmoTov57nu63pnZ7nqbrluo/liJfjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMSwxLDFdLCBrID0gMgrovpPlh7rvvJoyCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDIsM10sIGsgPSAzCui+k+WHuu+8mjIKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMiAqIDEwNGAKLSBgLTEwMDAgPD0gbnVtc1tpXSA8PSAxMDAwYAotIGAtMTA3IDw9IGsgPD0gMTA3YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3N1YmFycmF5LXN1bS1lcXVhbHMtay8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc3ViYXJyYXktc3VtLWVxdWFscy1rLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5YmN57yA5ZKMIHN1bSDooajnpLrku44gbnVtc1swXSDliLDlvZPliY3kvY3nva7nmoTlhYPntKDlkozjgILoi6Xmn5DkuKrmraTliY3liY3nvIDlkozkuLogc3VtLWvvvIzliJnkuKTogIXkuYvpl7TnmoTov57nu63lrZDmlbDnu4TlkozmgbDlpb3kuLoga+OAguWTiOW4jOihqCBmcmVxIOe7tOaKpOKAnOW3sumBjeWOhuWJjee8gOWSjCAtPiDlh7rnjrDmrKHmlbDigJ3vvIzku47lt6bliLDlj7PpgY3ljobml7bvvIzlhYjntK/orqEgZnJlcVtzdW0ta10g5Yiw562U5qGI77yM5YaN5bCG5b2T5YmNIHN1bSDlhpnlhaUgZnJlce+8jOS/neivgeWPque7n+iuoeWPs+err+eCueS4jeaZmuS6juW9k+WJjeS9jee9rueahOWtkOaVsOe7hOOAguWIneWniyBmcmVxWzBdPTHvvIzooajnpLrnqbrliY3nvIDvvIzkvb/lvpfku47kuIvmoIcgMCDlvIDlp4vjgIHlkozkuLogayDnmoTlrZDmlbDnu4Tog73ooqvnu5/orqHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5oqK5q+P5Liq5L2N572u5b2T5L2c5a2Q5pWw57uE5Y+z56uv54K544CC6Iul5b2T5YmN5YmN57yA5ZKM5pivIHN1be+8jOmcgOimgeaJvuatpOWJjeWHuueOsOi/h+WkmuWwkeS4qiBzdW0ta+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludCBudW0gOiBudW1zKSB7CiAgICAgICAgICAgIHN1bSArPSBudW07CiAgICAgICAgICAgIGNvdW50ICs9IGZyZXEuZ2V0T3JEZWZhdWx0KHN1bSAtIGssIDApOwogICAgICAgICAgICBmcmVxLnB1dChzdW0sIGZyZXEuZ2V0T3JEZWZhdWx0KHN1bSwgMCkgKyAxKTsKICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzdWJhcnJheVN1bShpbnRbXSBudW1zLCBpbnQgaykgewogICAgICAgIGphdmEudXRpbC5NYXA8SW50ZWdlciwgSW50ZWdlcj4gZnJlcSA9IG5ldyBqYXZhLnV0aWwuSGFzaE1hcDw+KCk7CiAgICAgICAgaW50IHN1bSA9IDA7CiAgICAgICAgaW50IGNvdW50ID0gMDsKICAgICAgICBmcmVxLnB1dCgwLCAxKTsKCiAgICAgICAgZm9yIChpbnQgbnVtIDogbnVtcykgewogICAgICAgICAgICBzdW0gKz0gbnVtOwogICAgICAgICAgICBjb3VudCArPSBmcmVxLmdldE9yRGVmYXVsdChzdW0gLSBrLCAwKTsKICAgICAgICAgICAgZnJlcS5wdXQoc3VtLCBmcmVxLmdldE9yRGVmYXVsdChzdW0sIDApICsgMSk7CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gY291bnQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4) WHERE p.leetcode_number = 560
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 560
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 560
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YmN57yA5ZKM') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YmN57yA5ZKM') USING utf8mb4) WHERE p.leetcode_number = 560
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5ZOI5biM6KGoIGZyZXEg55qE6ZSu5ZKM5YC85YiG5Yir6KGo56S65LuA5LmI77yf5Li65LuA5LmI6KaB5Yid5aeL5YyWIGZyZXFbMF09Me+8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6ZSu5piv5YmN57yA5ZKM77yM5YC85piv6K+l5YmN57yA5ZKM5Zyo5b2T5YmN5L2N572u5LmL5YmN5Ye6546w55qE5qyh5pWw44CCZnJlcVswXT0xIOihqOekuuepuuWJjee8gO+8jOeUqOS6jue7n+iuoeS7juS4i+aghyAwIOW8gOWni+S4lOWSjOS4uiBrIOeahOWtkOaVsOe7hOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aSE55CG5q+P5LiqIG51bSDlkI7vvIzmn6Xor6IgZnJlcVtzdW0ta10g5LiO5pu05pawIGZyZXFbc3VtXSDnmoTmraPnoa7pobrluo/mmK/ku4DkuYjvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5LukIGNvdW50IOWKoOS4iiBmcmVxLmdldE9yRGVmYXVsdChzdW0taywgMCnvvIzlho3lop7liqAgZnJlcVtzdW1d44CC6L+Z5qC35b2T5YmN5YmN57yA5ZKM5LiN5Lya6KKr5b2T5L2c5q2k5YmN5YmN57yA77yM6YG/5YWNIGs9MCDml7borqHlhaXnqbrlrZDmlbDnu4TjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l6Kej5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzmr4/kuKrlhYPntKDlj6rlpITnkIbkuIDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTyhuKe+8jOWTiOW4jOihqOacgOWkmuWtmOWCqCBuKzEg5Liq5LiN5ZCM5YmN57yA5ZKM44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75Yid5aeL5YyWIGZyZXEucHV0KDAsIDEp77yM5ZCm5YiZ5YmN57yA5ZKM5pys6Lqr562J5LqOIGsg5pe277yM5Y2z5LuO5LiL5qCHIDAg5byA5aeL55qE5a2Q5pWw57uE5LiN5Lya6KKr6K6h5YWl44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b6q546v5Lit5b+F6aG75YWI5p+l6K+i5bm257Sv5YqgIGZyZXEuZ2V0T3JEZWZhdWx0KHN1bSAtIGssIDAp77yM5YaN5pu05paw5b2T5YmNIHN1bSDnmoTlh7rnjrDmrKHmlbDvvJvlj43ov4fmnaXkvJrlnKggaz0wIOaXtuaKiuepuuWtkOaVsOe7hOmUmeivr+iuoeWFpeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzdWJhcnJheVN1bShpbnRbXSBudW1zLCBpbnQgaykgewogICAgICAgIGphdmEudXRpbC5NYXA8SW50ZWdlciwgSW50ZWdlcj4gZnJlcSA9IG5ldyBqYXZhLnV0aWwuSGFzaE1hcDw+KCk7CiAgICAgICAge3tibGFua18xfX0KICAgICAgICBpbnQgY291bnQgPSAwOwogICAgICAgIHt7YmxhbmtfMn19CgogICAgICAgIGZvciAoaW50IG51bSA6IG51bXMpIHsKICAgICAgICAgICAgc3VtICs9IG51bTsKICAgICAgICAgICAge3tibGFua18zfX0KICAgICAgICAgICAge3tibGFua180fX0KICAgICAgICB9CgogICAgICAgIHJldHVybiBjb3VudDsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaW50IHN1bSA9IDA7IiwiYmxhbmtfMiI6ImZyZXEucHV0KDAsIDEpOyIsImJsYW5rXzMiOiJjb3VudCArPSBmcmVxLmdldE9yRGVmYXVsdChzdW0gLSBrLCAwKTsiLCJibGFua180IjoiZnJlcS5wdXQoc3VtLCBmcmVxLmdldE9yRGVmYXVsdChzdW0sIDApICsgMSk7In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLliY3nvIDlkowiLCLlk4jluIzooajorqHmlbAiLCJzdW0tayIsIuWFiOafpeWQjuWtmCIsIuepuuWJjee8gCJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 560
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-11: #239 滑动窗口最大值

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    239, 11, CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j5pyA5aSn5YC8') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYO+8jOacieS4gOS4quWkp+Wwj+S4uiBga2AqKueahOa7keWKqOeql+WPo+S7juaVsOe7hOeahOacgOW3puS+p+enu+WKqOWIsOaVsOe7hOeahOacgOWPs+S+p+OAguS9oOWPquWPr+S7peeci+WIsOWcqOa7keWKqOeql+WPo+WGheeahCBga2Ag5Liq5pWw5a2X44CC5ruR5Yqo56qX5Y+j5q+P5qyh5Y+q5ZCR5Y+z56e75Yqo5LiA5L2N44CCCgrov5Tlm54gKua7keWKqOeql+WPo+S4reeahOacgOWkp+WAvCrjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMSwzLC0xLC0zLDUsMyw2LDddLCBrID0gMwrovpPlh7rvvJpbMywzLDUsNSw2LDddCuino+mHiu+8mgrmu5Hliqjnqpflj6PnmoTkvY3nva4gICAgICAgICAgICAgICAg5pyA5aSn5YC8Ci0tLS0tLS0tLS0tLS0tLSAgICAgICAgICAgICAgIC0tLS0tClsxICAzICAtMV0gLTMgIDUgIDMgIDYgIDcgICAgICAgMwoxIFszICAtMSAgLTNdIDUgIDMgIDYgIDcgICAgICAgMwoxICAzIFstMSAgLTMgIDVdIDMgIDYgIDcgICAgICAgNQoxICAzICAtMSBbLTMgIDUgIDNdIDYgIDcgICAgICAgNQoxICAzICAtMSAgLTMgWzUgIDMgIDZdIDcgICAgICAgNgoxICAzICAtMSAgLTMgIDUgWzMgIDYgIDddICAgICAgNwpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMV0sIGsgPSAxCui+k+WHuu+8mlsxXQpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBudW1zLmxlbmd0aCA8PSAxMDVgCi0gYC0xMDQgPD0gbnVtc1tpXSA8PSAxMDRgCi0gYDEgPD0gayA8PSBudW1zLmxlbmd0aGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9zbGlkaW5nLXdpbmRvdy1tYXhpbXVtLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9zbGlkaW5nLXdpbmRvdy1tYXhpbXVtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('57u05oqk5LiA5Liq5a2Y5pS+5LiL5qCH55qE5Y+M56uv6Zif5YiX77yM6Zif5aS05Yiw6Zif5bC+5a+55bqU55qEIG51bXMg5YC85Lil5qC86YCS5YeP77yM5Zug5q2k6Zif5aS05aeL57uI5piv5b2T5YmN56qX5Y+j5pyA5aSn5YC855qE5LiL5qCH44CC6YGN5Y6G5q+P5LiqIGkg5pe277yM5YWI5LuO6Zif5aS05Yig6Zmk5bey56a75byA56qX5Y+j55qE5LiL5qCH77yIPD0gaS1r77yJ77yb5YaN5LuO6Zif5bC+5Yig6Zmk5YC85LiN5aSn5LqOIG51bXNbaV0g55qE5LiL5qCH77yM5paw5YWD57Sg5YWl6Zif5ZCO5LuN5L+d5oyB6YCS5YeP44CC5b2TIGk+PWstMSDml7bvvIznqpflj6Plt7LlvaLmiJDvvIzlsIbpmJ/lpLTlr7nlupTlgLzlhpnlhaXnrZTmoYjjgILmr4/kuKrkuIvmoIfmnIDlpJrlhaXpmJ/jgIHlh7rpmJ/lkITkuIDmrKHvvIzmiYDku6XmlbTkvZPnur/mgKfjgII=') USING utf8mb4), CONVERT(FROM_BASE64('6Zif5YiX5Lit5LiN6KaB5a2Y5YC86ICM6KaB5a2Y5LiL5qCH77yb6Zif5aS06LSf6LSj5pyA5aSn5YC877yM6Zif5bC+6LSf6LSj57u05oqk6YCS5YeP5oCn77yM5bm25Y+K5pe25Yig6Zmk56qX5Y+j5bem5L6n6L+H5pyf5LiL5qCH44CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47IGkrKykgewogICAgICAgICAgICB3aGlsZSAoIWRlcXVlLmlzRW1wdHkoKSAmJiBkZXF1ZS5wZWVrRmlyc3QoKSA8PSBpIC0gaykgewogICAgICAgICAgICAgICAgZGVxdWUucG9sbEZpcnN0KCk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgd2hpbGUgKCFkZXF1ZS5pc0VtcHR5KCkgJiYgbnVtc1tkZXF1ZS5wZWVrTGFzdCgpXSA8PSBudW1zW2ldKSB7CiAgICAgICAgICAgICAgICBkZXF1ZS5wb2xsTGFzdCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGRlcXVlLm9mZmVyTGFzdChpKTsKCiAgICAgICAgICAgIGlmIChpID49IGsgLSAxKSB7CiAgICAgICAgICAgICAgICBhbnNbaSAtIGsgKyAxXSA9IG51bXNbZGVxdWUucGVla0ZpcnN0KCldOwogICAgICAgICAgICB9CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheURlcXVlOwppbXBvcnQgamF2YS51dGlsLkRlcXVlOwoKY2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIG1heFNsaWRpbmdXaW5kb3coaW50W10gbnVtcywgaW50IGspIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludFtdIGFucyA9IG5ldyBpbnRbbiAtIGsgKyAxXTsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBkZXF1ZSA9IG5ldyBBcnJheURlcXVlPD4oKTsKCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyBpKyspIHsKICAgICAgICAgICAgd2hpbGUgKCFkZXF1ZS5pc0VtcHR5KCkgJiYgZGVxdWUucGVla0ZpcnN0KCkgPD0gaSAtIGspIHsKICAgICAgICAgICAgICAgIGRlcXVlLnBvbGxGaXJzdCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHdoaWxlICghZGVxdWUuaXNFbXB0eSgpICYmIG51bXNbZGVxdWUucGVla0xhc3QoKV0gPD0gbnVtc1tpXSkgewogICAgICAgICAgICAgICAgZGVxdWUucG9sbExhc3QoKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBkZXF1ZS5vZmZlckxhc3QoaSk7CgogICAgICAgICAgICBpZiAoaSA+PSBrIC0gMSkgewogICAgICAgICAgICAgICAgYW5zW2kgLSBrICsgMV0gPSBudW1zW2RlcXVlLnBlZWtGaXJzdCgpXTsKICAgICAgICAgICAgfQogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6Zif5YiX') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6Zif5YiX') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y2V6LCD6Zif5YiX') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y2V6LCD6Zif5YiX') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4) WHERE p.leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y2V6LCD6Zif5YiX5a2Y5YKo5LuA5LmI77yf6Zif5YiX6ZyA6KaB5L+d5oyB5LuA5LmI5LiN5Y+Y6YeP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5a2Y5YKo5pWw57uE5LiL5qCH77yb5LuO6Zif5aS05Yiw6Zif5bC+5a+55bqUIG51bXMg5YC85Lil5qC86YCS5YeP77yM5LiU5omA5pyJ5LiL5qCH6YO95bGe5LqO5b2T5YmN56qX5Y+j77yM5Zug5q2k6Zif5aS05LiL5qCH5a+55bqU56qX5Y+j5pyA5aSn5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6YGN5Y6G5Yiw5LiL5qCHIGkg5pe277yM6L+H5pyf5YWD57Sg5ZKM6Zif5bC+5YWD57Sg5YiG5Yir5aaC5L2V5aSE55CG77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5Yig6Zmk6Zif5aS05omA5pyJ5ruh6LazIGRlcXVlLnBlZWtGaXJzdCgpIDw9IGkgLSBrIOeahOi/h+acn+S4i+agh++8m+WGjeWIoOmZpOmYn+WwvuaJgOaciea7oei2syBudW1zW2RlcXVlLnBlZWtMYXN0KCldIDw9IG51bXNbaV0g55qE5LiL5qCH77yM5pyA5ZCO5bCGIGkg5YWl6Zif44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l5Y2V6LCD6Zif5YiX6Kej5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzmr4/kuKrkuIvmoIfmnIDlpJrlhaXpmJ/lkozlh7rpmJ/kuIDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTyhrKe+8jOmYn+WIl+acgOWkmuS/neWtmOS4gOS4queql+WPo+WGheeahOS4i+agh+OAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+H5pyf5Yik5pat5b+F6aG75pivIGRlcXVlLnBlZWtGaXJzdCgpIDw9IGkgLSBr77yb6Iul5YaZ5oiQIDwgaSAtIGvvvIzkvJrkv53nlZnlt7Lnu4/nprvlvIDlvZPliY3nqpflj6PnmoTkuIvmoIfjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('57u05oqk6Zif5bC+5pe25bqU5Yig6ZmkIG51bXNbZGVxdWUucGVla0xhc3QoKV0gPD0gbnVtc1tpXSDnmoTkuIvmoIfvvJvnm7jnrYnlgLzkv53nlZnovoPmlrDnmoTkuIvmoIfvvIzpgb/lhY3ovoPml6fkuIvmoIfov4fmnJ/lkI7lvbHlk43pmJ/liJfnu7TmiqTjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheURlcXVlOwppbXBvcnQgamF2YS51dGlsLkRlcXVlOwoKY2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIG1heFNsaWRpbmdXaW5kb3coaW50W10gbnVtcywgaW50IGspIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludFtdIGFucyA9IG5ldyBpbnRbbiAtIGsgKyAxXTsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBkZXF1ZSA9IG5ldyBBcnJheURlcXVlPD4oKTsKCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyBpKyspIHsKICAgICAgICAgICAgd2hpbGUgKCFkZXF1ZS5pc0VtcHR5KCkgJiYgZGVxdWUucGVla0ZpcnN0KCkgPD0ge3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIGRlcXVlLnBvbGxGaXJzdCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHdoaWxlICghZGVxdWUuaXNFbXB0eSgpICYmIHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICBkZXF1ZS5wb2xsTGFzdCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHt7YmxhbmtfM319OwoKICAgICAgICAgICAgaWYgKGkgPj0gayAtIDEpIHsKICAgICAgICAgICAgICAgIGFuc1tpIC0gayArIDFdID0ge3tibGFua180fX07CiAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgIHJldHVybiBhbnM7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaSAtIGsiLCJibGFua18yIjoibnVtc1tkZXF1ZS5wZWVrTGFzdCgpXSA8PSBudW1zW2ldIiwiYmxhbmtfMyI6ImRlcXVlLm9mZmVyTGFzdChpKSIsImJsYW5rXzQiOiJudW1zW2RlcXVlLnBlZWtGaXJzdCgpXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljZXosIPpgJLlh4/pmJ/liJciLCLpmJ/liJflrZjkuIvmoIciLCLliKDpmaTov4fmnJ/kuIvmoIciLCLpmJ/lsL7lvLnlh7rovoPlsI/lgLwiLCLpmJ/lpLTnqpflj6PmnIDlpKflgLwiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 239
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-12: #76 最小覆盖子串

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    76, 12, CONVERT(FROM_BASE64('5pyA5bCP6KaG55uW5a2Q5Liy') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5a6a5Lik5Liq5a2X56ym5LiyIGBzYCDlkowgYHRg77yM6ZW/5bqm5YiG5Yir5pivIGBtYCDlkowgYG5g77yM6L+U5ZueIHMg5Lit55qEKirmnIDnn63nqpflj6Mg5a2Q5LiyKirvvIzkvb/lvpfor6XlrZDkuLLljIXlkKsgYHRgIOS4reeahOavj+S4gOS4quWtl+espu+8iCoq5YyF5ous6YeN5aSN5a2X56ymKirvvInjgILlpoLmnpzmsqHmnInov5nmoLfnmoTlrZDkuLLvvIzov5Tlm57nqbrlrZfnrKbkuLIqKmAiImDjgIIKCua1i+ivleeUqOS+i+S/neivgeetlOahiOWUr+S4gOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yacyA9ICJBRE9CRUNPREVCQU5DIiwgdCA9ICJBQkMiCui+k+WHuu+8miJCQU5DIgrop6Pph4rvvJrmnIDlsI/opobnm5blrZDkuLIgIkJBTkMiIOWMheWQq+adpeiHquWtl+espuS4siB0IOeahCAnQSfjgIEnQicg5ZKMICdDJ+OAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiYSIsIHQgPSAiYSIK6L6T5Ye677yaImEiCuino+mHiu+8muaVtOS4quWtl+espuS4siBzIOaYr+acgOWwj+imhuebluWtkOS4suOAggpgYGAqKuekuuS+iyAzOioqYGBgdGV4dArovpPlhaU6IHMgPSAiYSIsIHQgPSAiYWEiCui+k+WHujogIiIK6Kej6YeKOiB0IOS4reS4pOS4quWtl+espiAnYScg5Z2H5bqU5YyF5ZCr5ZyoIHMg55qE5a2Q5Liy5Lit77yMCuWboOatpOayoeacieespuWQiOadoeS7tueahOWtkOWtl+espuS4su+8jOi/lOWbnuepuuWtl+espuS4suOAggpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBzLmxlbmd0aGAKLSBgbiA9PSB0Lmxlbmd0aGAKLSBgMSA8PSBtLCBuIDw9IDEwNWAKLSBgc2Ag5ZKMIGB0YCDnlLHoi7HmloflrZfmr43nu4TmiJAqKui/m+mYtu+8mioq5L2g6IO96K6+6K6h5LiA5Liq5ZyoIGBPKG0gKyBuKWAg5pe26Ze05YaF6Kej5Yaz5q2k6Zeu6aKY55qE566X5rOV5ZCX77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbWluaW11bS13aW5kb3ctc3Vic3RyaW5nLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9taW5pbXVtLXdpbmRvdy1zdWJzdHJpbmcvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('55So6ZW/5bqm5Li6IDEyOCDnmoQgbmVlZCDmlbDnu4TorrDlvZXmr4/kuKrlrZfnrKbov5jnvLrlpJrlsJHkuKrvvIxtaXNzaW5nIOihqOekuuW9k+WJjeeql+WPo+aAu+WFsei/mOe8uueahOWtl+espuaVsOmHj++8iOaMiemHjeWkjeasoeaVsOiuoeeul++8ieOAguWPs+aMh+mSiOS4jeaWreaJqeW8oO+8muiLpeWKoOWFpeeahOWtl+espuato+aYr+eql+WPo+aJgOe8uu+8jOWImSBtaXNzaW5nIOWHj+S4gO+8m+maj+WQjiBuZWVkW2NdIOWHj+S4gOOAguW9kyBtaXNzaW5nPT0wIOaXtu+8jOeql+WPo+W3suimhuebliB077yM5q2k5pe25LiN5pat56e75Yqo5bem5oyH6ZKI5pS257yp56qX5Y+j77ya5YWI6K6w5b2V5pyA55+t562U5qGI77yM5YaN56e76Zmk5bem5a2X56ym77yb6Iul56e76Zmk5ZCOIG5lZWRbY10g5Y+Y5Li65q2j5pWw77yM6K+05piO56qX5Y+j6YeN5paw57y65bCR6K+l5a2X56ym77yMbWlzc2luZyDliqDkuIDlubblgZzmraLmlLbnvKnjgILlj7PmjIfpkojljZXosIPlj7Pnp7vjgIHlt6bmjIfpkojljZXosIPlj7Pnp7vvvIzmr4/kuKrlrZfnrKbmnIDlpJrov5vlh7rnqpflj6PkuIDmrKHvvIzlm6DmraTmraPnoa7kuJTpq5jmlYjjgII=') USING utf8mb4), CONVERT(FROM_BASE64('bmVlZCDorrDlvZXigJzov5jnvLrlpJrlsJHigJ3vvIxtaXNzaW5nIOiusOW9leKAnOaAu+WFsei/mOe8uuWkmuWwkeKAneOAguWPs+aJqea7oei2s+imhuebluWQju+8jOW3pue8qeWIsOWImuWkseaViOS4uuatouOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludCByaWdodCA9IDA7IHJpZ2h0IDwgcy5sZW5ndGgoKTsgcmlnaHQrKykgewogICAgICAgICAgICBjaGFyIGMgPSBzLmNoYXJBdChyaWdodCk7CiAgICAgICAgICAgIGlmIChuZWVkW2NdID4gMCkgewogICAgICAgICAgICAgICAgbWlzc2luZy0tOwogICAgICAgICAgICB9CiAgICAgICAgICAgIG5lZWRbY10tLTsKCiAgICAgICAgICAgIHdoaWxlIChtaXNzaW5nID09IDApIHsKICAgICAgICAgICAgICAgIGlmIChyaWdodCAtIGxlZnQgKyAxIDwgbWluTGVuKSB7CiAgICAgICAgICAgICAgICAgICAgc3RhcnQgPSBsZWZ0OwogICAgICAgICAgICAgICAgICAgIG1pbkxlbiA9IHJpZ2h0IC0gbGVmdCArIDE7CiAgICAgICAgICAgICAgICB9CgogICAgICAgICAgICAgICAgY2hhciByZW1vdmVkID0gcy5jaGFyQXQobGVmdCsrKTsKICAgICAgICAgICAgICAgIG5lZWRbcmVtb3ZlZF0rKzsKICAgICAgICAgICAgICAgIGlmIChuZWVkW3JlbW92ZWRdID4gMCkgewogICAgICAgICAgICAgICAgICAgIG1pc3NpbmcrKzsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFN0cmluZyBtaW5XaW5kb3coU3RyaW5nIHMsIFN0cmluZyB0KSB7CiAgICAgICAgaW50W10gbmVlZCA9IG5ldyBpbnRbMTI4XTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IHQubGVuZ3RoKCk7IGkrKykgewogICAgICAgICAgICBuZWVkW3QuY2hhckF0KGkpXSsrOwogICAgICAgIH0KCiAgICAgICAgaW50IGxlZnQgPSAwOwogICAgICAgIGludCBtaXNzaW5nID0gdC5sZW5ndGgoKTsKICAgICAgICBpbnQgc3RhcnQgPSAwOwogICAgICAgIGludCBtaW5MZW4gPSBJbnRlZ2VyLk1BWF9WQUxVRTsKCiAgICAgICAgZm9yIChpbnQgcmlnaHQgPSAwOyByaWdodCA8IHMubGVuZ3RoKCk7IHJpZ2h0KyspIHsKICAgICAgICAgICAgY2hhciBjID0gcy5jaGFyQXQocmlnaHQpOwogICAgICAgICAgICBpZiAobmVlZFtjXSA+IDApIHsKICAgICAgICAgICAgICAgIG1pc3NpbmctLTsKICAgICAgICAgICAgfQogICAgICAgICAgICBuZWVkW2NdLS07CgogICAgICAgICAgICB3aGlsZSAobWlzc2luZyA9PSAwKSB7CiAgICAgICAgICAgICAgICBpZiAocmlnaHQgLSBsZWZ0ICsgMSA8IG1pbkxlbikgewogICAgICAgICAgICAgICAgICAgIHN0YXJ0ID0gbGVmdDsKICAgICAgICAgICAgICAgICAgICBtaW5MZW4gPSByaWdodCAtIGxlZnQgKyAxOwogICAgICAgICAgICAgICAgfQoKICAgICAgICAgICAgICAgIGNoYXIgcmVtb3ZlZCA9IHMuY2hhckF0KGxlZnQrKyk7CiAgICAgICAgICAgICAgICBuZWVkW3JlbW92ZWRdKys7CiAgICAgICAgICAgICAgICBpZiAobmVlZFtyZW1vdmVkXSA+IDApIHsKICAgICAgICAgICAgICAgICAgICBtaXNzaW5nKys7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgIHJldHVybiBtaW5MZW4gPT0gSW50ZWdlci5NQVhfVkFMVUUgPyAiIiA6IHMuc3Vic3RyaW5nKHN0YXJ0LCBzdGFydCArIG1pbkxlbik7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2Q5Liy') USING utf8mb4) WHERE p.leetcode_number = 76
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 76
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 76
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ruR5Yqo56qX5Y+j') USING utf8mb4) WHERE p.leetcode_number = 76
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('bmVlZCDmlbDnu4TlkowgbWlzc2luZyDliIbliKvooajnpLrku4DkuYjkuI3lj5jph4/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('bmVlZFtjXSDooajnpLrlvZPliY3nqpflj6Pot53nprvmu6HotrMgdCDkuK3lrZfnrKYgYyDnmoTpnIDmsYLov5jlt67lpJrlsJHvvIzotJ/mlbDooajnpLogYyDmnInlpJrkvZnvvJttaXNzaW5nIOihqOekuuaJgOacieWtl+espuaAu+WFsei/mOe8uueahOasoeaVsO+8jG1pc3Npbmc9PTAg5pe256qX5Y+j6KaG55uWIHTjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bem5Y+z5oyH6ZKI5pu05paw5pe277yMbWlzc2luZyDnmoTliKTmlq3mnaHku7bliIbliKvmmK/ku4DkuYjvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5Y+z5omp5Yqg5YWlIGMg5pe277yM6IulIG5lZWRbY10+MCDliJkgbWlzc2luZy0t77yM6ZqP5ZCOIG5lZWRbY10tLe+8m+W3pue8qeenu+mZpCBjIOaXtu+8jOWFiCBuZWVkW2NdKyvvvIzoi6XmraTml7YgbmVlZFtjXT4wIOWImSBtaXNzaW5nKyvjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obStuKe+8jOaehOW7uumcgOaxguaVsOe7hOS4uiBPKG4p77yM5Y+M5oyH6ZKI5omr5o+P5Li6IE8obSnvvJvnqbrpl7TlpI3mnYLluqYgTygxKe+8jOWtl+espuaVsOe7hOWkp+Wwj+WbuuWumuS4uiAxMjjjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+z5omp5pe25b+F6aG75YWI5Yik5patIG5lZWRbY10gPiAwIOWGjeiuqSBtaXNzaW5nLS3vvIzlm6DkuLrnqpflj6PkuK3lpJrkvZnlrZfnrKbkvJrkvb8gbmVlZFtjXSDkuLogMCDmiJbotJ/mlbDvvIzkuI3og73lh4/lsJHnvLrlpLHmgLvmlbDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bem57yp5pe25YWI6K6w5b2V5b2T5YmN5pyJ5pWI56qX5Y+j77yM5YaN5omn6KGMIG5lZWRbY10rK++8m+WPquaciemAkuWinuWJjSBuZWVkW2NdID49IDAg5pe277yM56e76Zmk6K+l5a2X56ym5omN5Lya5a+86Ie0IG1pc3NpbmcrK+OAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFN0cmluZyBtaW5XaW5kb3coU3RyaW5nIHMsIFN0cmluZyB0KSB7CiAgICAgICAgaW50W10gbmVlZCA9IHt7YmxhbmtfMX19OwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgdC5sZW5ndGgoKTsgaSsrKSB7CiAgICAgICAgICAgIG5lZWRbdC5jaGFyQXQoaSldKys7CiAgICAgICAgfQoKICAgICAgICBpbnQgbGVmdCA9IDA7CiAgICAgICAgaW50IG1pc3NpbmcgPSB0Lmxlbmd0aCgpOwogICAgICAgIGludCBzdGFydCA9IDA7CiAgICAgICAgaW50IG1pbkxlbiA9IEludGVnZXIuTUFYX1ZBTFVFOwoKICAgICAgICBmb3IgKGludCByaWdodCA9IDA7IHJpZ2h0IDwgcy5sZW5ndGgoKTsgcmlnaHQrKykgewogICAgICAgICAgICBjaGFyIGMgPSBzLmNoYXJBdChyaWdodCk7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgbWlzc2luZy0tOwogICAgICAgICAgICB9CiAgICAgICAgICAgIG5lZWRbY10tLTsKCiAgICAgICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgaWYgKHJpZ2h0IC0gbGVmdCArIDEgPCBtaW5MZW4pIHsKICAgICAgICAgICAgICAgICAgICBzdGFydCA9IGxlZnQ7CiAgICAgICAgICAgICAgICAgICAgbWluTGVuID0gcmlnaHQgLSBsZWZ0ICsgMTsKICAgICAgICAgICAgICAgIH0KCiAgICAgICAgICAgICAgICBjaGFyIHJlbW92ZWQgPSBzLmNoYXJBdChsZWZ0KyspOwogICAgICAgICAgICAgICAgbmVlZFtyZW1vdmVkXSsrOwogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfNH19KSB7CiAgICAgICAgICAgICAgICAgICAgbWlzc2luZysrOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICByZXR1cm4gbWluTGVuID09IEludGVnZXIuTUFYX1ZBTFVFID8gIiIgOiBzLnN1YnN0cmluZyhzdGFydCwgc3RhcnQgKyBtaW5MZW4pOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibmV3IGludFsxMjhdIiwiYmxhbmtfMiI6Im5lZWRbY10gPiAwIiwiYmxhbmtfMyI6Im1pc3NpbmcgPT0gMCIsImJsYW5rXzQiOiJuZWVkW3JlbW92ZWRdID4gMCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJuZWVkIOe8uuWPo+aVsOe7hCIsIm1pc3Npbmcg5oC757y65aSxIiwi5Y+z5omp5bem57ypIiwi6KaG55uW5ZCO5pS257ypIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 76
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-13: #53 最大子数组和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    53, 13, CONVERT(FROM_BASE64('5pyA5aSn5a2Q5pWw57uE5ZKM') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzor7fkvaDmib7lh7rkuIDkuKrlhbfmnInmnIDlpKflkoznmoTov57nu63lrZDmlbDnu4TvvIjlrZDmlbDnu4TmnIDlsJHljIXlkKvkuIDkuKrlhYPntKDvvInvvIzov5Tlm57lhbbmnIDlpKflkozjgIIqKuWtkOaVsOe7hCoq5piv5pWw57uE5Lit55qE5LiA5Liq6L+e57ut6YOo5YiG44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWy0yLDEsLTMsNCwtMSwyLDEsLTUsNF0K6L6T5Ye677yaNgrop6Pph4rvvJrov57nu63lrZDmlbDnu4TCoFs0LC0xLDIsMV0g55qE5ZKM5pyA5aSn77yM5Li6wqA2IOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMV0K6L6T5Ye677yaMQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbNSw0LC0xLDcsOF0K6L6T5Ye677yaMjMKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTA1YAotIGAtMTA0IDw9IG51bXNbaV0gPD0gMTA0YCoq6L+b6Zi277yaKirlpoLmnpzkvaDlt7Lnu4/lrp7njrDlpI3mnYLluqbkuLogYE8obilgIOeahOino+azle+8jOWwneivleS9v+eUqOabtOS4uueyvuWmmeeahCoq5YiG5rK75rOVKirmsYLop6PjgIIKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9tYXhpbXVtLXN1YmFycmF5LykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9tYXhpbXVtLXN1YmFycmF5Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55SoIEthZGFuZSDliqjmgIHop4TliJLjgILku6QgY3VyIOihqOekuuKAnOW/hemhu+S7peW9k+WJjeWFg+e0oOe7k+WwvuKAneeahOacgOWkp+i/nue7reWtkOaVsOe7hOWSjO+8mumBjeWOhuWIsCBudW1zW2ldIOaXtu+8jGN1ciDopoHkuYjku44gbnVtc1tpXSDph43mlrDlvIDlp4vvvIzopoHkuYjmjqXlnKjliY3kuIDkuKogY3VyIOWQjumdou+8jOWboOatpCBjdXIgPSBtYXgobnVtc1tpXSwgY3VyICsgbnVtc1tpXSnjgIJiZXN0IOe7tOaKpOmBjeWOhui/h+eahOaJgOaciSBjdXIg5Lit5pyA5aSn5YC844CC5Yid5aeL5YyW5Li6IG51bXNbMF3vvIzkv53or4HlhajotJ/mlbDnu4Tml7bkuZ/og73ov5Tlm57lhbbkuK3mnIDlpKfnmoTlhYPntKDvvJvku47kuIvmoIcgMSDmraPluo/pgY3ljobvvIzlvqrnjq/nu5PmnZ/lkI4gYmVzdCDljbPkuLrnrZTmoYjjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5a6a5LmJ4oCc5Lul5b2T5YmN5L2N572u57uT5bC+4oCd55qE5pyA5aSn5ZKM44CC6ICD6JmR5b2T5YmN5YWD57Sg5piv5Y2V54us5byA5paw5a2Q5pWw57uE77yM6L+Y5piv5o6l5Yiw5YmN6Z2i55qE6L+e57ut5a2Q5pWw57uE5ZCO44CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG51bXMubGVuZ3RoOyBpKyspIHsKICAgICAgICAgICAgY3VyID0gTWF0aC5tYXgobnVtc1tpXSwgY3VyICsgbnVtc1tpXSk7CiAgICAgICAgICAgIGJlc3QgPSBNYXRoLm1heChiZXN0LCBjdXIpOwogICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhTdWJBcnJheShpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IGN1ciA9IG51bXNbMF07CiAgICAgICAgaW50IGJlc3QgPSBudW1zWzBdOwoKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG51bXMubGVuZ3RoOyBpKyspIHsKICAgICAgICAgICAgY3VyID0gTWF0aC5tYXgobnVtc1tpXSwgY3VyICsgbnVtc1tpXSk7CiAgICAgICAgICAgIGJlc3QgPSBNYXRoLm1heChiZXN0LCBjdXIpOwogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIGJlc3Q7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 53
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 53
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 53
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 53
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('S2FkYW5lIOeul+azleS4rSBjdXIg5ZKMIGJlc3Qg5YiG5Yir6KGo56S65LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('Y3VyIOaYr+W/hemhu+S7peW9k+WJjeS4i+agh+e7k+WwvueahOacgOWkp+i/nue7reWtkOaVsOe7hOWSjO+8m2Jlc3Qg5piv5oiq6Iez5b2T5YmN5LiL5qCH5pe25omA5pyJIGN1ciDnmoTmnIDlpKflgLzjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Li65LuA5LmIIGN1ciDkuI4gYmVzdCDopoHliJ3lp4vljJbkuLogbnVtc1swXe+8jOW+queOr+S7jiBpPTEg5byA5aeL77yf') USING utf8mb4), CONVERT(FROM_BASE64('5a2Q5pWw57uE6Iez5bCR5ZCr5LiA5Liq5YWD57Sg44CC6L+Z5qC35Y+v5q2j56Gu5aSE55CG5YWo6LSf5pWw57uE77yM6YG/5YWN6ZSZ6K+v5Zyw5oqK56m65a2Q5pWw57uE5ZKMIDAg5b2T5L2c562U5qGI44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l6Kej5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM56m66Ze05aSN5p2C5bqm5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzlj6rpgY3ljobmlbDnu4TkuIDmrKHvvJvnqbrpl7TlpI3mnYLluqYgTygxKe+8jOS7heS9v+eUqCBjdXIg5ZKMIGJlc3Qg5Lik5Liq5Y+Y6YeP44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bCGIGN1ciDlkowgYmVzdCDliJ3lp4vljJbkuLogMCDkvJrkvb/lhajotJ/mlbDnu4TplJnor6/lnLDov5Tlm54gMO+8m+W6lOmDveWIneWni+WMluS4uiBudW1zWzBd44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+P6L2u5b+F6aG75YWI55So5penIGN1ciDorqHnrpfmlrDnmoQgY3Vy77yM5YaN55So5pu05paw5ZCO55qEIGN1ciDmm7TmlrAgYmVzdO+8m+S4jeiDveWPquWcqCBjdXIg5Li65q2j5pe25omN5pu05pawIGJlc3TjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhTdWJBcnJheShpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IGN1ciA9IHt7YmxhbmtfMX19OwogICAgICAgIGludCBiZXN0ID0gbnVtc1swXTsKCiAgICAgICAgZm9yIChpbnQgaSA9IHt7YmxhbmtfMn19OyBpIDwgbnVtcy5sZW5ndGg7IGkrKykgewogICAgICAgICAgICBjdXIgPSB7e2JsYW5rXzN9fTsKICAgICAgICAgICAgYmVzdCA9IHt7YmxhbmtfNH19OwogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIGJlc3Q7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtc1swXSIsImJsYW5rXzIiOiIxIiwiYmxhbmtfMyI6Ik1hdGgubWF4KG51bXNbaV0sIGN1ciArIG51bXNbaV0pIiwiYmxhbmtfNCI6Ik1hdGgubWF4KGJlc3QsIGN1cikifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJLYWRhbmUiLCLku6XlvZPliY3kvY3nva7nu5PlsL4iLCLph43mlrDlvIDlp4vmiJblu7bnu60iLCLlhajotJ/mlbDnu4TliJ3lp4vljJYiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 53
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-14: #56 合并区间

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    56, 14, CONVERT(FROM_BASE64('5ZCI5bm25Yy66Ze0') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5Lul5pWw57uEIGBpbnRlcnZhbHNgIOihqOekuuiLpeW5suS4quWMuumXtOeahOmbhuWQiO+8jOWFtuS4reWNleS4quWMuumXtOS4uiBgaW50ZXJ2YWxzW2ldID0gW3N0YXJ0aSwgZW5kaV1gIOOAguivt+S9oOWQiOW5tuaJgOaciemHjeWPoOeahOWMuumXtO+8jOW5tui/lOWbniAq5LiA5Liq5LiN6YeN5Y+g55qE5Yy66Ze05pWw57uE77yM6K+l5pWw57uE6ZyA5oGw5aW96KaG55uW6L6T5YWl5Lit55qE5omA5pyJ5Yy66Ze0KiDjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mmludGVydmFscyA9IFtbMSwzXSxbMiw2XSxbOCwxMF0sWzE1LDE4XV0K6L6T5Ye677yaW1sxLDZdLFs4LDEwXSxbMTUsMThdXQrop6Pph4rvvJrljLrpl7QgWzEsM10g5ZKMIFsyLDZdIOmHjeWPoCwg5bCG5a6D5Lus5ZCI5bm25Li6IFsxLDZdLgpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmludGVydmFscyA9IFtbMSw0XSxbNCw1XV0K6L6T5Ye677yaW1sxLDVdXQrop6Pph4rvvJrljLrpl7QgWzEsNF0g5ZKMIFs0LDVdIOWPr+iiq+inhuS4uumHjeWPoOWMuumXtOOAggpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mmludGVydmFscyA9IFtbNCw3XSxbMSw0XV0K6L6T5Ye677yaW1sxLDddXQrop6Pph4rvvJrljLrpl7QgWzEsNF0g5ZKMIFs0LDddIOWPr+iiq+inhuS4uumHjeWPoOWMuumXtOOAggpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBpbnRlcnZhbHMubGVuZ3RoIDw9IDEwNGAKLSBgaW50ZXJ2YWxzW2ldLmxlbmd0aCA9PSAyYAotIGAwIDw9IHN0YXJ0aSA8PSBlbmRpIDw9IDEwNGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9tZXJnZS1pbnRlcnZhbHMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL21lcmdlLWludGVydmFscy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5oyJ5Yy66Ze05bem56uv54K55Y2H5bqP5o6S5bqP44CC5o6S5bqP5ZCO77yM6Iul5b2T5YmN5Yy66Ze055qE5bem56uv54K55aSn5LqO5bey5ZCI5bm25pyA5ZCO5LiA5Liq5Yy66Ze055qE5Y+z56uv54K577yM6K+05piO5a6D5LiO5q2k5YmN5omA5pyJ5Yy66Ze06YO95LiN6YeN5Y+g77yM55u05o6l5Yqg5YWl57uT5p6c77yb5ZCm5YiZ5b+F5LiO5pyA5ZCO5LiA5Liq5ZCI5bm25Yy66Ze06YeN5Y+g77yM5Y+q6ZyA5bCG5pyA5ZCO5Yy66Ze055qE5Y+z56uv54K55pu05paw5Li65Lik6ICF5Y+z56uv54K555qE6L6D5aSn5YC844CC5b6q546v5LiN5Y+Y6YeP5piv77yabWVyZ2VkIOWni+e7iOS/neWtmOW3sumBjeWOhuWMuumXtOWQiOW5tuWQjueahOOAgeaMieW3puerr+eCueacieW6j+S4lOS6kuS4jemHjeWPoOeahOe7k+aenOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5oyJ5bem56uv54K55o6S5bqP5ZCO77yM5Y+q6ZyA5q+U6L6D5b2T5YmN5Yy66Ze05LiO57uT5p6c5YiX6KGo5pyA5ZCO5LiA5Liq5Yy66Ze077yb5rOo5oSP56uv54K555u4562J5Lmf6KaB5ZCI5bm244CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBmb3IgKGludFtdIGludGVydmFsIDogaW50ZXJ2YWxzKSB7CiAgICAgICAgICAgIGlmIChtZXJnZWQuaXNFbXB0eSgpIHx8IG1lcmdlZC5nZXQobWVyZ2VkLnNpemUoKSAtIDEpWzFdIDwgaW50ZXJ2YWxbMF0pIHsKICAgICAgICAgICAgICAgIG1lcmdlZC5hZGQoaW50ZXJ2YWwpOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbWVyZ2VkLmdldChtZXJnZWQuc2l6ZSgpIC0gMSlbMV0gPSBNYXRoLm1heChtZXJnZWQuZ2V0KG1lcmdlZC5zaXplKCkgLSAxKVsxXSwgaW50ZXJ2YWxbMV0pOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBtZXJnZWQudG9BcnJheShuZXcgaW50W21lcmdlZC5zaXplKCldW10pOw==') USING utf8mb4), CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheUxpc3Q7CmltcG9ydCBqYXZhLnV0aWwuQXJyYXlzOwppbXBvcnQgamF2YS51dGlsLkxpc3Q7CgpjbGFzcyBTb2x1dGlvbiB7CiAgICBwdWJsaWMgaW50W11bXSBtZXJnZShpbnRbXVtdIGludGVydmFscykgewogICAgICAgIEFycmF5cy5zb3J0KGludGVydmFscywgKGEsIGIpIC0+IEludGVnZXIuY29tcGFyZShhWzBdLCBiWzBdKSk7CiAgICAgICAgTGlzdDxpbnRbXT4gbWVyZ2VkID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgZm9yIChpbnRbXSBpbnRlcnZhbCA6IGludGVydmFscykgewogICAgICAgICAgICBpZiAobWVyZ2VkLmlzRW1wdHkoKSB8fCBtZXJnZWQuZ2V0KG1lcmdlZC5zaXplKCkgLSAxKVsxXSA8IGludGVydmFsWzBdKSB7CiAgICAgICAgICAgICAgICBtZXJnZWQuYWRkKGludGVydmFsKTsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIG1lcmdlZC5nZXQobWVyZ2VkLnNpemUoKSAtIDEpWzFdID0gTWF0aC5tYXgobWVyZ2VkLmdldChtZXJnZWQuc2l6ZSgpIC0gMSlbMV0sIGludGVydmFsWzFdKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbWVyZ2VkLnRvQXJyYXkobmV3IGludFttZXJnZWQuc2l6ZSgpXVtdKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 56
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 56
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 56
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5o6S5bqP5ZCO77yM57uT5p6c5YiX6KGoIG1lcmdlZCDnu7TmiqTnmoTmoLjlv4PkuI3lj5jph4/mmK/ku4DkuYjvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('bWVyZ2VkIOS/neWtmOaJgOacieW3sumBjeWOhuWMuumXtOWQiOW5tuWQjueahOe7k+aenO+8jOWMuumXtOaMieW3puerr+eCueacieW6j++8jOW5tuS4lOS7u+aEj+ebuOmCu+S4pOS4quWMuumXtOS6kuS4jemHjeWPoOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5L2V5pe25bCG5b2T5YmN5Yy66Ze055u05o6l5Yqg5YWl57uT5p6c77yM6YeN5Y+g5pe25aaC5L2V5pu05paw77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b2T5pyA5ZCO5Yy66Ze055qE5Y+z56uv54K55bCP5LqO5b2T5YmN5bem56uv54K55pe255u05o6l5Yqg5YWl77yb5ZCm5YiZ5ZCI5bm277yM5bm25bCG5pyA5ZCO5Yy66Ze05Y+z56uv54K55pu05paw5Li6IG1heChsYXN0RW5kLCBjdXJyZW50RW5kKeOAguetieS6juaXtuS5n+WxnuS6juWQiOW5tuOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqm5Li6IE8obiBsb2cgbinvvIzkuLvopoHmnaXoh6rmjpLluo/vvJvpop3lpJbnqbrpl7TlpI3mnYLluqbkuLogTyhuKe+8jOeUqOS6juS/neWtmOWQiOW5tue7k+aenOOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Yik5pat5LiN6YeN5Y+g5pe25LiN6IO95YaZ5oiQIGxhc3RFbmQgPD0gaW50ZXJ2YWxbMF3vvIzlm6DkuLrlpoIgWzEsNF0g5LiOIFs0LDVdIOerr+eCueebuOaOpeS5n+W/hemhu+WQiOW5tu+8m+W6lOS9v+eUqCBsYXN0RW5kIDwgaW50ZXJ2YWxbMF3jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+R55Sf6YeN5Y+g5pe25LiN6IO955u05o6l55So5b2T5YmN5Yy66Ze05pu/5o2i5pyA5ZCO5Yy66Ze077yM5b+F6aG75L+d55WZ5Y6f5bem56uv54K577yM5bm25bCG5pyA5ZCO5Yy66Ze05Y+z56uv54K55pu05paw5Li65Lik5Liq5Y+z56uv54K555qE5pyA5aSn5YC844CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('aW1wb3J0IGphdmEudXRpbC5BcnJheUxpc3Q7CmltcG9ydCBqYXZhLnV0aWwuQXJyYXlzOwppbXBvcnQgamF2YS51dGlsLkxpc3Q7CgpjbGFzcyBTb2x1dGlvbiB7CiAgICBwdWJsaWMgaW50W11bXSBtZXJnZShpbnRbXVtdIGludGVydmFscykgewogICAgICAgIEFycmF5cy5zb3J0KGludGVydmFscywgKGEsIGIpIC0+IHt7YmxhbmtfMX19KTsKICAgICAgICBMaXN0PGludFtdPiBtZXJnZWQgPSB7e2JsYW5rXzJ9fTsKICAgICAgICBmb3IgKGludFtdIGludGVydmFsIDogaW50ZXJ2YWxzKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgbWVyZ2VkLmFkZChpbnRlcnZhbCk7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBtZXJnZWQuZ2V0KG1lcmdlZC5zaXplKCkgLSAxKVsxXSA9IHt7YmxhbmtfNH19OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBtZXJnZWQudG9BcnJheSh7e2JsYW5rXzV9fSk7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiSW50ZWdlci5jb21wYXJlKGFbMF0sIGJbMF0pIiwiYmxhbmtfMiI6Im5ldyBBcnJheUxpc3Q8PigpIiwiYmxhbmtfMyI6Im1lcmdlZC5pc0VtcHR5KCkgfHwgbWVyZ2VkLmdldChtZXJnZWQuc2l6ZSgpIC0gMSlbMV0gPCBpbnRlcnZhbFswXSIsImJsYW5rXzQiOiJNYXRoLm1heChtZXJnZWQuZ2V0KG1lcmdlZC5zaXplKCkgLSAxKVsxXSwgaW50ZXJ2YWxbMV0pIiwiYmxhbmtfNSI6Im5ldyBpbnRbbWVyZ2VkLnNpemUoKV1bXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6bnq6/ngrnmjpLluo8iLCLnu5PmnpzliJfooajmnIDlkI7ljLrpl7QiLCLnq6/ngrnnm7jnrYnlkIjlubYiLCLlj7Pnq6/ngrnlj5bmnIDlpKflgLwiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 56
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-15: #189 轮转数组

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    189, 15, CONVERT(FROM_BASE64('6L2u6L2s5pWw57uE') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYO+8jOWwhuaVsOe7hOS4reeahOWFg+e0oOWQkeWPs+i9rui9rCBga2AqKuS4quS9jee9ru+8jOWFtuS4rSBga2AqKuaYr+mdnui0n+aVsOOAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFsxLDIsMyw0LDUsNiw3XSwgayA9IDMK6L6T5Ye6OiBbNSw2LDcsMSwyLDMsNF0K6Kej6YeKOgrlkJHlj7Pova7ovawgMSDmraU6IFs3LDEsMiwzLDQsNSw2XQrlkJHlj7Pova7ovawgMiDmraU6IFs2LDcsMSwyLDMsNCw1XQrlkJHlj7Pova7ovawgMyDmraU6IFs1LDYsNywxLDIsMyw0XQpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWy0xLC0xMDAsMyw5OV0sIGsgPSAyCui+k+WHuu+8mlszLDk5LC0xLC0xMDBdCuino+mHijoK5ZCR5Y+z6L2u6L2sIDEg5q2lOiBbOTksLTEsLTEwMCwzXQrlkJHlj7Pova7ovawgMiDmraU6IFszLDk5LC0xLC0xMDBdCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDEwNWAKLSBgLTIzMSA8PSBudW1zW2ldIDw9IDIzMSAtIDFgCi0gYDAgPD0gayA8PSAxMDVgKirov5vpmLbvvJoqKi0g5bC95Y+v6IO95oOz5Ye65pu05aSa55qE6Kej5Yaz5pa55qGI77yM6Iez5bCR5pyJKirkuInnp40qKuS4jeWQjOeahOaWueazleWPr+S7peino+WGs+i/meS4qumXrumimOOAggotIOS9oOWPr+S7peS9v+eUqOepuumXtOWkjeadguW6puS4uiBgTygxKWAg55qEKirljp/lnLAqKueul+azleino+WGs+i/meS4qumXrumimOWQl++8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3JvdGF0ZS1hcnJheS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcm90YXRlLWFycmF5Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5L2/55So5LiJ5qyh57+76L2s5a6e546w5Y6f5Zyw5Y+z6L2u6L2s44CC5YWI5LukIGsgJT0gbnVtcy5sZW5ndGjvvIzlsIbmlbTkuKrmlbDnu4Tnv7vovazvvIzlho3liIbliKvnv7vovazliY0gayDkuKrlhYPntKDlkozlkI4gbi1rIOS4quWFg+e0oOOAguaVtOS9k+e/u+i9rOWQju+8jOWOn+aVsOe7hOacq+WwvueahCBrIOS4quWFg+e0oOW3suadpeWIsOWJjemDqOS9huWGhemDqOmhuuW6j+WPjeS6hu+8m+WIhuWIq+e/u+i9rOS4pOauteWNs+WPr+aBouWkjeWQhOauteebuOWvuemhuuW6j+OAgnJldmVyc2Ug5Lit5L+d5oyB5Y+M5oyH6ZKIIGxlZnTjgIFyaWdodO+8jOW+queOr+S4jeWPmOmHj+aYr+WMuumXtOWkluWFg+e0oOW3suWcqOacgOe7iOS9jee9ru+8jOavj+asoeS6pOaNouS4pOerr+WQjuWPjOaMh+mSiOWQkeS4remXtOaUtue8qeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5Y+z56e7IGsg5L2N562J5Lu35LqO5oqK5pyr5bC+IGsg5Liq5YWD57Sg5pCs5Yiw5YmN6Z2i44CC6IO95ZCm6YCa6L+H4oCc5pW05L2T57+76L2sICsg5Lik5q6157+76L2s4oCd5ZyoIE8oMSkg6aKd5aSW56m66Ze05a6M5oiQ77yf') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBrICU9IG47CgogICAgICAgIHJldmVyc2UobnVtcywgMCwgbiAtIDEpOwogICAgICAgIHJldmVyc2UobnVtcywgMCwgayAtIDEpOwogICAgICAgIHJldmVyc2UobnVtcywgaywgbiAtIDEpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgcm90YXRlKGludFtdIG51bXMsIGludCBrKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICBrICU9IG47CgogICAgICAgIHJldmVyc2UobnVtcywgMCwgbiAtIDEpOwogICAgICAgIHJldmVyc2UobnVtcywgMCwgayAtIDEpOwogICAgICAgIHJldmVyc2UobnVtcywgaywgbiAtIDEpOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCByZXZlcnNlKGludFtdIG51bXMsIGludCBsZWZ0LCBpbnQgcmlnaHQpIHsKICAgICAgICB3aGlsZSAobGVmdCA8IHJpZ2h0KSB7CiAgICAgICAgICAgIGludCB0ZW1wID0gbnVtc1tsZWZ0XTsKICAgICAgICAgICAgbnVtc1tsZWZ0XSA9IG51bXNbcmlnaHRdOwogICAgICAgICAgICBudW1zW3JpZ2h0XSA9IHRlbXA7CiAgICAgICAgICAgIGxlZnQrKzsKICAgICAgICAgICAgcmlnaHQtLTsKICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 189
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 189
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 189
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 189
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiJ5qyh57+76L2s5rOV55qE5qC45b+D5pON5L2c6aG65bqP5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5bCGIGsg5a+5IG4g5Y+W5qih77yb57+76L2s5pW05Liq5pWw57uE77yb57+76L2s5LiL5qCHIFswLCBrIC0gMV3vvJvnv7vovazkuIvmoIcgW2ssIG4gLSAxXeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('cmV2ZXJzZSDlj4zmjIfpkojlvqrnjq/nmoTovrnnlYzlkozmm7TmlrDpobrluo/mmK/ku4DkuYjvvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5b2TIGxlZnQgPCByaWdodCDml7bkuqTmjaIgbnVtc1tsZWZ0XSDkuI4gbnVtc1tyaWdodF3vvIzkuqTmjaLlrozmiJDlkI7miafooYwgbGVmdCsr44CBcmlnaHQtLeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzkuInmrKHnv7vovaznmoTmgLvmk43kvZzph4/ku43kuLrnur/mgKfvvJvpop3lpJbnqbrpl7TlpI3mnYLluqYgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5omn6KGMIGsgJT0gbnVtcy5sZW5ndGjvvJvlvZMgayDlpKfkuo7mlbDnu4Tplb/luqbml7bvvIznm7TmjqXmjIkgayDliJLliIbliY3lkI7ljLrpl7TkvJrlr7zoh7TkuIvmoIfotornlYzjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiJ5qyh57+76L2s6aG65bqP5LiN6IO96aKg5YCS77ya5b+F6aG75YWI57+76L2s5pW05Liq5pWw57uE77yM5YaN57+76L2sIFswLCBrIC0gMV0g5ZKMIFtrLCBuIC0gMV3vvJvkuJQgcmV2ZXJzZSDnmoTlvqrnjq/mnaHku7blupTkuLogbGVmdCA8IHJpZ2h044CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgcm90YXRlKGludFtdIG51bXMsIGludCBrKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICB7e2JsYW5rXzF9fQoKICAgICAgICB7e2JsYW5rXzJ9fQogICAgICAgIHt7YmxhbmtfM319CiAgICAgICAgcmV2ZXJzZShudW1zLCBrLCBuIC0gMSk7CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIHJldmVyc2UoaW50W10gbnVtcywgaW50IGxlZnQsIGludCByaWdodCkgewogICAgICAgIHdoaWxlICh7e2JsYW5rXzR9fSkgewogICAgICAgICAgICBpbnQgdGVtcCA9IG51bXNbbGVmdF07CiAgICAgICAgICAgIG51bXNbbGVmdF0gPSBudW1zW3JpZ2h0XTsKICAgICAgICAgICAgbnVtc1tyaWdodF0gPSB0ZW1wOwogICAgICAgICAgICB7e2JsYW5rXzV9fQogICAgICAgICAgICB7e2JsYW5rXzZ9fQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiayAlPSBuOyIsImJsYW5rXzIiOiJyZXZlcnNlKG51bXMsIDAsIG4gLSAxKTsiLCJibGFua18zIjoicmV2ZXJzZShudW1zLCAwLCBrIC0gMSk7IiwiYmxhbmtfNCI6ImxlZnQgPCByaWdodCIsImJsYW5rXzUiOiJsZWZ0Kys7IiwiYmxhbmtfNiI6InJpZ2h0LS07In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJr5Y+W5qihIiwi5pW05L2T57+76L2sIiwi5YmNa+e/u+i9rCIsIuWPjOaMh+mSiOS6pOaNoiIsIk8oMSnljp/lnLAiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 189
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-16: #238 除了自身以外数组的乘积

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    238, 16, CONVERT(FROM_BASE64('6Zmk5LqG6Ieq6Lqr5Lul5aSW5pWw57uE55qE5LmY56ev') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYO+8jOi/lOWbniDmlbDnu4QgYGFuc3dlcmAg77yM5YW25LitIGBhbnN3ZXJbaV1gIOetieS6jiBgbnVtc2Ag5Lit6Zmk5LqGIGBudW1zW2ldYCDkuYvlpJblhbbkvZnlkITlhYPntKDnmoTkuZjnp68g44CCCgrpopjnm67mlbDmja4qKuS/neivgSoq5pWw57uEIGBudW1zYOS5i+S4reS7u+aEj+WFg+e0oOeahOWFqOmDqOWJjee8gOWFg+e0oOWSjOWQjue8gOeahOS5mOenr+mDveWcqCoqMzIg5L2NKirmlbTmlbDojIPlm7TlhoXjgIIKCuivtyoq5LiN6KaB5L2/55So6Zmk5rOV77yMKirkuJTlnKggYE8obilgIOaXtumXtOWkjeadguW6puWGheWujOaIkOatpOmimOOAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFsxLDIsMyw0XQrovpPlh7o6IFsyNCwxMiw4LDZdCmBgYCoq56S65L6LIDI6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFstMSwxLDAsLTMsM10K6L6T5Ye6OiBbMCwwLDksMCwwXQpgYGAqKuaPkOekuu+8mioqLSBgMiA8PSBudW1zLmxlbmd0aCA8PSAxMDVgCi0gYC0zMCA8PSBudW1zW2ldIDw9IDMwYAotIOi+k+WFpSoq5L+d6K+BKirmlbDnu4QgYGFuc3dlcltpXWAg5ZyoKiozMiDkvY0qKuaVtOaVsOiMg+WbtOWGhSoq6L+b6Zi277yaKirkvaDlj6/ku6XlnKggYE8oMSlgIOeahOmineWkluepuumXtOWkjeadguW6puWGheWujOaIkOi/meS4qumimOebruWQl++8n++8iCDlh7rkuo7lr7nnqbrpl7TlpI3mnYLluqbliIbmnpDnmoTnm67nmoTvvIzovpPlh7rmlbDnu4QqKuS4jeiiq+inhuS4uioq6aKd5aSW56m66Ze044CC77yJCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvcHJvZHVjdC1vZi1hcnJheS1leGNlcHQtc2VsZi8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcHJvZHVjdC1vZi1hcnJheS1leGNlcHQtc2VsZi8p') USING utf8mb4),
    CONVERT(FROM_BASE64('55So6L6T5Ye65pWw57uEIGFuc3dlciDlpI3nlKjkuLrliY3nvIDkuZjnp6/vvJrku47lt6bliLDlj7Pku6QgYW5zd2VyW2ldIOS/neWtmCBudW1zWzAuLmktMV0g55qE5LmY56ev44CC5YaN57u05oqk5LiA5LiqIHN1ZmZpeO+8jOaMieS7juWPs+WIsOW3pumBjeWOhuaXtu+8jHN1ZmZpeCDooajnpLogbnVtc1tpKzEuLm4tMV0g55qE5LmY56ev77yb5bCGIGFuc3dlcltpXSDkuZjku6Ugc3VmZml4IOWQjuW+l+WIsOmZpCBudW1zW2ldIOWkluaJgOacieWFg+e0oOeahOS5mOenr++8jOWGjeabtOaWsCBzdWZmaXjjgILkuKTmrKHpgY3ljobpg73kuI3kvb/nlKjpmaTms5XvvIzkuJTovpPlh7rmlbDnu4TkuI3orqHlhaXpop3lpJbnqbrpl7TjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI6K6pIGFuc3dlcltpXSDlrZjlt6bkvqfmiYDmnInmlbDnmoTkuZjnp6/vvJvlho3ku47lj7PlkJHlt6bnlKjkuIDkuKrlj5jph4/ntK/orqHlj7PkvqfkuZjnp6/lubbkuZjlm54gYW5zd2Vy44CC') USING utf8mb4), CONVERT(FROM_BASE64('ICAgICAgICBhbnN3ZXJbMF0gPSAxOwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbjsgaSsrKSB7CiAgICAgICAgICAgIGFuc3dlcltpXSA9IGFuc3dlcltpIC0gMV0gKiBudW1zW2kgLSAxXTsKICAgICAgICB9CgogICAgICAgIGludCBzdWZmaXggPSAxOwogICAgICAgIGZvciAoaW50IGkgPSBuIC0gMTsgaSA+PSAwOyBpLS0pIHsKICAgICAgICAgICAgYW5zd2VyW2ldICo9IHN1ZmZpeDsKICAgICAgICAgICAgc3VmZml4ICo9IG51bXNbaV07CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHByb2R1Y3RFeGNlcHRTZWxmKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludFtdIGFuc3dlciA9IG5ldyBpbnRbbl07CgogICAgICAgIGFuc3dlclswXSA9IDE7CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPCBuOyBpKyspIHsKICAgICAgICAgICAgYW5zd2VyW2ldID0gYW5zd2VyW2kgLSAxXSAqIG51bXNbaSAtIDFdOwogICAgICAgIH0KCiAgICAgICAgaW50IHN1ZmZpeCA9IDE7CiAgICAgICAgZm9yIChpbnQgaSA9IG4gLSAxOyBpID49IDA7IGktLSkgewogICAgICAgICAgICBhbnN3ZXJbaV0gKj0gc3VmZml4OwogICAgICAgICAgICBzdWZmaXggKj0gbnVtc1tpXTsKICAgICAgICB9CgogICAgICAgIHJldHVybiBhbnN3ZXI7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 238
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 238
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YmN57yA5ZKM') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YmN57yA5ZKM') USING utf8mb4) WHERE p.leetcode_number = 238
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('YW5zd2VyIOaVsOe7hOWSjCBzdWZmaXgg5Zyo5Lik5qyh6YGN5Y6G5Lit5YiG5Yir57u05oqk5LuA5LmI54q25oCB77yf') USING utf8mb4), CONVERT(FROM_BASE64('5bem6YGN5Y6G5ZCOIGFuc3dlcltpXSDmmK8gaSDlt6bkvqflhYPntKDnmoTkuZjnp6/vvJvlj7PpgY3ljobml7Ygc3VmZml4IOaYryBpIOWPs+S+p+WFg+e0oOeahOS5mOenr++8jOS6jOiAheebuOS5mOWNs+S4uuebruagh+WAvOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+z5ZCR5bem5pu05pawIGFuc3dlcltpXSDkuI4gc3VmZml4IOeahOato+ehrumhuuW6j+aYr+S7gOS5iO+8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5omn6KGMIGFuc3dlcltpXSAqPSBzdWZmaXjvvIzlho3miafooYwgc3VmZml4ICo9IG51bXNbaV3vvIzpgb/lhY3mioogbnVtc1tpXSDoh6rouqvkuZjlhaXnrZTmoYjjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K+l566X5rOV55qE5pe26Ze05aSN5p2C5bqm5ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5YiG5Yir5piv5aSa5bCR77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05aSN5p2C5bqmIE8obinvvIzpop3lpJbnqbrpl7TlpI3mnYLluqYgTygxKe+8m+i/lOWbnueahCBhbnN3ZXIg5pWw57uE5LiN6K6h5YWl6aKd5aSW56m66Ze044CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5YmN57yA6YGN5Y6G5b+F6aG75YWI6K6+572uIGFuc3dlclswXSA9IDHvvIzkuJQgaSDku44gMSDlvIDlp4vvvJvlkKbliJkgbnVtc1swXSDlt6bovrnkuLrnqbrkuZjnp6/ml7bkvJrplJnor6/jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+z5ZCR5bem6YGN5Y6G5Lit5b+F6aG75YWI5omn6KGMIGFuc3dlcltpXSAqPSBzdWZmaXjvvIzlho3miafooYwgc3VmZml4ICo9IG51bXNbaV3vvJvoi6XlhYjmm7TmlrAgc3VmZml477yM5Lya5oqKIG51bXNbaV0g6ZSZ5LmY6L+bIGFuc3dlcltpXeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHByb2R1Y3RFeGNlcHRTZWxmKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludFtdIGFuc3dlciA9IG5ldyBpbnRbbl07CgogICAgICAgIHt7YmxhbmtfMX19CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPCBuOyBpKyspIHsKICAgICAgICAgICAge3tibGFua18yfX0KICAgICAgICB9CgogICAgICAgIGludCBzdWZmaXggPSAxOwogICAgICAgIHt7YmxhbmtfM319IHsKICAgICAgICAgICAgYW5zd2VyW2ldICo9IHN1ZmZpeDsKICAgICAgICAgICAge3tibGFua180fX0KICAgICAgICB9CgogICAgICAgIHJldHVybiBhbnN3ZXI7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zd2VyWzBdID0gMTsiLCJibGFua18yIjoiYW5zd2VyW2ldID0gYW5zd2VyW2kgLSAxXSAqIG51bXNbaSAtIDFdOyIsImJsYW5rXzMiOiJmb3IgKGludCBpID0gbiAtIDE7IGkgPj0gMDsgaS0tKSIsImJsYW5rXzQiOiJzdWZmaXggKj0gbnVtc1tpXTsifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLliY3nvIDkuZjnp68iLCLlkI7nvIDkuZjnp68iLCLovpPlh7rmlbDnu4TlpI3nlKgiLCLlhYjkuZjlkI7mm7TmlrAiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 238
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-17: #41 缺失的第一个正数

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    41, 17, CONVERT(FROM_BASE64('57y65aSx55qE56ys5LiA5Liq5q2j5pWw') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pyq5o6S5bqP55qE5pW05pWw5pWw57uEIGBudW1zYCDvvIzor7fkvaDmib7lh7rlhbbkuK3msqHmnInlh7rnjrDnmoTmnIDlsI/nmoTmraPmlbTmlbDjgIIKCuivt+S9oOWunueOsOaXtumXtOWkjeadguW6puS4uiBgTyhuKWAg5bm25LiU5Y+q5L2/55So5bi45pWw57qn5Yir6aKd5aSW56m66Ze055qE6Kej5Yaz5pa55qGI44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzEsMiwwXQrovpPlh7rvvJozCuino+mHiu+8muiMg+WbtCBbMSwyXSDkuK3nmoTmlbDlrZfpg73lnKjmlbDnu4TkuK3jgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzMsNCwtMSwxXQrovpPlh7rvvJoyCuino+mHiu+8mjEg5Zyo5pWw57uE5Lit77yM5L2GIDIg5rKh5pyJ44CCCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFs3LDgsOSwxMSwxMl0K6L6T5Ye677yaMQrop6Pph4rvvJrmnIDlsI/nmoTmraPmlbAgMSDmsqHmnInlh7rnjrDjgIIKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTA1YAotIGAtMjMxIDw9IG51bXNbaV0gPD0gMjMxIC0gMWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9maXJzdC1taXNzaW5nLXBvc2l0aXZlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9maXJzdC1taXNzaW5nLXBvc2l0aXZlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqK5YC8IHgg5Lqk5o2i5Yiw5LiL5qCHIHgtMe+8jOacgOe7iOesrOS4gOS4qiBudW1zW2ldICE9IGkrMSDnmoTkvY3nva7lsLHmmK/nvLrlpLHmraPmlbDjgIIg5pys6aKY5Zu057uV44CM57y65aSx55qE56ys5LiA5Liq5q2j5pWw44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5aSE55CG5a6M5LiL5qCHIGkg5ZCO77yM5omA5pyJ6IO95b2S5L2N55qEIDEuLm4g6YO95bC96YeP5L2N5LqO6Ieq5bex55qE55uu5qCH5LiL5qCH44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y6f5Zyw5ZOI5biM55qE5ZCr5LmJ77yM5YaN5qOA5p+l5LiL5qCH5b2S5L2N5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIGlmIChudW1zW2ldICE9IGkgKyAxKSB7CiAgICAgICAgICAgICAgICByZXR1cm4gaSArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaXJzdE1pc3NpbmdQb3NpdGl2ZShpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICB3aGlsZSAobnVtc1tpXSA+IDAgJiYgbnVtc1tpXSA8PSBuICYmIG51bXNbaV0gIT0gbnVtc1tudW1zW2ldIC0gMV0pIHsKICAgICAgICAgICAgICAgIHN3YXAobnVtcywgaSwgbnVtc1tpXSAtIDEpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIGlmIChudW1zW2ldICE9IGkgKyAxKSB7CiAgICAgICAgICAgICAgICByZXR1cm4gaSArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIG4gKyAxOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBzd2FwKGludFtdIG51bXMsIGludCBpLCBpbnQgaikgewogICAgICAgIGludCB0ID0gbnVtc1tpXTsKICAgICAgICBudW1zW2ldID0gbnVtc1tqXTsKICAgICAgICBudW1zW2pdID0gdDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pmu6YCa5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 41
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 41
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 41
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5a6M5LiL5qCHIGkg5ZCO77yM5omA5pyJ6IO95b2S5L2N55qEIDEuLm4g6YO95bC96YeP5L2N5LqO6Ieq5bex55qE55uu5qCH5LiL5qCH44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZpcnN0TWlzc2luZ1Bvc2l0aXZlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5Lqk5o2i5p2h5Lu25b+F6aG75ZCM5pe25qOA5p+l5YC85ZyoIFsxLG5dIOS4lOebruagh+S9jeS4jeaYr+ebuOWQjOWAvO+8jOWQpuWImemHjeWkjeWFg+e0oOS8muatu+W+queOr+OAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Y6f5Zyw5Lqk5o2i6Iez5aSaIE8obikg5qyh77yM5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Lqk5o2i5p2h5Lu25b+F6aG75ZCM5pe25qOA5p+l5YC85ZyoIFsxLG5dIOS4lOebruagh+S9jeS4jeaYr+ebuOWQjOWAvO+8jOWQpuWImemHjeWkjeWFg+e0oOS8muatu+W+queOr+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZpcnN0TWlzc2luZ1Bvc2l0aXZlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaXJzdE1pc3NpbmdQb3NpdGl2ZShpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIHN3YXAobnVtcywgaSwgbnVtc1tpXSAtIDEpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KCiAgICBwcml2YXRlIHZvaWQgc3dhcChpbnRbXSBudW1zLCBpbnQgaSwgaW50IGopIHsKICAgICAgICBpbnQgdCA9IHt7YmxhbmtfNX19OwogICAgICAgIG51bXNbaV0gPSBudW1zW2pdOwogICAgICAgIG51bXNbal0gPSB0OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtc1tpXSA+IDAgJiYgbnVtc1tpXSA8PSBuICYmIG51bXNbaV0gIT0gbnVtc1tudW1zW2ldIC0gMV0iLCJibGFua18yIjoibnVtc1tpXSAhPSBpICsgMSIsImJsYW5rXzMiOiJpICsgMSIsImJsYW5rXzQiOiJuICsgMSIsImJsYW5rXzUiOiJudW1zW2ldIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljp/lnLDlk4jluIwiLCLkuIvmoIflvZLkvY0iLCLph43lpI3lgLwiLCLmlbDnu4QiLCLlk4jluIzooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 41
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-18: #73 矩阵置零

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    73, 18, CONVERT(FROM_BASE64('55+p6Zi1572u6Zu2') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5LiqIGBtIHggbmAg55qE55+p6Zi177yM5aaC5p6c5LiA5Liq5YWD57Sg5Li6KiowKirvvIzliJnlsIblhbbmiYDlnKjooYzlkozliJfnmoTmiYDmnInlhYPntKDpg73orr7kuLoqKjAqKuOAguivt+S9v+eUqCoqW+WOn+WcsF0oaHR0cDovL2JhaWtlLmJhaWR1LmNvbS9pdGVtLyVFNSU4RSU5RiVFNSU5QyVCMCVFNyVBRSU5NyVFNiVCMyU5NSkqKueul+azlSoq44CCKioqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8wOC8xNy9tYXQxLmpwZykKCmBgYHRleHQK6L6T5YWl77yabWF0cml4ID0gW1sxLDEsMV0sWzEsMCwxXSxbMSwxLDFdXQrovpPlh7rvvJpbWzEsMCwxXSxbMCwwLDBdLFsxLDAsMV1dCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzA4LzE3L21hdDIuanBnKQoKYGBgdGV4dArovpPlhaXvvJptYXRyaXggPSBbWzAsMSwyLDBdLFszLDQsNSwyXSxbMSwzLDEsNV1dCui+k+WHuu+8mltbMCwwLDAsMF0sWzAsNCw1LDBdLFswLDMsMSwwXV0KYGBgKirmj5DnpLrvvJoqKi0gYG0gPT0gbWF0cml4Lmxlbmd0aGAKLSBgbiA9PSBtYXRyaXhbMF0ubGVuZ3RoYAotIGAxIDw9IG0sIG4gPD0gMjAwYAotIGAtMjMxIDw9IG1hdHJpeFtpXVtqXSA8PSAyMzEgLSAxYCoq6L+b6Zi277yaKiotIOS4gOS4quebtOingueahOino+WGs+aWueahiOaYr+S9v+eUqCBgTyhtbilgIOeahOmineWkluepuumXtO+8jOS9hui/meW5tuS4jeaYr+S4gOS4quWlveeahOino+WGs+aWueahiOOAggotIOS4gOS4queugOWNleeahOaUuei/m+aWueahiOaYr+S9v+eUqCBgTyhtICsgbilgIOeahOmineWkluepuumXtO+8jOS9hui/meS7jeeEtuS4jeaYr+acgOWlveeahOino+WGs+aWueahiOOAggotIOS9oOiDveaDs+WHuuS4gOS4quS7heS9v+eUqOW4uOmHj+epuumXtOeahOino+WGs+aWueahiOWQl++8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3NldC1tYXRyaXgtemVyb2VzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9zZXQtbWF0cml4LXplcm9lcy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('55So6aaW6KGM5ZKM6aaW5YiX5YWF5b2T6KGM5YiX572u6Zu25qCH6K6w77yM5bm26aKd5aSW6K6w5b2V6aaW5YiX5Y6f5pys5piv5ZCm5ZCrIDDjgIIg5pys6aKY5Zu057uV44CM55+p6Zi1572u6Zu244CN6JC95a6e6L+Z5LiA5qih5Z6L77ya56ys5LiA6YGN5ZCOIG1hdHJpeFtpXVswXSDlkowgbWF0cml4WzBdW2pdIOWHhuehruihqOekuuesrCBpIOihjOOAgeesrCBqIOWIl+aYr+WQpuW6lOa4hembtuOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6aaW6KGM6aaW5YiX55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y6f5Zyw5qCH6K6w5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG07ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8IG47ICsraikgewogICAgICAgICAgICAgICAgaWYgKG1hdHJpeFtpXVswXSA9PSAwIHx8IG1hdHJpeFswXVtqXSA9PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgbWF0cml4W2ldW2pdID0gMDs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgc2V0WmVyb2VzKGludFtdW10gbWF0cml4KSB7CiAgICAgICAgaW50IG0gPSBtYXRyaXgubGVuZ3RoLCBuID0gbWF0cml4WzBdLmxlbmd0aDsKICAgICAgICBib29sZWFuIGkwID0gZmFsc2UsIGowID0gZmFsc2U7CiAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgaWYgKG1hdHJpeFswXVtqXSA9PSAwKSB7CiAgICAgICAgICAgICAgICBpMCA9IHRydWU7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG07ICsraSkgewogICAgICAgICAgICBpZiAobWF0cml4W2ldWzBdID09IDApIHsKICAgICAgICAgICAgICAgIGowID0gdHJ1ZTsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBpZiAobWF0cml4W2ldW2pdID09IDApIHsKICAgICAgICAgICAgICAgICAgICBtYXRyaXhbaV1bMF0gPSAwOwogICAgICAgICAgICAgICAgICAgIG1hdHJpeFswXVtqXSA9IDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDE7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChtYXRyaXhbaV1bMF0gPT0gMCB8fCBtYXRyaXhbMF1bal0gPT0gMCkgewogICAgICAgICAgICAgICAgICAgIG1hdHJpeFtpXVtqXSA9IDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgaWYgKGkwKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBtYXRyaXhbMF1bal0gPSAwOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGlmIChqMCkgewogICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG07ICsraSkgewogICAgICAgICAgICAgICAgbWF0cml4W2ldWzBdID0gMDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 73
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 73
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 73
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('56ys5LiA6YGN5ZCOIG1hdHJpeFtpXVswXSDlkowgbWF0cml4WzBdW2pdIOWHhuehruihqOekuuesrCBpIOihjOOAgeesrCBqIOWIl+aYr+WQpuW6lOa4hembtuOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNldFplcm9lcyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('6aaW6KGM5ZKM6aaW5YiX5pei5piv5pWw5o2u5Y+I5piv5qCH6K6w77yM5b+F6aG75LuO5ZCO5ZCR5YmN5Zue5YaZ77yM5bm25Y2V54us5aSE55CG6aaW5YiX44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5omr5o+P5LiO5Zue5YaZ5ZCEIE8obW4p77yM6aKd5aSW56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6aaW6KGM5ZKM6aaW5YiX5pei5piv5pWw5o2u5Y+I5piv5qCH6K6w77yM5b+F6aG75LuO5ZCO5ZCR5YmN5Zue5YaZ77yM5bm25Y2V54us5aSE55CG6aaW5YiX44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNldFplcm9lcyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgc2V0WmVyb2VzKGludFtdW10gbWF0cml4KSB7CiAgICAgICAgaW50IG0gPSBtYXRyaXgubGVuZ3RoLCBuID0gbWF0cml4WzBdLmxlbmd0aDsKICAgICAgICBib29sZWFuIGkwID0gZmFsc2UsIGowID0gZmFsc2U7CiAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgICAgICBpMCA9IHRydWU7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG07ICsraSkgewogICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgIGowID0gdHJ1ZTsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgICAgICAgICBtYXRyaXhbaV1bMF0gPSAwOwogICAgICAgICAgICAgICAgICAgIG1hdHJpeFswXVtqXSA9IDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDE7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzR9fSkgewogICAgICAgICAgICAgICAgICAgIG1hdHJpeFtpXVtqXSA9IDA7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgaWYgKGkwKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBtYXRyaXhbMF1bal0gPSAwOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGlmIChqMCkgewogICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG07ICsraSkgewogICAgICAgICAgICAgICAgbWF0cml4W2ldWzBdID0gMDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibWF0cml4WzBdW2pdID09IDAiLCJibGFua18yIjoibWF0cml4W2ldWzBdID09IDAiLCJibGFua18zIjoibWF0cml4W2ldW2pdID09IDAiLCJibGFua180IjoibWF0cml4W2ldWzBdID09IDAgfHwgbWF0cml4WzBdW2pdID09IDAifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpppbooYzpppbliJciLCLljp/lnLDmoIforrAiLCLpgIbluo/lm57lhpkiLCLmlbDnu4QiLCLlk4jluIzooagiLCLnn6npmLUiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 73
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-19: #54 螺旋矩阵

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    54, 19, CONVERT(FROM_BASE64('6J665peL55+p6Zi1') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5LiqIGBtYCDooYwgYG5gIOWIl+eahOefqemYtSBgbWF0cml4YCDvvIzor7fmjInnhacqKumhuuaXtumSiOieuuaXi+mhuuW6jyoq77yM6L+U5Zue55+p6Zi15Lit55qE5omA5pyJ5YWD57Sg44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTEvMTMvc3BpcmFsMS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mm1hdHJpeCA9IFtbMSwyLDNdLFs0LDUsNl0sWzcsOCw5XV0K6L6T5Ye677yaWzEsMiwzLDYsOSw4LDcsNCw1XQpgYGAqKuekuuS+iyAy77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8xMS8xMy9zcGlyYWwuanBnKQoKYGBgdGV4dArovpPlhaXvvJptYXRyaXggPSBbWzEsMiwzLDRdLFs1LDYsNyw4XSxbOSwxMCwxMSwxMl1dCui+k+WHuu+8mlsxLDIsMyw0LDgsMTIsMTEsMTAsOSw1LDYsN10KYGBgKirmj5DnpLrvvJoqKi0gYG0gPT0gbWF0cml4Lmxlbmd0aGAKLSBgbiA9PSBtYXRyaXhbaV0ubGVuZ3RoYAotIGAxIDw9IG0sIG4gPD0gMTBgCi0gYC0xMDAgPD0gbWF0cml4W2ldW2pdIDw9IDEwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9zcGlyYWwtbWF0cml4LykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9zcGlyYWwtbWF0cml4Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5pa55ZCR5pWw57uE5ZKMIHZpc2l0ZWQg55+p6Zi15qih5ouf6KGM6LWw77yb5LiL5LiA5qC86LaK55WM5oiW5bey6K6/6Zeu5pe26aG65pe26ZKI6L2s5ZCR44CCIOacrOmimOWbtOe7leOAjOieuuaXi+efqemYteOAjeiQveWunui/meS4gOaooeWei++8muW+queOr+eahOW9k+WJjeWdkOagh+Wni+e7iOaYr+Wwmuacquiuv+mXrueahOagvOWtkO+8jHZpc2l0ZWQg57K+56Gu6K6w5b2V5bey57uP5Yqg5YWl562U5qGI55qE5qC85a2Q44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5pa55ZCR5pWw57uE55qE5ZCr5LmJ77yM5YaN5qOA5p+l6K6/6Zeu5qCH6K6w5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('dmlzW2ldW2pdID0gdHJ1ZTsKICAgICAgICAgICAgaW50IHggPSBpICsgZGlyc1trXSwgeSA9IGogKyBkaXJzW2sgKyAxXTsKICAgICAgICAgICAgaWYgKHggPCAwIHx8IHggPj0gbSB8fCB5IDwgMCB8fCB5ID49IG4gfHwgdmlzW3hdW3ldKSB7CiAgICAgICAgICAgICAgICBrID0gKGsgKyAxKSAlIDQ7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaSArPSBkaXJzW2tdOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gc3BpcmFsT3JkZXIoaW50W11bXSBtYXRyaXgpIHsKICAgICAgICBpbnQgbSA9IG1hdHJpeC5sZW5ndGgsIG4gPSBtYXRyaXhbMF0ubGVuZ3RoOwogICAgICAgIGludFtdIGRpcnMgPSB7MCwgMSwgMCwgLTEsIDB9OwogICAgICAgIGludCBpID0gMCwgaiA9IDAsIGsgPSAwOwogICAgICAgIExpc3Q8SW50ZWdlcj4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgYm9vbGVhbltdW10gdmlzID0gbmV3IGJvb2xlYW5bbV1bbl07CiAgICAgICAgZm9yIChpbnQgaCA9IG0gKiBuOyBoID4gMDsgLS1oKSB7CiAgICAgICAgICAgIGFucy5hZGQobWF0cml4W2ldW2pdKTsKICAgICAgICAgICAgdmlzW2ldW2pdID0gdHJ1ZTsKICAgICAgICAgICAgaW50IHggPSBpICsgZGlyc1trXSwgeSA9IGogKyBkaXJzW2sgKyAxXTsKICAgICAgICAgICAgaWYgKHggPCAwIHx8IHggPj0gbSB8fCB5IDwgMCB8fCB5ID49IG4gfHwgdmlzW3hdW3ldKSB7CiAgICAgICAgICAgICAgICBrID0gKGsgKyAxKSAlIDQ7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaSArPSBkaXJzW2tdOwogICAgICAgICAgICBqICs9IGRpcnNbayArIDFdOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 54
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 54
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qih5ouf') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qih5ouf') USING utf8mb4) WHERE p.leetcode_number = 54
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b6q546v55qE5b2T5YmN5Z2Q5qCH5aeL57uI5piv5bCa5pyq6K6/6Zeu55qE5qC85a2Q77yMdmlzaXRlZCDnsr7noa7orrDlvZXlt7Lnu4/liqDlhaXnrZTmoYjnmoTmoLzlrZDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNwaXJhbE9yZGVyIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6L2s5ZCR5Yik5pat5b+F6aG75qOA5p+l5LiL5LiA5qC86ICM5LiN5piv5b2T5YmN5qC877yb5oC75q2l5pWw5Zu65a6a5Li6IG0qbu+8jOmBv+WFjee7k+adn+adoeS7tuWkjeadguWMluOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yMdmlzaXRlZCDpop3lpJbnqbrpl7QgTyhtbinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L2s5ZCR5Yik5pat5b+F6aG75qOA5p+l5LiL5LiA5qC86ICM5LiN5piv5b2T5YmN5qC877yb5oC75q2l5pWw5Zu65a6a5Li6IG0qbu+8jOmBv+WFjee7k+adn+adoeS7tuWkjeadguWMluOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNwaXJhbE9yZGVyIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gc3BpcmFsT3JkZXIoaW50W11bXSBtYXRyaXgpIHsKICAgICAgICBpbnQgbSA9IG1hdHJpeC5sZW5ndGgsIG4gPSBtYXRyaXhbMF0ubGVuZ3RoOwogICAgICAgIGludFtdIGRpcnMgPSB7MCwgMSwgMCwgLTEsIDB9OwogICAgICAgIGludCBpID0gMCwgaiA9IDAsIGsgPSAwOwogICAgICAgIExpc3Q8SW50ZWdlcj4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgYm9vbGVhbltdW10gdmlzID0gbmV3IGJvb2xlYW5bbV1bbl07CiAgICAgICAgZm9yIChpbnQgaCA9IG0gKiBuOyBoID4gMDsgLS1oKSB7CiAgICAgICAgICAgIGFucy5hZGQobWF0cml4W2ldW2pdKTsKICAgICAgICAgICAgdmlzW2ldW2pdID0gdHJ1ZTsKICAgICAgICAgICAgaW50IHggPSBpICsgZGlyc1trXSwgeSA9IGogKyBkaXJzW2sgKyAxXTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgICAgICBrID0gKGsgKyAxKSAlIDQ7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaSArPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgaiArPSB7e2JsYW5rXzN9fTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNH19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoieCA8IDAgfHwgeCA+PSBtIHx8IHkgPCAwIHx8IHkgPj0gbiB8fCB2aXNbeF1beV0iLCJibGFua18yIjoiZGlyc1trXSIsImJsYW5rXzMiOiJkaXJzW2sgKyAxXSIsImJsYW5rXzQiOiJhbnMifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmlrnlkJHmlbDnu4QiLCLorr/pl67moIforrAiLCLpobrml7bpkojovazlkJEiLCLmlbDnu4QiLCLnn6npmLUiLCLmqKHmi58iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 54
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-20: #48 旋转图像

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    48, 20, CONVERT(FROM_BASE64('5peL6L2s5Zu+5YOP') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5LiqICpuKsOXICpuKiDnmoTkuoznu7Tnn6npmLUgYG1hdHJpeGAg6KGo56S65LiA5Liq5Zu+5YOP44CC6K+35L2g5bCG5Zu+5YOP6aG65pe26ZKI5peL6L2sIDkwIOW6puOAggoK5L2g5b+F6aG75ZyoKipb5Y6f5ZywXShodHRwczovL2JhaWtlLmJhaWR1LmNvbS9pdGVtLyVFNSU4RSU5RiVFNSU5QyVCMCVFNyVBRSU5NyVFNiVCMyU5NSkqKuaXi+i9rOWbvuWDj++8jOi/meaEj+WRs+edgOS9oOmcgOimgeebtOaOpeS/ruaUuei+k+WFpeeahOS6jOe7tOefqemYteOAgioq6K+35LiN6KaBKirkvb/nlKjlj6bkuIDkuKrnn6npmLXmnaXml4vovazlm77lg4/jgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8wOC8yOC9tYXQxLmpwZykKCmBgYHRleHQK6L6T5YWl77yabWF0cml4ID0gW1sxLDIsM10sWzQsNSw2XSxbNyw4LDldXQrovpPlh7rvvJpbWzcsNCwxXSxbOCw1LDJdLFs5LDYsM11dCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzA4LzI4L21hdDIuanBnKQoKYGBgdGV4dArovpPlhaXvvJptYXRyaXggPSBbWzUsMSw5LDExXSxbMiw0LDgsMTBdLFsxMywzLDYsN10sWzE1LDE0LDEyLDE2XV0K6L6T5Ye677yaW1sxNSwxMywyLDVdLFsxNCwzLDQsMV0sWzEyLDYsOCw5XSxbMTYsNywxMCwxMV1dCmBgYCoq5o+Q56S677yaKiotIGBuID09IG1hdHJpeC5sZW5ndGggPT0gbWF0cml4W2ldLmxlbmd0aGAKLSBgMSA8PSBuIDw9IDIwYAotIGAtMTAwMCA8PSBtYXRyaXhbaV1bal0gPD0gMTAwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9yb3RhdGUtaW1hZ2UvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3JvdGF0ZS1pbWFnZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5rK/5Li75a+56KeS57q/6L2s572u77yM5YaN5Y+N6L2s5q+P5LiA6KGM77yM5Y2z5b6X5Yiw6aG65pe26ZKIIDkwIOW6puaXi+i9rOOAgiDmnKzpopjlm7Tnu5XjgIzml4vovazlm77lg4/jgI3okL3lrp7ov5nkuIDmqKHlnovvvJrovaznva7lkI4gbWF0cml4W2ldW2pdIOW3suenu+WKqOWIsCBtYXRyaXhbal1baV3vvIzooYzlj43ovazlho3lrozmiJDliJfliLDnm67moIfliJfnmoTmmKDlsITjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Li75a+56KeS57q/6L2s572u55qE5ZCr5LmJ77yM5YaN5qOA5p+l6KGM5Y+N6L2s5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IGk7ICsraikgewogICAgICAgICAgICAgICAgaW50IHQgPSBtYXRyaXhbaV1bal07CiAgICAgICAgICAgICAgICBtYXRyaXhbaV1bal0gPSBtYXRyaXhbal1baV07') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgcm90YXRlKGludFtdW10gbWF0cml4KSB7CiAgICAgICAgaW50IG4gPSBtYXRyaXgubGVuZ3RoOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbiA+PiAxOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGludCB0ID0gbWF0cml4W2ldW2pdOwogICAgICAgICAgICAgICAgbWF0cml4W2ldW2pdID0gbWF0cml4W24gLSBpIC0gMV1bal07CiAgICAgICAgICAgICAgICBtYXRyaXhbbiAtIGkgLSAxXVtqXSA9IHQ7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBpOyArK2opIHsKICAgICAgICAgICAgICAgIGludCB0ID0gbWF0cml4W2ldW2pdOwogICAgICAgICAgICAgICAgbWF0cml4W2ldW2pdID0gbWF0cml4W2pdW2ldOwogICAgICAgICAgICAgICAgbWF0cml4W2pdW2ldID0gdDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 48
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 48
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 48
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6L2s572u5ZCOIG1hdHJpeFtpXVtqXSDlt7Lnp7vliqjliLAgbWF0cml4W2pdW2ld77yM6KGM5Y+N6L2s5YaN5a6M5oiQ5YiX5Yiw55uu5qCH5YiX55qE5pig5bCE44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJvdGF0ZSDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('6L2s572u5YaF5bGC5Y+q6IO96YGN5Y6GIGo+aSDnmoTkuIDljYrljLrln5/vvJvlj43ovazml7blt6blj7PmjIfpkojkuI3og73otorov4fjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CGIG7CsiDkuKrljZXlhYPvvIzml7bpl7QgTyhuwrIp77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L2s572u5YaF5bGC5Y+q6IO96YGN5Y6GIGo+aSDnmoTkuIDljYrljLrln5/vvJvlj43ovazml7blt6blj7PmjIfpkojkuI3og73otorov4fjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJvdGF0ZSDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgcm90YXRlKGludFtdW10gbWF0cml4KSB7CiAgICAgICAgaW50IG4gPSBtYXRyaXgubGVuZ3RoOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbiA+PiAxOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGludCB0ID0ge3tibGFua18xfX07CiAgICAgICAgICAgICAgICBtYXRyaXhbaV1bal0gPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgICAgIG1hdHJpeFtuIC0gaSAtIDFdW2pdID0gdDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IGk7ICsraikgewogICAgICAgICAgICAgICAgaW50IHQgPSBtYXRyaXhbaV1bal07CiAgICAgICAgICAgICAgICBtYXRyaXhbaV1bal0gPSB7e2JsYW5rXzN9fTsKICAgICAgICAgICAgICAgIG1hdHJpeFtqXVtpXSA9IHQ7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibWF0cml4W2ldW2pdIiwiYmxhbmtfMiI6Im1hdHJpeFtuIC0gaSAtIDFdW2pdIiwiYmxhbmtfMyI6Im1hdHJpeFtqXVtpXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuLvlr7nop5Lnur/ovaznva4iLCLooYzlj43ovawiLCLljp/lnLDml4vovawiLCLmlbDnu4QiLCLmlbDlraYiLCLnn6npmLUiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 48
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-21: #240 搜索二维矩阵 II

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    240, 21, CONVERT(FROM_BASE64('5pCc57Si5LqM57u055+p6Zi1IElJ') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57yW5YaZ5LiA5Liq6auY5pWI55qE566X5rOV5p2l5pCc57SiIGBtIHggbmAg55+p6Zi1IGBtYXRyaXhgIOS4reeahOS4gOS4quebruagh+WAvCBgdGFyZ2V0YCDjgILor6Xnn6npmLXlhbfmnInku6XkuIvnibnmgKfvvJoKCi0g5q+P6KGM55qE5YWD57Sg5LuO5bem5Yiw5Y+z5Y2H5bqP5o6S5YiX44CCCi0g5q+P5YiX55qE5YWD57Sg5LuO5LiK5Yiw5LiL5Y2H5bqP5o6S5YiX44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNuL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDIwLzExLzI1L3NlYXJjaGdyaWQyLmpwZykKCmBgYHRleHQK6L6T5YWl77yabWF0cml4ID0gW1sxLDQsNywxMSwxNV0sWzIsNSw4LDEyLDE5XSxbMyw2LDksMTYsMjJdLFsxMCwxMywxNCwxNywyNF0sWzE4LDIxLDIzLDI2LDMwXV0sIHRhcmdldCA9IDUK6L6T5Ye677yadHJ1ZQpgYGAqKuekuuS+iyAy77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY24vYWxpeXVuLWxjLXVwbG9hZC91cGxvYWRzLzIwMjAvMTEvMjUvc2VhcmNoZ3JpZC5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mm1hdHJpeCA9IFtbMSw0LDcsMTEsMTVdLFsyLDUsOCwxMiwxOV0sWzMsNiw5LDE2LDIyXSxbMTAsMTMsMTQsMTcsMjRdLFsxOCwyMSwyMywyNiwzMF1dLCB0YXJnZXQgPSAyMArovpPlh7rvvJpmYWxzZQpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBtYXRyaXgubGVuZ3RoYAotIGBuID09IG1hdHJpeFtpXS5sZW5ndGhgCi0gYDEgPD0gbiwgbSA8PSAzMDBgCi0gYC0xMDkgPD0gbWF0cml4W2ldW2pdIDw9IDEwOWAKLSDmr4/ooYznmoTmiYDmnInlhYPntKDku47lt6bliLDlj7PljYfluo/mjpLliJcKLSDmr4/liJfnmoTmiYDmnInlhYPntKDku47kuIrliLDkuIvljYfluo/mjpLliJcKLSBgLTEwOSA8PSB0YXJnZXQgPD0gMTA5YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3NlYXJjaC1hLTJkLW1hdHJpeC1paS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc2VhcmNoLWEtMmQtbWF0cml4LWlpLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuO5bem5LiL6KeS5Ye65Y+R77ya5b2T5YmN5YC85aSn5YiZ5LiK56e777yM5bCP5YiZ5Y+z56e777yM5LiA5qyh5o6S6Zmk5LiA5pW06KGM5oiW5LiA5pW05YiX44CCIOacrOmimOWbtOe7leOAjOaQnOe0ouS6jOe7tOefqemYtSBJSeOAjeiQveWunui/meS4gOaooeWei++8muebruagh+iLpeS7jeWtmOWcqO+8jOWni+e7iOS9jeS6juW9k+WJjeWdkOagh+WPs+S4iuaWueWwmuacquaOkumZpOeahOefqeW9ouS4reOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bem5LiL6KeS55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y2V6LCD55+p6Zi15aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGkgPj0gMCAmJiBqIDwgbikgewogICAgICAgICAgICBpZiAobWF0cml4W2ldW2pdID09IHRhcmdldCkgewogICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKG1hdHJpeFtpXVtqXSA+IHRhcmdldCkgewogICAgICAgICAgICAgICAgLS1pOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gc2VhcmNoTWF0cml4KGludFtdW10gbWF0cml4LCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgaW50IG0gPSBtYXRyaXgubGVuZ3RoLCBuID0gbWF0cml4WzBdLmxlbmd0aDsKICAgICAgICBpbnQgaSA9IG0gLSAxLCBqID0gMDsKICAgICAgICB3aGlsZSAoaSA+PSAwICYmIGogPCBuKSB7CiAgICAgICAgICAgIGlmIChtYXRyaXhbaV1bal0gPT0gdGFyZ2V0KSB7CiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgICAgfQogICAgICAgICAgICBpZiAobWF0cml4W2ldW2pdID4gdGFyZ2V0KSB7CiAgICAgICAgICAgICAgICAtLWk7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICArK2o7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 240
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 240
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 240
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 240
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('55uu5qCH6Iul5LuN5a2Y5Zyo77yM5aeL57uI5L2N5LqO5b2T5YmN5Z2Q5qCH5Y+z5LiK5pa55bCa5pyq5o6S6Zmk55qE55+p5b2i5Lit44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNlYXJjaE1hdHJpeCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5b6q546v5p2h5Lu26KaB5ZCM5pe26ZmQ5Yi26KGM5ZKM5YiX77yb56m655+p6Zi16ZyA55u05o6l6L+U5Zue44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5aSa56e75YqoIG0rbiDmrKHvvIzml7bpl7QgTyhtK24p77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b6q546v5p2h5Lu26KaB5ZCM5pe26ZmQ5Yi26KGM5ZKM5YiX77yb56m655+p6Zi16ZyA55u05o6l6L+U5Zue44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNlYXJjaE1hdHJpeCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gc2VhcmNoTWF0cml4KGludFtdW10gbWF0cml4LCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgaW50IG0gPSBtYXRyaXgubGVuZ3RoLCBuID0gbWF0cml4WzBdLmxlbmd0aDsKICAgICAgICBpbnQgaSA9IG0gLSAxLCBqID0gMDsKICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKHt7YmxhbmtfNH19KSB7CiAgICAgICAgICAgICAgICAtLWk7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICArK2o7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaSA+PSAwICYmIGogPCBuIiwiYmxhbmtfMiI6Im1hdHJpeFtpXVtqXSA9PSB0YXJnZXQiLCJibGFua18zIjoidHJ1ZSIsImJsYW5rXzQiOiJtYXRyaXhbaV1bal0gPiB0YXJnZXQiLCJibGFua181IjoiZmFsc2UifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6bkuIvop5IiLCLljZXosIPnn6npmLUiLCLmjpLpmaTooYzliJciLCLmlbDnu4QiLCLkuozliIbmn6Xmib4iLCLliIbmsrsiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 240
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-22: #160 相交链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    160, 22, CONVERT(FROM_BASE64('55u45Lqk6ZO+6KGo') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5Lik5Liq5Y2V6ZO+6KGo55qE5aS06IqC54K5IGBoZWFkQWAg5ZKMIGBoZWFkQmAg77yM6K+35L2g5om+5Ye65bm26L+U5Zue5Lik5Liq5Y2V6ZO+6KGo55u45Lqk55qE6LW35aeL6IqC54K544CC5aaC5p6c5Lik5Liq6ZO+6KGo5LiN5a2Y5Zyo55u45Lqk6IqC54K577yM6L+U5ZueIGBudWxsYCDjgIIKCuWbvuekuuS4pOS4qumTvuihqOWcqOiKgueCuSBgYzFgIOW8gOWni+ebuOS6pCoq77yaKipbIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNuL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDE4LzEyLzE0LzE2MF9zdGF0ZW1lbnQucG5nKV0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY24vYWxpeXVuLWxjLXVwbG9hZC91cGxvYWRzLzIwMTgvMTIvMTQvMTYwX3N0YXRlbWVudC5wbmcpCgrpopjnm67mlbDmja4qKuS/neivgSoq5pW05Liq6ZO+5byP57uT5p6E5Lit5LiN5a2Y5Zyo546v44CCKirms6jmhI8qKu+8jOWHveaVsOi/lOWbnue7k+aenOWQju+8jOmTvuihqOW/hemhuyoq5L+d5oyB5YW25Y6f5aeL57uT5p6EKirjgIIqKuiHquWumuS5ieivhOa1i++8mioqKiror4TmtYvns7vnu58qKueahOi+k+WFpeWmguS4i++8iOS9oOiuvuiuoeeahOeoi+W6jyoq5LiN6YCC55SoKirmraTovpPlhaXvvInvvJoKCi0gYGludGVyc2VjdFZhbGAgLSDnm7jkuqTnmoTotbflp4voioLngrnnmoTlgLzjgILlpoLmnpzkuI3lrZjlnKjnm7jkuqToioLngrnvvIzov5nkuIDlgLzkuLogYDBgCi0gYGxpc3RBYCAtIOesrOS4gOS4qumTvuihqAotIGBsaXN0QmAgLSDnrKzkuozkuKrpk77ooagKLSBgc2tpcEFgIC0g5ZyoIGBsaXN0QWAg5Lit77yI5LuO5aS06IqC54K55byA5aeL77yJ6Lez5Yiw5Lqk5Y+J6IqC54K555qE6IqC54K55pWwCi0gYHNraXBCYCAtIOWcqCBgbGlzdEJgIOS4re+8iOS7juWktOiKgueCueW8gOWni++8iei3s+WIsOS6pOWPieiKgueCueeahOiKgueCueaVsAoK6K+E5rWL57O757uf5bCG5qC55o2u6L+Z5Lqb6L6T5YWl5Yib5bu66ZO+5byP5pWw5o2u57uT5p6E77yM5bm25bCG5Lik5Liq5aS06IqC54K5IGBoZWFkQWAg5ZKMIGBoZWFkQmAg5Lyg6YCS57uZ5L2g55qE56iL5bqP44CC5aaC5p6c56iL5bqP6IO95aSf5q2j56Gu6L+U5Zue55u45Lqk6IqC54K577yM6YKj5LmI5L2g55qE6Kej5Yaz5pa55qGI5bCG6KKrKirop4bkvZzmraPnoa7nrZTmoYgqKuOAgioq56S65L6LIDHvvJoqKlshW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMy8wNS8xNjBfZXhhbXBsZV8xXzEucG5nKV0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAxOC8xMi8xMy8xNjBfZXhhbXBsZV8xLnBuZykKCmBgYHRleHQK6L6T5YWl77yaaW50ZXJzZWN0VmFsID0gOCwgbGlzdEEgPSBbNCwxLDgsNCw1XSwgbGlzdEIgPSBbNSw2LDEsOCw0LDVdLCBza2lwQSA9IDIsIHNraXBCID0gMwrovpPlh7rvvJpJbnRlcnNlY3RlZCBhdCAnOCcK6Kej6YeK77ya55u45Lqk6IqC54K555qE5YC85Li6IDgg77yI5rOo5oSP77yM5aaC5p6c5Lik5Liq6ZO+6KGo55u45Lqk5YiZ5LiN6IO95Li6IDDvvInjgIIK5LuO5ZCE6Ieq55qE6KGo5aS05byA5aeL566X6LW377yM6ZO+6KGoIEEg5Li6IFs0LDEsOCw0LDVd77yM6ZO+6KGoIEIg5Li6IFs1LDYsMSw4LDQsNV3jgIIK5ZyoIEEg5Lit77yM55u45Lqk6IqC54K55YmN5pyJIDIg5Liq6IqC54K577yb5ZyoIEIg5Lit77yM55u45Lqk6IqC54K55YmN5pyJIDMg5Liq6IqC54K544CCCuKAlCDor7fms6jmhI/nm7jkuqToioLngrnnmoTlgLzkuI3kuLogMe+8jOWboOS4uuWcqOmTvuihqCBBIOWSjOmTvuihqCBCIOS5i+S4reWAvOS4uiAxIOeahOiKgueCuSAoQSDkuK3nrKzkuozkuKroioLngrnlkowgQiDkuK3nrKzkuInkuKroioLngrkpIOaYr+S4jeWQjOeahOiKgueCueOAguaNouWPpeivneivtO+8jOWug+S7rOWcqOWGheWtmOS4reaMh+WQkeS4pOS4quS4jeWQjOeahOS9jee9ru+8jOiAjOmTvuihqCBBIOWSjOmTvuihqCBCIOS4reWAvOS4uiA4IOeahOiKgueCuSAoQSDkuK3nrKzkuInkuKroioLngrnvvIxCIOS4reesrOWbm+S4quiKgueCuSkg5Zyo5YaF5a2Y5Lit5oyH5ZCR55u45ZCM55qE5L2N572u44CCCmBgYCoq56S65L6LIDLvvJoqKlshW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMy8wNS8xNjBfZXhhbXBsZV8yLnBuZyldKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMTgvMTIvMTMvMTYwX2V4YW1wbGVfMi5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmludGVyc2VjdFZhbMKgPSAyLCBsaXN0QSA9IFsxLDksMSwyLDRdLCBsaXN0QiA9IFszLDIsNF0sIHNraXBBID0gMywgc2tpcEIgPSAxCui+k+WHuu+8mkludGVyc2VjdGVkIGF0ICcyJwrop6Pph4rvvJrnm7jkuqToioLngrnnmoTlgLzkuLogMiDvvIjms6jmhI/vvIzlpoLmnpzkuKTkuKrpk77ooajnm7jkuqTliJnkuI3og73kuLogMO+8ieOAggrku47lkIToh6rnmoTooajlpLTlvIDlp4vnrpfotbfvvIzpk77ooaggQSDkuLogWzEsOSwxLDIsNF3vvIzpk77ooaggQiDkuLogWzMsMiw0XeOAggrlnKggQSDkuK3vvIznm7jkuqToioLngrnliY3mnIkgMyDkuKroioLngrnvvJvlnKggQiDkuK3vvIznm7jkuqToioLngrnliY3mnIkgMSDkuKroioLngrnjgIIKYGBgKirnpLrkvosgM++8mioqWyFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAxOC8xMi8xNC8xNjBfZXhhbXBsZV8zLnBuZyldKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMTgvMTIvMTMvMTYwX2V4YW1wbGVfMy5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmludGVyc2VjdFZhbCA9IDAsIGxpc3RBID0gWzIsNiw0XSwgbGlzdEIgPSBbMSw1XSwgc2tpcEEgPSAzLCBza2lwQiA9IDIK6L6T5Ye677yaTm8gaW50ZXJzZWN0aW9uCuino+mHiu+8muS7juWQhOiHqueahOihqOWktOW8gOWni+eul+i1t++8jOmTvuihqCBBIOS4uiBbMiw2LDRd77yM6ZO+6KGoIEIg5Li6IFsxLDVd44CCCueUseS6jui/meS4pOS4qumTvuihqOS4jeebuOS6pO+8jOaJgOS7pSBpbnRlcnNlY3RWYWwg5b+F6aG75Li6IDDvvIzogIwgc2tpcEEg5ZKMIHNraXBCIOWPr+S7peaYr+S7u+aEj+WAvOOAggrov5nkuKTkuKrpk77ooajkuI3nm7jkuqTvvIzlm6DmraTov5Tlm54gbnVsbCDjgIIKYGBgKirmj5DnpLrvvJoqKi0gYGxpc3RBYCDkuK3oioLngrnmlbDnm67kuLogYG1gCi0gYGxpc3RCYCDkuK3oioLngrnmlbDnm67kuLogYG5gCi0gYDEgPD0gbSwgbiA8PSAzICogMTA0YAotIGAxIDw9IE5vZGUudmFsIDw9IDEwNWAKLSBgMCA8PSBza2lwQSA8PSBtYAotIGAwIDw9IHNraXBCIDw9IG5gCi0g5aaC5p6cIGBsaXN0QWAg5ZKMIGBsaXN0QmAg5rKh5pyJ5Lqk54K577yMYGludGVyc2VjdFZhbGAg5Li6IGAwYAotIOWmguaenCBgbGlzdEFgIOWSjCBgbGlzdEJgIOacieS6pOeCue+8jGBpbnRlcnNlY3RWYWwgPT0gbGlzdEFbc2tpcEFdID09IGxpc3RCW3NraXBCXWAqKui/m+mYtu+8mioq5L2g6IO95ZCm6K6+6K6h5LiA5Liq5pe26Ze05aSN5p2C5bqmIGBPKG0gKyBuKWAg44CB5LuF55SoIGBPKDEpYCDlhoXlrZjnmoTop6PlhrPmlrnmoYjvvJ8KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9pbnRlcnNlY3Rpb24tb2YtdHdvLWxpbmtlZC1saXN0cy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvaW50ZXJzZWN0aW9uLW9mLXR3by1saW5rZWQtbGlzdHMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5Lik5oyH6ZKI5YiG5Yir6LWwIEHihpJCIOS4jiBC4oaSQe+8jOi1sOi/h+ebuOWQjOaAu+i3r+eoi+WQjuS8muWcqOS6pOeCueaIliBudWxsIOebuOmBh+OAgiDmnKzpopjlm7Tnu5XjgIznm7jkuqTpk77ooajjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrliIfmjaLpk77ooajlkI7vvIzkuKTmjIfpkojliankvZnot6/nqIvnm7jlkIzvvIzplb/luqblt67ooqvoh6rnhLbmirXmtojjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y+M6ZO+5YiH5o2i55qE5ZCr5LmJ77yM5YaN5qOA5p+l5oq15raI6ZW/5bqm5beu5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGEgIT0gYikgewogICAgICAgICAgICBhID0gYSA9PSBudWxsID8gaGVhZEIgOiBhLm5leHQ7CiAgICAgICAgICAgIGIgPSBiID09IG51bGwgPyBoZWFkQSA6IGIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGE7CiAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBMaXN0Tm9kZSBnZXRJbnRlcnNlY3Rpb25Ob2RlKExpc3ROb2RlIGhlYWRBLCBMaXN0Tm9kZSBoZWFkQikgewogICAgICAgIExpc3ROb2RlIGEgPSBoZWFkQSwgYiA9IGhlYWRCOwogICAgICAgIHdoaWxlIChhICE9IGIpIHsKICAgICAgICAgICAgYSA9IGEgPT0gbnVsbCA/IGhlYWRCIDogYS5uZXh0OwogICAgICAgICAgICBiID0gYiA9PSBudWxsID8gaGVhZEEgOiBiLm5leHQ7CiAgICAgICAgfQogICAgICAgIHJldHVybiBhOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 160
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 160
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 160
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YiH5o2i6ZO+6KGo5ZCO77yM5Lik5oyH6ZKI5Ymp5L2Z6Lev56iL55u45ZCM77yM6ZW/5bqm5beu6KKr6Ieq54S25oq15raI44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGdldEludGVyc2VjdGlvbk5vZGUg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+U6L6D55qE5piv6IqC54K55byV55So6ICM5LiN5pivIHZhbO+8m+WIsCBudWxsIOaXtuWIh+aNouWIsOWPpuS4gOadoemTvuihqOeahOWktOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obStuKe+8jOepuumXtCBPKDEp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+U6L6D55qE5piv6IqC54K55byV55So6ICM5LiN5pivIHZhbO+8m+WIsCBudWxsIOaXtuWIh+aNouWIsOWPpuS4gOadoemTvuihqOeahOWktOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGdldEludGVyc2VjdGlvbk5vZGUg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBMaXN0Tm9kZSBnZXRJbnRlcnNlY3Rpb25Ob2RlKExpc3ROb2RlIGhlYWRBLCBMaXN0Tm9kZSBoZWFkQikgewogICAgICAgIExpc3ROb2RlIGEgPSB7e2JsYW5rXzF9fSwgYiA9IHt7YmxhbmtfMn19OwogICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICBhID0gYSA9PSBudWxsID8gaGVhZEIgOiBhLm5leHQ7CiAgICAgICAgICAgIGIgPSBiID09IG51bGwgPyBoZWFkQSA6IGIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGE7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaGVhZEEiLCJibGFua18yIjoiaGVhZEIiLCJibGFua18zIjoiYSAhPSBiIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlj4zpk77liIfmjaIiLCLmirXmtojplb/luqblt64iLCLoioLngrnlvJXnlKgiLCLlk4jluIzooagiLCLpk77ooagiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 160
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-23: #206 反转链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    206, 23, CONVERT(FROM_BASE64('5Y+N6L2s6ZO+6KGo') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5Y2V6ZO+6KGo55qE5aS06IqC54K5IGBoZWFkYCDvvIzor7fkvaDlj43ovazpk77ooajvvIzlubbov5Tlm57lj43ovazlkI7nmoTpk77ooajjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMi8xOS9yZXYxZXgxLmpwZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFsxLDIsMyw0LDVdCui+k+WHuu+8mls1LDQsMywyLDFdCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAyLzE5L3JldjFleDIuanBnKQoKYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWzEsMl0K6L6T5Ye677yaWzIsMV0KYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpoZWFkID0gW10K6L6T5Ye677yaW10KYGBgKirmj5DnpLrvvJoqKi0g6ZO+6KGo5Lit6IqC54K555qE5pWw55uu6IyD5Zu05pivIGBbMCwgNTAwMF1gCi0gYC01MDAwIDw9IE5vZGUudmFsIDw9IDUwMDBgKirov5vpmLbvvJoqKumTvuihqOWPr+S7pemAieeUqOi/reS7o+aIlumAkuW9kuaWueW8j+WujOaIkOWPjei9rOOAguS9oOiDveWQpueUqOS4pOenjeaWueazleino+WGs+i/memBk+mimO+8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3JldmVyc2UtbGlua2VkLWxpc3QvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3JldmVyc2UtbGlua2VkLWxpc3QvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('55So6Jma5ouf5aS05YGa5aS05o+S5rOV77ya6YCQ5Liq5pGY5LiL5Y6f6ZO+5b2T5YmN6IqC54K577yM5o+S5YiwIGR1bW15Lm5leHQg5LmL5YmN44CCIOacrOmimOWbtOe7leOAjOWPjei9rOmTvuihqOOAjeiQveWunui/meS4gOaooeWei++8mmR1bW15Lm5leHQg5aeL57uI5oyH5ZCR5bey5Y+N6L2s5YmN57yA55qE5aS077yMY3VyciDmjIflkJHmnKrlpITnkIblkI7nvIDnmoTpppboioLngrnjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5aS05o+S5rOV55qE5ZCr5LmJ77yM5YaN5qOA5p+l5L+d5a2Y5ZCO57un5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Y3Vyci5uZXh0ID0gZHVtbXkubmV4dDsKICAgICAgICAgICAgZHVtbXkubmV4dCA9IGN1cnI7CiAgICAgICAgICAgIGN1cnIgPSBuZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJldmVyc2VMaXN0KExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgpOwogICAgICAgIExpc3ROb2RlIGN1cnIgPSBoZWFkOwogICAgICAgIHdoaWxlIChjdXJyICE9IG51bGwpIHsKICAgICAgICAgICAgTGlzdE5vZGUgbmV4dCA9IGN1cnIubmV4dDsKICAgICAgICAgICAgY3Vyci5uZXh0ID0gZHVtbXkubmV4dDsKICAgICAgICAgICAgZHVtbXkubmV4dCA9IGN1cnI7CiAgICAgICAgICAgIGN1cnIgPSBuZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 206
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 206
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('ZHVtbXkubmV4dCDlp4vnu4jmjIflkJHlt7Llj43ovazliY3nvIDnmoTlpLTvvIxjdXJyIOaMh+WQkeacquWkhOeQhuWQjue8gOeahOmmluiKgueCueOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJldmVyc2VMaXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75YWI5L+d5a2YIGN1cnIubmV4dCDlho3lgZrlpLTmj5LvvJvmnIDnu4jov5Tlm54gZHVtbXkubmV4dOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5L+d5a2YIGN1cnIubmV4dCDlho3lgZrlpLTmj5LvvJvmnIDnu4jov5Tlm54gZHVtbXkubmV4dOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJldmVyc2VMaXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJldmVyc2VMaXN0KExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgpOwogICAgICAgIExpc3ROb2RlIGN1cnIgPSB7e2JsYW5rXzF9fTsKICAgICAgICB3aGlsZSAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgTGlzdE5vZGUgbmV4dCA9IGN1cnIubmV4dDsKICAgICAgICAgICAgY3Vyci5uZXh0ID0gZHVtbXkubmV4dDsKICAgICAgICAgICAgZHVtbXkubmV4dCA9IGN1cnI7CiAgICAgICAgICAgIGN1cnIgPSBuZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaGVhZCIsImJsYW5rXzIiOiJjdXJyICE9IG51bGwiLCJibGFua18zIjoiZHVtbXkubmV4dCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlpLTmj5Lms5UiLCLkv53lrZjlkI7nu6ciLCLomZrmi5/lpLQiLCLpgJLlvZIiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 206
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-24: #234 回文链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    234, 24, CONVERT(FROM_BASE64('5Zue5paH6ZO+6KGo') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5Y2V6ZO+6KGo55qE5aS06IqC54K5IGBoZWFkYCDvvIzor7fkvaDliKTmlq3or6Xpk77ooajmmK/lkKbkuLrlm57mlofpk77ooajjgILlpoLmnpzmmK/vvIzov5Tlm54gYHRydWVgIO+8m+WQpuWIme+8jOi/lOWbniBgZmFsc2VgIOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAzLzAzL3BhbDFsaW5rZWQtbGlzdC5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMSwyLDIsMV0K6L6T5Ye677yadHJ1ZQpgYGAqKuekuuS+iyAy77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMy8wMy9wYWwybGlua2VkLWxpc3QuanBnKQoKYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWzEsMl0K6L6T5Ye677yaZmFsc2UKYGBgKirmj5DnpLrvvJoqKi0g6ZO+6KGo5Lit6IqC54K55pWw55uu5Zyo6IyD5Zu0YFsxLCAxMDVdYCDlhoUKLSBgMCA8PSBOb2RlLnZhbCA8PSA5YCoq6L+b6Zi277yaKirkvaDog73lkKbnlKggYE8obilgIOaXtumXtOWkjeadguW6puWSjCBgTygxKWAg56m66Ze05aSN5p2C5bqm6Kej5Yaz5q2k6aKY77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvcGFsaW5kcm9tZS1saW5rZWQtbGlzdC8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcGFsaW5kcm9tZS1saW5rZWQtbGlzdC8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5b+r5oWi5oyH6ZKI5om+5Lit54K577yM5Y+N6L2s5ZCO5Y2K6ZO+6KGo77yM5YaN5LuO5Lik56uv6YCQ6IqC54K55q+U6L6D44CCIOacrOmimOWbtOe7leOAjOWbnuaWh+mTvuihqOOAjeiQveWunui/meS4gOaooeWei++8muavlOi+g+mYtuautSBmaXJzdCDmjIflkJHliY3ljYrlvZPliY3oioLngrnvvIxzZWNvbmQg5oyH5ZCR5Y+N6L2s5ZCO5Y2K5b2T5YmN6IqC54K577yM5bey5q+U6L6D5YmN57yA55u4562J44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5b+r5oWi5oyH6ZKI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y+N6L2s5ZCO5Y2K5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIHdoaWxlIChwcmUgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAocHJlLnZhbCAhPSBoZWFkLnZhbCkgewogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHByZSA9IHByZS5uZXh0Ow==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNQYWxpbmRyb21lKExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gaGVhZC5uZXh0OwogICAgICAgIHdoaWxlIChmYXN0ICE9IG51bGwgJiYgZmFzdC5uZXh0ICE9IG51bGwpIHsKICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dC5uZXh0OwogICAgICAgIH0KICAgICAgICBMaXN0Tm9kZSBjdXIgPSBzbG93Lm5leHQ7CiAgICAgICAgc2xvdy5uZXh0ID0gbnVsbDsKICAgICAgICBMaXN0Tm9kZSBwcmUgPSBudWxsOwogICAgICAgIHdoaWxlIChjdXIgIT0gbnVsbCkgewogICAgICAgICAgICBMaXN0Tm9kZSB0ID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGN1ci5uZXh0ID0gcHJlOwogICAgICAgICAgICBwcmUgPSBjdXI7CiAgICAgICAgICAgIGN1ciA9IHQ7CiAgICAgICAgfQogICAgICAgIHdoaWxlIChwcmUgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAocHJlLnZhbCAhPSBoZWFkLnZhbCkgewogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHByZSA9IHByZS5uZXh0OwogICAgICAgICAgICBoZWFkID0gaGVhZC5uZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gdHJ1ZTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 234
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 234
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 234
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 234
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+U6L6D6Zi25q61IGZpcnN0IOaMh+WQkeWJjeWNiuW9k+WJjeiKgueCue+8jHNlY29uZCDmjIflkJHlj43ovazlkI7ljYrlvZPliY3oioLngrnvvIzlt7Lmr5TovoPliY3nvIDnm7jnrYnjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGlzUGFsaW5kcm9tZSDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5aWH5pWw6ZW/5bqm6KaB6K6p5ZCO5Y2K5LuO5q2j56Gu5L2N572u5byA5aeL77yb5bel56iL5Zy65pmv5Y+v5Zyo5q+U6L6D5ZCO5oGi5aSN6ZO+6KGo44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aWH5pWw6ZW/5bqm6KaB6K6p5ZCO5Y2K5LuO5q2j56Gu5L2N572u5byA5aeL77yb5bel56iL5Zy65pmv5Y+v5Zyo5q+U6L6D5ZCO5oGi5aSN6ZO+6KGo44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGlzUGFsaW5kcm9tZSDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNQYWxpbmRyb21lKExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gaGVhZC5uZXh0OwogICAgICAgIHdoaWxlICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICBzbG93ID0gc2xvdy5uZXh0OwogICAgICAgICAgICBmYXN0ID0gZmFzdC5uZXh0Lm5leHQ7CiAgICAgICAgfQogICAgICAgIExpc3ROb2RlIGN1ciA9IHNsb3cubmV4dDsKICAgICAgICBzbG93Lm5leHQgPSBudWxsOwogICAgICAgIExpc3ROb2RlIHByZSA9IG51bGw7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIExpc3ROb2RlIHQgPSBjdXIubmV4dDsKICAgICAgICAgICAgY3VyLm5leHQgPSBwcmU7CiAgICAgICAgICAgIHByZSA9IGN1cjsKICAgICAgICAgICAgY3VyID0gdDsKICAgICAgICB9CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzR9fSkgewogICAgICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgICAgICAgICB9CiAgICAgICAgICAgIHByZSA9IHByZS5uZXh0OwogICAgICAgICAgICBoZWFkID0gaGVhZC5uZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gdHJ1ZTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsIiwiYmxhbmtfMiI6ImN1ciAhPSBudWxsIiwiYmxhbmtfMyI6InByZSAhPSBudWxsIiwiYmxhbmtfNCI6InByZS52YWwgIT0gaGVhZC52YWwiLCJibGFua181IjoiZmFsc2UifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlv6vmhaLmjIfpkogiLCLlj43ovazlkI7ljYoiLCLlj4znq6/mr5TovoMiLCLmoIgiLCLpgJLlvZIiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 234
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-25: #141 环形链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    141, 25, CONVERT(FROM_BASE64('546v5b2i6ZO+6KGo') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6ZO+6KGo55qE5aS06IqC54K5IGBoZWFkYCDvvIzliKTmlq3pk77ooajkuK3mmK/lkKbmnInnjq/jgIIKCuWmguaenOmTvuihqOS4reacieafkOS4quiKgueCue+8jOWPr+S7pemAmui/h+i/nue7rei3n+i4qiBgbmV4dGAg5oyH6ZKI5YaN5qyh5Yiw6L6+77yM5YiZ6ZO+6KGo5Lit5a2Y5Zyo546v44CCIOS4uuS6huihqOekuue7meWumumTvuihqOS4reeahOeOr++8jOivhOa1i+ezu+e7n+WGhemDqOS9v+eUqOaVtOaVsCBgcG9zYCDmnaXooajnpLrpk77ooajlsL7ov57mjqXliLDpk77ooajkuK3nmoTkvY3nva7vvIjntKLlvJXku44gMCDlvIDlp4vvvInjgIIqKuazqOaEj++8mmBwb3NgIOS4jeS9nOS4uuWPguaVsOi/m+ihjOS8oOmAkioq44CC5LuF5LuF5piv5Li65LqG5qCH6K+G6ZO+6KGo55qE5a6e6ZmF5oOF5Ya144CCCgoq5aaC5p6c6ZO+6KGo5Lit5a2Y5Zyo546vKiDvvIzliJnov5Tlm54gYHRydWVgIOOAgiDlkKbliJnvvIzov5Tlm54gYGZhbHNlYCDjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY24vYWxpeXVuLWxjLXVwbG9hZC91cGxvYWRzLzIwMTgvMTIvMDcvY2lyY3VsYXJsaW5rZWRsaXN0LnBuZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFszLDIsMCwtNF0sIHBvcyA9IDEK6L6T5Ye677yadHJ1ZQrop6Pph4rvvJrpk77ooajkuK3mnInkuIDkuKrnjq/vvIzlhbblsL7pg6jov57mjqXliLDnrKzkuozkuKroioLngrnjgIIKYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNuL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDE4LzEyLzA3L2NpcmN1bGFybGlua2VkbGlzdF90ZXN0Mi5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMSwyXSwgcG9zID0gMArovpPlh7rvvJp0cnVlCuino+mHiu+8mumTvuihqOS4reacieS4gOS4queOr++8jOWFtuWwvumDqOi/nuaOpeWIsOesrOS4gOS4quiKgueCueOAggpgYGAqKuekuuS+iyAz77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY24vYWxpeXVuLWxjLXVwbG9hZC91cGxvYWRzLzIwMTgvMTIvMDcvY2lyY3VsYXJsaW5rZWRsaXN0X3Rlc3QzLnBuZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFsxXSwgcG9zID0gLTEK6L6T5Ye677yaZmFsc2UK6Kej6YeK77ya6ZO+6KGo5Lit5rKh5pyJ546v44CCCmBgYCoq5o+Q56S677yaKiotIOmTvuihqOS4reiKgueCueeahOaVsOebruiMg+WbtOaYryBgWzAsIDEwNF1gCi0gYC0xMDUgPD0gTm9kZS52YWwgPD0gMTA1YAotIGBwb3NgIOS4uiBgLTFgIOaIluiAhemTvuihqOS4reeahOS4gOS4qioq5pyJ5pWI57Si5byVKirjgIIqKui/m+mYtu+8mioq5L2g6IO955SoIGBPKDEpYO+8iOWNs++8jOW4uOmHj++8ieWGheWtmOino+WGs+atpOmXrumimOWQl++8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2xpbmtlZC1saXN0LWN5Y2xlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9saW5rZWQtbGlzdC1jeWNsZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5b+r5oyH6ZKI5q+P5qyh5Lik5q2l44CB5oWi5oyH6ZKI5q+P5qyh5LiA5q2l77yb5pyJ546v5pe25LqM6ICF5b+F5Zyo546v5YaF55u46YGH44CCIOacrOmimOWbtOe7leOAjOeOr+W9oumTvuihqOOAjeiQveWunui/meS4gOaooeWei++8muavj+i9ruW/q+aMh+mSiOebuOWvueaFouaMh+mSiOWJjei/m+S4gOS4quS9jee9ru+8jOaXoOeOr+WImeW/q+aMh+mSiOWFiOWIsCBudWxs44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFRmxveWTnmoTlkKvkuYnvvIzlho3mo4Dmn6Xlv6vmhaLmjIfpkojlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('ZmFzdCA9IGZhc3QubmV4dC5uZXh0OwogICAgICAgICAgICBpZiAoc2xvdyA9PSBmYXN0KSB7CiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gZmFsc2U7') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBib29sZWFuIGhhc0N5Y2xlKExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gaGVhZDsKICAgICAgICB3aGlsZSAoZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsKSB7CiAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgIGZhc3QgPSBmYXN0Lm5leHQubmV4dDsKICAgICAgICAgICAgaWYgKHNsb3cgPT0gZmFzdCkgewogICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 141
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 141
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 141
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u5b+r5oyH6ZKI55u45a+55oWi5oyH6ZKI5YmN6L+b5LiA5Liq5L2N572u77yM5peg546v5YiZ5b+r5oyH6ZKI5YWI5YiwIG51bGzjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGhhc0N5Y2xlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5b6q546v5b+F6aG75YWI5qOA5p+lIGZhc3Qg5ZKMIGZhc3QubmV4dO+8jOmBv+WFjeepuuaMh+mSiOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b6q546v5b+F6aG75YWI5qOA5p+lIGZhc3Qg5ZKMIGZhc3QubmV4dO+8jOmBv+WFjeepuuaMh+mSiOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGhhc0N5Y2xlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBib29sZWFuIGhhc0N5Y2xlKExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gaGVhZDsKICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dC5uZXh0OwogICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsIiwiYmxhbmtfMiI6InNsb3cgPT0gZmFzdCIsImJsYW5rXzMiOiJ0cnVlIiwiYmxhbmtfNCI6ImZhbHNlIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJGbG95ZCIsIuW/q+aFouaMh+mSiCIsIuebuOmBhyIsIuWTiOW4jOihqCIsIumTvuihqCIsIuWPjOaMh+mSiCJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 141
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-26: #142 环形链表 II

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    142, 26, CONVERT(FROM_BASE64('546v5b2i6ZO+6KGoIElJ') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq6ZO+6KGo55qE5aS06IqC54K5ICBgaGVhZGAg77yM6L+U5Zue6ZO+6KGo5byA5aeL5YWl546v55qE56ys5LiA5Liq6IqC54K544CCICrlpoLmnpzpk77ooajml6Dnjq/vvIzliJnov5Tlm54gYG51bGxg44CCKgoK5aaC5p6c6ZO+6KGo5Lit5pyJ5p+Q5Liq6IqC54K577yM5Y+v5Lul6YCa6L+H6L+e57ut6Lef6LiqIGBuZXh0YCDmjIfpkojlho3mrKHliLDovr7vvIzliJnpk77ooajkuK3lrZjlnKjnjq/jgIIg5Li65LqG6KGo56S657uZ5a6a6ZO+6KGo5Lit55qE546v77yM6K+E5rWL57O757uf5YaF6YOo5L2/55So5pW05pWwIGBwb3NgIOadpeihqOekuumTvuihqOWwvui/nuaOpeWIsOmTvuihqOS4reeahOS9jee9ru+8iCoq57Si5byV5LuOIDAg5byA5aeLKirvvInjgILlpoLmnpwgYHBvc2Ag5pivIGAtMWDvvIzliJnlnKjor6Xpk77ooajkuK3msqHmnInnjq/jgIIqKuazqOaEj++8mmBwb3NgIOS4jeS9nOS4uuWPguaVsOi/m+ihjOS8oOmAkioq77yM5LuF5LuF5piv5Li65LqG5qCH6K+G6ZO+6KGo55qE5a6e6ZmF5oOF5Ya144CCKirkuI3lhYHorrjkv67mlLkqKumTvuihqOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDE4LzEyLzA3L2NpcmN1bGFybGlua2VkbGlzdC5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMywyLDAsLTRdLCBwb3MgPSAxCui+k+WHuu+8mui/lOWbnue0ouW8leS4uiAxIOeahOmTvuihqOiKgueCuQrop6Pph4rvvJrpk77ooajkuK3mnInkuIDkuKrnjq/vvIzlhbblsL7pg6jov57mjqXliLDnrKzkuozkuKroioLngrnjgIIKYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNuL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDE4LzEyLzA3L2NpcmN1bGFybGlua2VkbGlzdF90ZXN0Mi5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMSwyXSwgcG9zID0gMArovpPlh7rvvJrov5Tlm57ntKLlvJXkuLogMCDnmoTpk77ooajoioLngrkK6Kej6YeK77ya6ZO+6KGo5Lit5pyJ5LiA5Liq546v77yM5YW25bC+6YOo6L+e5o6l5Yiw56ys5LiA5Liq6IqC54K544CCCmBgYCoq56S65L6LIDPvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAxOC8xMi8wNy9jaXJjdWxhcmxpbmtlZGxpc3RfdGVzdDMucG5nKQoKYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWzFdLCBwb3MgPSAtMQrovpPlh7rvvJrov5Tlm54gbnVsbArop6Pph4rvvJrpk77ooajkuK3msqHmnInnjq/jgIIKYGBgKirmj5DnpLrvvJoqKi0g6ZO+6KGo5Lit6IqC54K555qE5pWw55uu6IyD5Zu05Zyo6IyD5Zu0IGBbMCwgMTA0XWAg5YaFCi0gYC0xMDUgPD0gTm9kZS52YWwgPD0gMTA1YAotIGBwb3NgIOeahOWAvOS4uiBgLTFgIOaIluiAhemTvuihqOS4reeahOS4gOS4quacieaViOe0ouW8lSoq6L+b6Zi277yaKirkvaDmmK/lkKblj6/ku6Xkvb/nlKggYE8oMSlgIOepuumXtOino+WGs+atpOmimO+8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2xpbmtlZC1saXN0LWN5Y2xlLWlpLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9saW5rZWQtbGlzdC1jeWNsZS1paS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5b+r5oWi5oyH6ZKI546v5YaF55u46YGH5ZCO77yM5LiA5Liq5oyH6ZKI5Zue5Yiw5aS057uT54K577yM5Lik6ICF5ZCM6YCf5YmN6L+b77yM5YaN5qyh55u46YGH54K55bCx5piv546v5YWl5Y+j44CCIOacrOmimOWbtOe7leOAjOeOr+W9oumTvuihqCBJSeOAjeiQveWunui/meS4gOaooeWei++8mueUsei3r+eoi+WFs+ezu+WPr+W+l+WktOWIsOWFpeWPo+i3neemu+etieS6juebuOmBh+eCuee7p+e7ree7leWIsOWFpeWPo+eahOi3neemu++8iOaooeeOr+mVv++8ieOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF546v5YWl5Y+j55qE5ZCr5LmJ77yM5YaN5qOA5p+l6Lev56iL5YWz57O75aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aWYgKHNsb3cgPT0gZmFzdCkgewogICAgICAgICAgICAgICAgTGlzdE5vZGUgYW5zID0gaGVhZDsKICAgICAgICAgICAgICAgIHdoaWxlIChhbnMgIT0gc2xvdykgewogICAgICAgICAgICAgICAgICAgIGFucyA9IGFucy5uZXh0OwogICAgICAgICAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBMaXN0Tm9kZSBkZXRlY3RDeWNsZShMaXN0Tm9kZSBoZWFkKSB7CiAgICAgICAgTGlzdE5vZGUgZmFzdCA9IGhlYWQsIHNsb3cgPSBoZWFkOwogICAgICAgIHdoaWxlIChmYXN0ICE9IG51bGwgJiYgZmFzdC5uZXh0ICE9IG51bGwpIHsKICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dC5uZXh0OwogICAgICAgICAgICBpZiAoc2xvdyA9PSBmYXN0KSB7CiAgICAgICAgICAgICAgICBMaXN0Tm9kZSBhbnMgPSBoZWFkOwogICAgICAgICAgICAgICAgd2hpbGUgKGFucyAhPSBzbG93KSB7CiAgICAgICAgICAgICAgICAgICAgYW5zID0gYW5zLm5leHQ7CiAgICAgICAgICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIHJldHVybiBhbnM7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIG51bGw7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 142
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 142
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 142
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('55Sx6Lev56iL5YWz57O75Y+v5b6X5aS05Yiw5YWl5Y+j6Led56a7562J5LqO55u46YGH54K557un57ut57uV5Yiw5YWl5Y+j55qE6Led56a777yI5qih546v6ZW/77yJ44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGRldGVjdEN5Y2xlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5peg546v5pe2IGZhc3Qg5oiWIGZhc3QubmV4dCDkuLogbnVsbO+8m+esrOS6jOmYtuauteW/hemhu+aUueS4uuWQjOmAn+S4gOatpeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5peg546v5pe2IGZhc3Qg5oiWIGZhc3QubmV4dCDkuLogbnVsbO+8m+esrOS6jOmYtuauteW/hemhu+aUueS4uuWQjOmAn+S4gOatpeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGRldGVjdEN5Y2xlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('cHVibGljIGNsYXNzIFNvbHV0aW9uIHsKICAgIHB1YmxpYyBMaXN0Tm9kZSBkZXRlY3RDeWNsZShMaXN0Tm9kZSBoZWFkKSB7CiAgICAgICAgTGlzdE5vZGUgZmFzdCA9IGhlYWQsIHNsb3cgPSBoZWFkOwogICAgICAgIHdoaWxlICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICBzbG93ID0gc2xvdy5uZXh0OwogICAgICAgICAgICBmYXN0ID0gZmFzdC5uZXh0Lm5leHQ7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgTGlzdE5vZGUgYW5zID0gaGVhZDsKICAgICAgICAgICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgICAgIGFucyA9IGFucy5uZXh0OwogICAgICAgICAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsIiwiYmxhbmtfMiI6InNsb3cgPT0gZmFzdCIsImJsYW5rXzMiOiJhbnMgIT0gc2xvdyIsImJsYW5rXzQiOiJhbnMiLCJibGFua181IjoibnVsbCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnjq/lhaXlj6MiLCLot6/nqIvlhbPns7siLCLlkIzpgJ/nm7jpgYciLCLlk4jluIzooagiLCLpk77ooagiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 142
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-27: #21 合并两个有序链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    21, 27, CONVERT(FROM_BASE64('5ZCI5bm25Lik5Liq5pyJ5bqP6ZO+6KGo') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('5bCG5Lik5Liq5Y2H5bqP6ZO+6KGo5ZCI5bm25Li65LiA5Liq5paw55qEKirljYfluo8qKumTvuihqOW5tui/lOWbnuOAguaWsOmTvuihqOaYr+mAmui/h+aLvOaOpee7meWumueahOS4pOS4qumTvuihqOeahOaJgOacieiKgueCuee7hOaIkOeahOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzEwLzAzL21lcmdlX2V4MS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmwxID0gWzEsMiw0XSwgbDIgPSBbMSwzLDRdCui+k+WHuu+8mlsxLDEsMiwzLDQsNF0KYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpsMSA9IFtdLCBsMiA9IFtdCui+k+WHuu+8mltdCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabDEgPSBbXSwgbDIgPSBbMF0K6L6T5Ye677yaWzBdCmBgYCoq5o+Q56S677yaKiotIOS4pOS4qumTvuihqOeahOiKgueCueaVsOebruiMg+WbtOaYryBgWzAsIDUwXWAKLSBgLTEwMCA8PSBOb2RlLnZhbCA8PSAxMDBgCi0gYGwxYCDlkowgYGwyYCDlnYfmjIkqKumdnumAkuWHj+mhuuW6jyoq5o6S5YiXCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbWVyZ2UtdHdvLXNvcnRlZC1saXN0cy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbWVyZ2UtdHdvLXNvcnRlZC1saXN0cy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('55So6Jma5ouf5aS057uT54K55om/5o6l57uT5p6c77yM5q+U6L6D5Lik6ZO+5b2T5YmN6IqC54K577yM5oqK6L6D5bCP6IqC54K55o6l5Yiw5bC+6YOo44CCIOacrOmimOWbtOe7leOAjOWQiOW5tuS4pOS4quacieW6j+mTvuihqOOAjeiQveWunui/meS4gOaooeWei++8mnRhaWwg5LmL5YmN5aeL57uI5piv5bey5ZCI5bm25LiU5pyJ5bqP55qE5YmN57yA77yM5Lik5Liq5b2T5YmN5oyH6ZKI5oyH5ZCR5ZCE6Ieq5pyq5aSE55CG5pyA5bCP5YC844CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6Jma5ouf5aS057uT54K555qE5ZCr5LmJ77yM5YaN5qOA5p+l5pyJ5bqP5ZCI5bm25aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('TGlzdE5vZGUgY3VyciA9IGR1bW15OwogICAgICAgIHdoaWxlIChsaXN0MSAhPSBudWxsICYmIGxpc3QyICE9IG51bGwpIHsKICAgICAgICAgICAgaWYgKGxpc3QxLnZhbCA8PSBsaXN0Mi52YWwpIHsKICAgICAgICAgICAgICAgIGN1cnIubmV4dCA9IGxpc3QxOwogICAgICAgICAgICAgICAgbGlzdDEgPSBsaXN0MS5uZXh0OwogICAgICAgICAgICB9IGVsc2Ugew==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIG1lcmdlVHdvTGlzdHMoTGlzdE5vZGUgbGlzdDEsIExpc3ROb2RlIGxpc3QyKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoKTsKICAgICAgICBMaXN0Tm9kZSBjdXJyID0gZHVtbXk7CiAgICAgICAgd2hpbGUgKGxpc3QxICE9IG51bGwgJiYgbGlzdDIgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAobGlzdDEudmFsIDw9IGxpc3QyLnZhbCkgewogICAgICAgICAgICAgICAgY3Vyci5uZXh0ID0gbGlzdDE7CiAgICAgICAgICAgICAgICBsaXN0MSA9IGxpc3QxLm5leHQ7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBjdXJyLm5leHQgPSBsaXN0MjsKICAgICAgICAgICAgICAgIGxpc3QyID0gbGlzdDIubmV4dDsKICAgICAgICAgICAgfQogICAgICAgICAgICBjdXJyID0gY3Vyci5uZXh0OwogICAgICAgIH0KICAgICAgICBjdXJyLm5leHQgPSBsaXN0MSA9PSBudWxsID8gbGlzdDIgOiBsaXN0MTsKICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 21
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 21
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('dGFpbCDkuYvliY3lp4vnu4jmmK/lt7LlkIjlubbkuJTmnInluo/nmoTliY3nvIDvvIzkuKTkuKrlvZPliY3mjIfpkojmjIflkJHlkIToh6rmnKrlpITnkIbmnIDlsI/lgLzjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1lcmdlVHdvTGlzdHMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b6q546v57uT5p2f5ZCO6KaB5LiA5qyh5oCn5o6l5LiK6Z2e56m65Ymp5L2Z6ZO+6KGo77yb5LiN6KaB5paw5bu65peg5oSP5LmJ6IqC54K55aSN5Yi25YC844CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obStuKe+8jOepuumXtCBPKDEp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b6q546v57uT5p2f5ZCO6KaB5LiA5qyh5oCn5o6l5LiK6Z2e56m65Ymp5L2Z6ZO+6KGo77yb5LiN6KaB5paw5bu65peg5oSP5LmJ6IqC54K55aSN5Yi25YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1lcmdlVHdvTGlzdHMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIG1lcmdlVHdvTGlzdHMoTGlzdE5vZGUgbGlzdDEsIExpc3ROb2RlIGxpc3QyKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoKTsKICAgICAgICBMaXN0Tm9kZSBjdXJyID0gZHVtbXk7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgY3Vyci5uZXh0ID0gbGlzdDE7CiAgICAgICAgICAgICAgICBsaXN0MSA9IGxpc3QxLm5leHQ7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBjdXJyLm5leHQgPSBsaXN0MjsKICAgICAgICAgICAgICAgIGxpc3QyID0gbGlzdDIubmV4dDsKICAgICAgICAgICAgfQogICAgICAgICAgICBjdXJyID0gY3Vyci5uZXh0OwogICAgICAgIH0KICAgICAgICBjdXJyLm5leHQgPSBsaXN0MSA9PSBudWxsID8gbGlzdDIgOiBsaXN0MTsKICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibGlzdDEgIT0gbnVsbCAmJiBsaXN0MiAhPSBudWxsIiwiYmxhbmtfMiI6Imxpc3QxLnZhbCA8PSBsaXN0Mi52YWwiLCJibGFua18zIjoiZHVtbXkubmV4dCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLomZrmi5/lpLTnu5PngrkiLCLmnInluo/lkIjlubYiLCLmjqXliankvZnpk74iLCLpgJLlvZIiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 21
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-28: #2 两数相加

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    2, 28, CONVERT(FROM_BASE64('5Lik5pWw55u45Yqg') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5Lik5LiqKirpnZ7nqboqKueahOmTvuihqO+8jOihqOekuuS4pOS4qumdnui0n+eahOaVtOaVsOOAguWug+S7rOavj+S9jeaVsOWtl+mDveaYr+aMieeFpyoq6YCG5bqPKirnmoTmlrnlvI/lrZjlgqjnmoTvvIzlubbkuJTmr4/kuKroioLngrnlj6rog73lrZjlgqgqKuS4gOS9jSoq5pWw5a2X44CCCgror7fkvaDlsIbkuKTkuKrmlbDnm7jliqDvvIzlubbku6Xnm7jlkIzlvaLlvI/ov5Tlm57kuIDkuKrooajnpLrlkoznmoTpk77ooajjgIIKCuS9oOWPr+S7peWBh+iuvumZpOS6huaVsOWtlyAwIOS5i+Wklu+8jOi/meS4pOS4quaVsOmDveS4jeS8muS7pSAwIOW8gOWktOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAyMS8wMS8wMi9hZGR0d29udW1iZXIxLmpwZykKCmBgYHRleHQK6L6T5YWl77yabDEgPSBbMiw0LDNdLCBsMiA9IFs1LDYsNF0K6L6T5Ye677yaWzcsMCw4XQrop6Pph4rvvJozNDIgKyA0NjUgPSA4MDcuCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabDEgPSBbMF0sIGwyID0gWzBdCui+k+WHuu+8mlswXQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mmwxID0gWzksOSw5LDksOSw5LDldLCBsMiA9IFs5LDksOSw5XQrovpPlh7rvvJpbOCw5LDksOSwwLDAsMCwxXQpgYGAqKuaPkOekuu+8mioqLSDmr4/kuKrpk77ooajkuK3nmoToioLngrnmlbDlnKjojIPlm7QgYFsxLCAxMDBdYCDlhoUKLSBgMCA8PSBOb2RlLnZhbCA8PSA5YAotIOmimOebruaVsOaNruS/neivgeWIl+ihqOihqOekuueahOaVsOWtl+S4jeWQq+WJjeWvvOmbtgoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2FkZC10d28tbnVtYmVycy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvYWRkLXR3by1udW1iZXJzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZCM5q2l6YGN5Y6G5Lik5p2h6YCG5bqP5pWw5a2X6ZO+77yM6YCQ5L2N55u45Yqg5bm25pC65bimIGNhcnJ577yM55So6Jma5ouf5aS05p6E5bu6562U5qGI44CCIOacrOmimOWbtOe7leOAjOS4pOaVsOebuOWKoOOAjeiQveWunui/meS4gOaooeWei++8muavj+i9rue7k+adn+WQjue7k+aenOmTvuW3suS/neWtmOS9juS9jeWSjO+8jGNhcnJ5IOaYr+S8oOe7meS4i+S4gOmrmOS9jeeahOi/m+S9jeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6YCQ5L2N55u45Yqg55qE5ZCr5LmJ77yM5YaN5qOA5p+l6L+b5L2N5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Y3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGwxID0gbDEgPT0gbnVsbCA/IG51bGwgOiBsMS5uZXh0OwogICAgICAgICAgICBsMiA9IGwyID09IG51bGwgPyBudWxsIDogbDIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIGFkZFR3b051bWJlcnMoTGlzdE5vZGUgbDEsIExpc3ROb2RlIGwyKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoMCk7CiAgICAgICAgaW50IGNhcnJ5ID0gMDsKICAgICAgICBMaXN0Tm9kZSBjdXIgPSBkdW1teTsKICAgICAgICB3aGlsZSAobDEgIT0gbnVsbCB8fCBsMiAhPSBudWxsIHx8IGNhcnJ5ICE9IDApIHsKICAgICAgICAgICAgaW50IHMgPSAobDEgPT0gbnVsbCA/IDAgOiBsMS52YWwpICsgKGwyID09IG51bGwgPyAwIDogbDIudmFsKSArIGNhcnJ5OwogICAgICAgICAgICBjYXJyeSA9IHMgLyAxMDsKICAgICAgICAgICAgY3VyLm5leHQgPSBuZXcgTGlzdE5vZGUocyAlIDEwKTsKICAgICAgICAgICAgY3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGwxID0gbDEgPT0gbnVsbCA/IG51bGwgOiBsMS5uZXh0OwogICAgICAgICAgICBsMiA9IGwyID09IG51bGwgPyBudWxsIDogbDIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 2
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 2
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 2
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u57uT5p2f5ZCO57uT5p6c6ZO+5bey5L+d5a2Y5L2O5L2N5ZKM77yMY2Fycnkg5piv5Lyg57uZ5LiL5LiA6auY5L2N55qE6L+b5L2N44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGFkZFR3b051bWJlcnMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b6q546v5p2h5Lu26KaB5YyF5ZCrIGNhcnJ577yM6ZW/5bqm5LiN5ZCM5aSE5oqK57y65aSx5L2N6KeG5Li6IDDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obWF4KG0sbikp77yM562U5qGI5aSW56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b6q546v5p2h5Lu26KaB5YyF5ZCrIGNhcnJ577yM6ZW/5bqm5LiN5ZCM5aSE5oqK57y65aSx5L2N6KeG5Li6IDDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGFkZFR3b051bWJlcnMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIGFkZFR3b051bWJlcnMoTGlzdE5vZGUgbDEsIExpc3ROb2RlIGwyKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoMCk7CiAgICAgICAgaW50IGNhcnJ5ID0gMDsKICAgICAgICBMaXN0Tm9kZSBjdXIgPSB7e2JsYW5rXzF9fTsKICAgICAgICB3aGlsZSAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgaW50IHMgPSAobDEgPT0gbnVsbCA/IDAgOiBsMS52YWwpICsgKGwyID09IG51bGwgPyAwIDogbDIudmFsKSArIGNhcnJ5OwogICAgICAgICAgICBjYXJyeSA9IHMgLyAxMDsKICAgICAgICAgICAgY3VyLm5leHQgPSBuZXcgTGlzdE5vZGUocyAlIDEwKTsKICAgICAgICAgICAgY3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGwxID0gbDEgPT0gbnVsbCA/IG51bGwgOiBsMS5uZXh0OwogICAgICAgICAgICBsMiA9IGwyID09IG51bGwgPyBudWxsIDogbDIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZHVtbXkiLCJibGFua18yIjoibDEgIT0gbnVsbCB8fCBsMiAhPSBudWxsIHx8IGNhcnJ5ICE9IDAiLCJibGFua18zIjoiZHVtbXkubmV4dCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpgJDkvY3nm7jliqAiLCLov5vkvY0iLCLomZrmi5/lpLQiLCLpgJLlvZIiLCLpk77ooagiLCLmlbDlraYiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 2
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-29: #19 删除链表的倒数第 N 个结点

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    19, 29, CONVERT(FROM_BASE64('5Yig6Zmk6ZO+6KGo55qE5YCS5pWw56ysIE4g5Liq57uT54K5') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6ZO+6KGo77yM5Yig6Zmk6ZO+6KGo55qE5YCS5pWw56ysIGBuYCoq5Liq57uT54K577yM5bm25LiU6L+U5Zue6ZO+6KGo55qE5aS057uT54K544CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTAvMDMvcmVtb3ZlX2V4MS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMSwyLDMsNCw1XSwgbiA9IDIK6L6T5Ye677yaWzEsMiwzLDVdCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFsxXSwgbiA9IDEK6L6T5Ye677yaW10KYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWzEsMl0sIG4gPSAxCui+k+WHuu+8mlsxXQpgYGAqKuaPkOekuu+8mioqLSDpk77ooajkuK3nu5PngrnnmoTmlbDnm67kuLogYHN6YAotIGAxIDw9IHN6IDw9IDMwYAotIGAwIDw9IE5vZGUudmFsIDw9IDEwMGAKLSBgMSA8PSBuIDw9IHN6YCoq6L+b6Zi277yaKirkvaDog73lsJ3or5Xkvb/nlKjkuIDotp/miavmj4/lrp7njrDlkJfvvJ8KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9yZW1vdmUtbnRoLW5vZGUtZnJvbS1lbmQtb2YtbGlzdC8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcmVtb3ZlLW50aC1ub2RlLWZyb20tZW5kLW9mLWxpc3QvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('6Jma5ouf5aS05ZCO6K6pIGZhc3Qg5YWI6LWwIG4g5q2l77yM5YaN6K6pIGZhc3TjgIFzbG93IOWQjOatpeWJjei/m++8jHNsb3cg5YGc5Zyo5b6F5Yig6IqC54K55YmN6amx44CCIOacrOmimOWbtOe7leOAjOWIoOmZpOmTvuihqOeahOWAkuaVsOesrCBOIOS4que7k+eCueOAjeiQveWunui/meS4gOaooeWei++8muWQjOatpemYtuautSBmYXN0IOS4jiBzbG93IOWni+e7iOebuOmalCBuIOS4quiKgueCueOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5YmN5ZCO5oyH6ZKI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Zu65a6a6Ze06Led5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('ZmFzdCA9IGZhc3QubmV4dDsKICAgICAgICB9CiAgICAgICAgd2hpbGUgKGZhc3QubmV4dCAhPSBudWxsKSB7CiAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgIGZhc3QgPSBmYXN0Lm5leHQ7CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJlbW92ZU50aEZyb21FbmQoTGlzdE5vZGUgaGVhZCwgaW50IG4pIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgwLCBoZWFkKTsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gZHVtbXksIHNsb3cgPSBkdW1teTsKICAgICAgICB3aGlsZSAobi0tID4gMCkgewogICAgICAgICAgICBmYXN0ID0gZmFzdC5uZXh0OwogICAgICAgIH0KICAgICAgICB3aGlsZSAoZmFzdC5uZXh0ICE9IG51bGwpIHsKICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dDsKICAgICAgICB9CiAgICAgICAgc2xvdy5uZXh0ID0gc2xvdy5uZXh0Lm5leHQ7CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 19
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 19
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5ZCM5q2l6Zi25q61IGZhc3Qg5LiOIHNsb3cg5aeL57uI55u46ZqUIG4g5Liq6IqC54K544CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJlbW92ZU50aEZyb21FbmQg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5L2/55So6Jma5ouf5aS05omN6IO957uf5LiA5Yig6Zmk5aS057uT54K577yb5YWI6LWwIG4g5q2l5pe25LuOIGR1bW15IOaIliBoZWFkIOWHuuWPkeimgeS4juaooeadv+S4gOiHtOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5L2/55So6Jma5ouf5aS05omN6IO957uf5LiA5Yig6Zmk5aS057uT54K577yb5YWI6LWwIG4g5q2l5pe25LuOIGR1bW15IOaIliBoZWFkIOWHuuWPkeimgeS4juaooeadv+S4gOiHtOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJlbW92ZU50aEZyb21FbmQg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJlbW92ZU50aEZyb21FbmQoTGlzdE5vZGUgaGVhZCwgaW50IG4pIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgwLCBoZWFkKTsKICAgICAgICBMaXN0Tm9kZSBmYXN0ID0gZHVtbXksIHNsb3cgPSBkdW1teTsKICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dDsKICAgICAgICB9CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgIGZhc3QgPSBmYXN0Lm5leHQ7CiAgICAgICAgfQogICAgICAgIHNsb3cubmV4dCA9IHNsb3cubmV4dC5uZXh0OwogICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibi0tID4gMCIsImJsYW5rXzIiOiJmYXN0Lm5leHQgIT0gbnVsbCIsImJsYW5rXzMiOiJkdW1teS5uZXh0In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLliY3lkI7mjIfpkogiLCLlm7rlrprpl7Tot50iLCLliKDpmaTliY3pqbEiLCLpk77ooagiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 19
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-30: #24 两两交换链表中的节点

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    24, 30, CONVERT(FROM_BASE64('5Lik5Lik5Lqk5o2i6ZO+6KGo5Lit55qE6IqC54K5') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6ZO+6KGo77yM5Lik5Lik5Lqk5o2i5YW25Lit55u46YK755qE6IqC54K577yM5bm26L+U5Zue5Lqk5o2i5ZCO6ZO+6KGo55qE5aS06IqC54K544CC5L2g5b+F6aG75Zyo5LiN5L+u5pS56IqC54K55YaF6YOo55qE5YC855qE5oOF5Ya15LiL5a6M5oiQ5pys6aKY77yI5Y2z77yM5Y+q6IO96L+b6KGM6IqC54K55Lqk5o2i77yJ44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTAvMDMvc3dhcF9leDEuanBnKQoKYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWzEsMiwzLDRdCui+k+WHuu+8mlsyLDEsNCwzXQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbXQrovpPlh7rvvJpbXQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMV0K6L6T5Ye677yaWzFdCmBgYCoq5o+Q56S677yaKiotIOmTvuihqOS4reiKgueCueeahOaVsOebruWcqOiMg+WbtCBgWzAsIDEwMF1gIOWGhQotIGAwIDw9IE5vZGUudmFsIDw9IDEwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9zd2FwLW5vZGVzLWluLXBhaXJzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9zd2FwLW5vZGVzLWluLXBhaXJzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5Lul6Jma5ouf5aS05Li65YmN6amx77yM5q+P5qyh5oqK55u46YK755qEIGZpcnN044CBc2Vjb25kIOmHjei/nuS4uiBzZWNvbmTihpJmaXJzdO+8jOWGjeaOqOi/m+WIsOS4i+S4gOe7hOOAgiDmnKzpopjlm7Tnu5XjgIzkuKTkuKTkuqTmjaLpk77ooajkuK3nmoToioLngrnjgI3okL3lrp7ov5nkuIDmqKHlnovvvJpwcmV2IOWQjuaWueeahOiKgueCueWvueW3sue7j+S6pOaNouWujOaIkO+8jHByZXYg5oyH5ZCR5LiL5LiA57uE5LmL5YmN55qE5bC+6IqC54K544CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5oiQ5a+56YeN6L+e55qE5ZCr5LmJ77yM5YaN5qOA5p+l57uE5YmN6amx5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJlLm5leHQgPSB0OwogICAgICAgICAgICBwcmUgPSBjdXI7CiAgICAgICAgICAgIGN1ciA9IGN1ci5uZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHN3YXBQYWlycyhMaXN0Tm9kZSBoZWFkKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoMCwgaGVhZCk7CiAgICAgICAgTGlzdE5vZGUgcHJlID0gZHVtbXk7CiAgICAgICAgTGlzdE5vZGUgY3VyID0gaGVhZDsKICAgICAgICB3aGlsZSAoY3VyICE9IG51bGwgJiYgY3VyLm5leHQgIT0gbnVsbCkgewogICAgICAgICAgICBMaXN0Tm9kZSB0ID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGN1ci5uZXh0ID0gdC5uZXh0OwogICAgICAgICAgICB0Lm5leHQgPSBjdXI7CiAgICAgICAgICAgIHByZS5uZXh0ID0gdDsKICAgICAgICAgICAgcHJlID0gY3VyOwogICAgICAgICAgICBjdXIgPSBjdXIubmV4dDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 24
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 24
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('cHJldiDlkI7mlrnnmoToioLngrnlr7nlt7Lnu4/kuqTmjaLlrozmiJDvvIxwcmV2IOaMh+WQkeS4i+S4gOe7hOS5i+WJjeeahOWwvuiKgueCueOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHN3YXBQYWlycyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75YWI5L+d5a2YIHNlY29uZC5uZXh077yb5Ymp5L2Z5LiN6Laz5Lik5Liq6IqC54K55pe255u05o6l57uT5p2f44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5L+d5a2YIHNlY29uZC5uZXh077yb5Ymp5L2Z5LiN6Laz5Lik5Liq6IqC54K55pe255u05o6l57uT5p2f44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHN3YXBQYWlycyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHN3YXBQYWlycyhMaXN0Tm9kZSBoZWFkKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoMCwge3tibGFua18xfX0pOwogICAgICAgIExpc3ROb2RlIHByZSA9IGR1bW15OwogICAgICAgIExpc3ROb2RlIGN1ciA9IGhlYWQ7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIExpc3ROb2RlIHQgPSBjdXIubmV4dDsKICAgICAgICAgICAgY3VyLm5leHQgPSB0Lm5leHQ7CiAgICAgICAgICAgIHQubmV4dCA9IGN1cjsKICAgICAgICAgICAgcHJlLm5leHQgPSB0OwogICAgICAgICAgICBwcmUgPSBjdXI7CiAgICAgICAgICAgIGN1ciA9IGN1ci5uZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaGVhZCIsImJsYW5rXzIiOiJjdXIgIT0gbnVsbCAmJiBjdXIubmV4dCAhPSBudWxsIiwiYmxhbmtfMyI6ImR1bW15Lm5leHQifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmiJDlr7nph43ov54iLCLnu4TliY3pqbEiLCLkv53lrZjlkI7nu6ciLCLpgJLlvZIiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 24
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-31: #25 K 个一组翻转链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    25, 31, CONVERT(FROM_BASE64('SyDkuKrkuIDnu4Tnv7vovazpk77ooag=') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5L2g6ZO+6KGo55qE5aS06IqC54K5IGBoZWFkYCDvvIzmr48gYGtgKirkuKroioLngrnkuIDnu4Tov5vooYznv7vovazvvIzor7fkvaDov5Tlm57kv67mlLnlkI7nmoTpk77ooajjgIIKCmBrYCDmmK/kuIDkuKrmraPmlbTmlbDvvIzlroPnmoTlgLzlsI/kuo7miJbnrYnkuo7pk77ooajnmoTplb/luqbjgILlpoLmnpzoioLngrnmgLvmlbDkuI3mmK8gYGtgKirnmoTmlbTmlbDlgI3vvIzpgqPkuYjor7flsIbmnIDlkI7liankvZnnmoToioLngrnkv53mjIHljp/mnInpobrluo/jgIIKCuS9oOS4jeiDveWPquaYr+WNlee6r+eahOaUueWPmOiKgueCueWGhemDqOeahOWAvO+8jOiAjOaYr+mcgOimgeWunumZhei/m+ihjOiKgueCueS6pOaNouOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzEwLzAzL3JldmVyc2VfZXgxLmpwZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFsxLDIsMyw0LDVdLCBrID0gMgrovpPlh7rvvJpbMiwxLDQsMyw1XQpgYGAqKuekuuS+iyAy77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8xMC8wMy9yZXZlcnNlX2V4Mi5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbMSwyLDMsNCw1XSwgayA9IDMK6L6T5Ye677yaWzMsMiwxLDQsNV0KYGBgKirmj5DnpLrvvJoqKi0g6ZO+6KGo5Lit55qE6IqC54K55pWw55uu5Li6IGBuYAotIGAxIDw9IGsgPD0gbiA8PSA1MDAwYAotIGAwIDw9IE5vZGUudmFsIDw9IDEwMDBgKirov5vpmLbvvJoqKuS9oOWPr+S7peiuvuiuoeS4gOS4quWPqueUqCBgTygxKWAg6aKd5aSW5YaF5a2Y56m66Ze055qE566X5rOV6Kej5Yaz5q2k6Zeu6aKY5ZCX77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvcmV2ZXJzZS1ub2Rlcy1pbi1rLWdyb3VwLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9yZXZlcnNlLW5vZGVzLWluLWstZ3JvdXAvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5a6a5L2N5q+P57uE56ysIGsg5Liq6IqC54K577yM6K6w5b2V5LiL5LiA57uE5YWl5Y+j77yM5YaN5Y6f5Zyw5Y+N6L2s5b2T5YmN6Zet5Yy66Ze05bm25o6l5Zue5YmN5ZCO6ZO+5q6144CCIOacrOmimOWbtOe7leOAjEsg5Liq5LiA57uE57+76L2s6ZO+6KGo44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5q+P6L2u57uT5p2f5ZCO5b2T5YmNIGsg5Liq6IqC54K55YWo6YOo5Y+N6L2s5LiU5pW05p2h6ZO+5LuN6L+e6YCa77yMZ3JvdXBQcmV2IOaMh+WQkeivpee7hOaWsOWwvuOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFa+e7hOi+ueeVjOeahOWQq+S5ie+8jOWGjeajgOafpeWMuumXtOWPjei9rOWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('Y3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgICAgICBpZiAoY3VyID09IG51bGwpIHsKICAgICAgICAgICAgICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICBMaXN0Tm9kZSBub2RlID0gcHJlLm5leHQ7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJldmVyc2VLR3JvdXAoTGlzdE5vZGUgaGVhZCwgaW50IGspIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgwLCBoZWFkKTsKICAgICAgICBkdW1teS5uZXh0ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBwcmUgPSBkdW1teTsKICAgICAgICB3aGlsZSAocHJlICE9IG51bGwpIHsKICAgICAgICAgICAgTGlzdE5vZGUgY3VyID0gcHJlOwogICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IGs7IGkrKykgewogICAgICAgICAgICAgICAgY3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgICAgICBpZiAoY3VyID09IG51bGwpIHsKICAgICAgICAgICAgICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICBMaXN0Tm9kZSBub2RlID0gcHJlLm5leHQ7CiAgICAgICAgICAgIExpc3ROb2RlIG54dCA9IGN1ci5uZXh0OwogICAgICAgICAgICBjdXIubmV4dCA9IG51bGw7CiAgICAgICAgICAgIHByZS5uZXh0ID0gcmV2ZXJzZShub2RlKTsKICAgICAgICAgICAgbm9kZS5uZXh0ID0gbnh0OwogICAgICAgICAgICBwcmUgPSBub2RlOwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KCiAgICBwcml2YXRlIExpc3ROb2RlIHJldmVyc2UoTGlzdE5vZGUgaGVhZCkgewogICAgICAgIExpc3ROb2RlIGR1bW15ID0gbmV3IExpc3ROb2RlKCk7CiAgICAgICAgTGlzdE5vZGUgY3VyID0gaGVhZDsKICAgICAgICB3aGlsZSAoY3VyICE9IG51bGwpIHsKICAgICAgICAgICAgTGlzdE5vZGUgbnh0ID0gY3VyLm5leHQ7CiAgICAgICAgICAgIGN1ci5uZXh0ID0gZHVtbXkubmV4dDsKICAgICAgICAgICAgZHVtbXkubmV4dCA9IGN1cjsKICAgICAgICAgICAgY3VyID0gbnh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 25
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 25
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u57uT5p2f5ZCO5b2T5YmNIGsg5Liq6IqC54K55YWo6YOo5Y+N6L2s5LiU5pW05p2h6ZO+5LuN6L+e6YCa77yMZ3JvdXBQcmV2IOaMh+WQkeivpee7hOaWsOWwvuOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJldmVyc2VLR3JvdXAg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LiN6LazIGsg5Liq6IqC54K55LiN6IO95Y+N6L2s77yb5Y+N6L2s5b6q546v55qE57uI54K55bqU5pivIGdyb3VwTmV4dCDogIzkuI3mmK8gbnVsbOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6LazIGsg5Liq6IqC54K55LiN6IO95Y+N6L2s77yb5Y+N6L2s5b6q546v55qE57uI54K55bqU5pivIGdyb3VwTmV4dCDogIzkuI3mmK8gbnVsbOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJldmVyc2VLR3JvdXAg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHJldmVyc2VLR3JvdXAoTGlzdE5vZGUgaGVhZCwgaW50IGspIHsKICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgwLCBoZWFkKTsKICAgICAgICBkdW1teS5uZXh0ID0gaGVhZDsKICAgICAgICBMaXN0Tm9kZSBwcmUgPSBkdW1teTsKICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgTGlzdE5vZGUgY3VyID0gcHJlOwogICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IGs7IGkrKykgewogICAgICAgICAgICAgICAgY3VyID0gY3VyLm5leHQ7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgTGlzdE5vZGUgbm9kZSA9IHByZS5uZXh0OwogICAgICAgICAgICBMaXN0Tm9kZSBueHQgPSBjdXIubmV4dDsKICAgICAgICAgICAgY3VyLm5leHQgPSBudWxsOwogICAgICAgICAgICBwcmUubmV4dCA9IHt7YmxhbmtfNH19OwogICAgICAgICAgICBub2RlLm5leHQgPSBueHQ7CiAgICAgICAgICAgIHByZSA9IG5vZGU7CiAgICAgICAgfQogICAgICAgIHJldHVybiBkdW1teS5uZXh0OwogICAgfQoKICAgIHByaXZhdGUgTGlzdE5vZGUgcmV2ZXJzZShMaXN0Tm9kZSBoZWFkKSB7CiAgICAgICAgTGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoKTsKICAgICAgICBMaXN0Tm9kZSBjdXIgPSBoZWFkOwogICAgICAgIHdoaWxlICh7e2JsYW5rXzV9fSkgewogICAgICAgICAgICBMaXN0Tm9kZSBueHQgPSBjdXIubmV4dDsKICAgICAgICAgICAgY3VyLm5leHQgPSBkdW1teS5uZXh0OwogICAgICAgICAgICBkdW1teS5uZXh0ID0gY3VyOwogICAgICAgICAgICBjdXIgPSBueHQ7CiAgICAgICAgfQogICAgICAgIHJldHVybiBkdW1teS5uZXh0OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicHJlICE9IG51bGwiLCJibGFua18yIjoiY3VyID09IG51bGwiLCJibGFua18zIjoiZHVtbXkubmV4dCIsImJsYW5rXzQiOiJyZXZlcnNlKG5vZGUpIiwiYmxhbmtfNSI6ImN1ciAhPSBudWxsIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJr57uE6L6555WMIiwi5Yy66Ze05Y+N6L2sIiwi5o6l5Zue6ZO+6KGoIiwi6YCS5b2SIiwi6ZO+6KGoIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 25
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-32: #138 随机链表的复制

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    138, 32, CONVERT(FROM_BASE64('6ZqP5py66ZO+6KGo55qE5aSN5Yi2') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6ZW/5bqm5Li6IGBuYCDnmoTpk77ooajvvIzmr4/kuKroioLngrnljIXlkKvkuIDkuKrpop3lpJblop7liqDnmoTpmo/mnLrmjIfpkoggYHJhbmRvbWAg77yM6K+l5oyH6ZKI5Y+v5Lul5oyH5ZCR6ZO+6KGo5Lit55qE5Lu75L2V6IqC54K55oiW56m66IqC54K544CCCgrmnoTpgKDov5nkuKrpk77ooajnmoQqKlvmt7Hmi7fotJ1dKGh0dHBzOi8vYmFpa2UuYmFpZHUuY29tL2l0ZW0v5rex5ou36LSdLzIyNzg1MzE3P2ZyPWFsYWRkaW4pKirjgIIg5rex5ou36LSd5bqU6K+l5q2j5aW955SxIGBuYCDkuKoqKuWFqOaWsCoq6IqC54K557uE5oiQ77yM5YW25Lit5q+P5Liq5paw6IqC54K555qE5YC86YO96K6+5Li65YW25a+55bqU55qE5Y6f6IqC54K555qE5YC844CC5paw6IqC54K555qEIGBuZXh0YCDmjIfpkojlkowgYHJhbmRvbWAg5oyH6ZKI5Lmf6YO95bqU5oyH5ZCR5aSN5Yi26ZO+6KGo5Lit55qE5paw6IqC54K577yM5bm25L2/5Y6f6ZO+6KGo5ZKM5aSN5Yi26ZO+6KGo5Lit55qE6L+Z5Lqb5oyH6ZKI6IO95aSf6KGo56S655u45ZCM55qE6ZO+6KGo54q25oCB44CCKirlpI3liLbpk77ooajkuK3nmoTmjIfpkojpg73kuI3lupTmjIflkJHljp/pk77ooajkuK3nmoToioLngrkqKuOAggoK5L6L5aaC77yM5aaC5p6c5Y6f6ZO+6KGo5Lit5pyJIGBYYCDlkowgYFlgIOS4pOS4quiKgueCue+8jOWFtuS4rSBgWC5yYW5kb20gLS0+IFlgIOOAgumCo+S5iOWcqOWkjeWItumTvuihqOS4reWvueW6lOeahOS4pOS4quiKgueCuSBgeGAg5ZKMIGB5YCDvvIzlkIzmoLfmnIkgYHgucmFuZG9tIC0tPiB5YCDjgIIKCui/lOWbnuWkjeWItumTvuihqOeahOWktOiKgueCueOAggoK55So5LiA5Liq55SxIGBuYCDkuKroioLngrnnu4TmiJDnmoTpk77ooajmnaXooajnpLrovpPlhaUv6L6T5Ye65Lit55qE6ZO+6KGo44CC5q+P5Liq6IqC54K555So5LiA5LiqIGBbdmFsLCByYW5kb21faW5kZXhdYCDooajnpLrvvJoKCi0gYHZhbGDvvJrkuIDkuKrooajnpLogYE5vZGUudmFsYCDnmoTmlbTmlbDjgIIKLSBgcmFuZG9tX2luZGV4YO+8mumaj+acuuaMh+mSiOaMh+WQkeeahOiKgueCuee0ouW8le+8iOiMg+WbtOS7jiBgMGAg5YiwIGBuLTFg77yJ77yb5aaC5p6c5LiN5oyH5ZCR5Lu75L2V6IqC54K577yM5YiZ5Li6IGBudWxsYCDjgIIKCuS9oOeahOS7o+eggSoq5Y+qKirmjqXlj5fljp/pk77ooajnmoTlpLToioLngrkgYGhlYWRgIOS9nOS4uuS8oOWFpeWPguaVsOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAyMC8wMS8wOS9lMS5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbWzcsbnVsbF0sWzEzLDBdLFsxMSw0XSxbMTAsMl0sWzEsMF1dCui+k+WHuu+8mltbNyxudWxsXSxbMTMsMF0sWzExLDRdLFsxMCwyXSxbMSwwXV0KYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNuL2FsaXl1bi1sYy11cGxvYWQvdXBsb2Fkcy8yMDIwLzAxLzA5L2UyLnBuZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFtbMSwxXSxbMiwxXV0K6L6T5Ye677yaW1sxLDFdLFsyLDFdXQpgYGAqKuekuuS+iyAz77yaKioqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAyMC8wMS8wOS9lMy5wbmcpKipgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbWzMsbnVsbF0sWzMsMF0sWzMsbnVsbF1dCui+k+WHuu+8mltbMyxudWxsXSxbMywwXSxbMyxudWxsXV0KYGBgKirmj5DnpLrvvJoqKi0gYDAgPD0gbiA8PSAxMDAwYAotIGAtMTA0IDw9IE5vZGUudmFsIDw9IDEwNGAKLSBgTm9kZS5yYW5kb21gIOS4uiBgbnVsbGAg5oiW5oyH5ZCR6ZO+6KGo5Lit55qE6IqC54K544CCCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvY29weS1saXN0LXdpdGgtcmFuZG9tLXBvaW50ZXIvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2NvcHktbGlzdC13aXRoLXJhbmRvbS1wb2ludGVyLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5Y6f6IqC54K55Yiw5YWL6ZqG6IqC54K555qE5ZOI5biM5pig5bCE77yM56ys5LiA6YGN5bu65Ymv5pys77yM56ys5LqM6YGN6L+e5o6lIG5leHQg5ZKMIHJhbmRvbeOAgiDmnKzpopjlm7Tnu5XjgIzpmo/mnLrpk77ooajnmoTlpI3liLbjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrnrKzkuozpgY3lpITnkIboioLngrkgeCDml7bvvIxtYXAg5bey5YyF5ZCr5omA5pyJ5Y6f6IqC54K55a+55bqU55qE5YWL6ZqG6IqC54K544CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6IqC54K55pig5bCE55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Lik6YGN5aSN5Yi25aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('ZC5wdXQoY3VyLCBub2RlKTsKICAgICAgICB9CiAgICAgICAgZm9yIChOb2RlIGN1ciA9IGhlYWQ7IGN1ciAhPSBudWxsOyBjdXIgPSBjdXIubmV4dCkgewogICAgICAgICAgICBkLmdldChjdXIpLnJhbmRvbSA9IGN1ci5yYW5kb20gPT0gbnVsbCA/IG51bGwgOiBkLmdldChjdXIucmFuZG9tKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIE5vZGUgY29weVJhbmRvbUxpc3QoTm9kZSBoZWFkKSB7CiAgICAgICAgTWFwPE5vZGUsIE5vZGU+IGQgPSBuZXcgSGFzaE1hcDw+KCk7CiAgICAgICAgTm9kZSBkdW1teSA9IG5ldyBOb2RlKDApOwogICAgICAgIE5vZGUgdGFpbCA9IGR1bW15OwogICAgICAgIGZvciAoTm9kZSBjdXIgPSBoZWFkOyBjdXIgIT0gbnVsbDsgY3VyID0gY3VyLm5leHQpIHsKICAgICAgICAgICAgTm9kZSBub2RlID0gbmV3IE5vZGUoY3VyLnZhbCk7CiAgICAgICAgICAgIHRhaWwubmV4dCA9IG5vZGU7CiAgICAgICAgICAgIHRhaWwgPSBub2RlOwogICAgICAgICAgICBkLnB1dChjdXIsIG5vZGUpOwogICAgICAgIH0KICAgICAgICBmb3IgKE5vZGUgY3VyID0gaGVhZDsgY3VyICE9IG51bGw7IGN1ciA9IGN1ci5uZXh0KSB7CiAgICAgICAgICAgIGQuZ2V0KGN1cikucmFuZG9tID0gY3VyLnJhbmRvbSA9PSBudWxsID8gbnVsbCA6IGQuZ2V0KGN1ci5yYW5kb20pOwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 138
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 138
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('56ys5LqM6YGN5aSE55CG6IqC54K5IHgg5pe277yMbWFwIOW3suWMheWQq+aJgOacieWOn+iKgueCueWvueW6lOeahOWFi+mahuiKgueCueOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNvcHlSYW5kb21MaXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('cmFuZG9tIOWPr+iDveS4uiBudWxs77yb5pig5bCE6ZSu5b+F6aG75piv6IqC54K55byV55So77yM5LiN6IO955So5Y+v6IO96YeN5aSN55qEIHZhbOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('cmFuZG9tIOWPr+iDveS4uiBudWxs77yb5pig5bCE6ZSu5b+F6aG75piv6IqC54K55byV55So77yM5LiN6IO955So5Y+v6IO96YeN5aSN55qEIHZhbOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNvcHlSYW5kb21MaXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIE5vZGUgY29weVJhbmRvbUxpc3QoTm9kZSBoZWFkKSB7CiAgICAgICAgTWFwPE5vZGUsIE5vZGU+IGQgPSBuZXcgSGFzaE1hcDw+KCk7CiAgICAgICAgTm9kZSBkdW1teSA9IG5ldyBOb2RlKDApOwogICAgICAgIE5vZGUgdGFpbCA9IHt7YmxhbmtfMX19OwogICAgICAgIGZvciAoTm9kZSBjdXIgPSB7e2JsYW5rXzJ9fTsgY3VyICE9IG51bGw7IGN1ciA9IGN1ci5uZXh0KSB7CiAgICAgICAgICAgIE5vZGUgbm9kZSA9IG5ldyBOb2RlKGN1ci52YWwpOwogICAgICAgICAgICB0YWlsLm5leHQgPSBub2RlOwogICAgICAgICAgICB0YWlsID0gbm9kZTsKICAgICAgICAgICAgZC5wdXQoY3VyLCBub2RlKTsKICAgICAgICB9CiAgICAgICAgZm9yIChOb2RlIGN1ciA9IGhlYWQ7IGN1ciAhPSBudWxsOyBjdXIgPSBjdXIubmV4dCkgewogICAgICAgICAgICBkLmdldChjdXIpLnJhbmRvbSA9IGN1ci5yYW5kb20gPT0gbnVsbCA/IG51bGwgOiBkLmdldChjdXIucmFuZG9tKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZHVtbXkiLCJibGFua18yIjoiaGVhZCIsImJsYW5rXzMiOiJkdW1teS5uZXh0In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLoioLngrnmmKDlsIQiLCLkuKTpgY3lpI3liLYiLCJyYW5kb20iLCLlk4jluIzooagiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 138
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-33: #148 排序链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    148, 33, CONVERT(FROM_BASE64('5o6S5bqP6ZO+6KGo') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g6ZO+6KGo55qE5aS057uT54K5IGBoZWFkYCDvvIzor7flsIblhbbmjIkqKuWNh+W6jyoq5o6S5YiX5bm26L+U5ZueKirmjpLluo/lkI7nmoTpk77ooagqKuOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzA5LzE0L3NvcnRfbGlzdF8xLmpwZykKCmBgYHRleHQK6L6T5YWl77yaaGVhZCA9IFs0LDIsMSwzXQrovpPlh7rvvJpbMSwyLDMsNF0KYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMDkvMTQvc29ydF9saXN0XzIuanBnKQoKYGBgdGV4dArovpPlhaXvvJpoZWFkID0gWy0xLDUsMyw0LDBdCui+k+WHuu+8mlstMSwwLDMsNCw1XQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mmhlYWQgPSBbXQrovpPlh7rvvJpbXQpgYGAqKuaPkOekuu+8mioqLSDpk77ooajkuK3oioLngrnnmoTmlbDnm67lnKjojIPlm7QgYFswLCA1ICogMTA0XWAg5YaFCi0gYC0xMDUgPD0gTm9kZS52YWwgPD0gMTA1YCoq6L+b6Zi277yaKirkvaDlj6/ku6XlnKggYE8obiBsb2cgbilgIOaXtumXtOWkjeadguW6puWSjOW4uOaVsOe6p+epuumXtOWkjeadguW6puS4i++8jOWvuemTvuihqOi/m+ihjOaOkuW6j+WQl++8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3NvcnQtbGlzdC8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc29ydC1saXN0Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5b2S5bm25o6S5bqP77ya5b+r5oWi5oyH6ZKI5LqM5YiG6ZO+6KGo77yM6YCS5b2S5o6S5aW95Lik5Y2K77yM5YaN57q/5oCn5ZCI5bm244CCIOacrOmimOWbtOe7leOAjOaOkuW6j+mTvuihqOOAjeiQveWunui/meS4gOaooeWei++8mm1lcmdlIOi+k+WFpeeahOS4pOadoemTvuWQhOiHquacieW6j++8jHRhaWwg5YmN57yA5aeL57uI5piv5Lik6ICF5b2T5YmN5pyA5bCP6IqC54K557uE5oiQ55qE5pyJ5bqP5bqP5YiX44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5b2S5bm25o6S5bqP55qE5ZCr5LmJ77yM5YaN5qOA5p+l5pat6ZO+5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('TGlzdE5vZGUgZHVtbXkgPSBuZXcgTGlzdE5vZGUoKTsKICAgICAgICBMaXN0Tm9kZSB0YWlsID0gZHVtbXk7CiAgICAgICAgd2hpbGUgKGwxICE9IG51bGwgJiYgbDIgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAobDEudmFsIDw9IGwyLnZhbCkgewogICAgICAgICAgICAgICAgdGFpbC5uZXh0ID0gbDE7CiAgICAgICAgICAgICAgICBsMSA9IGwxLm5leHQ7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHNvcnRMaXN0KExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBpZiAoaGVhZCA9PSBudWxsIHx8IGhlYWQubmV4dCA9PSBudWxsKSB7CiAgICAgICAgICAgIHJldHVybiBoZWFkOwogICAgICAgIH0KICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZCwgZmFzdCA9IGhlYWQubmV4dDsKICAgICAgICB3aGlsZSAoZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsKSB7CiAgICAgICAgICAgIHNsb3cgPSBzbG93Lm5leHQ7CiAgICAgICAgICAgIGZhc3QgPSBmYXN0Lm5leHQubmV4dDsKICAgICAgICB9CiAgICAgICAgTGlzdE5vZGUgbDEgPSBoZWFkLCBsMiA9IHNsb3cubmV4dDsKICAgICAgICBzbG93Lm5leHQgPSBudWxsOwogICAgICAgIGwxID0gc29ydExpc3QobDEpOwogICAgICAgIGwyID0gc29ydExpc3QobDIpOwogICAgICAgIExpc3ROb2RlIGR1bW15ID0gbmV3IExpc3ROb2RlKCk7CiAgICAgICAgTGlzdE5vZGUgdGFpbCA9IGR1bW15OwogICAgICAgIHdoaWxlIChsMSAhPSBudWxsICYmIGwyICE9IG51bGwpIHsKICAgICAgICAgICAgaWYgKGwxLnZhbCA8PSBsMi52YWwpIHsKICAgICAgICAgICAgICAgIHRhaWwubmV4dCA9IGwxOwogICAgICAgICAgICAgICAgbDEgPSBsMS5uZXh0OwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgdGFpbC5uZXh0ID0gbDI7CiAgICAgICAgICAgICAgICBsMiA9IGwyLm5leHQ7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgdGFpbCA9IHRhaWwubmV4dDsKICAgICAgICB9CiAgICAgICAgdGFpbC5uZXh0ID0gbDEgIT0gbnVsbCA/IGwxIDogbDI7CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5b2S5bm25o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5b2S5bm25o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('bWVyZ2Ug6L6T5YWl55qE5Lik5p2h6ZO+5ZCE6Ieq5pyJ5bqP77yMdGFpbCDliY3nvIDlp4vnu4jmmK/kuKTogIXlvZPliY3mnIDlsI/oioLngrnnu4TmiJDnmoTmnInluo/luo/liJfjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNvcnRMaXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5om+5Lit54K55pe26KaB5L+d55WZ5YmN5Y2K5bC+5bm25pat6ZO+77yM5ZCm5YiZ6YCS5b2S5LiN5Lya57yp5bCP77yb5ZCI5bm25ZCO5o6l5Ymp5L2Z6IqC54K544CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obiBsb2cgbinvvIzpgJLlvZLmoIggTyhsb2cgbinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5om+5Lit54K55pe26KaB5L+d55WZ5YmN5Y2K5bC+5bm25pat6ZO+77yM5ZCm5YiZ6YCS5b2S5LiN5Lya57yp5bCP77yb5ZCI5bm25ZCO5o6l5Ymp5L2Z6IqC54K544CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNvcnRMaXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIHNvcnRMaXN0KExpc3ROb2RlIGhlYWQpIHsKICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICBMaXN0Tm9kZSBzbG93ID0gaGVhZCwgZmFzdCA9IGhlYWQubmV4dDsKICAgICAgICB3aGlsZSAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgc2xvdyA9IHNsb3cubmV4dDsKICAgICAgICAgICAgZmFzdCA9IGZhc3QubmV4dC5uZXh0OwogICAgICAgIH0KICAgICAgICBMaXN0Tm9kZSBsMSA9IGhlYWQsIGwyID0gc2xvdy5uZXh0OwogICAgICAgIHNsb3cubmV4dCA9IG51bGw7CiAgICAgICAgbDEgPSB7e2JsYW5rXzR9fTsKICAgICAgICBsMiA9IHt7YmxhbmtfNX19OwogICAgICAgIExpc3ROb2RlIGR1bW15ID0gbmV3IExpc3ROb2RlKCk7CiAgICAgICAgTGlzdE5vZGUgdGFpbCA9IGR1bW15OwogICAgICAgIHdoaWxlIChsMSAhPSBudWxsICYmIGwyICE9IG51bGwpIHsKICAgICAgICAgICAgaWYgKGwxLnZhbCA8PSBsMi52YWwpIHsKICAgICAgICAgICAgICAgIHRhaWwubmV4dCA9IGwxOwogICAgICAgICAgICAgICAgbDEgPSBsMS5uZXh0OwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgdGFpbC5uZXh0ID0gbDI7CiAgICAgICAgICAgICAgICBsMiA9IGwyLm5leHQ7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgdGFpbCA9IHRhaWwubmV4dDsKICAgICAgICB9CiAgICAgICAgdGFpbC5uZXh0ID0gbDEgIT0gbnVsbCA/IGwxIDogbDI7CiAgICAgICAgcmV0dXJuIGR1bW15Lm5leHQ7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaGVhZCA9PSBudWxsIHx8IGhlYWQubmV4dCA9PSBudWxsIiwiYmxhbmtfMiI6ImhlYWQiLCJibGFua18zIjoiZmFzdCAhPSBudWxsICYmIGZhc3QubmV4dCAhPSBudWxsIiwiYmxhbmtfNCI6InNvcnRMaXN0KGwxKSIsImJsYW5rXzUiOiJzb3J0TGlzdChsMikifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlvZLlubbmjpLluo8iLCLmlq3pk74iLCLmnInluo/lkIjlubYiLCLpk77ooagiLCLlj4zmjIfpkogiLCLliIbmsrsiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 148
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-34: #23 合并 K 个升序链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    23, 34, CONVERT(FROM_BASE64('5ZCI5bm2IEsg5Liq5Y2H5bqP6ZO+6KGo') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6ZO+6KGo5pWw57uE77yM5q+P5Liq6ZO+6KGo6YO95bey57uP5oyJ5Y2H5bqP5o6S5YiX44CCCgror7fkvaDlsIbmiYDmnInpk77ooajlkIjlubbliLDkuIDkuKrljYfluo/pk77ooajkuK3vvIzov5Tlm57lkIjlubblkI7nmoTpk77ooajjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mmxpc3RzID0gW1sxLDQsNV0sWzEsMyw0XSxbMiw2XV0K6L6T5Ye677yaWzEsMSwyLDMsNCw0LDUsNl0K6Kej6YeK77ya6ZO+6KGo5pWw57uE5aaC5LiL77yaClsKMS0+NC0+NSwKMS0+My0+NCwKMi0+NgpdCuWwhuWug+S7rOWQiOW5tuWIsOS4gOS4quacieW6j+mTvuihqOS4reW+l+WIsOOAggoxLT4xLT4yLT4zLT40LT40LT41LT42CmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabGlzdHMgPSBbXQrovpPlh7rvvJpbXQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mmxpc3RzID0gW1tdXQrovpPlh7rvvJpbXQpgYGAqKuaPkOekuu+8mioqLSBgayA9PSBsaXN0cy5sZW5ndGhgCi0gYDAgPD0gayA8PSAxMF40YAotIGAwIDw9IGxpc3RzW2ldLmxlbmd0aCA8PSA1MDBgCi0gYC0xMF40IDw9IGxpc3RzW2ldW2pdIDw9IDEwXjRgCi0gYGxpc3RzW2ldYCDmjIkqKuWNh+W6jyoq5o6S5YiXCi0gYGxpc3RzW2ldLmxlbmd0aGAg55qE5oC75ZKM5LiN6LaF6L+HIGAxMF40YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL21lcmdlLWstc29ydGVkLWxpc3RzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9tZXJnZS1rLXNvcnRlZC1saXN0cy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqK5q+P5p2h6Z2e56m66ZO+6KGo5aS05pS+5YWl5bCP5qC55aCG77yM5q+P5qyh5Y+W5pyA5bCP6IqC54K55o6l5Yiw562U5qGI77yM5bm25oqK5YW25ZCO57un5YWl5aCG44CCIOacrOmimOWbtOe7leOAjOWQiOW5tiBLIOS4quWNh+W6j+mTvuihqOOAjeiQveWunui/meS4gOaooeWei++8muWghuS4reWni+e7iOS/neWtmOavj+adoeWwmuacquiAl+WwvemTvuihqOeahOW9k+WJjeacgOWwj+iKgueCueOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bCP5qC55aCG55qE5ZCr5LmJ77yM5YaN5qOA5p+la+i3r+W9kuW5tuWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('TGlzdE5vZGUgY3VyID0gZHVtbXk7CiAgICAgICAgd2hpbGUgKCFwcS5pc0VtcHR5KCkpIHsKICAgICAgICAgICAgTGlzdE5vZGUgbm9kZSA9IHBxLnBvbGwoKTsKICAgICAgICAgICAgaWYgKG5vZGUubmV4dCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICBwcS5vZmZlcihub2RlLm5leHQpOwogICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIG1lcmdlS0xpc3RzKExpc3ROb2RlW10gbGlzdHMpIHsKICAgICAgICBQcmlvcml0eVF1ZXVlPExpc3ROb2RlPiBwcSA9IG5ldyBQcmlvcml0eVF1ZXVlPD4oKGEsIGIpIC0+IEludGVnZXIuY29tcGFyZShhLnZhbCwgYi52YWwpKTsKICAgICAgICBmb3IgKExpc3ROb2RlIGhlYWQgOiBsaXN0cykgewogICAgICAgICAgICBpZiAoaGVhZCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICBwcS5vZmZlcihoZWFkKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBMaXN0Tm9kZSBkdW1teSA9IG5ldyBMaXN0Tm9kZSgpOwogICAgICAgIExpc3ROb2RlIGN1ciA9IGR1bW15OwogICAgICAgIHdoaWxlICghcHEuaXNFbXB0eSgpKSB7CiAgICAgICAgICAgIExpc3ROb2RlIG5vZGUgPSBwcS5wb2xsKCk7CiAgICAgICAgICAgIGlmIChub2RlLm5leHQgIT0gbnVsbCkgewogICAgICAgICAgICAgICAgcHEub2ZmZXIobm9kZS5uZXh0KTsKICAgICAgICAgICAgfQogICAgICAgICAgICBjdXIubmV4dCA9IG5vZGU7CiAgICAgICAgICAgIGN1ciA9IGN1ci5uZXh0OwogICAgICAgIH0KICAgICAgICByZXR1cm4gZHVtbXkubmV4dDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 23
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 23
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4) WHERE p.leetcode_number = 23
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5b2S5bm25o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5b2S5bm25o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 23
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aCG5Lit5aeL57uI5L+d5a2Y5q+P5p2h5bCa5pyq6ICX5bC96ZO+6KGo55qE5b2T5YmN5pyA5bCP6IqC54K544CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1lcmdlS0xpc3RzIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5q+U6L6D5Zmo55SoIEludGVnZXIuY29tcGFyZSDpmLLmuqLlh7rvvJvlvLnlh7roioLngrnlkI7lj6rlnKggbmV4dCDpnZ7nqbrml7blhaXloIbjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWxIG4g5Liq6IqC54K577yM5pe26Ze0IE8obiBsb2cgaynvvIznqbrpl7QgTyhrKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+U6L6D5Zmo55SoIEludGVnZXIuY29tcGFyZSDpmLLmuqLlh7rvvJvlvLnlh7roioLngrnlkI7lj6rlnKggbmV4dCDpnZ7nqbrml7blhaXloIbjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1lcmdlS0xpc3RzIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3ROb2RlIG1lcmdlS0xpc3RzKExpc3ROb2RlW10gbGlzdHMpIHsKICAgICAgICBQcmlvcml0eVF1ZXVlPExpc3ROb2RlPiBwcSA9IG5ldyBQcmlvcml0eVF1ZXVlPD4oKGEsIGIpIC0+IEludGVnZXIuY29tcGFyZShhLnZhbCwgYi52YWwpKTsKICAgICAgICBmb3IgKExpc3ROb2RlIGhlYWQgOiBsaXN0cykgewogICAgICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIHBxLm9mZmVyKGhlYWQpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIExpc3ROb2RlIGR1bW15ID0gbmV3IExpc3ROb2RlKCk7CiAgICAgICAgTGlzdE5vZGUgY3VyID0gZHVtbXk7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIExpc3ROb2RlIG5vZGUgPSB7e2JsYW5rXzN9fTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfNH19KSB7CiAgICAgICAgICAgICAgICBwcS5vZmZlcihub2RlLm5leHQpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGN1ci5uZXh0ID0gbm9kZTsKICAgICAgICAgICAgY3VyID0gY3VyLm5leHQ7CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzV9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaGVhZCAhPSBudWxsIiwiYmxhbmtfMiI6IiFwcS5pc0VtcHR5KCkiLCJibGFua18zIjoicHEucG9sbCgpIiwiYmxhbmtfNCI6Im5vZGUubmV4dCAhPSBudWxsIiwiYmxhbmtfNSI6ImR1bW15Lm5leHQifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlsI/moLnloIYiLCJr6Lev5b2S5bm2Iiwi5b2T5YmN6ZO+5aS0Iiwi6ZO+6KGoIiwi5YiG5rK7Iiwi5aCG77yI5LyY5YWI6Zif5YiX77yJIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 23
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-35: #146 LRU 缓存

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    146, 35, CONVERT(FROM_BASE64('TFJVIOe8k+WtmA==') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('6K+35L2g6K6+6K6h5bm25a6e546w5LiA5Liq5ruh6LazICBbTFJVICjmnIDov5HmnIDlsJHkvb/nlKgpIOe8k+WtmF0oaHR0cHM6Ly9iYWlrZS5iYWlkdS5jb20vaXRlbS9MUlUpIOe6puadn+eahOaVsOaNrue7k+aehOOAggoK5a6e546wIGBMUlVDYWNoZWAg57G777yaCgotIGBMUlVDYWNoZShpbnQgY2FwYWNpdHkpYCDku6UqKuato+aVtOaVsCoq5L2c5Li65a656YePIGBjYXBhY2l0eWAg5Yid5aeL5YyWIExSVSDnvJPlrZgKLSBgaW50IGdldChpbnQga2V5KWAg5aaC5p6c5YWz6ZSu5a2XIGBrZXlgIOWtmOWcqOS6jue8k+WtmOS4re+8jOWImei/lOWbnuWFs+mUruWtl+eahOWAvO+8jOWQpuWImei/lOWbniBgLTFgIOOAggotIGB2b2lkIHB1dChpbnQga2V5LCBpbnQgdmFsdWUpYCDlpoLmnpzlhbPplK7lrZcgYGtleWAg5bey57uP5a2Y5Zyo77yM5YiZ5Y+Y5pu05YW25pWw5o2u5YC8IGB2YWx1ZWAg77yb5aaC5p6c5LiN5a2Y5Zyo77yM5YiZ5ZCR57yT5a2Y5Lit5o+S5YWl6K+l57uEIGBrZXktdmFsdWVgIOOAguWmguaenOaPkuWFpeaTjeS9nOWvvOiHtOWFs+mUruWtl+aVsOmHj+i2hei/hyBgY2FwYWNpdHlgIO+8jOWImeW6lOivpSoq6YCQ5Ye6KirmnIDkuYXmnKrkvb/nlKjnmoTlhbPplK7lrZfjgIIKCuWHveaVsCBgZ2V0YCDlkowgYHB1dGAg5b+F6aG75LulIGBPKDEpYCDnmoTlubPlnYfml7bpl7TlpI3mnYLluqbov5DooYzjgIIqKuekuuS+i++8mioqYGBgdGV4dArovpPlhaUKWyJMUlVDYWNoZSIsICJwdXQiLCAicHV0IiwgImdldCIsICJwdXQiLCAiZ2V0IiwgInB1dCIsICJnZXQiLCAiZ2V0IiwgImdldCJdCltbMl0sIFsxLCAxXSwgWzIsIDJdLCBbMV0sIFszLCAzXSwgWzJdLCBbNCwgNF0sIFsxXSwgWzNdLCBbNF1dCui+k+WHugpbbnVsbCwgbnVsbCwgbnVsbCwgMSwgbnVsbCwgLTEsIG51bGwsIC0xLCAzLCA0XQoK6Kej6YeKCkxSVUNhY2hlIGxSVUNhY2hlID0gbmV3IExSVUNhY2hlKDIpOwpsUlVDYWNoZS5wdXQoMSwgMSk7IC8vIOe8k+WtmOaYryB7MT0xfQpsUlVDYWNoZS5wdXQoMiwgMik7IC8vIOe8k+WtmOaYryB7MT0xLCAyPTJ9CmxSVUNhY2hlLmdldCgxKTsgICAgLy8g6L+U5ZueIDEKbFJVQ2FjaGUucHV0KDMsIDMpOyAvLyDor6Xmk43kvZzkvJrkvb/lvpflhbPplK7lrZcgMiDkvZzlup/vvIznvJPlrZjmmK8gezE9MSwgMz0zfQpsUlVDYWNoZS5nZXQoMik7ICAgIC8vIOi/lOWbniAtMSAo5pyq5om+5YiwKQpsUlVDYWNoZS5wdXQoNCwgNCk7IC8vIOivpeaTjeS9nOS8muS9v+W+l+WFs+mUruWtlyAxIOS9nOW6n++8jOe8k+WtmOaYryB7ND00LCAzPTN9CmxSVUNhY2hlLmdldCgxKTsgICAgLy8g6L+U5ZueIC0xICjmnKrmib7liLApCmxSVUNhY2hlLmdldCgzKTsgICAgLy8g6L+U5ZueIDMKbFJVQ2FjaGUuZ2V0KDQpOyAgICAvLyDov5Tlm54gNApgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBjYXBhY2l0eSA8PSAzMDAwYAotIGAwIDw9IGtleSA8PSAxMDAwMGAKLSBgMCA8PSB2YWx1ZSA8PSAxMDVgCi0g5pyA5aSa6LCD55SoIGAyICogMTA1YCDmrKEgYGdldGAg5ZKMIGBwdXRgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbHJ1LWNhY2hlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9scnUtY2FjaGUvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZOI5biM6KGo5a6a5L2N6IqC54K577yM5Y+M5ZCR6ZO+6KGo5oyJ5pyA6L+R5L2/55So6aG65bqP5o6S5YiX77yb6K6/6Zeu5oiW5YaZ5YWl5ZCO56e75Yiw5aS06YOo77yM6LaF5a656YeP5reY5rGw5bC+6YOo44CCIOacrOmimOWbtOe7leOAjExSVSDnvJPlrZjjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrlk4jluIzooajkuI7pk77ooajkuIDkuIDlr7nlupTvvIzlpLTpg6jmnIDluLjnlKjjgIHlsL7pg6jmnIDkuYXmnKrkvb/nlKjvvIzlrrnph4/lp4vnu4jkuI3otoXpmZDliLbjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ZOI5biM6KGo55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y+M5ZCR6ZO+6KGo5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQoKICAgIHB1YmxpYyB2b2lkIHB1dChpbnQga2V5LCBpbnQgdmFsdWUpIHsKICAgICAgICBpZiAoY2FjaGUuY29udGFpbnNLZXkoa2V5KSkgewogICAgICAgICAgICBOb2RlIG5vZGUgPSBjYWNoZS5nZXQoa2V5KTsKICAgICAgICAgICAgcmVtb3ZlTm9kZShub2RlKTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgTm9kZSB7CiAgICBpbnQga2V5LCB2YWw7CiAgICBOb2RlIHByZXYsIG5leHQ7CgogICAgTm9kZSgpIHsKICAgIH0KCiAgICBOb2RlKGludCBrZXksIGludCB2YWwpIHsKICAgICAgICB0aGlzLmtleSA9IGtleTsKICAgICAgICB0aGlzLnZhbCA9IHZhbDsKICAgIH0KfQoKY2xhc3MgTFJVQ2FjaGUgewogICAgcHJpdmF0ZSBpbnQgc2l6ZTsKICAgIHByaXZhdGUgaW50IGNhcGFjaXR5OwogICAgcHJpdmF0ZSBOb2RlIGhlYWQgPSBuZXcgTm9kZSgpOwogICAgcHJpdmF0ZSBOb2RlIHRhaWwgPSBuZXcgTm9kZSgpOwogICAgcHJpdmF0ZSBNYXA8SW50ZWdlciwgTm9kZT4gY2FjaGUgPSBuZXcgSGFzaE1hcDw+KCk7CgogICAgcHVibGljIExSVUNhY2hlKGludCBjYXBhY2l0eSkgewogICAgICAgIHRoaXMuY2FwYWNpdHkgPSBjYXBhY2l0eTsKICAgICAgICBoZWFkLm5leHQgPSB0YWlsOwogICAgICAgIHRhaWwucHJldiA9IGhlYWQ7CiAgICB9CgogICAgcHVibGljIGludCBnZXQoaW50IGtleSkgewogICAgICAgIGlmICghY2FjaGUuY29udGFpbnNLZXkoa2V5KSkgewogICAgICAgICAgICByZXR1cm4gLTE7CiAgICAgICAgfQogICAgICAgIE5vZGUgbm9kZSA9IGNhY2hlLmdldChrZXkpOwogICAgICAgIHJlbW92ZU5vZGUobm9kZSk7CiAgICAgICAgYWRkVG9IZWFkKG5vZGUpOwogICAgICAgIHJldHVybiBub2RlLnZhbDsKICAgIH0KCiAgICBwdWJsaWMgdm9pZCBwdXQoaW50IGtleSwgaW50IHZhbHVlKSB7CiAgICAgICAgaWYgKGNhY2hlLmNvbnRhaW5zS2V5KGtleSkpIHsKICAgICAgICAgICAgTm9kZSBub2RlID0gY2FjaGUuZ2V0KGtleSk7CiAgICAgICAgICAgIHJlbW92ZU5vZGUobm9kZSk7CiAgICAgICAgICAgIG5vZGUudmFsID0gdmFsdWU7CiAgICAgICAgICAgIGFkZFRvSGVhZChub2RlKTsKICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBOb2RlIG5vZGUgPSBuZXcgTm9kZShrZXksIHZhbHVlKTsKICAgICAgICAgICAgY2FjaGUucHV0KGtleSwgbm9kZSk7CiAgICAgICAgICAgIGFkZFRvSGVhZChub2RlKTsKICAgICAgICAgICAgaWYgKCsrc2l6ZSA+IGNhcGFjaXR5KSB7CiAgICAgICAgICAgICAgICBub2RlID0gdGFpbC5wcmV2OwogICAgICAgICAgICAgICAgY2FjaGUucmVtb3ZlKG5vZGUua2V5KTsKICAgICAgICAgICAgICAgIHJlbW92ZU5vZGUobm9kZSk7CiAgICAgICAgICAgICAgICAtLXNpemU7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIHJlbW92ZU5vZGUoTm9kZSBub2RlKSB7CiAgICAgICAgbm9kZS5wcmV2Lm5leHQgPSBub2RlLm5leHQ7CiAgICAgICAgbm9kZS5uZXh0LnByZXYgPSBub2RlLnByZXY7CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIGFkZFRvSGVhZChOb2RlIG5vZGUpIHsKICAgICAgICBub2RlLm5leHQgPSBoZWFkLm5leHQ7CiAgICAgICAgbm9kZS5wcmV2ID0gaGVhZDsKICAgICAgICBoZWFkLm5leHQgPSBub2RlOwogICAgICAgIG5vZGUubmV4dC5wcmV2ID0gbm9kZTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 146
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4) WHERE p.leetcode_number = 146
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 146
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5ZCR6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5ZCR6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 146
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5ZOI5biM6KGo5LiO6ZO+6KGo5LiA5LiA5a+55bqU77yM5aS06YOo5pyA5bi455So44CB5bC+6YOo5pyA5LmF5pyq5L2/55So77yM5a656YeP5aeL57uI5LiN6LaF6ZmQ5Yi244CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIExSVUNhY2hlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5pu05paw5bey5pyJIGtleSDkuZ/opoHnp7vliqjvvJvmt5jmsbDml7bpk77ooajlkozlk4jluIzooajlv4XpobvlkIzmraXliKDpmaTvvIzlk6jlhbXoioLngrnkuI3orqHlrrnph4/jgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('Z2V0L3B1dCDlubPlnYcgTygxKe+8jOepuumXtCBPKGNhcGFjaXR5KeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5pu05paw5bey5pyJIGtleSDkuZ/opoHnp7vliqjvvJvmt5jmsbDml7bpk77ooajlkozlk4jluIzooajlv4XpobvlkIzmraXliKDpmaTvvIzlk6jlhbXoioLngrnkuI3orqHlrrnph4/jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIExSVUNhY2hlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgTm9kZSB7CiAgICBpbnQga2V5LCB2YWw7CiAgICBOb2RlIHByZXYsIG5leHQ7CgogICAgTm9kZSgpIHsKICAgIH0KCiAgICBOb2RlKGludCBrZXksIGludCB2YWwpIHsKICAgICAgICB0aGlzLmtleSA9IGtleTsKICAgICAgICB0aGlzLnZhbCA9IHZhbDsKICAgIH0KfQoKY2xhc3MgTFJVQ2FjaGUgewogICAgcHJpdmF0ZSBpbnQgc2l6ZTsKICAgIHByaXZhdGUgaW50IGNhcGFjaXR5OwogICAgcHJpdmF0ZSBOb2RlIGhlYWQgPSBuZXcgTm9kZSgpOwogICAgcHJpdmF0ZSBOb2RlIHRhaWwgPSBuZXcgTm9kZSgpOwogICAgcHJpdmF0ZSBNYXA8SW50ZWdlciwgTm9kZT4gY2FjaGUgPSBuZXcgSGFzaE1hcDw+KCk7CgogICAgcHVibGljIExSVUNhY2hlKGludCBjYXBhY2l0eSkgewogICAgICAgIHRoaXMuY2FwYWNpdHkgPSBjYXBhY2l0eTsKICAgICAgICBoZWFkLm5leHQgPSB0YWlsOwogICAgICAgIHRhaWwucHJldiA9IGhlYWQ7CiAgICB9CgogICAgcHVibGljIGludCBnZXQoaW50IGtleSkgewogICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICByZXR1cm4ge3tibGFua18yfX07CiAgICAgICAgfQogICAgICAgIE5vZGUgbm9kZSA9IHt7YmxhbmtfM319OwogICAgICAgIHJlbW92ZU5vZGUobm9kZSk7CiAgICAgICAgYWRkVG9IZWFkKG5vZGUpOwogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KCiAgICBwdWJsaWMgdm9pZCBwdXQoaW50IGtleSwgaW50IHZhbHVlKSB7CiAgICAgICAgaWYgKHt7YmxhbmtfNX19KSB7CiAgICAgICAgICAgIE5vZGUgbm9kZSA9IGNhY2hlLmdldChrZXkpOwogICAgICAgICAgICByZW1vdmVOb2RlKG5vZGUpOwogICAgICAgICAgICBub2RlLnZhbCA9IHZhbHVlOwogICAgICAgICAgICBhZGRUb0hlYWQobm9kZSk7CiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgTm9kZSBub2RlID0gbmV3IE5vZGUoa2V5LCB2YWx1ZSk7CiAgICAgICAgICAgIGNhY2hlLnB1dChrZXksIG5vZGUpOwogICAgICAgICAgICBhZGRUb0hlYWQobm9kZSk7CiAgICAgICAgICAgIGlmICgrK3NpemUgPiBjYXBhY2l0eSkgewogICAgICAgICAgICAgICAgbm9kZSA9IHRhaWwucHJldjsKICAgICAgICAgICAgICAgIGNhY2hlLnJlbW92ZShub2RlLmtleSk7CiAgICAgICAgICAgICAgICByZW1vdmVOb2RlKG5vZGUpOwogICAgICAgICAgICAgICAgLS1zaXplOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQoKICAgIHByaXZhdGUgdm9pZCByZW1vdmVOb2RlKE5vZGUgbm9kZSkgewogICAgICAgIG5vZGUucHJldi5uZXh0ID0gbm9kZS5uZXh0OwogICAgICAgIG5vZGUubmV4dC5wcmV2ID0gbm9kZS5wcmV2OwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBhZGRUb0hlYWQoTm9kZSBub2RlKSB7CiAgICAgICAgbm9kZS5uZXh0ID0gaGVhZC5uZXh0OwogICAgICAgIG5vZGUucHJldiA9IGhlYWQ7CiAgICAgICAgaGVhZC5uZXh0ID0gbm9kZTsKICAgICAgICBub2RlLm5leHQucHJldiA9IG5vZGU7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiIWNhY2hlLmNvbnRhaW5zS2V5KGtleSkiLCJibGFua18yIjoiLTEiLCJibGFua18zIjoiY2FjaGUuZ2V0KGtleSkiLCJibGFua180Ijoibm9kZS52YWwiLCJibGFua181IjoiY2FjaGUuY29udGFpbnNLZXkoa2V5KSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlk4jluIzooagiLCLlj4zlkJHpk77ooagiLCLmnIDov5Hkvb/nlKgiLCLorr7orqEiLCLpk77ooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 146
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-36: #94 二叉树的中序遍历

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    94, 36, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE5Lit5bqP6YGN5Y6G') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIzov5Tlm54gKuWug+eahCoq5Lit5bqPKirpgY3ljoYqIOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzA5LzE1L2lub3JkZXJfMS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMSxudWxsLDIsM10K6L6T5Ye677yaWzEsMywyXQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbXQrovpPlh7rvvJpbXQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMV0K6L6T5Ye677yaWzFdCmBgYCoq5o+Q56S677yaKiotIOagkeS4reiKgueCueaVsOebruWcqOiMg+WbtCBgWzAsIDEwMF1gIOWGhQotIGAtMTAwIDw9IE5vZGUudmFsIDw9IDEwMGAqKui/m+mYtjoqKumAkuW9kueul+azleW+iOeugOWNle+8jOS9oOWPr+S7pemAmui/h+i/reS7o+eul+azleWujOaIkOWQl++8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2JpbmFyeS10cmVlLWlub3JkZXItdHJhdmVyc2FsLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9iaW5hcnktdHJlZS1pbm9yZGVyLXRyYXZlcnNhbC8p') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5qCI5qih5ouf6YCS5b2S77ya5LiA6Lev5Y6L5YWl5bem6ZO+77yM5by55Ye66K6/6Zeu6IqC54K577yM5YaN6L2s5ZCR5YW25Y+z5a2Q5qCR44CCIOacrOmimOWbtOe7leOAjOS6jOWPieagkeeahOS4reW6j+mBjeWOhuOAjeiQveWunui/meS4gOaooeWei++8muagiOS/neWtmOWwmuacquiuv+mXrueahOelluWFiO+8m+W8ueagiOiKgueCueeahOW3puWtkOagkeW3sue7j+WFqOmDqOiuv+mXruOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bem6ZO+5YWl5qCI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Lit5bqP5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSB2b2lkIGRmcyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHJvb3QgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGRmcyhyb290LmxlZnQpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwoKICAgIHB1YmxpYyBMaXN0PEludGVnZXI+IGlub3JkZXJUcmF2ZXJzYWwoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGRmcyhyb290KTsKICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmIChyb290ID09IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBkZnMocm9vdC5sZWZ0KTsKICAgICAgICBhbnMuYWRkKHJvb3QudmFsKTsKICAgICAgICBkZnMocm9vdC5yaWdodCk7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 94
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 94
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 94
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 94
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5qCI5L+d5a2Y5bCa5pyq6K6/6Zeu55qE56WW5YWI77yb5by55qCI6IqC54K555qE5bem5a2Q5qCR5bey57uP5YWo6YOo6K6/6Zeu44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGlub3JkZXJUcmF2ZXJzYWwg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSW5bGC5p2h5Lu25b+F6aG75pivIGN1cnJlbnQgIT0gbnVsbCDmiJbmoIjpnZ7nqbrvvIzkuI3og73mvI/mjonmnIDlkI7nmoTlj7PlrZDmoJHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aSW5bGC5p2h5Lu25b+F6aG75pivIGN1cnJlbnQgIT0gbnVsbCDmiJbmoIjpnZ7nqbrvvIzkuI3og73mvI/mjonmnIDlkI7nmoTlj7PlrZDmoJHjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGlub3JkZXJUcmF2ZXJzYWwg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwoKICAgIHB1YmxpYyBMaXN0PEludGVnZXI+IGlub3JkZXJUcmF2ZXJzYWwoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGRmcyh7e2JsYW5rXzF9fSk7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGRmcyhyb290LmxlZnQpOwogICAgICAgIGFucy5hZGQocm9vdC52YWwpOwogICAgICAgIGRmcyhyb290LnJpZ2h0KTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCIsImJsYW5rXzIiOiJhbnMiLCJibGFua18zIjoicm9vdCA9PSBudWxsIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6bpk77lhaXmoIgiLCLkuK3luo8iLCLmmL7lvI/moIgiLCLmoIgiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 94
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-37: #104 二叉树的最大深度

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    104, 37, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE5pyA5aSn5rex5bqm') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5qCRIGByb290YCDvvIzov5Tlm57lhbbmnIDlpKfmt7HluqbjgIIKCuS6jOWPieagkeeahCoq5pyA5aSn5rex5bqmKirmmK/mjIfku47moLnoioLngrnliLDmnIDov5zlj7blrZDoioLngrnnmoTmnIDplb/ot6/lvoTkuIrnmoToioLngrnmlbDjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8xMS8yNi90bXAtdHJlZS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMyw5LDIwLG51bGwsbnVsbCwxNSw3XQrovpPlh7rvvJozCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxLG51bGwsMl0K6L6T5Ye677yaMgpgYGAqKuaPkOekuu+8mioqLSDmoJHkuK3oioLngrnnmoTmlbDph4/lnKggYFswLCAxMDRdYCDljLrpl7TlhoXjgIIKLSBgLTEwMCA8PSBOb2RlLnZhbCA8PSAxMDBgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbWF4aW11bS1kZXB0aC1vZi1iaW5hcnktdHJlZS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbWF4aW11bS1kZXB0aC1vZi1iaW5hcnktdHJlZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('6YCS5b2S6L+U5Zue5b2T5YmN5a2Q5qCR5pyA5aSn5rex5bqm77yaMSArIG1heCjlt6bmt7HluqYsIOWPs+a3seW6pinjgIIg5pys6aKY5Zu057uV44CM5LqM5Y+J5qCR55qE5pyA5aSn5rex5bqm44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5q+P5Liq6LCD55So55qE6L+U5Zue5YC85Y+q6KGo56S65Lul5b2T5YmN6IqC54K55Li65qC555qE5a2Q5qCR5rex5bqm44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5a2Q5qCR5rex5bqm55qE5ZCr5LmJ77yM5YaN5qOA5p+l6YCS5b2S6L+U5Zue5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIGludCBtYXhEZXB0aChUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHJvb3QgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9CiAgICAgICAgaW50IGwgPSBtYXhEZXB0aChyb290LmxlZnQpOwogICAgICAgIGludCByID0gbWF4RGVwdGgocm9vdC5yaWdodCk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhEZXB0aChUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHJvb3QgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9CiAgICAgICAgaW50IGwgPSBtYXhEZXB0aChyb290LmxlZnQpOwogICAgICAgIGludCByID0gbWF4RGVwdGgocm9vdC5yaWdodCk7CiAgICAgICAgcmV0dXJuIDEgKyBNYXRoLm1heChsLCByKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 104
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 104
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 104
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 104
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5Liq6LCD55So55qE6L+U5Zue5YC85Y+q6KGo56S65Lul5b2T5YmN6IqC54K55Li65qC555qE5a2Q5qCR5rex5bqm44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1heERlcHRoIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('56m66IqC54K55rex5bqm5Li6IDDvvJvkuI3opoHmioroioLngrnmlbDkuI7ovrnmlbDlrprkuYnmt7fnlKjjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('56m66IqC54K55rex5bqm5Li6IDDvvJvkuI3opoHmioroioLngrnmlbDkuI7ovrnmlbDlrprkuYnmt7fnlKjjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1heERlcHRoIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhEZXB0aChUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KICAgICAgICBpbnQgbCA9IHt7YmxhbmtfMn19OwogICAgICAgIGludCByID0ge3tibGFua18zfX07CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNH19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCA9PSBudWxsIiwiYmxhbmtfMiI6Im1heERlcHRoKHJvb3QubGVmdCkiLCJibGFua18zIjoibWF4RGVwdGgocm9vdC5yaWdodCkiLCJibGFua180IjoiMSArIE1hdGgubWF4KGwsIHIpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlrZDmoJHmt7HluqYiLCLpgJLlvZLov5Tlm54iLCLnqbroioLngrkiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 104
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-38: #226 翻转二叉树

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    226, 38, CONVERT(FROM_BASE64('57+76L2s5LqM5Y+J5qCR') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5qO15LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIznv7vovazov5nmo7Xkuozlj4nmoJHvvIzlubbov5Tlm57lhbbmoLnoioLngrnjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMy8xNC9pbnZlcnQxLXRyZWUuanBnKQoKYGBgdGV4dArovpPlhaXvvJpyb290ID0gWzQsMiw3LDEsMyw2LDldCui+k+WHuu+8mls0LDcsMiw5LDYsMywxXQpgYGAqKuekuuS+iyAy77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMy8xNC9pbnZlcnQyLXRyZWUuanBnKQoKYGBgdGV4dArovpPlhaXvvJpyb290ID0gWzIsMSwzXQrovpPlh7rvvJpbMiwzLDFdCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFtdCui+k+WHuu+8mltdCmBgYCoq5o+Q56S677yaKiotIOagkeS4reiKgueCueaVsOebruiMg+WbtOWcqCBgWzAsIDEwMF1gIOWGhQotIGAtMTAwIDw9IE5vZGUudmFsIDw9IDEwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9pbnZlcnQtYmluYXJ5LXRyZWUvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2ludmVydC1iaW5hcnktdHJlZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('6YCS5b2S5Lqk5o2i5q+P5Liq6IqC54K555qE5bem5Y+z5a2Q5qCR77yM5oiW55So6Zif5YiX6YCQ6IqC54K55Lqk5o2i44CCIOacrOmimOWbtOe7leOAjOe/u+i9rOS6jOWPieagkeOAjeiQveWunui/meS4gOaooeWei++8muWkhOeQhuWujOiKgueCuSB4IOWQju+8jOS7pSB4IOS4uuagueeahOaVtOajteWtkOagkeW3sue7j+ebuOWvueWOn+agkemVnOWDj+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bem5Y+z5Lqk5o2i55qE5ZCr5LmJ77yM5YaN5qOA5p+l6ZWc5YOP6YCS5b2S5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIFRyZWVOb2RlIGludmVydFRyZWUoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmIChyb290ID09IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuIG51bGw7CiAgICAgICAgfQogICAgICAgIFRyZWVOb2RlIGwgPSBpbnZlcnRUcmVlKHJvb3QubGVmdCk7CiAgICAgICAgVHJlZU5vZGUgciA9IGludmVydFRyZWUocm9vdC5yaWdodCk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFRyZWVOb2RlIGludmVydFRyZWUoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmIChyb290ID09IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuIG51bGw7CiAgICAgICAgfQogICAgICAgIFRyZWVOb2RlIGwgPSBpbnZlcnRUcmVlKHJvb3QubGVmdCk7CiAgICAgICAgVHJlZU5vZGUgciA9IGludmVydFRyZWUocm9vdC5yaWdodCk7CiAgICAgICAgcm9vdC5sZWZ0ID0gcjsKICAgICAgICByb290LnJpZ2h0ID0gbDsKICAgICAgICByZXR1cm4gcm9vdDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 226
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 226
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 226
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 226
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5a6M6IqC54K5IHgg5ZCO77yM5LulIHgg5Li65qC555qE5pW05qO15a2Q5qCR5bey57uP55u45a+55Y6f5qCR6ZWc5YOP44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGludmVydFRyZWUg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75L+d5a2Y5oiW55u05o6l5Lqk5o2i5Lik5Liq6YCS5b2S6L+U5Zue5YC877yM6YG/5YWN6KaG55uW5ZCO6YeN5aSN5aSE55CG5ZCM5LiA5a2Q5qCR44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75L+d5a2Y5oiW55u05o6l5Lqk5o2i5Lik5Liq6YCS5b2S6L+U5Zue5YC877yM6YG/5YWN6KaG55uW5ZCO6YeN5aSN5aSE55CG5ZCM5LiA5a2Q5qCR44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGludmVydFRyZWUg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFRyZWVOb2RlIGludmVydFRyZWUoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICByZXR1cm4ge3tibGFua18yfX07CiAgICAgICAgfQogICAgICAgIFRyZWVOb2RlIGwgPSB7e2JsYW5rXzN9fTsKICAgICAgICBUcmVlTm9kZSByID0ge3tibGFua180fX07CiAgICAgICAgcm9vdC5sZWZ0ID0gcjsKICAgICAgICByb290LnJpZ2h0ID0gbDsKICAgICAgICByZXR1cm4ge3tibGFua181fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCA9PSBudWxsIiwiYmxhbmtfMiI6Im51bGwiLCJibGFua18zIjoiaW52ZXJ0VHJlZShyb290LmxlZnQpIiwiYmxhbmtfNCI6ImludmVydFRyZWUocm9vdC5yaWdodCkiLCJibGFua181Ijoicm9vdCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6blj7PkuqTmjaIiLCLplZzlg4/pgJLlvZIiLCLnqbroioLngrkiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 226
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-39: #101 对称二叉树

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    101, 39, CONVERT(FROM_BASE64('5a+556ew5LqM5Y+J5qCR') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIwg5qOA5p+l5a6D5piv5ZCm6L205a+556ew44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vcGljLmxlZXRjb2RlLmNuLzE2OTgwMjY5NjYtSkRZUERVLWltYWdlLnBuZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxLDIsMiwzLDQsNCwzXQrovpPlh7rvvJp0cnVlCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL3BpYy5sZWV0Y29kZS5jbi8xNjk4MDI3MDA4LW5QRkxiTS1pbWFnZS5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMSwyLDIsbnVsbCwzLG51bGwsM10K6L6T5Ye677yaZmFsc2UKYGBgKirmj5DnpLrvvJoqKi0g5qCR5Lit6IqC54K55pWw55uu5Zyo6IyD5Zu0IGBbMSwgMTAwMF1gIOWGhQotIGAtMTAwIDw9IE5vZGUudmFsIDw9IDEwMGAqKui/m+mYtu+8mioq5L2g5Y+v5Lul6L+Q55So6YCS5b2S5ZKM6L+t5Luj5Lik56eN5pa55rOV6Kej5Yaz6L+Z5Liq6Zeu6aKY5ZCX77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvc3ltbWV0cmljLXRyZWUvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3N5bW1ldHJpYy10cmVlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('6YCS5b2S5q+U6L6D6ZWc5YOP5L2N572u77yabGVmdC5sZWZ0IOWvuSByaWdodC5yaWdodO+8jGxlZnQucmlnaHQg5a+5IHJpZ2h0LmxlZnTjgIIg5pys6aKY5Zu057uV44CM5a+556ew5LqM5Y+J5qCR44CN6JC95a6e6L+Z5LiA5qih5Z6L77yaaXNNaXJyb3IoYSxiKSDkuLrnnJ/lvZPkuJTku4XlvZPkuKTmo7XlrZDmoJHnu5PmnoTlkozlgLzlhbPkuo7kuK3lv4Plr7nnp7DjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6ZWc5YOP5L2N572u55qE5ZCr5LmJ77yM5YaN5qOA5p+l5oiQ5a+56YCS5b2S5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cmV0dXJuIHRydWU7CiAgICAgICAgfQogICAgICAgIGlmIChyb290MSA9PSBudWxsIHx8IHJvb3QyID09IG51bGwgfHwgcm9vdDEudmFsICE9IHJvb3QyLnZhbCkgewogICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgICAgfQogICAgICAgIHJldHVybiBkZnMocm9vdDEubGVmdCwgcm9vdDIucmlnaHQpICYmIGRmcyhyb290MS5yaWdodCwgcm9vdDIubGVmdCk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNTeW1tZXRyaWMoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIHJldHVybiBkZnMocm9vdC5sZWZ0LCByb290LnJpZ2h0KTsKICAgIH0KCiAgICBwcml2YXRlIGJvb2xlYW4gZGZzKFRyZWVOb2RlIHJvb3QxLCBUcmVlTm9kZSByb290MikgewogICAgICAgIGlmIChyb290MSA9PSByb290MikgewogICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICB9CiAgICAgICAgaWYgKHJvb3QxID09IG51bGwgfHwgcm9vdDIgPT0gbnVsbCB8fCByb290MS52YWwgIT0gcm9vdDIudmFsKSB7CiAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGRmcyhyb290MS5sZWZ0LCByb290Mi5yaWdodCkgJiYgZGZzKHJvb3QxLnJpZ2h0LCByb290Mi5sZWZ0KTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 101
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 101
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 101
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 101
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('aXNNaXJyb3IoYSxiKSDkuLrnnJ/lvZPkuJTku4XlvZPkuKTmo7XlrZDmoJHnu5PmnoTlkozlgLzlhbPkuo7kuK3lv4Plr7nnp7DjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGlzU3ltbWV0cmljIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5Lik5Liq6IqC54K55ZCM5pe25Li656m65omN5Li655yf77yM5Y+q5pyJ5LiA5Liq5Li656m65oiW5YC85LiN5ZCM56uL5Y2z5Li65YGH44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Lik5Liq6IqC54K55ZCM5pe25Li656m65omN5Li655yf77yM5Y+q5pyJ5LiA5Liq5Li656m65oiW5YC85LiN5ZCM56uL5Y2z5Li65YGH44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGlzU3ltbWV0cmljIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNTeW1tZXRyaWMoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIHJldHVybiB7e2JsYW5rXzF9fTsKICAgIH0KCiAgICBwcml2YXRlIGJvb2xlYW4gZGZzKFRyZWVOb2RlIHJvb3QxLCBUcmVlTm9kZSByb290MikgewogICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICAgICAgfQogICAgICAgIGlmICh7e2JsYW5rXzR9fSkgewogICAgICAgICAgICByZXR1cm4ge3tibGFua181fX07CiAgICAgICAgfQogICAgICAgIHJldHVybiBkZnMocm9vdDEubGVmdCwgcm9vdDIucmlnaHQpICYmIGRmcyhyb290MS5yaWdodCwgcm9vdDIubGVmdCk7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKHJvb3QubGVmdCwgcm9vdC5yaWdodCkiLCJibGFua18yIjoicm9vdDEgPT0gcm9vdDIiLCJibGFua18zIjoidHJ1ZSIsImJsYW5rXzQiOiJyb290MSA9PSBudWxsIHx8IHJvb3QyID09IG51bGwgfHwgcm9vdDEudmFsICE9IHJvb3QyLnZhbCIsImJsYW5rXzUiOiJmYWxzZSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLplZzlg4/kvY3nva4iLCLmiJDlr7npgJLlvZIiLCLnu5PmnoTlkozlgLwiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 101
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-40: #543 二叉树的直径

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    543, 40, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE55u05b6E') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5qO15LqM5Y+J5qCR55qE5qC56IqC54K577yM6L+U5Zue6K+l5qCR55qEKirnm7TlvoQqKuOAggoK5LqM5Y+J5qCR55qEKirnm7TlvoQqKuaYr+aMh+agkeS4reS7u+aEj+S4pOS4quiKgueCueS5i+mXtOacgOmVv+i3r+W+hOeahCoq6ZW/5bqmKirjgILov5nmnaHot6/lvoTlj6/og73nu4/ov4fkuZ/lj6/og73kuI3nu4/ov4fmoLnoioLngrkgYHJvb3RgIOOAggoK5Lik6IqC54K55LmL6Ze06Lev5b6E55qEKirplb/luqYqKueUseWug+S7rOS5i+mXtOi+ueaVsOihqOekuuOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAzLzA2L2RpYW10cmVlLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxLDIsMyw0LDVdCui+k+WHuu+8mjMK6Kej6YeK77yaMyDvvIzlj5bot6/lvoQgWzQsMiwxLDNdIOaIliBbNSwyLDEsM10g55qE6ZW/5bqm44CCCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxLDJdCui+k+WHuu+8mjEKYGBgKirmj5DnpLrvvJoqKi0g5qCR5Lit6IqC54K55pWw55uu5Zyo6IyD5Zu0IGBbMSwgMTA0XWAg5YaFCi0gYC0xMDAgPD0gTm9kZS52YWwgPD0gMTAwYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2RpYW1ldGVyLW9mLWJpbmFyeS10cmVlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9kaWFtZXRlci1vZi1iaW5hcnktdHJlZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZCO5bqP6YCS5b2S6L+U5Zue5Y2V6L655pyA5aSn5rex5bqm77yM5bm255SoIGxlZnREZXB0aCArIHJpZ2h0RGVwdGgg5pu05paw57uP6L+H5b2T5YmN6IqC54K555qE55u05b6E44CCIOacrOmimOWbtOe7leOAjOS6jOWPieagkeeahOebtOW+hOOAjeiQveWunui/meS4gOaooeWei++8mumAkuW9kui/lOWbnuWAvOWPquiDveaYr+WQkeeItuiKgueCueW7tuS8uOeahOS4gOadoeacgOmVv+mTvu+8jOWFqOWxgOWPmOmHj+S/neWtmOS7u+aEj+S4pOerr+i3r+W+hOacgOWkp+i+ueaVsOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y2V6L655rex5bqm55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YWo5bGA55u05b6E5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBpbnQgZGZzKFRyZWVOb2RlIHJvb3QpIHsKICAgICAgICBpZiAocm9vdCA9PSBudWxsKSB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KICAgICAgICBpbnQgbCA9IGRmcyhyb290LmxlZnQpOwogICAgICAgIGludCByID0gZGZzKHJvb3QucmlnaHQpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgYW5zOwoKICAgIHB1YmxpYyBpbnQgZGlhbWV0ZXJPZkJpbmFyeVRyZWUoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGRmcyhyb290KTsKICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgaW50IGRmcyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHJvb3QgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9CiAgICAgICAgaW50IGwgPSBkZnMocm9vdC5sZWZ0KTsKICAgICAgICBpbnQgciA9IGRmcyhyb290LnJpZ2h0KTsKICAgICAgICBhbnMgPSBNYXRoLm1heChhbnMsIGwgKyByKTsKICAgICAgICByZXR1cm4gMSArIE1hdGgubWF4KGwsIHIpOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 543
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 543
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 543
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2S6L+U5Zue5YC85Y+q6IO95piv5ZCR54i26IqC54K55bu25Ly455qE5LiA5p2h5pyA6ZW/6ZO+77yM5YWo5bGA5Y+Y6YeP5L+d5a2Y5Lu75oSP5Lik56uv6Lev5b6E5pyA5aSn6L655pWw44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGRpYW1ldGVyT2ZCaW5hcnlUcmVlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('55u05b6E5oyJ6L655pWw6K6h566X77yM5LiN6KaB5aSa5Yqg5b2T5YmN6IqC54K5IDHvvJvnqbrlrZDmoJHmt7HluqbkuLogMOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('55u05b6E5oyJ6L655pWw6K6h566X77yM5LiN6KaB5aSa5Yqg5b2T5YmN6IqC54K5IDHvvJvnqbrlrZDmoJHmt7HluqbkuLogMOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGRpYW1ldGVyT2ZCaW5hcnlUcmVlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgYW5zOwoKICAgIHB1YmxpYyBpbnQgZGlhbWV0ZXJPZkJpbmFyeVRyZWUoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGRmcyhyb290KTsKICAgICAgICByZXR1cm4ge3tibGFua18xfX07CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgZGZzKFRyZWVOb2RlIHJvb3QpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGludCBsID0ge3tibGFua18zfX07CiAgICAgICAgaW50IHIgPSB7e2JsYW5rXzR9fTsKICAgICAgICBhbnMgPSB7e2JsYW5rXzV9fTsKICAgICAgICByZXR1cm4gMSArIE1hdGgubWF4KGwsIHIpOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6InJvb3QgPT0gbnVsbCIsImJsYW5rXzMiOiJkZnMocm9vdC5sZWZ0KSIsImJsYW5rXzQiOiJkZnMocm9vdC5yaWdodCkiLCJibGFua181IjoiTWF0aC5tYXgoYW5zLCBsICsgcikifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljZXovrnmt7HluqYiLCLlhajlsYDnm7TlvoQiLCLlkI7luo8iLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLkuozlj4nmoJEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 543
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-41: #102 二叉树的层序遍历

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    102, 41, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE5bGC5bqP6YGN5Y6G') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIzov5Tlm57lhbboioLngrnlgLznmoQqKuWxguW6j+mBjeWOhioq44CCIO+8iOWNs+mAkOWxguWcsO+8jOS7juW3puWIsOWPs+iuv+mXruaJgOacieiKgueCue+8ieOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAyLzE5L3RyZWUxLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFszLDksMjAsbnVsbCxudWxsLDE1LDddCui+k+WHuu+8mltbM10sWzksMjBdLFsxNSw3XV0KYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpyb290ID0gWzFdCui+k+WHuu+8mltbMV1dCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFtdCui+k+WHuu+8mltdCmBgYCoq5o+Q56S677yaKiotIOagkeS4reiKgueCueaVsOebruWcqOiMg+WbtCBgWzAsIDIwMDBdYCDlhoUKLSBgLTEwMDAgPD0gTm9kZS52YWwgPD0gMTAwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9iaW5hcnktdHJlZS1sZXZlbC1vcmRlci10cmF2ZXJzYWwvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2JpbmFyeS10cmVlLWxldmVsLW9yZGVyLXRyYXZlcnNhbC8p') USING utf8mb4),
    CONVERT(FROM_BASE64('6Zif5YiX5YGaIEJGU++8jOavj+i9ruWFiOivu+WPluW9k+WJjemYn+WIlyBzaXpl77yM5Y+q5by55Ye66L+Z5LiA5bGC5bm25oqK5a2Q6IqC54K55YWl6Zif44CCIOacrOmimOWbtOe7leOAjOS6jOWPieagkeeahOWxguW6j+mBjeWOhuOAjeiQveWunui/meS4gOaooeWei++8muS4gOi9ruW8gOWni+aXtumYn+WIl+WJjSBzaXplIOS4quiKgueCueaBsOWlveWxnuS6juWQjOS4gOWxguOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bGC5aSn5bCP55qE5ZCr5LmJ77yM5YaN5qOA5p+lQkZT6Zif5YiX5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('TGlzdDxJbnRlZ2VyPiB0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgICAgIGZvciAoaW50IG4gPSBxLnNpemUoKTsgbiA+IDA7IC0tbikgewogICAgICAgICAgICAgICAgVHJlZU5vZGUgbm9kZSA9IHEucG9sbCgpOwogICAgICAgICAgICAgICAgdC5hZGQobm9kZS52YWwpOwogICAgICAgICAgICAgICAgaWYgKG5vZGUubGVmdCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihub2RlLmxlZnQpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxJbnRlZ2VyPj4gbGV2ZWxPcmRlcihUcmVlTm9kZSByb290KSB7CiAgICAgICAgTGlzdDxMaXN0PEludGVnZXI+PiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAocm9vdCA9PSBudWxsKSB7CiAgICAgICAgICAgIHJldHVybiBhbnM7CiAgICAgICAgfQogICAgICAgIERlcXVlPFRyZWVOb2RlPiBxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIHEub2ZmZXIocm9vdCk7CiAgICAgICAgd2hpbGUgKCFxLmlzRW1wdHkoKSkgewogICAgICAgICAgICBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICAgICAgZm9yIChpbnQgbiA9IHEuc2l6ZSgpOyBuID4gMDsgLS1uKSB7CiAgICAgICAgICAgICAgICBUcmVlTm9kZSBub2RlID0gcS5wb2xsKCk7CiAgICAgICAgICAgICAgICB0LmFkZChub2RlLnZhbCk7CiAgICAgICAgICAgICAgICBpZiAobm9kZS5sZWZ0ICE9IG51bGwpIHsKICAgICAgICAgICAgICAgICAgICBxLm9mZmVyKG5vZGUubGVmdCk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAobm9kZS5yaWdodCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihub2RlLnJpZ2h0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICBhbnMuYWRkKHQpOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 102
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 102
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 102
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LiA6L2u5byA5aeL5pe26Zif5YiX5YmNIHNpemUg5Liq6IqC54K55oGw5aW95bGe5LqO5ZCM5LiA5bGC44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxldmVsT3JkZXIg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5bGC5aSn5bCP5b+F6aG75Zyo5YWl6Zif5a2Q6IqC54K55YmN5Zu65a6a77yb5qC55Li656m66L+U5Zue56m65YiX6KGo44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyh3Ke+8jHcg5Li65pyA5aSn5bGC5a6944CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5bGC5aSn5bCP5b+F6aG75Zyo5YWl6Zif5a2Q6IqC54K55YmN5Zu65a6a77yb5qC55Li656m66L+U5Zue56m65YiX6KGo44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxldmVsT3JkZXIg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxJbnRlZ2VyPj4gbGV2ZWxPcmRlcihUcmVlTm9kZSByb290KSB7CiAgICAgICAgTGlzdDxMaXN0PEludGVnZXI+PiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICBEZXF1ZTxUcmVlTm9kZT4gcSA9IG5ldyBBcnJheURlcXVlPD4oKTsKICAgICAgICBxLm9mZmVyKHJvb3QpOwogICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICAgICAgZm9yIChpbnQgbiA9IHt7YmxhbmtfNH19OyBuID4gMDsgLS1uKSB7CiAgICAgICAgICAgICAgICBUcmVlTm9kZSBub2RlID0ge3tibGFua181fX07CiAgICAgICAgICAgICAgICB0LmFkZChub2RlLnZhbCk7CiAgICAgICAgICAgICAgICBpZiAobm9kZS5sZWZ0ICE9IG51bGwpIHsKICAgICAgICAgICAgICAgICAgICBxLm9mZmVyKG5vZGUubGVmdCk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAobm9kZS5yaWdodCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihub2RlLnJpZ2h0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICBhbnMuYWRkKHQpOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCA9PSBudWxsIiwiYmxhbmtfMiI6ImFucyIsImJsYW5rXzMiOiIhcS5pc0VtcHR5KCkiLCJibGFua180IjoicS5zaXplKCkiLCJibGFua181IjoicS5wb2xsKCkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlsYLlpKflsI8iLCJCRlPpmJ/liJciLCLpgJDlsYLovpPlh7oiLCLmoJEiLCLlub/luqbkvJjlhYjmkJzntKIiLCLkuozlj4nmoJEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 102
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-42: #108 将有序数组转换为二叉搜索树

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    108, 42, CONVERT(FROM_BASE64('5bCG5pyJ5bqP5pWw57uE6L2s5o2i5Li65LqM5Y+J5pCc57Si5qCR') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzlhbbkuK3lhYPntKDlt7Lnu4/mjIkqKuWNh+W6jyoq5o6S5YiX77yM6K+35L2g5bCG5YW26L2s5o2i5Li65LiA5qO1IOW5s+ihoSDkuozlj4nmkJzntKLmoJHjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMi8xOC9idHJlZTEuanBnKQoKYGBgdGV4dArovpPlhaXvvJpudW1zID0gWy0xMCwtMywwLDUsOV0K6L6T5Ye677yaWzAsLTMsOSwtMTAsbnVsbCw1XQrop6Pph4rvvJpbMCwtMTAsNSxudWxsLC0zLG51bGwsOV0g5Lmf5bCG6KKr6KeG5Li65q2j56Gu562U5qGI77yaCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAyLzE4L2J0cmVlLmpwZykKCmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDNdCui+k+WHuu+8mlszLDFdCuino+mHiu+8mlsxLG51bGwsM10g5ZKMIFszLDFdIOmDveaYr+mrmOW6puW5s+ihoeS6jOWPieaQnOe0ouagkeOAggpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBudW1zLmxlbmd0aCA8PSAxMDRgCi0gYC0xMDQgPD0gbnVtc1tpXSA8PSAxMDRgCi0gYG51bXNgIOaMiSoq5Lil5qC86YCS5aKeKirpobrluo/mjpLliJcKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9jb252ZXJ0LXNvcnRlZC1hcnJheS10by1iaW5hcnktc2VhcmNoLXRyZWUvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2NvbnZlcnQtc29ydGVkLWFycmF5LXRvLWJpbmFyeS1zZWFyY2gtdHJlZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5q+P5qyh6YCJ5oup5pyJ5bqP5Yy66Ze05Lit54K55L2c5Li65qC577yM6YCS5b2S55So5bem5Y2K5bu65bem5a2Q5qCR44CB5Y+z5Y2K5bu65Y+z5a2Q5qCR44CCIOacrOmimOWbtOe7leOAjOWwhuacieW6j+aVsOe7hOi9rOaNouS4uuS6jOWPieaQnOe0ouagkeOAjeiQveWunui/meS4gOaooeWei++8mumAkuW9kiBidWlsZChsLHIpIOi/lOWbnuaBsOWlveWMheWQq+ivpemXreWMuumXtOWFg+e0oOS4lOmrmOW6puWwvemHj+W5s+ihoeeahCBCU1TjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Yy66Ze05Lit54K555qE5ZCr5LmJ77yM5YaN5qOA5p+l5bmz6KGhQlNU5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBUcmVlTm9kZSBkZnMoaW50IGwsIGludCByKSB7CiAgICAgICAgaWYgKGwgPiByKSB7CiAgICAgICAgICAgIHJldHVybiBudWxsOwogICAgICAgIH0KICAgICAgICBpbnQgbWlkID0gKGwgKyByKSA+PiAxOwogICAgICAgIHJldHVybiBuZXcgVHJlZU5vZGUobnVtc1ttaWRdLCBkZnMobCwgbWlkIC0gMSksIGRmcyhtaWQgKyAxLCByKSk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBudW1zOwoKICAgIHB1YmxpYyBUcmVlTm9kZSBzb3J0ZWRBcnJheVRvQlNUKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSBudW1zOwogICAgICAgIHJldHVybiBkZnMoMCwgbnVtcy5sZW5ndGggLSAxKTsKICAgIH0KCiAgICBwcml2YXRlIFRyZWVOb2RlIGRmcyhpbnQgbCwgaW50IHIpIHsKICAgICAgICBpZiAobCA+IHIpIHsKICAgICAgICAgICAgcmV0dXJuIG51bGw7CiAgICAgICAgfQogICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgcmV0dXJuIG5ldyBUcmVlTm9kZShudW1zW21pZF0sIGRmcyhsLCBtaWQgLSAxKSwgZGZzKG1pZCArIDEsIHIpKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4) WHERE p.leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2SIGJ1aWxkKGwscikg6L+U5Zue5oGw5aW95YyF5ZCr6K+l6Zet5Yy66Ze05YWD57Sg5LiU6auY5bqm5bC96YeP5bmz6KGh55qEIEJTVOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNvcnRlZEFycmF5VG9CU1Qg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Yy66Ze05Li656m65pe2IGw+ciDov5Tlm54gbnVsbO+8m+W3puWPs+mAkuW9kui+ueeVjOS4jeiDveWGjeasoeWMheWQqyBtaWTjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhsb2cgbinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Yy66Ze05Li656m65pe2IGw+ciDov5Tlm54gbnVsbO+8m+W3puWPs+mAkuW9kui+ueeVjOS4jeiDveWGjeasoeWMheWQqyBtaWTjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNvcnRlZEFycmF5VG9CU1Qg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBudW1zOwoKICAgIHB1YmxpYyBUcmVlTm9kZSBzb3J0ZWRBcnJheVRvQlNUKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSBudW1zOwogICAgICAgIHJldHVybiB7e2JsYW5rXzF9fTsKICAgIH0KCiAgICBwcml2YXRlIFRyZWVOb2RlIGRmcyhpbnQgbCwgaW50IHIpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICBpbnQgbWlkID0gKGwgKyByKSA+PiAxOwogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKDAsIG51bXMubGVuZ3RoIC0gMSkiLCJibGFua18yIjoibCA+IHIiLCJibGFua18zIjoibnVsbCIsImJsYW5rXzQiOiJuZXcgVHJlZU5vZGUobnVtc1ttaWRdLCBkZnMobCwgbWlkIC0gMSksIGRmcyhtaWQgKyAxLCByKSkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljLrpl7TkuK3ngrkiLCLlubPooaFCU1QiLCLpgJLlvZLovrnnlYwiLCLmoJEiLCLkuozlj4nmkJzntKLmoJEiLCLmlbDnu4QiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 108
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-43: #98 验证二叉搜索树

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    98, 43, CONVERT(FROM_BASE64('6aqM6K+B5LqM5Y+J5pCc57Si5qCR') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIzliKTmlq3lhbbmmK/lkKbmmK/kuIDkuKrmnInmlYjnmoTkuozlj4nmkJzntKLmoJHjgIIqKuacieaViCoq5LqM5Y+J5pCc57Si5qCR5a6a5LmJ5aaC5LiL77yaCgotIOiKgueCueeahOW3puWtkOagkeWPquWMheWQqyoq5Lil5qC85bCP5LqOKirlvZPliY3oioLngrnnmoTmlbDjgIIKLSDoioLngrnnmoTlj7PlrZDmoJHlj6rljIXlkKsqKuS4peagvOWkp+S6jioq5b2T5YmN6IqC54K555qE5pWw44CCCi0g5omA5pyJ5bem5a2Q5qCR5ZKM5Y+z5a2Q5qCR6Ieq6Lqr5b+F6aG75Lmf5piv5LqM5Y+J5pCc57Si5qCR44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTIvMDEvdHJlZTEuanBnKQoKYGBgdGV4dArovpPlhaXvvJpyb290ID0gWzIsMSwzXQrovpPlh7rvvJp0cnVlCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzEyLzAxL3RyZWUyLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFs1LDEsNCxudWxsLG51bGwsMyw2XQrovpPlh7rvvJpmYWxzZQrop6Pph4rvvJrmoLnoioLngrnnmoTlgLzmmK8gNSDvvIzkvYbmmK/lj7PlrZDoioLngrnnmoTlgLzmmK8gNCDjgIIKYGBgKirmj5DnpLrvvJoqKi0g5qCR5Lit6IqC54K55pWw55uu6IyD5Zu05ZyoYFsxLCAxMDRdYCDlhoUKLSBgLTIzMSA8PSBOb2RlLnZhbCA8PSAyMzEgLSAxYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3ZhbGlkYXRlLWJpbmFyeS1zZWFyY2gtdHJlZS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvdmFsaWRhdGUtYmluYXJ5LXNlYXJjaC10cmVlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5Lit5bqP6YGN5Y6GIEJTVCDlupTlvpfliLDkuKXmoLzpgJLlop7luo/liJfvvJvkv53lrZjliY3kuIDkuKrorr/pl67oioLngrnvvIzkuI7lvZPliY3oioLngrnmr5TovoPjgIIg5pys6aKY5Zu057uV44CM6aqM6K+B5LqM5Y+J5pCc57Si5qCR44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6K6/6Zeu5b2T5YmN6IqC54K55pe25bem5a2Q5qCR5bey57uP6aqM6K+B77yMcHJldiDmmK/kuK3luo/luo/liJfkuK3ntKfpgrvlvZPliY3oioLngrnnmoTliY3pqbHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Lit5bqP6YCS5aKe55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YmN6amx6IqC54K55aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIGlmICghZGZzKHJvb3QubGVmdCkpIHsKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgIH0KICAgICAgICBpZiAocHJldiAhPSBudWxsICYmIHByZXYudmFsID49IHJvb3QudmFsKSB7CiAgICAgICAgICAgIHJldHVybiBmYWxzZTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBUcmVlTm9kZSBwcmV2OwoKICAgIHB1YmxpYyBib29sZWFuIGlzVmFsaWRCU1QoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIHJldHVybiBkZnMocm9vdCk7CiAgICB9CgogICAgcHJpdmF0ZSBib29sZWFuIGRmcyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHJvb3QgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICB9CiAgICAgICAgaWYgKCFkZnMocm9vdC5sZWZ0KSkgewogICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgICAgfQogICAgICAgIGlmIChwcmV2ICE9IG51bGwgJiYgcHJldi52YWwgPj0gcm9vdC52YWwpIHsKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgIH0KICAgICAgICBwcmV2ID0gcm9vdDsKICAgICAgICByZXR1cm4gZGZzKHJvb3QucmlnaHQpOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 98
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 98
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 98
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4) WHERE p.leetcode_number = 98
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6K6/6Zeu5b2T5YmN6IqC54K55pe25bem5a2Q5qCR5bey57uP6aqM6K+B77yMcHJldiDmmK/kuK3luo/luo/liJfkuK3ntKfpgrvlvZPliY3oioLngrnnmoTliY3pqbHjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGlzVmFsaWRCU1Qg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75L2/55So5Lil5qC85bCP5LqO77yM6YeN5aSN5YC85LiN5ZCI5rOV77ybcHJldiDmmK/oioLngrnlvJXnlKjlj6/pgb/lhY0gaW50IOaegeWAvOWTqOWFtemXrumimOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75L2/55So5Lil5qC85bCP5LqO77yM6YeN5aSN5YC85LiN5ZCI5rOV77ybcHJldiDmmK/oioLngrnlvJXnlKjlj6/pgb/lhY0gaW50IOaegeWAvOWTqOWFtemXrumimOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGlzVmFsaWRCU1Qg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBUcmVlTm9kZSBwcmV2OwoKICAgIHB1YmxpYyBib29sZWFuIGlzVmFsaWRCU1QoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIHJldHVybiB7e2JsYW5rXzF9fTsKICAgIH0KCiAgICBwcml2YXRlIGJvb2xlYW4gZGZzKFRyZWVOb2RlIHJvb3QpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgICAgIH0KICAgICAgICBpZiAocHJldiAhPSBudWxsICYmIHByZXYudmFsID49IHJvb3QudmFsKSB7CiAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICB9CiAgICAgICAgcHJldiA9IHJvb3Q7CiAgICAgICAgcmV0dXJuIGRmcyhyb290LnJpZ2h0KTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKHJvb3QpIiwiYmxhbmtfMiI6InJvb3QgPT0gbnVsbCIsImJsYW5rXzMiOiJ0cnVlIiwiYmxhbmtfNCI6IiFkZnMocm9vdC5sZWZ0KSIsImJsYW5rXzUiOiJmYWxzZSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuK3luo/pgJLlop4iLCLliY3pqbHoioLngrkiLCLkuKXmoLzkuI3nrYkiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLkuozlj4nmkJzntKLmoJEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 98
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-44: #230 二叉搜索树中第 K 小的元素

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    230, 44, CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR5Lit56ysIEsg5bCP55qE5YWD57Sg') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5pCc57Si5qCR55qE5qC56IqC54K5IGByb290YCDvvIzlkozkuIDkuKrmlbTmlbAgYGtgIO+8jOivt+S9oOiuvuiuoeS4gOS4queul+azleafpeaJvuWFtuS4reesrCBga2AqKioq5bCP55qE5YWD57Sg77yIYGtgIOS7jiAxIOW8gOWni+iuoeaVsO+8ieOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAxLzI4L2t0aHRyZWUxLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFszLDEsNCxudWxsLDJdLCBrID0gMQrovpPlh7rvvJoxCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAxLzI4L2t0aHRyZWUyLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFs1LDMsNiwyLDQsbnVsbCxudWxsLDFdLCBrID0gMwrovpPlh7rvvJozCmBgYCoq5o+Q56S677yaKiotIOagkeS4reeahOiKgueCueaVsOS4uiBgbmAg44CCCi0gYDEgPD0gayA8PSBuIDw9IDEwNGAKLSBgMCA8PSBOb2RlLnZhbCA8PSAxMDRgKirov5vpmLbvvJoqKuWmguaenOS6jOWPieaQnOe0ouagkee7j+W4uOiiq+S/ruaUue+8iOaPkuWFpS/liKDpmaTmk43kvZzvvInlubbkuJTkvaDpnIDopoHpopHnuYHlnLDmn6Xmib7nrKwgYGtgIOWwj+eahOWAvO+8jOS9oOWwhuWmguS9leS8mOWMlueul+azle+8nwoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2t0aC1zbWFsbGVzdC1lbGVtZW50LWluLWEtYnN0LykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9rdGgtc21hbGxlc3QtZWxlbWVudC1pbi1hLWJzdC8p') USING utf8mb4),
    CONVERT(FROM_BASE64('QlNUIOS4reW6j+mBjeWOhuW+l+WIsOmAkuWinuW6j+WIl++8jOiuv+mXruWIsOesrCBrIOS4quiKgueCueaXtui/lOWbnuWFtuWAvOOAgiDmnKzpopjlm7Tnu5XjgIzkuozlj4nmkJzntKLmoJHkuK3nrKwgSyDlsI/nmoTlhYPntKDjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmr4/mrKHlvLnmoIjorr/pl67nmoToioLngrnmmK/lsJrmnKrorr/pl67oioLngrnkuK3nmoTmnIDlsI/lgLzjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFQlNU5Lit5bqP55qE5ZCr5LmJ77yM5YaN5qOA5p+l56ysa+S4quWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('fSBlbHNlIHsKICAgICAgICAgICAgICAgIHJvb3QgPSBzdGsucG9wKCk7CiAgICAgICAgICAgICAgICBpZiAoLS1rID09IDApIHsKICAgICAgICAgICAgICAgICAgICByZXR1cm4gcm9vdC52YWw7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByb290ID0gcm9vdC5yaWdodDs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBrdGhTbWFsbGVzdChUcmVlTm9kZSByb290LCBpbnQgaykgewogICAgICAgIERlcXVlPFRyZWVOb2RlPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgd2hpbGUgKHJvb3QgIT0gbnVsbCB8fCAhc3RrLmlzRW1wdHkoKSkgewogICAgICAgICAgICBpZiAocm9vdCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICBzdGsucHVzaChyb290KTsKICAgICAgICAgICAgICAgIHJvb3QgPSByb290LmxlZnQ7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICByb290ID0gc3RrLnBvcCgpOwogICAgICAgICAgICAgICAgaWYgKC0tayA9PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJvb3QudmFsOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgcm9vdCA9IHJvb3QucmlnaHQ7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIDA7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 230
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 230
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 230
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5pCc57Si5qCR') USING utf8mb4) WHERE p.leetcode_number = 230
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5qyh5by55qCI6K6/6Zeu55qE6IqC54K55piv5bCa5pyq6K6/6Zeu6IqC54K55Lit55qE5pyA5bCP5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGt0aFNtYWxsZXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('ayDmmK8gMS1iYXNlZO+8m+mAkuWHjyBrIOWQjuetieS6jiAwIOaJjeWRveS4re+8jOWkluWxguW+queOr+mcgOimhuebluaVtOS4quagiOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8oaCtrKe+8jOepuumXtCBPKGgp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('ayDmmK8gMS1iYXNlZO+8m+mAkuWHjyBrIOWQjuetieS6jiAwIOaJjeWRveS4re+8jOWkluWxguW+queOr+mcgOimhuebluaVtOS4quagiOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGt0aFNtYWxsZXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBrdGhTbWFsbGVzdChUcmVlTm9kZSByb290LCBpbnQgaykgewogICAgICAgIERlcXVlPFRyZWVOb2RlPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgc3RrLnB1c2gocm9vdCk7CiAgICAgICAgICAgICAgICByb290ID0gcm9vdC5sZWZ0OwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgcm9vdCA9IHt7YmxhbmtfM319OwogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfNH19KSB7CiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgcm9vdCA9IHJvb3QucmlnaHQ7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIDA7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCAhPSBudWxsIHx8ICFzdGsuaXNFbXB0eSgpIiwiYmxhbmtfMiI6InJvb3QgIT0gbnVsbCIsImJsYW5rXzMiOiJzdGsucG9wKCkiLCJibGFua180IjoiLS1rID09IDAiLCJibGFua181Ijoicm9vdC52YWwifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJCU1TkuK3luo8iLCLnrKxr5LiqIiwi5qCIIiwi5qCRIiwi5rex5bqm5LyY5YWI5pCc57SiIiwi5LqM5Y+J5pCc57Si5qCRIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 230
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-45: #199 二叉树的右视图

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    199, 45, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE5Y+z6KeG5Zu+') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5qCR55qEKirmoLnoioLngrkqKmByb290YO+8jOaDs+ixoeiHquW3seermeWcqOWug+eahOWPs+S+p++8jOaMieeFp+S7jumhtumDqOWIsOW6lemDqOeahOmhuuW6j++8jOi/lOWbnuS7juWPs+S+p+aJgOiDveeci+WIsOeahOiKgueCueWAvOOAgioq56S65L6LIDHvvJoqKioq6L6T5YWl77yaKipyb290ID0gWzEsMiwzLG51bGwsNSxudWxsLDRdKirovpPlh7rvvJoqKlsxLDMsNF0qKuino+mHiu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjQvMTEvMjQvdG1wZDVqbjQzZnMtMS5wbmcpKirnpLrkvosgMu+8mioqKirovpPlhaXvvJoqKnJvb3QgPSBbMSwyLDMsNCxudWxsLG51bGwsbnVsbCw1XSoq6L6T5Ye677yaKipbMSwzLDQsNV0qKuino+mHiu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjQvMTEvMjQvdG1wa3BlNDB4ZWgtMS5wbmcpKirnpLrkvosgM++8mioqKirovpPlhaXvvJoqKnJvb3QgPSBbMSxudWxsLDNdKirovpPlh7rvvJoqKlsxLDNdKirnpLrkvosgNO+8mioqKirovpPlhaXvvJoqKnJvb3QgPSBbXSoq6L6T5Ye677yaKipbXSoq5o+Q56S6OioqLSDkuozlj4nmoJHnmoToioLngrnkuKrmlbDnmoTojIPlm7TmmK8gYFswLDEwMF1gCi0gYC0xMDAgPD0gTm9kZS52YWwgPD0gMTAwYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2JpbmFyeS10cmVlLXJpZ2h0LXNpZGUtdmlldy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvYmluYXJ5LXRyZWUtcmlnaHQtc2lkZS12aWV3Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5bGC5bqP6YGN5Y6G5q+P5bGC77yM5oqK6K+l5bGC5pyA5ZCO6K6/6Zeu55qE6IqC54K55YC85Yqg5YWl562U5qGI44CCIOacrOmimOWbtOe7leOAjOS6jOWPieagkeeahOWPs+inhuWbvuOAjeiQveWunui/meS4gOaooeWei++8muavj+i9ruWbuuWumiBzaXplIOWQju+8jOW+queOr+S4reeahOesrCBzaXplLTEg5Liq6IqC54K55bCx5piv5b2T5YmN5bGC5pyA5Y+z6IqC54K544CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bGC5bqP6YGN5Y6G55qE5ZCr5LmJ77yM5YaN5qOA5p+l5q+P5bGC5pyA5ZCO5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('YW5zLmFkZChxLnBlZWtGaXJzdCgpLnZhbCk7CiAgICAgICAgICAgIGZvciAoaW50IGsgPSBxLnNpemUoKTsgayA+IDA7IC0taykgewogICAgICAgICAgICAgICAgVHJlZU5vZGUgbm9kZSA9IHEucG9sbCgpOwogICAgICAgICAgICAgICAgaWYgKG5vZGUucmlnaHQgIT0gbnVsbCkgewogICAgICAgICAgICAgICAgICAgIHEub2ZmZXIobm9kZS5yaWdodCk7CiAgICAgICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gcmlnaHRTaWRlVmlldyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgTGlzdDxJbnRlZ2VyPiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAocm9vdCA9PSBudWxsKSB7CiAgICAgICAgICAgIHJldHVybiBhbnM7CiAgICAgICAgfQogICAgICAgIERlcXVlPFRyZWVOb2RlPiBxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIHEub2ZmZXIocm9vdCk7CiAgICAgICAgd2hpbGUgKCFxLmlzRW1wdHkoKSkgewogICAgICAgICAgICBhbnMuYWRkKHEucGVla0ZpcnN0KCkudmFsKTsKICAgICAgICAgICAgZm9yIChpbnQgayA9IHEuc2l6ZSgpOyBrID4gMDsgLS1rKSB7CiAgICAgICAgICAgICAgICBUcmVlTm9kZSBub2RlID0gcS5wb2xsKCk7CiAgICAgICAgICAgICAgICBpZiAobm9kZS5yaWdodCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihub2RlLnJpZ2h0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGlmIChub2RlLmxlZnQgIT0gbnVsbCkgewogICAgICAgICAgICAgICAgICAgIHEub2ZmZXIobm9kZS5sZWZ0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 199
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 199
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 199
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 199
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u5Zu65a6aIHNpemUg5ZCO77yM5b6q546v5Lit55qE56ysIHNpemUtMSDkuKroioLngrnlsLHmmK/lvZPliY3lsYLmnIDlj7PoioLngrnjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJpZ2h0U2lkZVZpZXcg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Zu65a6a5bGC5aSn5bCP5ZCO5YaN5YWl6Zif5a2Q6IqC54K577yb5qC55Li656m655u05o6l6L+U5Zue44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyh3KeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Zu65a6a5bGC5aSn5bCP5ZCO5YaN5YWl6Zif5a2Q6IqC54K577yb5qC55Li656m655u05o6l6L+U5Zue44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJpZ2h0U2lkZVZpZXcg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gcmlnaHRTaWRlVmlldyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgTGlzdDxJbnRlZ2VyPiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICBEZXF1ZTxUcmVlTm9kZT4gcSA9IG5ldyBBcnJheURlcXVlPD4oKTsKICAgICAgICBxLm9mZmVyKHJvb3QpOwogICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICBhbnMuYWRkKHEucGVla0ZpcnN0KCkudmFsKTsKICAgICAgICAgICAgZm9yIChpbnQgayA9IHt7YmxhbmtfNH19OyBrID4gMDsgLS1rKSB7CiAgICAgICAgICAgICAgICBUcmVlTm9kZSBub2RlID0ge3tibGFua181fX07CiAgICAgICAgICAgICAgICBpZiAobm9kZS5yaWdodCAhPSBudWxsKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihub2RlLnJpZ2h0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGlmIChub2RlLmxlZnQgIT0gbnVsbCkgewogICAgICAgICAgICAgICAgICAgIHEub2ZmZXIobm9kZS5sZWZ0KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCA9PSBudWxsIiwiYmxhbmtfMiI6ImFucyIsImJsYW5rXzMiOiIhcS5pc0VtcHR5KCkiLCJibGFua180IjoicS5zaXplKCkiLCJibGFua181IjoicS5wb2xsKCkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlsYLluo/pgY3ljoYiLCLmr4/lsYLmnIDlkI4iLCLlj7Pop4blm74iLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 199
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-46: #114 二叉树展开为链表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    114, 46, CONVERT(FROM_BASE64('5LqM5Y+J5qCR5bGV5byA5Li66ZO+6KGo') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LqM5Y+J5qCR55qE5qC557uT54K5IGByb290YCDvvIzor7fkvaDlsIblroPlsZXlvIDkuLrkuIDkuKrljZXpk77ooajvvJoKCi0g5bGV5byA5ZCO55qE5Y2V6ZO+6KGo5bqU6K+l5ZCM5qC35L2/55SoIGBUcmVlTm9kZWAg77yM5YW25LitIGByaWdodGAg5a2Q5oyH6ZKI5oyH5ZCR6ZO+6KGo5Lit5LiL5LiA5Liq57uT54K577yM6ICM5bem5a2Q5oyH6ZKI5aeL57uI5Li6IGBudWxsYCDjgIIKLSDlsZXlvIDlkI7nmoTljZXpk77ooajlupTor6XkuI7kuozlj4nmoJEgWyoq5YWI5bqP6YGN5Y6GKipdKGh0dHBzOi8vYmFpa2UuYmFpZHUuY29tL2l0ZW0vJUU1JTg1JTg4JUU1JUJBJThGJUU5JTgxJThEJUU1JThFJTg2LzY0NDI4Mzk/ZnI9YWxhZGRpbikg6aG65bqP55u45ZCM44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjEvMDEvMTQvZmxhdGVuLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxLDIsNSwzLDQsbnVsbCw2XQrovpPlh7rvvJpbMSxudWxsLDIsbnVsbCwzLG51bGwsNCxudWxsLDUsbnVsbCw2XQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbXQrovpPlh7rvvJpbXQpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMF0K6L6T5Ye677yaWzBdCmBgYCoq5o+Q56S677yaKiotIOagkeS4ree7k+eCueaVsOWcqOiMg+WbtCBgWzAsIDIwMDBdYCDlhoUKLSBgLTEwMCA8PSBOb2RlLnZhbCA8PSAxMDBgKirov5vpmLbvvJoqKuS9oOWPr+S7peS9v+eUqOWOn+WcsOeul+azle+8iGBPKDEpYCDpop3lpJbnqbrpl7TvvInlsZXlvIDov5nmo7XmoJHlkJfvvJ8KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9mbGF0dGVuLWJpbmFyeS10cmVlLXRvLWxpbmtlZC1saXN0LykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9mbGF0dGVuLWJpbmFyeS10cmVlLXRvLWxpbmtlZC1saXN0Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('6L+t5Luj5aSE55CG5q+P5Liq6IqC54K577ya6Iul5pyJ5bem5a2Q5qCR77yM5om+5Yiw5bem5a2Q5qCR5pyA5Y+z6IqC54K577yM5oqK5Y6f5Y+z5a2Q5qCR5o6l5Yiw5YW25ZCO77yM5YaN5oqK5bem5a2Q5qCR56e75Yiw5Y+z5L6n44CCIOacrOmimOWbtOe7leOAjOS6jOWPieagkeWxleW8gOS4uumTvuihqOOAjeiQveWunui/meS4gOaooeWei++8muWkhOeQhui/h+eahOiKgueCuSBsZWZ0IOWdh+S4uiBudWxs77yM5rK/IHJpZ2h0IOmTvueahOmhuuW6j+etieS6juWOn+agkeWJjeW6j+mBjeWOhuOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bem5a2Q5qCR5pyA5Y+z55qE5ZCr5LmJ77yM5YaN5qOA5p+l6YeN5o6l5Y+z5a2Q5qCR5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIHZvaWQgZmxhdHRlbihUcmVlTm9kZSByb290KSB7CiAgICAgICAgd2hpbGUgKHJvb3QgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAocm9vdC5sZWZ0ICE9IG51bGwpIHsKCiAgICAgICAgICAgICAgICBUcmVlTm9kZSBwcmUgPSByb290LmxlZnQ7CiAgICAgICAgICAgICAgICB3aGlsZSAocHJlLnJpZ2h0ICE9IG51bGwpIHs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgZmxhdHRlbihUcmVlTm9kZSByb290KSB7CiAgICAgICAgd2hpbGUgKHJvb3QgIT0gbnVsbCkgewogICAgICAgICAgICBpZiAocm9vdC5sZWZ0ICE9IG51bGwpIHsKCiAgICAgICAgICAgICAgICBUcmVlTm9kZSBwcmUgPSByb290LmxlZnQ7CiAgICAgICAgICAgICAgICB3aGlsZSAocHJlLnJpZ2h0ICE9IG51bGwpIHsKICAgICAgICAgICAgICAgICAgICBwcmUgPSBwcmUucmlnaHQ7CiAgICAgICAgICAgICAgICB9CgogICAgICAgICAgICAgICAgcHJlLnJpZ2h0ID0gcm9vdC5yaWdodDsKCiAgICAgICAgICAgICAgICByb290LnJpZ2h0ID0gcm9vdC5sZWZ0OwogICAgICAgICAgICAgICAgcm9vdC5sZWZ0ID0gbnVsbDsKICAgICAgICAgICAgfQogICAgICAgICAgICByb290ID0gcm9vdC5yaWdodDsKICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6ZO+6KGo') USING utf8mb4) WHERE p.leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG6L+H55qE6IqC54K5IGxlZnQg5Z2H5Li6IG51bGzvvIzmsr8gcmlnaHQg6ZO+55qE6aG65bqP562J5LqO5Y6f5qCR5YmN5bqP6YGN5Y6G44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZsYXR0ZW4g5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75YWI5oqK5Y6f5Y+z5a2Q5qCR5o6l5Yiw5bem5a2Q5qCR5pyA5Y+z6IqC54K577yM5YaN6KaG55uWIHJvb3QucmlnaHTvvJvpmo/lkI4gbGVmdCDnva7nqbrjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5Z2P5pe26Ze0IE8obsKyKe+8jOepuumXtCBPKDEp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5oqK5Y6f5Y+z5a2Q5qCR5o6l5Yiw5bem5a2Q5qCR5pyA5Y+z6IqC54K577yM5YaN6KaG55uWIHJvb3QucmlnaHTvvJvpmo/lkI4gbGVmdCDnva7nqbrjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZsYXR0ZW4g55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgZmxhdHRlbihUcmVlTm9kZSByb290KSB7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewoKICAgICAgICAgICAgICAgIFRyZWVOb2RlIHByZSA9IHJvb3QubGVmdDsKICAgICAgICAgICAgICAgIHdoaWxlICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgICAgIHByZSA9IHByZS5yaWdodDsKICAgICAgICAgICAgICAgIH0KCiAgICAgICAgICAgICAgICBwcmUucmlnaHQgPSByb290LnJpZ2h0OwoKICAgICAgICAgICAgICAgIHJvb3QucmlnaHQgPSByb290LmxlZnQ7CiAgICAgICAgICAgICAgICByb290LmxlZnQgPSBudWxsOwogICAgICAgICAgICB9CiAgICAgICAgICAgIHJvb3QgPSByb290LnJpZ2h0OwogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCAhPSBudWxsIiwiYmxhbmtfMiI6InJvb3QubGVmdCAhPSBudWxsIiwiYmxhbmtfMyI6InByZS5yaWdodCAhPSBudWxsIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6blrZDmoJHmnIDlj7MiLCLph43mjqXlj7PlrZDmoJEiLCJsZWZ0572u56m6Iiwi5qCIIiwi5qCRIiwi5rex5bqm5LyY5YWI5pCc57SiIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 114
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-47: #105 从前序与中序遍历序列构造二叉树

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    105, 47, CONVERT(FROM_BASE64('5LuO5YmN5bqP5LiO5Lit5bqP6YGN5Y6G5bqP5YiX5p6E6YCg5LqM5Y+J5qCR') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5Lik5Liq5pW05pWw5pWw57uEIGBwcmVvcmRlcmAg5ZKMIGBpbm9yZGVyYCDvvIzlhbbkuK0gYHByZW9yZGVyYCDmmK/kuozlj4nmoJHnmoQqKuWFiOW6j+mBjeWOhioq77yMIGBpbm9yZGVyYCDmmK/lkIzkuIDmo7XmoJHnmoQqKuS4reW6j+mBjeWOhioq77yM6K+35p6E6YCg5LqM5Y+J5qCR5bm26L+U5Zue5YW25qC56IqC54K544CCKirnpLrkvosgMToqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIxLzAyLzE5L3RyZWUuanBnKQoKYGBgdGV4dArovpPlhaU6IHByZW9yZGVyID0gWzMsOSwyMCwxNSw3XSwgaW5vcmRlciA9IFs5LDMsMTUsMjAsN10K6L6T5Ye6OiBbMyw5LDIwLG51bGwsbnVsbCwxNSw3XQpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IHByZW9yZGVyID0gWy0xXSwgaW5vcmRlciA9IFstMV0K6L6T5Ye6OiBbLTFdCmBgYCoq5o+Q56S6OioqLSBgMSA8PSBwcmVvcmRlci5sZW5ndGggPD0gMzAwMGAKLSBgaW5vcmRlci5sZW5ndGggPT0gcHJlb3JkZXIubGVuZ3RoYAotIGAtMzAwMCA8PSBwcmVvcmRlcltpXSwgaW5vcmRlcltpXSA8PSAzMDAwYAotIGBwcmVvcmRlcmAg5ZKMIGBpbm9yZGVyYCDlnYcqKuaXoOmHjeWkjSoq5YWD57SgCi0gYGlub3JkZXJgIOWdh+WHuueOsOWcqCBgcHJlb3JkZXJgCi0gYHByZW9yZGVyYCoq5L+d6K+BKirkuLrkuozlj4nmoJHnmoTliY3luo/pgY3ljobluo/liJcKLSBgaW5vcmRlcmAqKuS/neivgSoq5Li65LqM5Y+J5qCR55qE5Lit5bqP6YGN5Y6G5bqP5YiXCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvY29uc3RydWN0LWJpbmFyeS10cmVlLWZyb20tcHJlb3JkZXItYW5kLWlub3JkZXItdHJhdmVyc2FsLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9jb25zdHJ1Y3QtYmluYXJ5LXRyZWUtZnJvbS1wcmVvcmRlci1hbmQtaW5vcmRlci10cmF2ZXJzYWwvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5YmN5bqP6aaW5YWD57Sg56Gu5a6a5qC577yM55So5ZOI5biM6KGo5a6a5L2N5YW25Zyo5Lit5bqP5Lit55qE5L2N572u77yM5o2u5bem5a2Q5qCR6ZW/5bqm5YiH5YiG5YmN5bqP5Yy66Ze044CCIOacrOmimOWbtOe7leOAjOS7juWJjeW6j+S4juS4reW6j+mBjeWOhuW6j+WIl+aehOmAoOS6jOWPieagkeOAjeiQveWunui/meS4gOaooeWei++8mmJ1aWxkIOeahOWJjeW6j+S4juS4reW6j+WMuumXtOWMheWQq+WujOWFqOebuOWQjOeahOS4gOe7hOiKgueCue+8jOW5tuaehOmAoOWHuuWUr+S4gOWtkOagkeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5YmN5bqP5a6a5qC555qE5ZCr5LmJ77yM5YaN5qOA5p+l5Lit5bqP5YiG5Ymy5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBUcmVlTm9kZSBkZnMoaW50IGksIGludCBqLCBpbnQgbikgewogICAgICAgIGlmIChuIDw9IDApIHsKICAgICAgICAgICAgcmV0dXJuIG51bGw7CiAgICAgICAgfQogICAgICAgIGludCB2ID0gcHJlb3JkZXJbaV07') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBwcmVvcmRlcjsKICAgIHByaXZhdGUgTWFwPEludGVnZXIsIEludGVnZXI+IGQgPSBuZXcgSGFzaE1hcDw+KCk7CgogICAgcHVibGljIFRyZWVOb2RlIGJ1aWxkVHJlZShpbnRbXSBwcmVvcmRlciwgaW50W10gaW5vcmRlcikgewogICAgICAgIGludCBuID0gcHJlb3JkZXIubGVuZ3RoOwogICAgICAgIHRoaXMucHJlb3JkZXIgPSBwcmVvcmRlcjsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBkLnB1dChpbm9yZGVyW2ldLCBpKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGRmcygwLCAwLCBuKTsKICAgIH0KCiAgICBwcml2YXRlIFRyZWVOb2RlIGRmcyhpbnQgaSwgaW50IGosIGludCBuKSB7CiAgICAgICAgaWYgKG4gPD0gMCkgewogICAgICAgICAgICByZXR1cm4gbnVsbDsKICAgICAgICB9CiAgICAgICAgaW50IHYgPSBwcmVvcmRlcltpXTsKICAgICAgICBpbnQgayA9IGQuZ2V0KHYpOwogICAgICAgIFRyZWVOb2RlIGwgPSBkZnMoaSArIDEsIGosIGsgLSBqKTsKICAgICAgICBUcmVlTm9kZSByID0gZGZzKGkgKyAxICsgayAtIGosIGsgKyAxLCBuIC0gMSAtIChrIC0gaikpOwogICAgICAgIHJldHVybiBuZXcgVHJlZU5vZGUodiwgbCwgcik7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('YnVpbGQg55qE5YmN5bqP5LiO5Lit5bqP5Yy66Ze05YyF5ZCr5a6M5YWo55u45ZCM55qE5LiA57uE6IqC54K577yM5bm25p6E6YCg5Ye65ZSv5LiA5a2Q5qCR44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGJ1aWxkVHJlZSDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5Yy66Ze06ZW/5bqm5ZKM5bem5Y+z56uv54K55b+F6aG75Yy56YWN77yb5ZOI5biM5pig5bCE5bu656uL5LiA5qyh77yM6YG/5YWN5q+P5bGC57q/5oCn5p+l5om+44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Yy66Ze06ZW/5bqm5ZKM5bem5Y+z56uv54K55b+F6aG75Yy56YWN77yb5ZOI5biM5pig5bCE5bu656uL5LiA5qyh77yM6YG/5YWN5q+P5bGC57q/5oCn5p+l5om+44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGJ1aWxkVHJlZSDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBwcmVvcmRlcjsKICAgIHByaXZhdGUgTWFwPEludGVnZXIsIEludGVnZXI+IGQgPSBuZXcgSGFzaE1hcDw+KCk7CgogICAgcHVibGljIFRyZWVOb2RlIGJ1aWxkVHJlZShpbnRbXSBwcmVvcmRlciwgaW50W10gaW5vcmRlcikgewogICAgICAgIGludCBuID0gcHJlb3JkZXIubGVuZ3RoOwogICAgICAgIHRoaXMucHJlb3JkZXIgPSBwcmVvcmRlcjsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBkLnB1dChpbm9yZGVyW2ldLCBpKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMX19OwogICAgfQoKICAgIHByaXZhdGUgVHJlZU5vZGUgZGZzKGludCBpLCBpbnQgaiwgaW50IG4pIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICBpbnQgdiA9IHt7YmxhbmtfNH19OwogICAgICAgIGludCBrID0ge3tibGFua181fX07CiAgICAgICAgVHJlZU5vZGUgbCA9IGRmcyhpICsgMSwgaiwgayAtIGopOwogICAgICAgIFRyZWVOb2RlIHIgPSBkZnMoaSArIDEgKyBrIC0gaiwgayArIDEsIG4gLSAxIC0gKGsgLSBqKSk7CiAgICAgICAgcmV0dXJuIG5ldyBUcmVlTm9kZSh2LCBsLCByKTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKDAsIDAsIG4pIiwiYmxhbmtfMiI6Im4gPD0gMCIsImJsYW5rXzMiOiJudWxsIiwiYmxhbmtfNCI6InByZW9yZGVyW2ldIiwiYmxhbmtfNSI6ImQuZ2V0KHYpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLliY3luo/lrprmoLkiLCLkuK3luo/liIblibIiLCLntKLlvJXmmKDlsIQiLCLmoJEiLCLmlbDnu4QiLCLlk4jluIzooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 105
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-48: #437 路径总和 III

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    437, 48, CONVERT(FROM_BASE64('6Lev5b6E5oC75ZKMIElJSQ==') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIzlkozkuIDkuKrmlbTmlbAgYHRhcmdldFN1bWAg77yM5rGC6K+l5LqM5Y+J5qCR6YeM6IqC54K55YC85LmL5ZKM562J5LqOIGB0YXJnZXRTdW1gIOeahCoq6Lev5b6EKirnmoTmlbDnm67jgIIqKui3r+W+hCoq5LiN6ZyA6KaB5LuO5qC56IqC54K55byA5aeL77yM5Lmf5LiN6ZyA6KaB5Zyo5Y+25a2Q6IqC54K557uT5p2f77yM5L2G5piv6Lev5b6E5pa55ZCR5b+F6aG75piv5ZCR5LiL55qE77yI5Y+q6IO95LuO54i26IqC54K55Yiw5a2Q6IqC54K577yJ44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjEvMDQvMDkvcGF0aHN1bTMtMS10cmVlLmpwZykKCmBgYHRleHQK6L6T5YWl77yacm9vdCA9IFsxMCw1LC0zLDMsMixudWxsLDExLDMsLTIsbnVsbCwxXSwgdGFyZ2V0U3VtID0gOArovpPlh7rvvJozCuino+mHiu+8muWSjOetieS6jiA4IOeahOi3r+W+hOaciSAzIOadoe+8jOWmguWbvuaJgOekuuOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbNSw0LDgsMTEsbnVsbCwxMyw0LDcsMixudWxsLG51bGwsNSwxXSwgdGFyZ2V0U3VtID0gMjIK6L6T5Ye677yaMwpgYGAqKuaPkOekujoqKi0g5LqM5Y+J5qCR55qE6IqC54K55Liq5pWw55qE6IyD5Zu05pivIGBbMCwxMDAwXWAKLSBgLTEwOSA8PSBOb2RlLnZhbCA8PSAxMDlgCi0gYC0xMDAwIDw9IHRhcmdldFN1bSA8PSAxMDAwYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3BhdGgtc3VtLWlpaS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcGF0aC1zdW0taWlpLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('REZTIOe7tOaKpOS7juagueWIsOW9k+WJjeiKgueCueeahOWJjee8gOWSjOiuoeaVsO+8jOW9k+WJjei0oeeMruaYryBwcmVmaXhTdW0tdGFyZ2V0IOWHuueOsOasoeaVsO+8m+Wbnua6r+aXtuaSpOmUgOW9k+WJjeWSjOOAgiDmnKzpopjlm7Tnu5XjgIzot6/lvoTmgLvlkowgSUlJ44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5YmN57yA6KGo5Y+q5YyF5ZCr5b2T5YmN6YCS5b2S6Lev5b6E5LiK55qE5YmN57yA5ZKM77yM5LiN5YyF5ZCr5bey56a75byA55qE5YWE5byf5YiG5pSv44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6Lev5b6E5YmN57yA5ZKM55qE5ZCr5LmJ77yM5YaN5qOA5p+l6K6h5pWw5ZOI5biM5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBpbnQgZGZzKFRyZWVOb2RlIG5vZGUsIGxvbmcgcykgewogICAgICAgIGlmIChub2RlID09IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIHMgKz0gbm9kZS52YWw7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBNYXA8TG9uZywgSW50ZWdlcj4gY250ID0gbmV3IEhhc2hNYXA8PigpOwogICAgcHJpdmF0ZSBpbnQgdGFyZ2V0U3VtOwoKICAgIHB1YmxpYyBpbnQgcGF0aFN1bShUcmVlTm9kZSByb290LCBpbnQgdGFyZ2V0U3VtKSB7CiAgICAgICAgY250LnB1dCgwTCwgMSk7CiAgICAgICAgdGhpcy50YXJnZXRTdW0gPSB0YXJnZXRTdW07CiAgICAgICAgcmV0dXJuIGRmcyhyb290LCAwKTsKICAgIH0KCiAgICBwcml2YXRlIGludCBkZnMoVHJlZU5vZGUgbm9kZSwgbG9uZyBzKSB7CiAgICAgICAgaWYgKG5vZGUgPT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9CiAgICAgICAgcyArPSBub2RlLnZhbDsKICAgICAgICBpbnQgYW5zID0gY250LmdldE9yRGVmYXVsdChzIC0gdGFyZ2V0U3VtLCAwKTsKICAgICAgICBjbnQubWVyZ2UocywgMSwgSW50ZWdlcjo6c3VtKTsKICAgICAgICBhbnMgKz0gZGZzKG5vZGUubGVmdCwgcyk7CiAgICAgICAgYW5zICs9IGRmcyhub2RlLnJpZ2h0LCBzKTsKICAgICAgICBjbnQubWVyZ2UocywgLTEsIEludGVnZXI6OnN1bSk7CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 437
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 437
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 437
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YmN57yA6KGo5Y+q5YyF5ZCr5b2T5YmN6YCS5b2S6Lev5b6E5LiK55qE5YmN57yA5ZKM77yM5LiN5YyF5ZCr5bey56a75byA55qE5YWE5byf5YiG5pSv44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHBhdGhTdW0g5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Yid5aeL5b+F6aG75pS+5YWl5YmN57yA5ZKMIDAg5LiA5qyh77yb57Sv5Yqg5ZKM55SoIGxvbmfvvIzlm57muq/ml7borqHmlbDlh4/kuIDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Yid5aeL5b+F6aG75pS+5YWl5YmN57yA5ZKMIDAg5LiA5qyh77yb57Sv5Yqg5ZKM55SoIGxvbmfvvIzlm57muq/ml7borqHmlbDlh4/kuIDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHBhdGhTdW0g55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBNYXA8TG9uZywgSW50ZWdlcj4gY250ID0gbmV3IEhhc2hNYXA8PigpOwogICAgcHJpdmF0ZSBpbnQgdGFyZ2V0U3VtOwoKICAgIHB1YmxpYyBpbnQgcGF0aFN1bShUcmVlTm9kZSByb290LCBpbnQgdGFyZ2V0U3VtKSB7CiAgICAgICAgY250LnB1dCgwTCwgMSk7CiAgICAgICAgdGhpcy50YXJnZXRTdW0gPSB0YXJnZXRTdW07CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMX19OwogICAgfQoKICAgIHByaXZhdGUgaW50IGRmcyhUcmVlTm9kZSBub2RlLCBsb25nIHMpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIHMgKz0gbm9kZS52YWw7CiAgICAgICAgaW50IGFucyA9IHt7YmxhbmtfM319OwogICAgICAgIGNudC5tZXJnZShzLCAxLCBJbnRlZ2VyOjpzdW0pOwogICAgICAgIGFucyArPSB7e2JsYW5rXzR9fTsKICAgICAgICBhbnMgKz0ge3tibGFua181fX07CiAgICAgICAgY250Lm1lcmdlKHMsIC0xLCBJbnRlZ2VyOjpzdW0pOwogICAgICAgIHJldHVybiBhbnM7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKHJvb3QsIDApIiwiYmxhbmtfMiI6Im5vZGUgPT0gbnVsbCIsImJsYW5rXzMiOiJjbnQuZ2V0T3JEZWZhdWx0KHMgLSB0YXJnZXRTdW0sIDApIiwiYmxhbmtfNCI6ImRmcyhub2RlLmxlZnQsIHMpIiwiYmxhbmtfNSI6ImRmcyhub2RlLnJpZ2h0LCBzKSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLot6/lvoTliY3nvIDlkowiLCLorqHmlbDlk4jluIwiLCLlm57muq/mkqTplIAiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLkuozlj4nmoJEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 437
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-49: #236 二叉树的最近公共祖先

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    236, 49, CONVERT(FROM_BASE64('5LqM5Y+J5qCR55qE5pyA6L+R5YWs5YWx56WW5YWI') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LqM5Y+J5qCRLCDmib7liLDor6XmoJHkuK3kuKTkuKrmjIflrproioLngrnnmoTmnIDov5HlhazlhbHnpZblhYjjgIIKClvnmb7luqbnmb7np5FdKGh0dHBzOi8vYmFpa2UuYmFpZHUuY29tL2l0ZW0vJUU2JTlDJTgwJUU4JUJGJTkxJUU1JTg1JUFDJUU1JTg1JUIxJUU3JUE1JTk2JUU1JTg1JTg4Lzg5MTg4MzQ/ZnI9YWxhZGRpbinkuK3mnIDov5HlhazlhbHnpZblhYjnmoTlrprkuYnkuLrvvJrigJzlr7nkuo7mnInmoLnmoJEgVCDnmoTkuKTkuKroioLngrkgcOOAgXHvvIzmnIDov5HlhazlhbHnpZblhYjooajnpLrkuLrkuIDkuKroioLngrkgeO+8jOa7oei2syB4IOaYryBw44CBcSDnmoTnpZblhYjkuJQgeCDnmoTmt7HluqblsL3lj6/og73lpKfvvIgqKuS4gOS4quiKgueCueS5n+WPr+S7peaYr+Wug+iHquW3seeahOelluWFiCoq77yJ44CC4oCdKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMTgvMTIvMTQvYmluYXJ5dHJlZS5wbmcpCgpgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMyw1LDEsNiwyLDAsOCxudWxsLG51bGwsNyw0XSwgcCA9IDUsIHEgPSAxCui+k+WHuu+8mjMK6Kej6YeK77ya6IqC54K5IDUg5ZKM6IqC54K5IDEg55qE5pyA6L+R5YWs5YWx56WW5YWI5piv6IqC54K5IDMg44CCCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDE4LzEyLzE0L2JpbmFyeXRyZWUucG5nKQoKYGBgdGV4dArovpPlhaXvvJpyb290ID0gWzMsNSwxLDYsMiwwLDgsbnVsbCxudWxsLDcsNF0sIHAgPSA1LCBxID0gNArovpPlh7rvvJo1Cuino+mHiu+8muiKgueCuSA1IOWSjOiKgueCuSA0IOeahOacgOi/keWFrOWFseelluWFiOaYr+iKgueCuSA1IOOAguWboOS4uuagueaNruWumuS5ieacgOi/keWFrOWFseelluWFiOiKgueCueWPr+S7peS4uuiKgueCueacrOi6q+OAggpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMSwyXSwgcCA9IDEsIHEgPSAyCui+k+WHuu+8mjEKYGBgKirmj5DnpLrvvJoqKi0g5qCR5Lit6IqC54K55pWw55uu5Zyo6IyD5Zu0IGBbMiwgMTA1XWAg5YaF44CCCi0gYC0xMDkgPD0gTm9kZS52YWwgPD0gMTA5YAotIOaJgOaciSBgTm9kZS52YWxgIGDkupLkuI3nm7jlkIxgIOOAggotIGBwICE9IHFgCi0gYHBgIOWSjCBgcWAg5Z2H5a2Y5Zyo5LqO57uZ5a6a55qE5LqM5Y+J5qCR5Lit44CCCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbG93ZXN0LWNvbW1vbi1hbmNlc3Rvci1vZi1hLWJpbmFyeS10cmVlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9sb3dlc3QtY29tbW9uLWFuY2VzdG9yLW9mLWEtYmluYXJ5LXRyZWUvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZCO5bqP6YCS5b2S77ya5b2T5YmN5Li656m65oiW562J5LqOIHAvcSDlsLHov5Tlm57vvJvlt6blj7Ppg73pnZ7nqbrliJnlvZPliY3mmK/mnIDov5HlhazlhbHnpZblhYjvvIzlkKbliJnlkJHkuIrkvKDpgJLpnZ7nqbrkvqfjgIIg5pys6aKY5Zu057uV44CM5LqM5Y+J5qCR55qE5pyA6L+R5YWs5YWx56WW5YWI44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6YCS5b2S6L+U5Zue5YC86KGo56S65b2T5YmN5a2Q5qCR5Lit5bey57uP5om+5Yiw55qEIHDjgIFxIOaIluWug+S7rOeahOacgOi/keWFrOWFseelluWFiOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ZCO5bqP6L+U5Zue55qE5ZCr5LmJ77yM5YaN5qOA5p+l5bem5Y+z5ZG95Lit5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('dmFyIGxlZnQgPSBsb3dlc3RDb21tb25BbmNlc3Rvcihyb290LmxlZnQsIHAsIHEpOwogICAgICAgIHZhciByaWdodCA9IGxvd2VzdENvbW1vbkFuY2VzdG9yKHJvb3QucmlnaHQsIHAsIHEpOwogICAgICAgIGlmIChsZWZ0ICE9IG51bGwgJiYgcmlnaHQgIT0gbnVsbCkgewogICAgICAgICAgICByZXR1cm4gcm9vdDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGxlZnQgPT0gbnVsbCA/IHJpZ2h0IDogbGVmdDs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFRyZWVOb2RlIGxvd2VzdENvbW1vbkFuY2VzdG9yKFRyZWVOb2RlIHJvb3QsIFRyZWVOb2RlIHAsIFRyZWVOb2RlIHEpIHsKICAgICAgICBpZiAocm9vdCA9PSBudWxsIHx8IHJvb3QgPT0gcCB8fCByb290ID09IHEpIHsKICAgICAgICAgICAgcmV0dXJuIHJvb3Q7CiAgICAgICAgfQogICAgICAgIHZhciBsZWZ0ID0gbG93ZXN0Q29tbW9uQW5jZXN0b3Iocm9vdC5sZWZ0LCBwLCBxKTsKICAgICAgICB2YXIgcmlnaHQgPSBsb3dlc3RDb21tb25BbmNlc3Rvcihyb290LnJpZ2h0LCBwLCBxKTsKICAgICAgICBpZiAobGVmdCAhPSBudWxsICYmIHJpZ2h0ICE9IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuIHJvb3Q7CiAgICAgICAgfQogICAgICAgIHJldHVybiBsZWZ0ID09IG51bGwgPyByaWdodCA6IGxlZnQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 236
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 236
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 236
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2S6L+U5Zue5YC86KGo56S65b2T5YmN5a2Q5qCR5Lit5bey57uP5om+5Yiw55qEIHDjgIFxIOaIluWug+S7rOeahOacgOi/keWFrOWFseelluWFiOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxvd2VzdENvbW1vbkFuY2VzdG9yIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5LiN6KaB57un57ut6LaK6L+H5ZG95LitIHAvcSDnmoToioLngrnlkJHkuIvvvJvpopjnm67kv53or4HkuKTkuKroioLngrnlrZjlnKjjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB57un57ut6LaK6L+H5ZG95LitIHAvcSDnmoToioLngrnlkJHkuIvvvJvpopjnm67kv53or4HkuKTkuKroioLngrnlrZjlnKjjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxvd2VzdENvbW1vbkFuY2VzdG9yIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFRyZWVOb2RlIGxvd2VzdENvbW1vbkFuY2VzdG9yKFRyZWVOb2RlIHJvb3QsIFRyZWVOb2RlIHAsIFRyZWVOb2RlIHEpIHsKICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICB2YXIgbGVmdCA9IHt7YmxhbmtfM319OwogICAgICAgIHZhciByaWdodCA9IHt7YmxhbmtfNH19OwogICAgICAgIGlmICh7e2JsYW5rXzV9fSkgewogICAgICAgICAgICByZXR1cm4gcm9vdDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGxlZnQgPT0gbnVsbCA/IHJpZ2h0IDogbGVmdDsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicm9vdCA9PSBudWxsIHx8IHJvb3QgPT0gcCB8fCByb290ID09IHEiLCJibGFua18yIjoicm9vdCIsImJsYW5rXzMiOiJsb3dlc3RDb21tb25BbmNlc3Rvcihyb290LmxlZnQsIHAsIHEpIiwiYmxhbmtfNCI6Imxvd2VzdENvbW1vbkFuY2VzdG9yKHJvb3QucmlnaHQsIHAsIHEpIiwiYmxhbmtfNSI6ImxlZnQgIT0gbnVsbCAmJiByaWdodCAhPSBudWxsIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlkI7luo/ov5Tlm54iLCLlt6blj7Plkb3kuK0iLCLmnIDov5HnpZblhYgiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLkuozlj4nmoJEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 236
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-50: #124 二叉树中的最大路径和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    124, 50, CONVERT(FROM_BASE64('5LqM5Y+J5qCR5Lit55qE5pyA5aSn6Lev5b6E5ZKM') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('5LqM5Y+J5qCR5Lit55qEKirot6/lvoQqKuiiq+WumuS5ieS4uuS4gOadoeiKgueCueW6j+WIl++8jOW6j+WIl+S4reavj+WvueebuOmCu+iKgueCueS5i+mXtOmDveWtmOWcqOS4gOadoei+ueOAguWQjOS4gOS4quiKgueCueWcqOS4gOadoei3r+W+hOW6j+WIl+S4rSoq6Iez5aSa5Ye6546w5LiA5qyhKirjgILor6Xot6/lvoQqKuiHs+WwkeWMheWQq+S4gOS4qioq6IqC54K577yM5LiU5LiN5LiA5a6a57uP6L+H5qC56IqC54K544CCKirot6/lvoTlkowqKuaYr+i3r+W+hOS4reWQhOiKgueCueWAvOeahOaAu+WSjOOAggoK57uZ5L2g5LiA5Liq5LqM5Y+J5qCR55qE5qC56IqC54K5IGByb290YCDvvIzov5Tlm57lhbYqKuacgOWkp+i3r+W+hOWSjCoq44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTAvMTMvZXh4MS5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mnJvb3QgPSBbMSwyLDNdCui+k+WHuu+8mjYK6Kej6YeK77ya5pyA5LyY6Lev5b6E5pivIDIgLT4gMSAtPiAzIO+8jOi3r+W+hOWSjOS4uiAyICsgMSArIDMgPSA2CmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzEwLzEzL2V4eDIuanBnKQoKYGBgdGV4dArovpPlhaXvvJpyb290ID0gWy0xMCw5LDIwLG51bGwsbnVsbCwxNSw3XQrovpPlh7rvvJo0Mgrop6Pph4rvvJrmnIDkvJjot6/lvoTmmK8gMTUgLT4gMjAgLT4gNyDvvIzot6/lvoTlkozkuLogMTUgKyAyMCArIDcgPSA0MgpgYGAqKuaPkOekuu+8mioqLSDmoJHkuK3oioLngrnmlbDnm67ojIPlm7TmmK8gYFsxLCAzICogMTA0XWAKLSBgLTEwMDAgPD0gTm9kZS52YWwgPD0gMTAwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9iaW5hcnktdHJlZS1tYXhpbXVtLXBhdGgtc3VtLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9iaW5hcnktdHJlZS1tYXhpbXVtLXBhdGgtc3VtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZCO5bqP6L+U5Zue5LuO5b2T5YmN6IqC54K55ZCR5LiL5bu25Ly455qE5pyA5aSn5Y2V6L656LSh54yu77yM6LSf6LSh54yu5oiq5Li6IDDvvJvnlKggbm9kZS52YWwrbGVmdCtyaWdodCDmm7TmlrDlhajlsYDot6/lvoTlkozjgIIg5pys6aKY5Zu057uV44CM5LqM5Y+J5qCR5Lit55qE5pyA5aSn6Lev5b6E5ZKM44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6L+U5Zue57uZ54i26IqC54K555qE6Lev5b6E5Y+q6IO96YCJ5LiA5L6n77yM5YWo5bGA562U5qGI5Y+v5ZCM5pe26L+e5o6l5bem5Y+z5Lik5L6n44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y2V6L656LSh54yu55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YWo5bGA6Lev5b6E5ZKM5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGludCBsZWZ0ID0gTWF0aC5tYXgoMCwgZGZzKHJvb3QubGVmdCkpOwogICAgICAgIGludCByaWdodCA9IE1hdGgubWF4KDAsIGRmcyhyb290LnJpZ2h0KSk7CiAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCByb290LnZhbCArIGxlZnQgKyByaWdodCk7CiAgICAgICAgcmV0dXJuIHJvb3QudmFsICsgTWF0aC5tYXgobGVmdCwgcmlnaHQpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgYW5zID0gLTEwMDE7CgogICAgcHVibGljIGludCBtYXhQYXRoU3VtKFRyZWVOb2RlIHJvb3QpIHsKICAgICAgICBkZnMocm9vdCk7CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KCiAgICBwcml2YXRlIGludCBkZnMoVHJlZU5vZGUgcm9vdCkgewogICAgICAgIGlmIChyb290ID09IG51bGwpIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGludCBsZWZ0ID0gTWF0aC5tYXgoMCwgZGZzKHJvb3QubGVmdCkpOwogICAgICAgIGludCByaWdodCA9IE1hdGgubWF4KDAsIGRmcyhyb290LnJpZ2h0KSk7CiAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCByb290LnZhbCArIGxlZnQgKyByaWdodCk7CiAgICAgICAgcmV0dXJuIHJvb3QudmFsICsgTWF0aC5tYXgobGVmdCwgcmlnaHQpOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5Y+J5qCR') USING utf8mb4) WHERE p.leetcode_number = 124
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCR') USING utf8mb4) WHERE p.leetcode_number = 124
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 124
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 124
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6L+U5Zue57uZ54i26IqC54K555qE6Lev5b6E5Y+q6IO96YCJ5LiA5L6n77yM5YWo5bGA562U5qGI5Y+v5ZCM5pe26L+e5o6l5bem5Y+z5Lik5L6n44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1heFBhdGhTdW0g5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWo5bGA562U5qGI6KaB5Yid5aeL5YyW5Li65pyA5bCP5YC85Lul6KaG55uW5YWo6LSf5qCR77yb5LiN6IO95oqK5bem5Y+z5Lik5L6n6YO96L+U5Zue57uZ54i26IqC54K544CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzpgJLlvZLmoIggTyhoKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5YWo5bGA562U5qGI6KaB5Yid5aeL5YyW5Li65pyA5bCP5YC85Lul6KaG55uW5YWo6LSf5qCR77yb5LiN6IO95oqK5bem5Y+z5Lik5L6n6YO96L+U5Zue57uZ54i26IqC54K544CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1heFBhdGhTdW0g55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgYW5zID0gLTEwMDE7CgogICAgcHVibGljIGludCBtYXhQYXRoU3VtKFRyZWVOb2RlIHJvb3QpIHsKICAgICAgICBkZnMocm9vdCk7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMX19OwogICAgfQoKICAgIHByaXZhdGUgaW50IGRmcyhUcmVlTm9kZSByb290KSB7CiAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KICAgICAgICBpbnQgbGVmdCA9IHt7YmxhbmtfM319OwogICAgICAgIGludCByaWdodCA9IHt7YmxhbmtfNH19OwogICAgICAgIGFucyA9IHt7YmxhbmtfNX19OwogICAgICAgIHJldHVybiByb290LnZhbCArIE1hdGgubWF4KGxlZnQsIHJpZ2h0KTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6InJvb3QgPT0gbnVsbCIsImJsYW5rXzMiOiJNYXRoLm1heCgwLCBkZnMocm9vdC5sZWZ0KSkiLCJibGFua180IjoiTWF0aC5tYXgoMCwgZGZzKHJvb3QucmlnaHQpKSIsImJsYW5rXzUiOiJNYXRoLm1heChhbnMsIHJvb3QudmFsICsgbGVmdCArIHJpZ2h0KSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljZXovrnotKHnjK4iLCLlhajlsYDot6/lvoTlkowiLCLotJ/otKHnjK7lvZLpm7YiLCLmoJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 124
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-51: #200 岛屿数量

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    200, 51, CONVERT(FROM_BASE64('5bKb5bG/5pWw6YeP') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq55SxIGAnMSdg77yI6ZmG5Zyw77yJ5ZKMIGAnMCdg77yI5rC077yJ57uE5oiQ55qE55qE5LqM57u0572R5qC877yM6K+35L2g6K6h566X572R5qC85Lit5bKb5bG/55qE5pWw6YeP44CCCgrlspvlsb/mgLvmmK/ooqvmsLTljIXlm7TvvIzlubbkuJTmr4/luqflspvlsb/lj6rog73nlLHmsLTlubPmlrnlkJHlkowv5oiW56uW55u05pa55ZCR5LiK55u46YK755qE6ZmG5Zyw6L+e5o6l5b2i5oiQ44CCCgrmraTlpJbvvIzkvaDlj6/ku6XlgYforr7or6XnvZHmoLznmoTlm5vmnaHovrnlnYfooqvmsLTljIXlm7TjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mmdyaWQgPSBbCsKgIFsnMScsJzEnLCcxJywnMScsJzAnXSwKwqAgWycxJywnMScsJzAnLCcxJywnMCddLArCoCBbJzEnLCcxJywnMCcsJzAnLCcwJ10sCsKgIFsnMCcsJzAnLCcwJywnMCcsJzAnXQpdCui+k+WHuu+8mjEKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpncmlkID0gWwrCoCBbJzEnLCcxJywnMCcsJzAnLCcwJ10sCsKgIFsnMScsJzEnLCcwJywnMCcsJzAnXSwKwqAgWycwJywnMCcsJzEnLCcwJywnMCddLArCoCBbJzAnLCcwJywnMCcsJzEnLCcxJ10KXQrovpPlh7rvvJozCmBgYCoq5o+Q56S677yaKiotIGBtID09IGdyaWQubGVuZ3RoYAotIGBuID09IGdyaWRbaV0ubGVuZ3RoYAotIGAxIDw9IG0sIG4gPD0gMzAwYAotIGBncmlkW2ldW2pdYCDnmoTlgLzkuLogYCcwJ2Ag5oiWIGAnMSdgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbnVtYmVyLW9mLWlzbGFuZHMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL251bWJlci1vZi1pc2xhbmRzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5omr5o+P572R5qC877yM6YGH5Yiw5pyq6K6/6Zeu6ZmG5Zyw5bCx5oqK5bKb5bG/5pWw5Yqg5LiA77yM5bm255SoIERGUy9CRlMg5re55rKh5pW05Liq6L+e6YCa5Z2X44CCIOacrOmimOWbtOe7leOAjOWym+Wxv+aVsOmHj+OAjeiQveWunui/meS4gOaooeWei++8muiiq+agh+iusOeahOmZhuWcsOW3sue7j+W9kuWxnuS6juafkOS4quW3suiuoeaVsOWym+Wxv++8jOS4jeS8muWGjeasoeinpuWPkeiuoeaVsOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6L+e6YCa5Z2X55qE5ZCr5LmJ77yM5YaN5qOA5p+l5re55rKh5qCH6K6w5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGksIGludCBqKSB7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBjaGFyW11bXSBncmlkOwogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CgogICAgcHVibGljIGludCBudW1Jc2xhbmRzKGNoYXJbXVtdIGdyaWQpIHsKICAgICAgICBtID0gZ3JpZC5sZW5ndGg7CiAgICAgICAgbiA9IGdyaWRbMF0ubGVuZ3RoOwogICAgICAgIHRoaXMuZ3JpZCA9IGdyaWQ7CiAgICAgICAgaW50IGFucyA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChncmlkW2ldW2pdID09ICcxJykgewogICAgICAgICAgICAgICAgICAgIGRmcyhpLCBqKTsKICAgICAgICAgICAgICAgICAgICArK2FuczsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGksIGludCBqKSB7CiAgICAgICAgZ3JpZFtpXVtqXSA9ICcwJzsKICAgICAgICBpbnRbXSBkaXJzID0gey0xLCAwLCAxLCAwLCAtMX07CiAgICAgICAgZm9yIChpbnQgayA9IDA7IGsgPCA0OyArK2spIHsKICAgICAgICAgICAgaW50IHggPSBpICsgZGlyc1trXTsKICAgICAgICAgICAgaW50IHkgPSBqICsgZGlyc1trICsgMV07CiAgICAgICAgICAgIGlmICh4ID49IDAgJiYgeCA8IG0gJiYgeSA+PSAwICYmIHkgPCBuICYmIGdyaWRbeF1beV0gPT0gJzEnKSB7CiAgICAgICAgICAgICAgICBkZnMoeCwgeSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm25p+l6ZuG') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm25p+l6ZuG') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6KKr5qCH6K6w55qE6ZmG5Zyw5bey57uP5b2S5bGe5LqO5p+Q5Liq5bey6K6h5pWw5bKb5bG/77yM5LiN5Lya5YaN5qyh6Kem5Y+R6K6h5pWw44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG51bUlzbGFuZHMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Y+q6LWw5LiK5LiL5bem5Y+z77yb5YWl6Zif5oiW6YCS5b2S5YmN56uL5Y2z5qCH6K6w77yM6YG/5YWN5ZCM5LiA5qC86YeN5aSN6L+b5YWl44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM5pyA5Z2P56m66Ze0IE8obW4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+q6LWw5LiK5LiL5bem5Y+z77yb5YWl6Zif5oiW6YCS5b2S5YmN56uL5Y2z5qCH6K6w77yM6YG/5YWN5ZCM5LiA5qC86YeN5aSN6L+b5YWl44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG51bUlzbGFuZHMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBjaGFyW11bXSBncmlkOwogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CgogICAgcHVibGljIGludCBudW1Jc2xhbmRzKGNoYXJbXVtdIGdyaWQpIHsKICAgICAgICBtID0gZ3JpZC5sZW5ndGg7CiAgICAgICAgbiA9IGdyaWRbMF0ubGVuZ3RoOwogICAgICAgIHRoaXMuZ3JpZCA9IGdyaWQ7CiAgICAgICAgaW50IGFucyA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgICAgIGRmcyhpLCBqKTsKICAgICAgICAgICAgICAgICAgICArK2FuczsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18yfX07CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIGRmcyhpbnQgaSwgaW50IGopIHsKICAgICAgICBncmlkW2ldW2pdID0gJzAnOwogICAgICAgIGludFtdIGRpcnMgPSB7LTEsIDAsIDEsIDAsIC0xfTsKICAgICAgICBmb3IgKGludCBrID0gMDsgayA8IDQ7ICsraykgewogICAgICAgICAgICBpbnQgeCA9IGkgKyBkaXJzW2tdOwogICAgICAgICAgICBpbnQgeSA9IGogKyBkaXJzW2sgKyAxXTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICBkZnMoeCwgeSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZ3JpZFtpXVtqXSA9PSAnMSciLCJibGFua18yIjoiYW5zIiwiYmxhbmtfMyI6InggPj0gMCAmJiB4IDwgbSAmJiB5ID49IDAgJiYgeSA8IG4gJiYgZ3JpZFt4XVt5XSA9PSAnMScifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLov57pgJrlnZciLCLmt7nmsqHmoIforrAiLCLlm5vmlrnlkJEiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiLCLlubbmn6Xpm4YiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 200
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-52: #994 腐烂的橘子

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    994, 52, CONVERT(FROM_BASE64('6IWQ54OC55qE5qmY5a2Q') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5Zyo57uZ5a6a55qEIGBtIHggbmAg572R5qC8IGBncmlkYCDkuK3vvIzmr4/kuKrljZXlhYPmoLzlj6/ku6XmnInku6XkuIvkuInkuKrlgLzkuYvkuIDvvJoKCi0g5YC8IGAwYCDku6PooajnqbrljZXlhYPmoLzvvJsKLSDlgLwgYDFgIOS7o+ihqOaWsOmynOapmOWtkO+8mwotIOWAvCBgMmAg5Luj6KGo6IWQ54OC55qE5qmY5a2Q44CCCgrmr4/liIbpkp/vvIzohZDng4LnmoTmqZjlrZAqKuWRqOWbtCA0IOS4quaWueWQkeS4iuebuOmCuyoq55qE5paw6bKc5qmY5a2Q6YO95Lya6IWQ54OC44CCCgrov5Tlm54gKuebtOWIsOWNleWFg+agvOS4reayoeacieaWsOmynOapmOWtkOS4uuatouaJgOW/hemhu+e7j+i/h+eahOacgOWwj+WIhumSn+aVsOOAguWmguaenOS4jeWPr+iDve+8jOi/lOWbniBgLTFgKiDjgIIqKuekuuS+iyAx77yaKioqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAxOS8wMi8xNi9vcmFuZ2VzLnBuZykqKmBgYHRleHQK6L6T5YWl77yaZ3JpZCA9IFtbMiwxLDFdLFsxLDEsMF0sWzAsMSwxXV0K6L6T5Ye677yaNApgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmdyaWQgPSBbWzIsMSwxXSxbMCwxLDFdLFsxLDAsMV1dCui+k+WHuu+8mi0xCuino+mHiu+8muW3puS4i+inkueahOapmOWtkO+8iOesrCAyIOihjO+8jCDnrKwgMCDliJfvvInmsLjov5zkuI3kvJrohZDng4LvvIzlm6DkuLrohZDng4Llj6rkvJrlj5HnlJ/lnKggNCDkuKrmlrnlkJHkuIrjgIIKYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpncmlkID0gW1swLDJdXQrovpPlh7rvvJowCuino+mHiu+8muWboOS4uiAwIOWIhumSn+aXtuW3sue7j+ayoeacieaWsOmynOapmOWtkOS6hu+8jOaJgOS7peetlOahiOWwseaYryAwIOOAggpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBncmlkLmxlbmd0aGAKLSBgbiA9PSBncmlkW2ldLmxlbmd0aGAKLSBgMSA8PSBtLCBuIDw9IDEwYAotIGBncmlkW2ldW2pdYCDku4XkuLogYDBg44CBYDFgIOaIliBgMmAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9yb3R0aW5nLW9yYW5nZXMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3JvdHRpbmctb3Jhbmdlcy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqK5omA5pyJ6IWQ54OC5qmY5a2Q5ZCM5pe25YWl6Zif5YGa5aSa5rqQIEJGU++8jOavj+aJqeWxleS4gOWxguS7o+ihqOS4gOWIhumSn++8jOW5tue7n+iuoeWJqeS9meaWsOmynOapmOWtkOOAgiDmnKzpopjlm7Tnu5XjgIzohZDng4LnmoTmqZjlrZDjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmr4/ova7pmJ/liJfkuK3nmoToioLngrnmmK/lkIzkuIDliIbpkp/lvIDlp4vohZDng4LnmoTmqZjlrZDvvIxmcmVzaCDmmK/lsJrmnKrohZDng4LmlbDph4/jgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5aSa5rqQQkZT55qE5ZCr5LmJ77yM5YaN5qOA5p+l5oyJ5bGC6K6h5pe25aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgYW5zID0gMTsgIXEuaXNFbXB0eSgpICYmIGNudCA+IDA7ICsrYW5zKSB7CiAgICAgICAgICAgIGZvciAoaW50IGsgPSBxLnNpemUoKTsgayA+IDA7IC0taykgewogICAgICAgICAgICAgICAgdmFyIHAgPSBxLnBvbGwoKTsKICAgICAgICAgICAgICAgIGZvciAoaW50IGQgPSAwOyBkIDwgNDsgKytkKSB7CiAgICAgICAgICAgICAgICAgICAgaW50IHggPSBwWzBdICsgZGlyc1tkXSwgeSA9IHBbMV0gKyBkaXJzW2QgKyAxXTsKICAgICAgICAgICAgICAgICAgICBpZiAoeCA+PSAwICYmIHggPCBtICYmIHkgPj0gMCAmJiB5IDwgbiAmJiBncmlkW3hdW3ldID09IDEpIHs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBvcmFuZ2VzUm90dGluZyhpbnRbXVtdIGdyaWQpIHsKICAgICAgICBpbnQgbSA9IGdyaWQubGVuZ3RoLCBuID0gZ3JpZFswXS5sZW5ndGg7CiAgICAgICAgRGVxdWU8aW50W10+IHEgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50IGNudCA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChncmlkW2ldW2pdID09IDEpIHsKICAgICAgICAgICAgICAgICAgICArK2NudDsKICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoZ3JpZFtpXVtqXSA9PSAyKSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihuZXcgaW50W10ge2ksIGp9KTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBmaW5hbCBpbnRbXSBkaXJzID0gey0xLCAwLCAxLCAwLCAtMX07CiAgICAgICAgZm9yIChpbnQgYW5zID0gMTsgIXEuaXNFbXB0eSgpICYmIGNudCA+IDA7ICsrYW5zKSB7CiAgICAgICAgICAgIGZvciAoaW50IGsgPSBxLnNpemUoKTsgayA+IDA7IC0taykgewogICAgICAgICAgICAgICAgdmFyIHAgPSBxLnBvbGwoKTsKICAgICAgICAgICAgICAgIGZvciAoaW50IGQgPSAwOyBkIDwgNDsgKytkKSB7CiAgICAgICAgICAgICAgICAgICAgaW50IHggPSBwWzBdICsgZGlyc1tkXSwgeSA9IHBbMV0gKyBkaXJzW2QgKyAxXTsKICAgICAgICAgICAgICAgICAgICBpZiAoeCA+PSAwICYmIHggPCBtICYmIHkgPj0gMCAmJiB5IDwgbiAmJiBncmlkW3hdW3ldID09IDEpIHsKICAgICAgICAgICAgICAgICAgICAgICAgZ3JpZFt4XVt5XSA9IDI7CiAgICAgICAgICAgICAgICAgICAgICAgIHEub2ZmZXIobmV3IGludFtdIHt4LCB5fSk7CiAgICAgICAgICAgICAgICAgICAgICAgIGlmICgtLWNudCA9PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gYW5zOwogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBjbnQgPiAwID8gLTEgOiAwOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4) WHERE p.leetcode_number = 994
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 994
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 994
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 994
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u6Zif5YiX5Lit55qE6IqC54K55piv5ZCM5LiA5YiG6ZKf5byA5aeL6IWQ54OC55qE5qmY5a2Q77yMZnJlc2gg5piv5bCa5pyq6IWQ54OC5pWw6YeP44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG9yYW5nZXNSb3R0aW5nIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5paw6bKc5qmY5a2Q5YWl6Zif5pe256uL5Y2z5pS55Li66IWQ54OC77yb5rKh5pyJ5paw6bKc5qmY5a2Q6L+U5ZueIDDvvIznu5PmnZ/lkI7ku43mnIkgZnJlc2gg6L+U5ZueIC0x44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM56m66Ze0IE8obW4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5paw6bKc5qmY5a2Q5YWl6Zif5pe256uL5Y2z5pS55Li66IWQ54OC77yb5rKh5pyJ5paw6bKc5qmY5a2Q6L+U5ZueIDDvvIznu5PmnZ/lkI7ku43mnIkgZnJlc2gg6L+U5ZueIC0x44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG9yYW5nZXNSb3R0aW5nIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBvcmFuZ2VzUm90dGluZyhpbnRbXVtdIGdyaWQpIHsKICAgICAgICBpbnQgbSA9IGdyaWQubGVuZ3RoLCBuID0gZ3JpZFswXS5sZW5ndGg7CiAgICAgICAgRGVxdWU8aW50W10+IHEgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50IGNudCA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgICAgICsrY250OwogICAgICAgICAgICAgICAgfSBlbHNlIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgICAgIHEub2ZmZXIobmV3IGludFtdIHtpLCBqfSk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgZmluYWwgaW50W10gZGlycyA9IHstMSwgMCwgMSwgMCwgLTF9OwogICAgICAgIGZvciAoaW50IGFucyA9IDE7ICFxLmlzRW1wdHkoKSAmJiBjbnQgPiAwOyArK2FucykgewogICAgICAgICAgICBmb3IgKGludCBrID0ge3tibGFua18zfX07IGsgPiAwOyAtLWspIHsKICAgICAgICAgICAgICAgIHZhciBwID0ge3tibGFua180fX07CiAgICAgICAgICAgICAgICBmb3IgKGludCBkID0gMDsgZCA8IDQ7ICsrZCkgewogICAgICAgICAgICAgICAgICAgIGludCB4ID0ge3tibGFua181fX07CiAgICAgICAgICAgICAgICAgICAgaWYgKHggPj0gMCAmJiB4IDwgbSAmJiB5ID49IDAgJiYgeSA8IG4gJiYgZ3JpZFt4XVt5XSA9PSAxKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGdyaWRbeF1beV0gPSAyOwogICAgICAgICAgICAgICAgICAgICAgICBxLm9mZmVyKG5ldyBpbnRbXSB7eCwgeX0pOwogICAgICAgICAgICAgICAgICAgICAgICBpZiAoLS1jbnQgPT0gMCkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGFuczsKICAgICAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gY250ID4gMCA/IC0xIDogMDsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZ3JpZFtpXVtqXSA9PSAxIiwiYmxhbmtfMiI6ImdyaWRbaV1bal0gPT0gMiIsImJsYW5rXzMiOiJxLnNpemUoKSIsImJsYW5rXzQiOiJxLnBvbGwoKSIsImJsYW5rXzUiOiJwWzBdICsgZGlyc1tkXSwgeSA9IHBbMV0gKyBkaXJzW2QgKyAxXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlpJrmupBCRlMiLCLmjInlsYLorqHml7YiLCJmcmVzaOiuoeaVsCIsIuW5v+W6puS8mOWFiOaQnOe0oiIsIuaVsOe7hCIsIuefqemYtSJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 994
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-53: #207 课程表

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    207, 53, CONVERT(FROM_BASE64('6K++56iL6KGo') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5L2g6L+Z5Liq5a2m5pyf5b+F6aG76YCJ5L+uIGBudW1Db3Vyc2VzYCDpl6jor77nqIvvvIzorrDkuLogYDBgIOWIsCBgbnVtQ291cnNlcyAtIDFgIOOAggoK5Zyo6YCJ5L+u5p+Q5Lqb6K++56iL5LmL5YmN6ZyA6KaB5LiA5Lqb5YWI5L+u6K++56iL44CCIOWFiOS/ruivvueoi+aMieaVsOe7hCBgcHJlcmVxdWlzaXRlc2Ag57uZ5Ye677yM5YW25LitIGBwcmVyZXF1aXNpdGVzW2ldID0gW2FpLCBiaV1gIO+8jOihqOekuuWmguaenOimgeWtpuS5oOivvueoiyBgYWlgIOWImSoq5b+F6aG7KirlhYjlrabkuaDor77nqIsgIGBiaWA8c3ViPjwvc3ViPuOAggoKLSDkvovlpoLvvIzlhYjkv67or77nqIvlr7kgYFswLCAxXWAg6KGo56S677ya5oOz6KaB5a2m5Lmg6K++56iLIGAwYCDvvIzkvaDpnIDopoHlhYjlrozmiJDor77nqIsgYDFgIOOAggoK6K+35L2g5Yik5pat5piv5ZCm5Y+v6IO95a6M5oiQ5omA5pyJ6K++56iL55qE5a2m5Lmg77yf5aaC5p6c5Y+v5Lul77yM6L+U5ZueIGB0cnVlYCDvvJvlkKbliJnvvIzov5Tlm54gYGZhbHNlYCDjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bUNvdXJzZXMgPSAyLCBwcmVyZXF1aXNpdGVzID0gW1sxLDBdXQrovpPlh7rvvJp0cnVlCuino+mHiu+8muaAu+WFseaciSAyIOmXqOivvueoi+OAguWtpuS5oOivvueoiyAxIOS5i+WJje+8jOS9oOmcgOimgeWujOaIkOivvueoiyAwIOOAgui/meaYr+WPr+iDveeahOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bUNvdXJzZXMgPSAyLCBwcmVyZXF1aXNpdGVzID0gW1sxLDBdLFswLDFdXQrovpPlh7rvvJpmYWxzZQrop6Pph4rvvJrmgLvlhbHmnIkgMiDpl6jor77nqIvjgILlrabkuaDor77nqIsgMSDkuYvliY3vvIzkvaDpnIDopoHlhYjlrozmiJDigIvor77nqIsgMCDvvJvlubbkuJTlrabkuaDor77nqIsgMCDkuYvliY3vvIzkvaDov5jlupTlhYjlrozmiJDor77nqIsgMSDjgILov5nmmK/kuI3lj6/og73nmoTjgIIKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtQ291cnNlcyA8PSAyMDAwYAotIGAwIDw9IHByZXJlcXVpc2l0ZXMubGVuZ3RoIDw9IDUwMDBgCi0gYHByZXJlcXVpc2l0ZXNbaV0ubGVuZ3RoID09IDJgCi0gYDAgPD0gYWksIGJpIDwgbnVtQ291cnNlc2AKLSBgcHJlcmVxdWlzaXRlc1tpXWAg5Lit55qE5omA5pyJ6K++56iL5a+5KirkupLkuI3nm7jlkIwqKgoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2NvdXJzZS1zY2hlZHVsZS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvY291cnNlLXNjaGVkdWxlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5bu656uL6K++56iL5L6d6LWW5Zu+5ZKM5YWl5bqm77yM5YWI5bCG5YWl5bqmIDAg55qE6K++56iL5YWl6Zif77yb6YCQ5Liq56e76Zmk5bm26ZmN5L2O5ZCO57un5YWl5bqm44CCIOacrOmimOWbtOe7leOAjOivvueoi+ihqOOAjeiQveWunui/meS4gOaooeWei++8muWFpeW6puihqOekuuWwmuacquWujOaIkOeahOWFiOS/ruivvueoi+aVsO+8jOWHuumYn+iKgueCueaehOaIkOS4gOS4quWQiOazleaLk+aJkeWJjee8gOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ouT5omR5o6S5bqP55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YWl5bqm5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIHdoaWxlICghcS5pc0VtcHR5KCkpIHsKICAgICAgICAgICAgaW50IGkgPSBxLnBvbGwoKTsKICAgICAgICAgICAgLS1udW1Db3Vyc2VzOwogICAgICAgICAgICBmb3IgKGludCBqIDogZ1tpXSkgewogICAgICAgICAgICAgICAgaWYgKC0taW5kZWdbal0gPT0gMCkgew==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuRmluaXNoKGludCBudW1Db3Vyc2VzLCBpbnRbXVtdIHByZXJlcXVpc2l0ZXMpIHsKICAgICAgICBMaXN0PEludGVnZXI+W10gZyA9IG5ldyBMaXN0W251bUNvdXJzZXNdOwogICAgICAgIEFycmF5cy5zZXRBbGwoZywgayAtPiBuZXcgQXJyYXlMaXN0PD4oKSk7CiAgICAgICAgaW50W10gaW5kZWcgPSBuZXcgaW50W251bUNvdXJzZXNdOwogICAgICAgIGZvciAodmFyIHAgOiBwcmVyZXF1aXNpdGVzKSB7CiAgICAgICAgICAgIGludCBhID0gcFswXSwgYiA9IHBbMV07CiAgICAgICAgICAgIGdbYl0uYWRkKGEpOwogICAgICAgICAgICArK2luZGVnW2FdOwogICAgICAgIH0KICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbnVtQ291cnNlczsgKytpKSB7CiAgICAgICAgICAgIGlmIChpbmRlZ1tpXSA9PSAwKSB7CiAgICAgICAgICAgICAgICBxLm9mZmVyKGkpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHdoaWxlICghcS5pc0VtcHR5KCkpIHsKICAgICAgICAgICAgaW50IGkgPSBxLnBvbGwoKTsKICAgICAgICAgICAgLS1udW1Db3Vyc2VzOwogICAgICAgICAgICBmb3IgKGludCBqIDogZ1tpXSkgewogICAgICAgICAgICAgICAgaWYgKC0taW5kZWdbal0gPT0gMCkgewogICAgICAgICAgICAgICAgICAgIHEub2ZmZXIoaik7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIG51bUNvdXJzZXMgPT0gMDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4) WHERE p.leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zu+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zu+') USING utf8mb4) WHERE p.leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ouT5omR5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ouT5omR5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWl5bqm6KGo56S65bCa5pyq5a6M5oiQ55qE5YWI5L+u6K++56iL5pWw77yM5Ye66Zif6IqC54K55p6E5oiQ5LiA5Liq5ZCI5rOV5ouT5omR5YmN57yA44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNhbkZpbmlzaCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('6L655pa55ZCR6KaB5LuOIHByZXJlcXVpc2l0ZSDmjIflkJEgY291cnNl77yb5pyA57uI5aSE55CG5pWw562J5LqO6K++56iL5oC75pWw5omN5peg546v44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8oVitFKe+8jOepuumXtCBPKFYrRSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L655pa55ZCR6KaB5LuOIHByZXJlcXVpc2l0ZSDmjIflkJEgY291cnNl77yb5pyA57uI5aSE55CG5pWw562J5LqO6K++56iL5oC75pWw5omN5peg546v44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNhbkZpbmlzaCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuRmluaXNoKGludCBudW1Db3Vyc2VzLCBpbnRbXVtdIHByZXJlcXVpc2l0ZXMpIHsKICAgICAgICBMaXN0PEludGVnZXI+W10gZyA9IG5ldyBMaXN0W251bUNvdXJzZXNdOwogICAgICAgIEFycmF5cy5zZXRBbGwoZywgayAtPiBuZXcgQXJyYXlMaXN0PD4oKSk7CiAgICAgICAgaW50W10gaW5kZWcgPSBuZXcgaW50W251bUNvdXJzZXNdOwogICAgICAgIGZvciAodmFyIHAgOiBwcmVyZXF1aXNpdGVzKSB7CiAgICAgICAgICAgIGludCBhID0ge3tibGFua18xfX07CiAgICAgICAgICAgIGdbYl0uYWRkKGEpOwogICAgICAgICAgICArK2luZGVnW2FdOwogICAgICAgIH0KICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbnVtQ291cnNlczsgKytpKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgcS5vZmZlcihpKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICB3aGlsZSAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgaW50IGkgPSB7e2JsYW5rXzR9fTsKICAgICAgICAgICAgLS1udW1Db3Vyc2VzOwogICAgICAgICAgICBmb3IgKGludCBqIDogZ1tpXSkgewogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfNX19KSB7CiAgICAgICAgICAgICAgICAgICAgcS5vZmZlcihqKTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbnVtQ291cnNlcyA9PSAwOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicFswXSwgYiA9IHBbMV0iLCJibGFua18yIjoiaW5kZWdbaV0gPT0gMCIsImJsYW5rXzMiOiIhcS5pc0VtcHR5KCkiLCJibGFua180IjoicS5wb2xsKCkiLCJibGFua181IjoiLS1pbmRlZ1tqXSA9PSAwIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmi5PmiZHmjpLluo8iLCLlhaXluqYiLCLnjq/mo4DmtYsiLCLmt7HluqbkvJjlhYjmkJzntKIiLCLlub/luqbkvJjlhYjmkJzntKIiLCLlm74iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 207
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-54: #208 实现 Trie (前缀树)

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    208, 54, CONVERT(FROM_BASE64('5a6e546wIFRyaWUgKOWJjee8gOagkSk=') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('KipbVHJpZV0oaHR0cHM6Ly9iYWlrZS5iYWlkdS5jb20vaXRlbS/lrZflhbjmoJEvOTgyNTIwOT9mcj1hbGFkZGluKSoq77yI5Y+R6Z+z57G75Ly8ICJ0cnki77yJ5oiW6ICF6K+0KirliY3nvIDmoJEqKuaYr+S4gOenjeagkeW9ouaVsOaNrue7k+aehO+8jOeUqOS6jumrmOaViOWcsOWtmOWCqOWSjOajgOe0ouWtl+espuS4suaVsOaNrumbhuS4reeahOmUruOAgui/meS4gOaVsOaNrue7k+aehOacieebuOW9k+WkmueahOW6lOeUqOaDheaZr++8jOS+i+WmguiHquWKqOihpeWFqOWSjOaLvOWGmeajgOafpeOAggoK6K+35L2g5a6e546wIFRyaWUg57G777yaCgotIGBUcmllKClgIOWIneWni+WMluWJjee8gOagkeWvueixoeOAggotIGB2b2lkIGluc2VydChTdHJpbmcgd29yZClgIOWQkeWJjee8gOagkeS4reaPkuWFpeWtl+espuS4siBgd29yZGAg44CCCi0gYGJvb2xlYW4gc2VhcmNoKFN0cmluZyB3b3JkKWAg5aaC5p6c5a2X56ym5LiyIGB3b3JkYCDlnKjliY3nvIDmoJHkuK3vvIzov5Tlm54gYHRydWVg77yI5Y2z77yM5Zyo5qOA57Si5LmL5YmN5bey57uP5o+S5YWl77yJ77yb5ZCm5YiZ77yM6L+U5ZueIGBmYWxzZWAg44CCCi0gYGJvb2xlYW4gc3RhcnRzV2l0aChTdHJpbmcgcHJlZml4KWAg5aaC5p6c5LmL5YmN5bey57uP5o+S5YWl55qE5a2X56ym5LiyIGB3b3JkYCDnmoTliY3nvIDkuYvkuIDkuLogYHByZWZpeGAg77yM6L+U5ZueIGB0cnVlYCDvvJvlkKbliJnvvIzov5Tlm54gYGZhbHNlYCDjgIIqKuekuuS+i++8mioqYGBgdGV4dArovpPlhaUKWyJUcmllIiwgImluc2VydCIsICJzZWFyY2giLCAic2VhcmNoIiwgInN0YXJ0c1dpdGgiLCAiaW5zZXJ0IiwgInNlYXJjaCJdCltbXSwgWyJhcHBsZSJdLCBbImFwcGxlIl0sIFsiYXBwIl0sIFsiYXBwIl0sIFsiYXBwIl0sIFsiYXBwIl1dCui+k+WHugpbbnVsbCwgbnVsbCwgdHJ1ZSwgZmFsc2UsIHRydWUsIG51bGwsIHRydWVdCgrop6Pph4oKVHJpZSB0cmllID0gbmV3IFRyaWUoKTsKdHJpZS5pbnNlcnQoImFwcGxlIik7CnRyaWUuc2VhcmNoKCJhcHBsZSIpOyAgIC8vIOi/lOWbniBUcnVlCnRyaWUuc2VhcmNoKCJhcHAiKTsgICAgIC8vIOi/lOWbniBGYWxzZQp0cmllLnN0YXJ0c1dpdGgoImFwcCIpOyAvLyDov5Tlm54gVHJ1ZQp0cmllLmluc2VydCgiYXBwIik7CnRyaWUuc2VhcmNoKCJhcHAiKTsgICAgIC8vIOi/lOWbniBUcnVlCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IHdvcmQubGVuZ3RoLCBwcmVmaXgubGVuZ3RoIDw9IDIwMDBgCi0gYHdvcmRgIOWSjCBgcHJlZml4YCDku4XnlLHlsI/lhpnoi7HmloflrZfmr43nu4TmiJAKLSBgaW5zZXJ0YOOAgWBzZWFyY2hgIOWSjCBgc3RhcnRzV2l0aGAg6LCD55So5qyh5pWwKirmgLvorqEqKuS4jei2hei/hyBgMyAqIDEwNGAg5qyhCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvaW1wbGVtZW50LXRyaWUtcHJlZml4LXRyZWUvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2ltcGxlbWVudC10cmllLXByZWZpeC10cmVlLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('VHJpZSDmr4/kuKroioLngrnkv53lrZjlrZfnrKblrZDoioLngrnlkowgaXNFbmTvvJvmj5LlhaXmsr/lrZfnrKbot6/lvoTliJvlu7rvvIzmn6Xor6Lmsr/ot6/lvoTotbDlubbmo4Dmn6Xnu4jmraLmoIforrDjgIIg5pys6aKY5Zu057uV44CM5a6e546wIFRyaWUgKOWJjee8gOagkSnjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrotbDliLDnrKwgaSDkuKrlrZfnrKblkI7vvIzlvZPliY3oioLngrnku6PooajliY3nvIAgd29yZFswLi5pXeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFVHJpZeiKgueCueeahOWQq+S5ie+8jOWGjeajgOafpeWtl+espui3r+W+hOWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBUcmllIHNlYXJjaFByZWZpeChTdHJpbmcgcykgewogICAgICAgIFRyaWUgbm9kZSA9IHRoaXM7CiAgICAgICAgZm9yIChjaGFyIGMgOiBzLnRvQ2hhckFycmF5KCkpIHsKICAgICAgICAgICAgaW50IGlkeCA9IGMgLSAnYSc7CiAgICAgICAgICAgIGlmIChub2RlLmNoaWxkcmVuW2lkeF0gPT0gbnVsbCkgewogICAgICAgICAgICAgICAgcmV0dXJuIG51bGw7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgVHJpZSB7CiAgICBwcml2YXRlIFRyaWVbXSBjaGlsZHJlbjsKICAgIHByaXZhdGUgYm9vbGVhbiBpc0VuZDsKCiAgICBwdWJsaWMgVHJpZSgpIHsKICAgICAgICBjaGlsZHJlbiA9IG5ldyBUcmllWzI2XTsKICAgIH0KCiAgICBwdWJsaWMgdm9pZCBpbnNlcnQoU3RyaW5nIHdvcmQpIHsKICAgICAgICBUcmllIG5vZGUgPSB0aGlzOwogICAgICAgIGZvciAoY2hhciBjIDogd29yZC50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGludCBpZHggPSBjIC0gJ2EnOwogICAgICAgICAgICBpZiAobm9kZS5jaGlsZHJlbltpZHhdID09IG51bGwpIHsKICAgICAgICAgICAgICAgIG5vZGUuY2hpbGRyZW5baWR4XSA9IG5ldyBUcmllKCk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgbm9kZSA9IG5vZGUuY2hpbGRyZW5baWR4XTsKICAgICAgICB9CiAgICAgICAgbm9kZS5pc0VuZCA9IHRydWU7CiAgICB9CgogICAgcHVibGljIGJvb2xlYW4gc2VhcmNoKFN0cmluZyB3b3JkKSB7CiAgICAgICAgVHJpZSBub2RlID0gc2VhcmNoUHJlZml4KHdvcmQpOwogICAgICAgIHJldHVybiBub2RlICE9IG51bGwgJiYgbm9kZS5pc0VuZDsKICAgIH0KCiAgICBwdWJsaWMgYm9vbGVhbiBzdGFydHNXaXRoKFN0cmluZyBwcmVmaXgpIHsKICAgICAgICBUcmllIG5vZGUgPSBzZWFyY2hQcmVmaXgocHJlZml4KTsKICAgICAgICByZXR1cm4gbm9kZSAhPSBudWxsOwogICAgfQoKICAgIHByaXZhdGUgVHJpZSBzZWFyY2hQcmVmaXgoU3RyaW5nIHMpIHsKICAgICAgICBUcmllIG5vZGUgPSB0aGlzOwogICAgICAgIGZvciAoY2hhciBjIDogcy50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGludCBpZHggPSBjIC0gJ2EnOwogICAgICAgICAgICBpZiAobm9kZS5jaGlsZHJlbltpZHhdID09IG51bGwpIHsKICAgICAgICAgICAgICAgIHJldHVybiBudWxsOwogICAgICAgICAgICB9CiAgICAgICAgICAgIG5vZGUgPSBub2RlLmNoaWxkcmVuW2lkeF07CiAgICAgICAgfQogICAgICAgIHJldHVybiBub2RlOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zu+6K66') USING utf8mb4) WHERE p.leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4) WHERE p.leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X5YW45qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X5YW45qCR') USING utf8mb4) WHERE p.leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6LWw5Yiw56ysIGkg5Liq5a2X56ym5ZCO77yM5b2T5YmN6IqC54K55Luj6KGo5YmN57yAIHdvcmRbMC4uaV3jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIFRyaWUg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('c2VhcmNoIOW/hemhu+ajgOafpSBpc0VuZO+8jHN0YXJ0c1dpdGgg5LiN6ZyA6KaB77yb5Y+q5Zyo57y65bCR5a2Q6IqC54K55pe25Yib5bu644CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5qyh5pON5L2c5pe26Ze0IE8oTCnvvIznqbrpl7TkuLrmiYDmnInmj5LlhaXlrZfnrKbmgLvmlbDjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('c2VhcmNoIOW/hemhu+ajgOafpSBpc0VuZO+8jHN0YXJ0c1dpdGgg5LiN6ZyA6KaB77yb5Y+q5Zyo57y65bCR5a2Q6IqC54K55pe25Yib5bu644CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIFRyaWUg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgVHJpZSB7CiAgICBwcml2YXRlIFRyaWVbXSBjaGlsZHJlbjsKICAgIHByaXZhdGUgYm9vbGVhbiBpc0VuZDsKCiAgICBwdWJsaWMgVHJpZSgpIHsKICAgICAgICBjaGlsZHJlbiA9IG5ldyBUcmllWzI2XTsKICAgIH0KCiAgICBwdWJsaWMgdm9pZCBpbnNlcnQoU3RyaW5nIHdvcmQpIHsKICAgICAgICBUcmllIG5vZGUgPSB0aGlzOwogICAgICAgIGZvciAoY2hhciBjIDogd29yZC50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGludCBpZHggPSBjIC0gJ2EnOwogICAgICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIG5vZGUuY2hpbGRyZW5baWR4XSA9IG5ldyBUcmllKCk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgbm9kZSA9IHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICBub2RlLmlzRW5kID0gdHJ1ZTsKICAgIH0KCiAgICBwdWJsaWMgYm9vbGVhbiBzZWFyY2goU3RyaW5nIHdvcmQpIHsKICAgICAgICBUcmllIG5vZGUgPSB7e2JsYW5rXzN9fTsKICAgICAgICByZXR1cm4gbm9kZSAhPSBudWxsICYmIG5vZGUuaXNFbmQ7CiAgICB9CgogICAgcHVibGljIGJvb2xlYW4gc3RhcnRzV2l0aChTdHJpbmcgcHJlZml4KSB7CiAgICAgICAgVHJpZSBub2RlID0ge3tibGFua180fX07CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQoKICAgIHByaXZhdGUgVHJpZSBzZWFyY2hQcmVmaXgoU3RyaW5nIHMpIHsKICAgICAgICBUcmllIG5vZGUgPSB0aGlzOwogICAgICAgIGZvciAoY2hhciBjIDogcy50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGludCBpZHggPSBjIC0gJ2EnOwogICAgICAgICAgICBpZiAobm9kZS5jaGlsZHJlbltpZHhdID09IG51bGwpIHsKICAgICAgICAgICAgICAgIHJldHVybiBudWxsOwogICAgICAgICAgICB9CiAgICAgICAgICAgIG5vZGUgPSBub2RlLmNoaWxkcmVuW2lkeF07CiAgICAgICAgfQogICAgICAgIHJldHVybiBub2RlOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibm9kZS5jaGlsZHJlbltpZHhdID09IG51bGwiLCJibGFua18yIjoibm9kZS5jaGlsZHJlbltpZHhdIiwiYmxhbmtfMyI6InNlYXJjaFByZWZpeCh3b3JkKSIsImJsYW5rXzQiOiJzZWFyY2hQcmVmaXgocHJlZml4KSIsImJsYW5rXzUiOiJub2RlICE9IG51bGwifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJUcmll6IqC54K5Iiwi5a2X56ym6Lev5b6EIiwiaXNFbmQiLCLorr7orqEiLCLlrZflhbjmoJEiLCLlk4jluIzooagiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 208
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-55: #46 全排列

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    46, 55, CONVERT(FROM_BASE64('5YWo5o6S5YiX') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LiN5ZCr6YeN5aSN5pWw5a2X55qE5pWw57uEIGBudW1zYCDvvIzov5Tlm57lhbYgKuaJgOacieWPr+iDveeahOWFqOaOkuWIlyog44CC5L2g5Y+v5LulKirmjInku7vmhI/pobrluo8qKui/lOWbnuetlOahiOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDIsM10K6L6T5Ye677yaW1sxLDIsM10sWzEsMywyXSxbMiwxLDNdLFsyLDMsMV0sWzMsMSwyXSxbMywyLDFdXQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMCwxXQrovpPlh7rvvJpbWzAsMV0sWzEsMF1dCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxXQrovpPlh7rvvJpbWzFdXQpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBudW1zLmxlbmd0aCA8PSA2YAotIGAtMTAgPD0gbnVtc1tpXSA8PSAxMGAKLSBgbnVtc2Ag5Lit55qE5omA5pyJ5pW05pWwKirkupLkuI3nm7jlkIwqKgoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3Blcm11dGF0aW9ucy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcGVybXV0YXRpb25zLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5Zue5rqv5oyJ5L2N572u6YCJ5oup5bCa5pyq5L2/55So55qE5pWw5a2X77yM55SoIHVzZWQg5qCH6K6w77yM6Lev5b6E6ZW/5bqm562J5LqOIG4g5pe25pS26ZuG562U5qGI44CCIOacrOmimOWbtOe7leOAjOWFqOaOkuWIl+OAjeiQveWunui/meS4gOaooeWei++8mnBhdGgg5Lit5YWD57Sg5LqS5LiN6YeN5aSN77yMdXNlZCDnsr7noa7lr7nlupTlt7Lnu4/liqDlhaUgcGF0aCDnmoTkuIvmoIfjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFdXNlZOaVsOe7hOeahOWQq+S5ie+8jOWGjeajgOafpei3r+W+hOWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('aWYgKGkgPT0gbnVtcy5sZW5ndGgpIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0PD4odCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbnVtcy5sZW5ndGg7ICsraikgewogICAgICAgICAgICBpZiAoIXZpc1tqXSkgew==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgYm9vbGVhbltdIHZpczsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBwZXJtdXRlKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSBudW1zOwogICAgICAgIHZpcyA9IG5ldyBib29sZWFuW251bXMubGVuZ3RoXTsKICAgICAgICBkZnMoMCk7CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KCiAgICBwcml2YXRlIHZvaWQgZGZzKGludCBpKSB7CiAgICAgICAgaWYgKGkgPT0gbnVtcy5sZW5ndGgpIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0PD4odCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbnVtcy5sZW5ndGg7ICsraikgewogICAgICAgICAgICBpZiAoIXZpc1tqXSkgewogICAgICAgICAgICAgICAgdmlzW2pdID0gdHJ1ZTsKICAgICAgICAgICAgICAgIHQuYWRkKG51bXNbal0pOwogICAgICAgICAgICAgICAgZGZzKGkgKyAxKTsKICAgICAgICAgICAgICAgIHQucmVtb3ZlKHQuc2l6ZSgpIC0gMSk7CiAgICAgICAgICAgICAgICB2aXNbal0gPSBmYWxzZTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 46
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 46
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('cGF0aCDkuK3lhYPntKDkupLkuI3ph43lpI3vvIx1c2VkIOeyvuehruWvueW6lOW3sue7j+WKoOWFpSBwYXRoIOeahOS4i+agh+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHBlcm11dGUg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2S6L+U5Zue5ZCO5b+F6aG75ZCM5pe256e76Zmk6Lev5b6E5pyr5bC+5bm25oGi5aSNIHVzZWTvvJvmlLbpm4bml7blpI3liLYgcGF0aOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obsK3biEp77yM6YCS5b2S5ZKM54q25oCB56m66Ze0IE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6YCS5b2S6L+U5Zue5ZCO5b+F6aG75ZCM5pe256e76Zmk6Lev5b6E5pyr5bC+5bm25oGi5aSNIHVzZWTvvJvmlLbpm4bml7blpI3liLYgcGF0aOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHBlcm11dGUg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgYm9vbGVhbltdIHZpczsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBwZXJtdXRlKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSBudW1zOwogICAgICAgIHZpcyA9IG5ldyBib29sZWFuW251bXMubGVuZ3RoXTsKICAgICAgICBkZnMoMCk7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMX19OwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGkpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0PD4odCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbnVtcy5sZW5ndGg7ICsraikgewogICAgICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgICAgIHZpc1tqXSA9IHRydWU7CiAgICAgICAgICAgICAgICB0LmFkZChudW1zW2pdKTsKICAgICAgICAgICAgICAgIGRmcyhpICsgMSk7CiAgICAgICAgICAgICAgICB0LnJlbW92ZSh0LnNpemUoKSAtIDEpOwogICAgICAgICAgICAgICAgdmlzW2pdID0gZmFsc2U7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6ImkgPT0gbnVtcy5sZW5ndGgiLCJibGFua18zIjoiIXZpc1tqXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJ1c2Vk5pWw57uEIiwi6Lev5b6EIiwi5o6S5YiX5qCRIiwi5pWw57uEIiwi5Zue5rqvIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 46
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-56: #78 子集

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    78, 56, CONVERT(FROM_BASE64('5a2Q6ZuG') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzmlbDnu4TkuK3nmoTlhYPntKAqKuS6kuS4jeebuOWQjCoq44CC6L+U5Zue6K+l5pWw57uE5omA5pyJ5Y+v6IO955qE5a2Q6ZuG77yI5bmC6ZuG77yJ44CCCgrop6Ppm4YqKuS4jeiDvSoq5YyF5ZCr6YeN5aSN55qE5a2Q6ZuG44CC5L2g5Y+v5Lul5oyJKirku7vmhI/pobrluo8qKui/lOWbnuino+mbhuOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDIsM10K6L6T5Ye677yaW1tdLFsxXSxbMl0sWzEsMl0sWzNdLFsxLDNdLFsyLDNdLFsxLDIsM11dCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFswXQrovpPlh7rvvJpbW10sWzBdXQpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBudW1zLmxlbmd0aCA8PSAxMGAKLSBgLTEwIDw9IG51bXNbaV0gPD0gMTBgCi0gYG51bXNgIOS4reeahOaJgOacieWFg+e0oCoq5LqS5LiN55u45ZCMKioKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9zdWJzZXRzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9zdWJzZXRzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5a+55q+P5Liq5LiL5qCH5YGa6YCJ5oiW5LiN6YCJ77yM5oiW55SoIHN0YXJ0IOaOp+WItuS4i+S4gOWAmemAie+8m+avj+S4qumAkuW9kuiKgueCuemDveS7o+ihqOS4gOS4quWtkOmbhuW5tuWKoOWFpeetlOahiOOAgiDmnKzpopjlm7Tnu5XjgIzlrZDpm4bjgI3okL3lrp7ov5nkuIDmqKHlnovvvJpwYXRoIOaYr+S7jiBbMCxzdGFydCkg5Lit6YCJ5Ye655qE5b2T5YmN5a2Q6ZuG77yM5ZCO57ut5Y+q6YCJ5oup5pu05aSn5LiL5qCH44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFc3RhcnTkuIvmoIfnmoTlkKvkuYnvvIzlho3mo4Dmn6Xmr4/lsYLmlLbpm4blpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSB2b2lkIGRmcyhpbnQgaSkgewogICAgICAgIGlmIChpID09IG51bXMubGVuZ3RoKSB7CiAgICAgICAgICAgIGFucy5hZGQobmV3IEFycmF5TGlzdDw+KHQpKTsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBzdWJzZXRzKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSBudW1zOwogICAgICAgIGRmcygwKTsKICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGkpIHsKICAgICAgICBpZiAoaSA9PSBudW1zLmxlbmd0aCkgewogICAgICAgICAgICBhbnMuYWRkKG5ldyBBcnJheUxpc3Q8Pih0KSk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgZGZzKGkgKyAxKTsKICAgICAgICB0LmFkZChudW1zW2ldKTsKICAgICAgICBkZnMoaSArIDEpOwogICAgICAgIHQucmVtb3ZlKHQuc2l6ZSgpIC0gMSk7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 78
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4) WHERE p.leetcode_number = 78
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 78
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('cGF0aCDmmK/ku44gWzAsc3RhcnQpIOS4remAieWHuueahOW9k+WJjeWtkOmbhu+8jOWQjue7reWPqumAieaLqeabtOWkp+S4i+agh+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHN1YnNldHMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('562U5qGI6KaB5Zyo5q+P5bGC5pS26ZuG6ICM6Z2e5Y+q5Zyo5Y+25a2Q77yb5Zue5rqv5ZCO56e76Zmk5Yia5Yqg5YWl5YWD57Sg44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5YWxIDJebiDkuKrlrZDpm4bvvIzml7bpl7QgTyhuwrcyXm4p77yM56m66Ze0IE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('562U5qGI6KaB5Zyo5q+P5bGC5pS26ZuG6ICM6Z2e5Y+q5Zyo5Y+25a2Q77yb5Zue5rqv5ZCO56e76Zmk5Yia5Yqg5YWl5YWD57Sg44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHN1YnNldHMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBzdWJzZXRzKGludFtdIG51bXMpIHsKICAgICAgICB0aGlzLm51bXMgPSB7e2JsYW5rXzF9fTsKICAgICAgICBkZnMoMCk7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGkpIHsKICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0PD4odCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGRmcyhpICsgMSk7CiAgICAgICAgdC5hZGQobnVtc1tpXSk7CiAgICAgICAgZGZzKGkgKyAxKTsKICAgICAgICB0LnJlbW92ZSh0LnNpemUoKSAtIDEpOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtcyIsImJsYW5rXzIiOiJhbnMiLCJibGFua18zIjoiaSA9PSBudW1zLmxlbmd0aCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJzdGFydOS4i+aghyIsIuavj+WxguaUtumbhiIsIuWbnua6ryIsIuS9jei/kOeulyIsIuaVsOe7hCJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 78
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-57: #17 电话号码的字母组合

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    17, 57, CONVERT(FROM_BASE64('55S16K+d5Y+356CB55qE5a2X5q+N57uE5ZCI') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5LuF5YyF5ZCr5pWw5a2XIGAyLTlgIOeahOWtl+espuS4su+8jOi/lOWbnuaJgOacieWug+iDveihqOekuueahOWtl+avjee7hOWQiOOAguetlOahiOWPr+S7peaMiSoq5Lu75oSP6aG65bqPKirov5Tlm57jgIIKCue7meWHuuaVsOWtl+WIsOWtl+avjeeahOaYoOWwhOWmguS4i++8iOS4jueUteivneaMiemUruebuOWQjO+8ieOAguazqOaEjyAxIOS4jeWvueW6lOS7u+S9leWtl+avjeOAggoKIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vcGljLmxlZXRjb2RlLmNuLzE3NTI3MjMwNTQtbWZJSFpzLWltYWdlLnBuZykqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mmRpZ2l0cyA9ICIyMyIK6L6T5Ye677yaWyJhZCIsImFlIiwiYWYiLCJiZCIsImJlIiwiYmYiLCJjZCIsImNlIiwiY2YiXQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmRpZ2l0cyA9ICIyIgrovpPlh7rvvJpbImEiLCJiIiwiYyJdCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IGRpZ2l0cy5sZW5ndGggPD0gNGAKLSBgZGlnaXRzW2ldYCDmmK/ojIPlm7QgYFsnMicsICc5J11gIOeahOS4gOS4quaVsOWtl+OAggoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2xldHRlci1jb21iaW5hdGlvbnMtb2YtYS1waG9uZS1udW1iZXIvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2xldHRlci1jb21iaW5hdGlvbnMtb2YtYS1waG9uZS1udW1iZXIvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuO5Y+q5ZCr56m65Liy55qE57uT5p6c5byA5aeL77yM6YCQ5Liq5pWw5a2X5YGa56yb5Y2h5bCU56ev77ya57uZ5bey5pyJ5q+P5Liq5YmN57yA6L+95Yqg6K+l5pWw5a2X55qE5q+P5Liq5YCZ6YCJ5a2X5q+N44CCIOacrOmimOWbtOe7leOAjOeUteivneWPt+eggeeahOWtl+avjee7hOWQiOOAjeiQveWunui/meS4gOaooeWei++8muWkhOeQhuWujOWJjSBpIOS4quaVsOWtl+WQju+8jOWIl+ihqOaBsOWlveWMheWQq+Wug+S7rOiDveW9ouaIkOeahOWFqOmDqOe7hOWQiOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6YCQ5L2N5omp5bGV55qE5ZCr5LmJ77yM5YaN5qOA5p+l56yb5Y2h5bCU56ev5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('U3RyaW5nIHMgPSBkW2kgLSAnMiddOwogICAgICAgICAgICBMaXN0PFN0cmluZz4gdCA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgICAgICAgICBmb3IgKFN0cmluZyBhIDogYW5zKSB7CiAgICAgICAgICAgICAgICBmb3IgKFN0cmluZyBiIDogcy5zcGxpdCgiIikpIHsKICAgICAgICAgICAgICAgICAgICB0LmFkZChhICsgYik7CiAgICAgICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8U3RyaW5nPiBsZXR0ZXJDb21iaW5hdGlvbnMoU3RyaW5nIGRpZ2l0cykgewogICAgICAgIExpc3Q8U3RyaW5nPiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAoZGlnaXRzLmxlbmd0aCgpID09IDApIHsKICAgICAgICAgICAgcmV0dXJuIGFuczsKICAgICAgICB9CiAgICAgICAgYW5zLmFkZCgiIik7CiAgICAgICAgU3RyaW5nW10gZCA9IG5ldyBTdHJpbmdbXSB7ImFiYyIsICJkZWYiLCAiZ2hpIiwgImprbCIsICJtbm8iLCAicHFycyIsICJ0dXYiLCAid3h5eiJ9OwogICAgICAgIGZvciAoY2hhciBpIDogZGlnaXRzLnRvQ2hhckFycmF5KCkpIHsKICAgICAgICAgICAgU3RyaW5nIHMgPSBkW2kgLSAnMiddOwogICAgICAgICAgICBMaXN0PFN0cmluZz4gdCA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgICAgICAgICBmb3IgKFN0cmluZyBhIDogYW5zKSB7CiAgICAgICAgICAgICAgICBmb3IgKFN0cmluZyBiIDogcy5zcGxpdCgiIikpIHsKICAgICAgICAgICAgICAgICAgICB0LmFkZChhICsgYik7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgYW5zID0gdDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 17
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 17
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 17
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5a6M5YmNIGkg5Liq5pWw5a2X5ZCO77yM5YiX6KGo5oGw5aW95YyF5ZCr5a6D5Lus6IO95b2i5oiQ55qE5YWo6YOo57uE5ZCI44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxldHRlckNvbWJpbmF0aW9ucyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('56m6IGRpZ2l0cyDlv4Xpobvov5Tlm57nqbrliJfooajvvJvmlbDlrZcgMiDlr7nlupTmmKDlsITmlbDnu4TkuIvmoIcgMOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05LiO6L6T5Ye66KeE5qihIE8oNF5uwrduKSDlkIzpmLbvvIznu5PmnpzlpJbovoXliqnnqbrpl7TkuI7kuK3pl7Tnu4TlkIjmlbDlkIzpmLbjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('56m6IGRpZ2l0cyDlv4Xpobvov5Tlm57nqbrliJfooajvvJvmlbDlrZcgMiDlr7nlupTmmKDlsITmlbDnu4TkuIvmoIcgMOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxldHRlckNvbWJpbmF0aW9ucyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8U3RyaW5nPiBsZXR0ZXJDb21iaW5hdGlvbnMoU3RyaW5nIGRpZ2l0cykgewogICAgICAgIExpc3Q8U3RyaW5nPiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfMn19OwogICAgICAgIH0KICAgICAgICBhbnMuYWRkKCIiKTsKICAgICAgICBTdHJpbmdbXSBkID0gbmV3IFN0cmluZ1tdIHsiYWJjIiwgImRlZiIsICJnaGkiLCAiamtsIiwgIm1ubyIsICJwcXJzIiwgInR1diIsICJ3eHl6In07CiAgICAgICAgZm9yIChjaGFyIGkgOiBkaWdpdHMudG9DaGFyQXJyYXkoKSkgewogICAgICAgICAgICBTdHJpbmcgcyA9IHt7YmxhbmtfM319OwogICAgICAgICAgICBMaXN0PFN0cmluZz4gdCA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgICAgICAgICBmb3IgKFN0cmluZyBhIDogYW5zKSB7CiAgICAgICAgICAgICAgICBmb3IgKFN0cmluZyBiIDogcy5zcGxpdCgiIikpIHsKICAgICAgICAgICAgICAgICAgICB0LmFkZChhICsgYik7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgYW5zID0gdDsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGlnaXRzLmxlbmd0aCgpID09IDAiLCJibGFua18yIjoiYW5zIiwiYmxhbmtfMyI6ImRbaSAtICcyJ10ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpgJDkvY3mianlsZUiLCLnrJvljaHlsJTnp68iLCLmlbDlrZfmmKDlsIQiLCLlk4jluIzooagiLCLlrZfnrKbkuLIiLCLlm57muq8iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 17
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-58: #39 组合总和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    39, 58, CONVERT(FROM_BASE64('57uE5ZCI5oC75ZKM') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5LiqKirml6Dph43lpI3lhYPntKAqKueahOaVtOaVsOaVsOe7hCBgY2FuZGlkYXRlc2Ag5ZKM5LiA5Liq55uu5qCH5pW05pWwIGB0YXJnZXRgIO+8jOaJvuWHuiBgY2FuZGlkYXRlc2Ag5Lit5Y+v5Lul5L2/5pWw5a2X5ZKM5Li655uu5qCH5pWwIGB0YXJnZXRgIOeahCDmiYDmnIkqKioq5LiN5ZCM57uE5ZCIKirvvIzlubbku6XliJfooajlvaLlvI/ov5Tlm57jgILkvaDlj6/ku6XmjIkqKuS7u+aEj+mhuuW6jyoq6L+U5Zue6L+Z5Lqb57uE5ZCI44CCCgpgY2FuZGlkYXRlc2Ag5Lit55qEKirlkIzkuIDkuKoqKuaVsOWtl+WPr+S7pSoq5peg6ZmQ5Yi26YeN5aSN6KKr6YCJ5Y+WKirjgILlpoLmnpzoh7PlsJHkuIDkuKrmlbDlrZfnmoTooqvpgInmlbDph4/kuI3lkIzvvIzliJnkuKTnp43nu4TlkIjmmK/kuI3lkIznmoTjgIIKCuWvueS6jue7meWumueahOi+k+WFpe+8jOS/neivgeWSjOS4uiBgdGFyZ2V0YCDnmoTkuI3lkIznu4TlkIjmlbDlsJHkuo4gYDE1MGAg5Liq44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpjYW5kaWRhdGVzID0gWzIsMyw2LDddLCB0YXJnZXQgPSA3Cui+k+WHuu+8mltbMiwyLDNdLFs3XV0K6Kej6YeK77yaCjIg5ZKMIDMg5Y+v5Lul5b2i5oiQ5LiA57uE5YCZ6YCJ77yMMiArIDIgKyAzID0gNyDjgILms6jmhI8gMiDlj6/ku6Xkvb/nlKjlpJrmrKHjgIIKNyDkuZ/mmK/kuIDkuKrlgJnpgInvvIwgNyA9IDcg44CCCuS7heaciei/meS4pOenjee7hOWQiOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpTogY2FuZGlkYXRlcyA9IFsyLDMsNV0sIHRhcmdldCA9IDgK6L6T5Ye6OiBbWzIsMiwyLDJdLFsyLDMsM10sWzMsNV1dCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWlOiBjYW5kaWRhdGVzID0gWzJdLCB0YXJnZXQgPSAxCui+k+WHujogW10KYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gY2FuZGlkYXRlcy5sZW5ndGggPD0gMzBgCi0gYDIgPD0gY2FuZGlkYXRlc1tpXSA8PSA0MGAKLSBgY2FuZGlkYXRlc2Ag55qE5omA5pyJ5YWD57SgKirkupLkuI3nm7jlkIwqKi0gYDEgPD0gdGFyZ2V0IDw9IDQwYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2NvbWJpbmF0aW9uLXN1bS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvY29tYmluYXRpb24tc3VtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI5o6S5bqP5YCZ6YCJ77yM5LuOIHN0YXJ0IOi1t+aemuS4vu+8m+WFgeiuuOmHjeWkjemAieaLqeW9k+WJjeaVsO+8jOWJqeS9meWSjOS4uiAwIOaXtuaUtumbhu+8jOi2heWHuuaXtuWJquaeneOAgiDmnKzpopjlm7Tnu5XjgIznu4TlkIjmgLvlkozjgI3okL3lrp7ov5nkuIDmqKHlnovvvJpwYXRoIOWPquWQq+S4i+agh+S4jeS4i+mZjeeahOWAmemAie+8jOaXouWFgeiuuOWkjeeUqOWPiOS4jeS8mueUn+aIkOS4jeWQjOmhuuW6j+eahOmHjeWkjee7hOWQiOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF57uE5ZCI5Zue5rqv55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y+v6YeN5aSN6YCJ5oup5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cmV0dXJuOwogICAgICAgIH0KICAgICAgICBpZiAocyA8IGNhbmRpZGF0ZXNbaV0pIHsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBmb3IgKGludCBqID0gaTsgaiA8IGNhbmRpZGF0ZXMubGVuZ3RoOyArK2opIHs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgaW50W10gY2FuZGlkYXRlczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBjb21iaW5hdGlvblN1bShpbnRbXSBjYW5kaWRhdGVzLCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgQXJyYXlzLnNvcnQoY2FuZGlkYXRlcyk7CiAgICAgICAgdGhpcy5jYW5kaWRhdGVzID0gY2FuZGlkYXRlczsKICAgICAgICBkZnMoMCwgdGFyZ2V0KTsKICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGksIGludCBzKSB7CiAgICAgICAgaWYgKHMgPT0gMCkgewogICAgICAgICAgICBhbnMuYWRkKG5ldyBBcnJheUxpc3QodCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGlmIChzIDwgY2FuZGlkYXRlc1tpXSkgewogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSBpOyBqIDwgY2FuZGlkYXRlcy5sZW5ndGg7ICsraikgewogICAgICAgICAgICB0LmFkZChjYW5kaWRhdGVzW2pdKTsKICAgICAgICAgICAgZGZzKGosIHMgLSBjYW5kaWRhdGVzW2pdKTsKICAgICAgICAgICAgdC5yZW1vdmUodC5zaXplKCkgLSAxKTsKICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 39
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 39
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('cGF0aCDlj6rlkKvkuIvmoIfkuI3kuIvpmY3nmoTlgJnpgInvvIzml6LlhYHorrjlpI3nlKjlj4jkuI3kvJrnlJ/miJDkuI3lkIzpobrluo/nmoTph43lpI3nu4TlkIjjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNvbWJpbmF0aW9uU3VtIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2S5b2T5YmN5pWw5pe25LiL5LiA5bGC5LuN5LygIGnvvJvlm57muq/mgaLlpI3ot6/lvoTvvIzlgJnpgInlpKfkuo7liankvZnlkozlj6/lgZzmraLjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze05Li65oyH5pWw57qn5bm25LiO562U5qGI5pWw5pyJ5YWz77yM6YCS5b2S56m66Ze0IE8odGFyZ2V0L21pbinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6YCS5b2S5b2T5YmN5pWw5pe25LiL5LiA5bGC5LuN5LygIGnvvJvlm57muq/mgaLlpI3ot6/lvoTvvIzlgJnpgInlpKfkuo7liankvZnlkozlj6/lgZzmraLjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNvbWJpbmF0aW9uU3VtIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8SW50ZWdlcj4+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgcHJpdmF0ZSBMaXN0PEludGVnZXI+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgIHByaXZhdGUgaW50W10gY2FuZGlkYXRlczsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PEludGVnZXI+PiBjb21iaW5hdGlvblN1bShpbnRbXSBjYW5kaWRhdGVzLCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgQXJyYXlzLnNvcnQoY2FuZGlkYXRlcyk7CiAgICAgICAgdGhpcy5jYW5kaWRhdGVzID0gY2FuZGlkYXRlczsKICAgICAgICBkZnMoMCwgdGFyZ2V0KTsKICAgICAgICByZXR1cm4ge3tibGFua18xfX07CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIGRmcyhpbnQgaSwgaW50IHMpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0KHQpKTsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBmb3IgKGludCBqID0gaTsgaiA8IGNhbmRpZGF0ZXMubGVuZ3RoOyArK2opIHsKICAgICAgICAgICAgdC5hZGQoY2FuZGlkYXRlc1tqXSk7CiAgICAgICAgICAgIGRmcyhqLCBzIC0gY2FuZGlkYXRlc1tqXSk7CiAgICAgICAgICAgIHQucmVtb3ZlKHQuc2l6ZSgpIC0gMSk7CiAgICAgICAgfQogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6InMgPT0gMCIsImJsYW5rXzMiOiJzIDwgY2FuZGlkYXRlc1tpXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnu4TlkIjlm57muq8iLCLlj6/ph43lpI3pgInmi6kiLCLliankvZnlkowiLCLmlbDnu4QiLCLlm57muq8iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 39
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-59: #22 括号生成

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    22, 59, CONVERT(FROM_BASE64('5ous5Y+355Sf5oiQ') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5pWw5a2XIGBuYCDku6PooajnlJ/miJDmi6zlj7fnmoTlr7nmlbDvvIzor7fkvaDorr7orqHkuIDkuKrlh73mlbDvvIznlKjkuo7og73lpJ/nlJ/miJDmiYDmnInlj6/og73nmoTlubbkuJQqKuacieaViOeahCoq5ous5Y+357uE5ZCI44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpuID0gMwrovpPlh7rvvJpbIigoKCkpKSIsIigoKSgpKSIsIigoKSkoKSIsIigpKCgpKSIsIigpKCkoKSJdCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabiA9IDEK6L6T5Ye677yaWyIoKSJdCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG4gPD0gOGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9nZW5lcmF0ZS1wYXJlbnRoZXNlcy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZ2VuZXJhdGUtcGFyZW50aGVzZXMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5Zue5rqv57u05oqk5bey5pS+5bem5ous5Y+35pWwIG9wZW4g5ZKM5Y+z5ous5Y+35pWwIGNsb3Nl77yab3BlbjxuIOWPr+aUvuW3pu+8jGNsb3NlPG9wZW4g5omN6IO95pS+5Y+z44CCIOacrOmimOWbtOe7leOAjOaLrOWPt+eUn+aIkOOAjeiQveWunui/meS4gOaooeWei++8muS7u+aEj+WJjee8gOmDveaciSBjbG9zZTw9b3Blbu+8jOS4lOS4pOenjeaLrOWPt+aVsOmDveS4jei2hei/hyBu44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ZCI5rOV5YmN57yA55qE5ZCr5LmJ77yM5YaN5qOA5p+l5bem5Y+z6K6h5pWw5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSB2b2lkIGRmcyhpbnQgbCwgaW50IHIsIFN0cmluZyB0KSB7CiAgICAgICAgaWYgKGwgPiBuIHx8IHIgPiBuIHx8IGwgPCByKSB7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgaWYgKGwgPT0gbiAmJiByID09IG4pIHsKICAgICAgICAgICAgYW5zLmFkZCh0KTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PFN0cmluZz4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIGludCBuOwoKICAgIHB1YmxpYyBMaXN0PFN0cmluZz4gZ2VuZXJhdGVQYXJlbnRoZXNpcyhpbnQgbikgewogICAgICAgIHRoaXMubiA9IG47CiAgICAgICAgZGZzKDAsIDAsICIiKTsKICAgICAgICByZXR1cm4gYW5zOwogICAgfQoKICAgIHByaXZhdGUgdm9pZCBkZnMoaW50IGwsIGludCByLCBTdHJpbmcgdCkgewogICAgICAgIGlmIChsID4gbiB8fCByID4gbiB8fCBsIDwgcikgewogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQogICAgICAgIGlmIChsID09IG4gJiYgciA9PSBuKSB7CiAgICAgICAgICAgIGFucy5hZGQodCk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgZGZzKGwgKyAxLCByLCB0ICsgIigiKTsKICAgICAgICBkZnMobCwgciArIDEsIHQgKyAiKSIpOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 22
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 22
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 22
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Lu75oSP5YmN57yA6YO95pyJIGNsb3NlPD1vcGVu77yM5LiU5Lik56eN5ous5Y+35pWw6YO95LiN6LaF6L+HIG7jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGdlbmVyYXRlUGFyZW50aGVzaXMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pS26ZuG5p2h5Lu25piv5a2X56ym5Liy6ZW/5bqmIDJu77yb5Y+z5ous5Y+35p2h5Lu25LiN6IO95YaZ5oiQIGNsb3NlPG7jgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('Q2F0YWxhbiDop4TmqKHvvIzml7bpl7QgTyhDbsK3binvvIzpgJLlvZLnqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5pS26ZuG5p2h5Lu25piv5a2X56ym5Liy6ZW/5bqmIDJu77yb5Y+z5ous5Y+35p2h5Lu25LiN6IO95YaZ5oiQIGNsb3NlPG7jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGdlbmVyYXRlUGFyZW50aGVzaXMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PFN0cmluZz4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIGludCBuOwoKICAgIHB1YmxpYyBMaXN0PFN0cmluZz4gZ2VuZXJhdGVQYXJlbnRoZXNpcyhpbnQgbikgewogICAgICAgIHRoaXMubiA9IG47CiAgICAgICAgZGZzKDAsIDAsICIiKTsKICAgICAgICByZXR1cm4ge3tibGFua18xfX07CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIGRmcyhpbnQgbCwgaW50IHIsIFN0cmluZyB0KSB7CiAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgIGFucy5hZGQodCk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgZGZzKGwgKyAxLCByLCB0ICsgIigiKTsKICAgICAgICBkZnMobCwgciArIDEsIHQgKyAiKSIpOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6ImwgPiBuIHx8IHIgPiBuIHx8IGwgPCByIiwiYmxhbmtfMyI6ImwgPT0gbiAmJiByID09IG4ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlkIjms5XliY3nvIAiLCLlt6blj7PorqHmlbAiLCJDYXRhbGFuIiwi5a2X56ym5LiyIiwi5Yqo5oCB6KeE5YiSIiwi5Zue5rqvIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 22
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-60: #79 单词搜索

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    79, 60, CONVERT(FROM_BASE64('5Y2V6K+N5pCc57Si') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5LiqIGBtIHggbmAg5LqM57u05a2X56ym572R5qC8IGBib2FyZGAg5ZKM5LiA5Liq5a2X56ym5Liy5Y2V6K+NIGB3b3JkYCDjgILlpoLmnpwgYHdvcmRgIOWtmOWcqOS6jue9keagvOS4re+8jOi/lOWbniBgdHJ1ZWAg77yb5ZCm5YiZ77yM6L+U5ZueIGBmYWxzZWAg44CCCgrljZXor43lv4XpobvmjInnhaflrZfmr43pobrluo/vvIzpgJrov4fnm7jpgrvnmoTljZXlhYPmoLzlhoXnmoTlrZfmr43mnoTmiJDvvIzlhbbkuK3igJznm7jpgrvigJ3ljZXlhYPmoLzmmK/pgqPkupvmsLTlubPnm7jpgrvmiJblnoLnm7Tnm7jpgrvnmoTljZXlhYPmoLzjgILlkIzkuIDkuKrljZXlhYPmoLzlhoXnmoTlrZfmr43kuI3lhYHorrjooqvph43lpI3kvb/nlKjjgIIqKuekuuS+iyAx77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8xMS8wNC93b3JkMi5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmJvYXJkID0gW1snQScsJ0InLCdDJywnRSddLFsnUycsJ0YnLCdDJywnUyddLFsnQScsJ0QnLCdFJywnRSddXSwgd29yZCA9ICJBQkNDRUQiCui+k+WHuu+8mnRydWUKYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTEvMDQvd29yZC0xLmpwZykKCmBgYHRleHQK6L6T5YWl77yaYm9hcmQgPSBbWydBJywnQicsJ0MnLCdFJ10sWydTJywnRicsJ0MnLCdTJ10sWydBJywnRCcsJ0UnLCdFJ11dLCB3b3JkID0gIlNFRSIK6L6T5Ye677yadHJ1ZQpgYGAqKuekuuS+iyAz77yaKiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMC8xMC8xNS93b3JkMy5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmJvYXJkID0gW1snQScsJ0InLCdDJywnRSddLFsnUycsJ0YnLCdDJywnUyddLFsnQScsJ0QnLCdFJywnRSddXSwgd29yZCA9ICJBQkNCIgrovpPlh7rvvJpmYWxzZQpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBib2FyZC5sZW5ndGhgCi0gYG4gPSBib2FyZFtpXS5sZW5ndGhgCi0gYDEgPD0gbSwgbiA8PSA2YAotIGAxIDw9IHdvcmQubGVuZ3RoIDw9IDE1YAotIGBib2FyZGAg5ZKMIGB3b3JkYCDku4XnlLHlpKflsI/lhpnoi7HmloflrZfmr43nu4TmiJAqKui/m+mYtu+8mioq5L2g5Y+v5Lul5L2/55So5pCc57Si5Ymq5p6d55qE5oqA5pyv5p2l5LyY5YyW6Kej5Yaz5pa55qGI77yM5L2/5YW25ZyoIGBib2FyZGAg5pu05aSn55qE5oOF5Ya15LiL5Y+v5Lul5pu05b+r6Kej5Yaz6Zeu6aKY77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvd29yZC1zZWFyY2gvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3dvcmQtc2VhcmNoLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuO5q+P5Liq5qC85a2Q5bCd6K+VIERGUyDljLnphY0gd29yZFtpbmRleF3vvIzkuLTml7bmoIforrDlvZPliY3moLzlkI7mjqLntKLlm5vpgrvvvIzlpLHotKXlho3mgaLlpI3jgIIg5pys6aKY5Zu057uV44CM5Y2V6K+N5pCc57Si44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6L+b5YWlIGRmcyhyLGMsaSkg5pe277yM6Lev5b6E5YmNIGkg5Liq5a2X56ym5bey5Yy56YWN5LiU5b2T5YmN6Lev5b6E5peg6YeN5aSN5qC844CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6Lev5b6E5Yy56YWN55qE5ZCr5LmJ77yM5YaN5qOA5p+l6K6/6Zeu5qCH6K6w5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSBib29sZWFuIGRmcyhpbnQgaSwgaW50IGosIGludCBrKSB7CiAgICAgICAgaWYgKGsgPT0gd29yZC5sZW5ndGgoKSAtIDEpIHsKICAgICAgICAgICAgcmV0dXJuIGJvYXJkW2ldW2pdID09IHdvcmQuY2hhckF0KGspOwogICAgICAgIH0KICAgICAgICBpZiAoYm9hcmRbaV1bal0gIT0gd29yZC5jaGFyQXQoaykpIHsKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CiAgICBwcml2YXRlIFN0cmluZyB3b3JkOwogICAgcHJpdmF0ZSBjaGFyW11bXSBib2FyZDsKCiAgICBwdWJsaWMgYm9vbGVhbiBleGlzdChjaGFyW11bXSBib2FyZCwgU3RyaW5nIHdvcmQpIHsKICAgICAgICBtID0gYm9hcmQubGVuZ3RoOwogICAgICAgIG4gPSBib2FyZFswXS5sZW5ndGg7CiAgICAgICAgdGhpcy53b3JkID0gd29yZDsKICAgICAgICB0aGlzLmJvYXJkID0gYm9hcmQ7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChkZnMoaSwgaiwgMCkpIHsKICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gZmFsc2U7CiAgICB9CgogICAgcHJpdmF0ZSBib29sZWFuIGRmcyhpbnQgaSwgaW50IGosIGludCBrKSB7CiAgICAgICAgaWYgKGsgPT0gd29yZC5sZW5ndGgoKSAtIDEpIHsKICAgICAgICAgICAgcmV0dXJuIGJvYXJkW2ldW2pdID09IHdvcmQuY2hhckF0KGspOwogICAgICAgIH0KICAgICAgICBpZiAoYm9hcmRbaV1bal0gIT0gd29yZC5jaGFyQXQoaykpIHsKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgIH0KICAgICAgICBjaGFyIGMgPSBib2FyZFtpXVtqXTsKICAgICAgICBib2FyZFtpXVtqXSA9ICcwJzsKICAgICAgICBpbnRbXSBkaXJzID0gey0xLCAwLCAxLCAwLCAtMX07CiAgICAgICAgZm9yIChpbnQgdSA9IDA7IHUgPCA0OyArK3UpIHsKICAgICAgICAgICAgaW50IHggPSBpICsgZGlyc1t1XSwgeSA9IGogKyBkaXJzW3UgKyAxXTsKICAgICAgICAgICAgaWYgKHggPj0gMCAmJiB4IDwgbSAmJiB5ID49IDAgJiYgeSA8IG4gJiYgYm9hcmRbeF1beV0gIT0gJzAnICYmIGRmcyh4LCB5LCBrICsgMSkpIHsKICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGJvYXJkW2ldW2pdID0gYzsKICAgICAgICByZXR1cm4gZmFsc2U7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5rex5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6L+b5YWlIGRmcyhyLGMsaSkg5pe277yM6Lev5b6E5YmNIGkg5Liq5a2X56ym5bey5Yy56YWN5LiU5b2T5YmN6Lev5b6E5peg6YeN5aSN5qC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGV4aXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5Yy56YWN5oiQ5Yqf5bqU5LyY5YWI6L+U5Zue77yb6K6/6Zeu5qCH6K6w5b+F6aG75Zue5rqv5oGi5aSN77yM6L6555WM5ZKM5a2X56ym5LiN562J56uL5Y2z5aSx6LSl44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5Z2P5pe26Ze0IE8obW7CtzReTCnvvIzpgJLlvZLnqbrpl7QgTyhMKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Yy56YWN5oiQ5Yqf5bqU5LyY5YWI6L+U5Zue77yb6K6/6Zeu5qCH6K6w5b+F6aG75Zue5rqv5oGi5aSN77yM6L6555WM5ZKM5a2X56ym5LiN562J56uL5Y2z5aSx6LSl44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGV4aXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CiAgICBwcml2YXRlIFN0cmluZyB3b3JkOwogICAgcHJpdmF0ZSBjaGFyW11bXSBib2FyZDsKCiAgICBwdWJsaWMgYm9vbGVhbiBleGlzdChjaGFyW11bXSBib2FyZCwgU3RyaW5nIHdvcmQpIHsKICAgICAgICBtID0gYm9hcmQubGVuZ3RoOwogICAgICAgIG4gPSBib2FyZFswXS5sZW5ndGg7CiAgICAgICAgdGhpcy53b3JkID0gd29yZDsKICAgICAgICB0aGlzLmJvYXJkID0gYm9hcmQ7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9CgogICAgcHJpdmF0ZSBib29sZWFuIGRmcyhpbnQgaSwgaW50IGosIGludCBrKSB7CiAgICAgICAgaWYgKHt7YmxhbmtfNH19KSB7CiAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzV9fTsKICAgICAgICB9CiAgICAgICAgaWYgKGJvYXJkW2ldW2pdICE9IHdvcmQuY2hhckF0KGspKSB7CiAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICB9CiAgICAgICAgY2hhciBjID0gYm9hcmRbaV1bal07CiAgICAgICAgYm9hcmRbaV1bal0gPSAnMCc7CiAgICAgICAgaW50W10gZGlycyA9IHstMSwgMCwgMSwgMCwgLTF9OwogICAgICAgIGZvciAoaW50IHUgPSAwOyB1IDwgNDsgKyt1KSB7CiAgICAgICAgICAgIGludCB4ID0gaSArIGRpcnNbdV0sIHkgPSBqICsgZGlyc1t1ICsgMV07CiAgICAgICAgICAgIGlmICh4ID49IDAgJiYgeCA8IG0gJiYgeSA+PSAwICYmIHkgPCBuICYmIGJvYXJkW3hdW3ldICE9ICcwJyAmJiBkZnMoeCwgeSwgayArIDEpKSB7CiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICBib2FyZFtpXVtqXSA9IGM7CiAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKGksIGosIDApIiwiYmxhbmtfMiI6InRydWUiLCJibGFua18zIjoiZmFsc2UiLCJibGFua180IjoiayA9PSB3b3JkLmxlbmd0aCgpIC0gMSIsImJsYW5rXzUiOiJib2FyZFtpXVtqXSA9PSB3b3JkLmNoYXJBdChrKSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLot6/lvoTljLnphY0iLCLorr/pl67moIforrAiLCLlm5vmlrnlkJHlm57muq8iLCLmt7HluqbkvJjlhYjmkJzntKIiLCLmlbDnu4QiLCLlrZfnrKbkuLIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 79
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-61: #131 分割回文串

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    131, 61, CONVERT(FROM_BASE64('5YiG5Ymy5Zue5paH5Liy') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5a2X56ym5LiyIGBzYO+8jOivt+S9oOWwhioqYHNgKirliIblibLmiJDkuIDkupsg5a2Q5Liy77yM5L2/5q+P5Liq5a2Q5Liy6YO95pivKirlm57mlofkuLIqKuOAgui/lOWbniBgc2Ag5omA5pyJ5Y+v6IO955qE5YiG5Ymy5pa55qGI44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpzID0gImFhYiIK6L6T5Ye677yaW1siYSIsImEiLCJiIl0sWyJhYSIsImIiXV0KYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpzID0gImEiCui+k+WHuu+8mltbImEiXV0KYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gcy5sZW5ndGggPD0gMTZgCi0gYHNgIOS7heeUseWwj+WGmeiLseaWh+Wtl+avjee7hOaIkAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3BhbGluZHJvbWUtcGFydGl0aW9uaW5nLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9wYWxpbmRyb21lLXBhcnRpdGlvbmluZy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuOIHN0YXJ0IOaemuS4vue7k+adn+S9jee9ru+8jOWPquacieW9k+WJjeWtkOS4suS4uuWbnuaWh+aJjeWKoOWFpei3r+W+hOW5tumAkuW9kuWkhOeQhuWQjue8gOOAgiDmnKzpopjlm7Tnu5XjgIzliIblibLlm57mlofkuLLjgI3okL3lrp7ov5nkuIDmqKHlnovvvJpwYXRoIOS4reavj+S4gOautemDveaYr+WbnuaWh++8jOS4lOaBsOWlveaLvOaOpeaIkCBzWzAuLnN0YXJ0KeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Zue5paH5YiH5YiG55qE5ZCr5LmJ77yM5YaN5qOA5p+lc3RhcnTkvY3nva7lpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('cHJpdmF0ZSB2b2lkIGRmcyhpbnQgaSkgewogICAgICAgIGlmIChpID09IHMubGVuZ3RoKCkpIHsKICAgICAgICAgICAgYW5zLmFkZChuZXcgQXJyYXlMaXN0PD4odCkpOwogICAgICAgICAgICByZXR1cm47CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbjsKICAgIHByaXZhdGUgU3RyaW5nIHM7CiAgICBwcml2YXRlIGJvb2xlYW5bXVtdIGY7CiAgICBwcml2YXRlIExpc3Q8U3RyaW5nPiB0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIExpc3Q8TGlzdDxTdHJpbmc+PiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PFN0cmluZz4+IHBhcnRpdGlvbihTdHJpbmcgcykgewogICAgICAgIG4gPSBzLmxlbmd0aCgpOwogICAgICAgIGYgPSBuZXcgYm9vbGVhbltuXVtuXTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBBcnJheXMuZmlsbChmW2ldLCB0cnVlKTsKICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IG4gLSAxOyBpID49IDA7IC0taSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gaSArIDE7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGZbaV1bal0gPSBzLmNoYXJBdChpKSA9PSBzLmNoYXJBdChqKSAmJiBmW2kgKyAxXVtqIC0gMV07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgdGhpcy5zID0gczsKICAgICAgICBkZnMoMCk7CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KCiAgICBwcml2YXRlIHZvaWQgZGZzKGludCBpKSB7CiAgICAgICAgaWYgKGkgPT0gcy5sZW5ndGgoKSkgewogICAgICAgICAgICBhbnMuYWRkKG5ldyBBcnJheUxpc3Q8Pih0KSk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaiA9IGk7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgaWYgKGZbaV1bal0pIHsKICAgICAgICAgICAgICAgIHQuYWRkKHMuc3Vic3RyaW5nKGksIGogKyAxKSk7CiAgICAgICAgICAgICAgICBkZnMoaiArIDEpOwogICAgICAgICAgICAgICAgdC5yZW1vdmUodC5zaXplKCkgLSAxKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 131
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 131
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 131
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('cGF0aCDkuK3mr4/kuIDmrrXpg73mmK/lm57mlofvvIzkuJTmgbDlpb3mi7zmjqXmiJAgc1swLi5zdGFydCnjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHBhcnRpdGlvbiDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('c3Vic3RyaW5nIOWPs+err+aYr+W8gOWMuumXtO+8m+aUtumbhuaXtuWkjeWItui3r+W+hO+8jOWPr+mihOWkhOeQhuWbnuaWh+ihqOWHj+WwkemHjeWkjeWIpOaWreOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5Z2P5pe26Ze0IE8obsK3Ml5uKe+8jOepuumXtCBPKG7CsinvvIjlkKvlm57mlofpooTlpITnkIbvvInjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('c3Vic3RyaW5nIOWPs+err+aYr+W8gOWMuumXtO+8m+aUtumbhuaXtuWkjeWItui3r+W+hO+8jOWPr+mihOWkhOeQhuWbnuaWh+ihqOWHj+WwkemHjeWkjeWIpOaWreOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHBhcnRpdGlvbiDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbjsKICAgIHByaXZhdGUgU3RyaW5nIHM7CiAgICBwcml2YXRlIGJvb2xlYW5bXVtdIGY7CiAgICBwcml2YXRlIExpc3Q8U3RyaW5nPiB0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIExpc3Q8TGlzdDxTdHJpbmc+PiBhbnMgPSBuZXcgQXJyYXlMaXN0PD4oKTsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PFN0cmluZz4+IHBhcnRpdGlvbihTdHJpbmcgcykgewogICAgICAgIG4gPSB7e2JsYW5rXzF9fTsKICAgICAgICBmID0gbmV3IGJvb2xlYW5bbl1bbl07CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgQXJyYXlzLmZpbGwoZltpXSwgdHJ1ZSk7CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSBuIC0gMTsgaSA+PSAwOyAtLWkpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IGkgKyAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBmW2ldW2pdID0gcy5jaGFyQXQoaSkgPT0gcy5jaGFyQXQoaikgJiYgZltpICsgMV1baiAtIDFdOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHRoaXMucyA9IHM7CiAgICAgICAgZGZzKDApOwogICAgICAgIHJldHVybiB7e2JsYW5rXzJ9fTsKICAgIH0KCiAgICBwcml2YXRlIHZvaWQgZGZzKGludCBpKSB7CiAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgIGFucy5hZGQobmV3IEFycmF5TGlzdDw+KHQpKTsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBmb3IgKGludCBqID0gaTsgaiA8IG47ICsraikgewogICAgICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgICAgIHQuYWRkKHMuc3Vic3RyaW5nKGksIGogKyAxKSk7CiAgICAgICAgICAgICAgICBkZnMoaiArIDEpOwogICAgICAgICAgICAgICAgdC5yZW1vdmUodC5zaXplKCkgLSAxKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicy5sZW5ndGgoKSIsImJsYW5rXzIiOiJhbnMiLCJibGFua18zIjoiaSA9PSBzLmxlbmd0aCgpIiwiYmxhbmtfNCI6ImZbaV1bal0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlm57mlofliIfliIYiLCJzdGFydOS9jee9riIsIuWQjue8gOmAkuW9kiIsIuWtl+espuS4siIsIuWKqOaAgeinhOWIkiIsIuWbnua6ryJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 131
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-62: #51 N 皇后

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    51, 62, CONVERT(FROM_BASE64('TiDnmoflkI4=') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('5oyJ54Wn5Zu96ZmF6LGh5qOL55qE6KeE5YiZ77yM55qH5ZCO5Y+v5Lul5pS75Ye75LiO5LmL5aSE5Zyo5ZCM5LiA6KGM5oiW5ZCM5LiA5YiX5oiW5ZCM5LiA5pac57q/5LiK55qE5qOL5a2Q44CCKipuIOeah+WQjumXrumimCoq56CU56m255qE5piv5aaC5L2V5bCGIGBuYCDkuKrnmoflkI7mlL7nva7lnKggYG7Dl25gIOeahOaji+ebmOS4iu+8jOW5tuS4lOS9v+eah+WQjuW9vOatpOS5i+mXtOS4jeiDveebuOS6kuaUu+WHu+OAggoK57uZ5L2g5LiA5Liq5pW05pWwIGBuYCDvvIzov5Tlm57miYDmnInkuI3lkIznmoQqKm4qKueah+WQjumXrumimCoq55qE6Kej5Yaz5pa55qGI44CCCgrmr4/kuIDnp43op6Pms5XljIXlkKvkuIDkuKrkuI3lkIznmoQqKm4g55qH5ZCO6Zeu6aKYKirnmoTmo4vlrZDmlL7nva7mlrnmoYjvvIzor6XmlrnmoYjkuK0gYCdRJ2Ag5ZKMIGAnLidgIOWIhuWIq+S7o+ihqOS6hueah+WQjuWSjOepuuS9jeOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzExLzEzL3F1ZWVucy5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mm4gPSA0Cui+k+WHuu+8mltbIi5RLi4iLCIuLi5RIiwiUS4uLiIsIi4uUS4iXSxbIi4uUS4iLCJRLi4uIiwiLi4uUSIsIi5RLi4iXV0K6Kej6YeK77ya5aaC5LiK5Zu+5omA56S677yMNCDnmoflkI7pl67popjlrZjlnKjkuKTkuKrkuI3lkIznmoTop6Pms5XjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpuID0gMQrovpPlh7rvvJpbWyJRIl1dCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG4gPD0gOWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9uLXF1ZWVucy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbi1xdWVlbnMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('6YCQ6KGM5pS+55qH5ZCO77yM55So5YiX44CB5Li75a+56KeS57q/IHJvdy1jb2wg5ZKM5Ymv5a+56KeS57q/IHJvdytjb2wg5LiJ57uE5Y2g55So54q25oCB5Ymq5p6d44CCIOacrOmimOWbtOe7leOAjE4g55qH5ZCO44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6YCS5b2S5YiwIHJvdyDml7bvvIzliY0gcm93IOihjOWQhOacieS4gOS4queah+WQjuS4lOS6kuS4jeaUu+WHu+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6YCQ6KGM5pS+572u55qE5ZCr5LmJ77yM5YaN5qOA5p+l5LiJ57uE5Yay56qB5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aWYgKGkgPT0gbikgewogICAgICAgICAgICBMaXN0PFN0cmluZz4gdCA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IG47ICsraikgewogICAgICAgICAgICAgICAgdC5hZGQoU3RyaW5nLmpvaW4oIiIsIGdbal0pKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBhbnMuYWRkKHQpOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8U3RyaW5nPj4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIGludFtdIGNvbDsKICAgIHByaXZhdGUgaW50W10gZGc7CiAgICBwcml2YXRlIGludFtdIHVkZzsKICAgIHByaXZhdGUgU3RyaW5nW11bXSBnOwogICAgcHJpdmF0ZSBpbnQgbjsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PFN0cmluZz4+IHNvbHZlTlF1ZWVucyhpbnQgbikgewogICAgICAgIHRoaXMubiA9IG47CiAgICAgICAgY29sID0gbmV3IGludFtuXTsKICAgICAgICBkZyA9IG5ldyBpbnRbbiA8PCAxXTsKICAgICAgICB1ZGcgPSBuZXcgaW50W24gPDwgMV07CiAgICAgICAgZyA9IG5ldyBTdHJpbmdbbl1bbl07CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgQXJyYXlzLmZpbGwoZ1tpXSwgIi4iKTsKICAgICAgICB9CiAgICAgICAgZGZzKDApOwogICAgICAgIHJldHVybiBhbnM7CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIGRmcyhpbnQgaSkgewogICAgICAgIGlmIChpID09IG4pIHsKICAgICAgICAgICAgTGlzdDxTdHJpbmc+IHQgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIHQuYWRkKFN0cmluZy5qb2luKCIiLCBnW2pdKSk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgYW5zLmFkZCh0KTsKICAgICAgICAgICAgcmV0dXJuOwogICAgICAgIH0KICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IG47ICsraikgewogICAgICAgICAgICBpZiAoY29sW2pdICsgZGdbaSArIGpdICsgdWRnW24gLSBpICsgal0gPT0gMCkgewogICAgICAgICAgICAgICAgZ1tpXVtqXSA9ICJRIjsKICAgICAgICAgICAgICAgIGNvbFtqXSA9IGRnW2kgKyBqXSA9IHVkZ1tuIC0gaSArIGpdID0gMTsKICAgICAgICAgICAgICAgIGRmcyhpICsgMSk7CiAgICAgICAgICAgICAgICBjb2xbal0gPSBkZ1tpICsgal0gPSB1ZGdbbiAtIGkgKyBqXSA9IDA7CiAgICAgICAgICAgICAgICBnW2ldW2pdID0gIi4iOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Zue5rqv') USING utf8mb4) WHERE p.leetcode_number = 51
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 51
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2S5YiwIHJvdyDml7bvvIzliY0gcm93IOihjOWQhOacieS4gOS4queah+WQjuS4lOS6kuS4jeaUu+WHu+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNvbHZlTlF1ZWVucyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5Lik57G75a+56KeS57q/5qCH6K+G5LiN6IO95re35reG77yb5Zue5rqv6KaB5ZCM5q2l5oGi5aSN5qOL55uY5ZKM5LiJ57uE54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze057qmIE8obiEp77yM56m66Ze0IE8obsKyKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Lik57G75a+56KeS57q/5qCH6K+G5LiN6IO95re35reG77yb5Zue5rqv6KaB5ZCM5q2l5oGi5aSN5qOL55uY5ZKM5LiJ57uE54q25oCB44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNvbHZlTlF1ZWVucyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBMaXN0PExpc3Q8U3RyaW5nPj4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICBwcml2YXRlIGludFtdIGNvbDsKICAgIHByaXZhdGUgaW50W10gZGc7CiAgICBwcml2YXRlIGludFtdIHVkZzsKICAgIHByaXZhdGUgU3RyaW5nW11bXSBnOwogICAgcHJpdmF0ZSBpbnQgbjsKCiAgICBwdWJsaWMgTGlzdDxMaXN0PFN0cmluZz4+IHNvbHZlTlF1ZWVucyhpbnQgbikgewogICAgICAgIHRoaXMubiA9IG47CiAgICAgICAgY29sID0gbmV3IGludFtuXTsKICAgICAgICBkZyA9IG5ldyBpbnRbbiA8PCAxXTsKICAgICAgICB1ZGcgPSBuZXcgaW50W24gPDwgMV07CiAgICAgICAgZyA9IG5ldyBTdHJpbmdbbl1bbl07CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgQXJyYXlzLmZpbGwoZ1tpXSwgIi4iKTsKICAgICAgICB9CiAgICAgICAgZGZzKDApOwogICAgICAgIHJldHVybiB7e2JsYW5rXzF9fTsKICAgIH0KCiAgICBwcml2YXRlIHZvaWQgZGZzKGludCBpKSB7CiAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIExpc3Q8U3RyaW5nPiB0ID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICB0LmFkZChTdHJpbmcuam9pbigiIiwgZ1tqXSkpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGFucy5hZGQodCk7CiAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICBnW2ldW2pdID0gIlEiOwogICAgICAgICAgICAgICAgY29sW2pdID0gZGdbaSArIGpdID0gdWRnW24gLSBpICsgal0gPSAxOwogICAgICAgICAgICAgICAgZGZzKGkgKyAxKTsKICAgICAgICAgICAgICAgIGNvbFtqXSA9IGRnW2kgKyBqXSA9IHVkZ1tuIC0gaSArIGpdID0gMDsKICAgICAgICAgICAgICAgIGdbaV1bal0gPSAiLiI7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW5zIiwiYmxhbmtfMiI6ImkgPT0gbiIsImJsYW5rXzMiOiJjb2xbal0gKyBkZ1tpICsgal0gKyB1ZGdbbiAtIGkgKyBqXSA9PSAwIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpgJDooYzmlL7nva4iLCLkuInnu4TlhrLnqoEiLCLlr7nop5Lnur8iLCLmlbDnu4QiLCLlm57muq8iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 51
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-63: #35 搜索插入位置

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    35, 63, CONVERT(FROM_BASE64('5pCc57Si5o+S5YWl5L2N572u') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5o6S5bqP5pWw57uE5ZKM5LiA5Liq55uu5qCH5YC877yM5Zyo5pWw57uE5Lit5om+5Yiw55uu5qCH5YC877yM5bm26L+U5Zue5YW257Si5byV44CC5aaC5p6c55uu5qCH5YC85LiN5a2Y5Zyo5LqO5pWw57uE5Lit77yM6L+U5Zue5a6D5bCG5Lya6KKr5oyJ6aG65bqP5o+S5YWl55qE5L2N572u44CCCgror7flv4Xpobvkvb/nlKjml7bpl7TlpI3mnYLluqbkuLogYE8obG9nIG4pYCDnmoTnrpfms5XjgIIqKuekuuS+iyAxOioqYGBgdGV4dArovpPlhaU6IG51bXMgPSBbMSwzLDUsNl0sIHRhcmdldCA9IDUK6L6T5Ye6OiAyCmBgYCoq56S65L6LIDI6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFsxLDMsNSw2XSwgdGFyZ2V0ID0gMgrovpPlh7o6IDEKYGBgKirnpLrkvosgMzoqKmBgYHRleHQK6L6T5YWlOiBudW1zID0gWzEsMyw1LDZdLCB0YXJnZXQgPSA3Cui+k+WHujogNApgYGAqKuaPkOekujoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTA0YAotIGAtMTA0IDw9IG51bXNbaV0gPD0gMTA0YAotIGBudW1zYCDkuLoqKuaXoOmHjeWkjeWFg+e0oCoq55qEKirljYfluo8qKuaOkuWIl+aVsOe7hAotIGAtMTA0IDw9IHRhcmdldCA8PSAxMDRgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvc2VhcmNoLWluc2VydC1wb3NpdGlvbi8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc2VhcmNoLWluc2VydC1wb3NpdGlvbi8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+56ys5LiA5Liq5aSn5LqO562J5LqOIHRhcmdldCDnmoTkvY3nva7vvIzljbMgbG93ZXJfYm91bmTjgIIg5pys6aKY5Zu057uV44CM5pCc57Si5o+S5YWl5L2N572u44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5pCc57Si5Yy66Ze05aSW5bem5L6n6YO95bCP5LqOIHRhcmdldO+8jOWPs+S+p+mDveWkp+S6juetieS6jiB0YXJnZXTjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFbG93ZXJfYm91bmTnmoTlkKvkuYnvvIzlho3mo4Dmn6Xmj5LlhaXkvY3nva7lpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGwgPCByKSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+PiAxOwogICAgICAgICAgICBpZiAobnVtc1ttaWRdID49IHRhcmdldCkgewogICAgICAgICAgICAgICAgciA9IG1pZDsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGwgPSBtaWQgKyAxOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzZWFyY2hJbnNlcnQoaW50W10gbnVtcywgaW50IHRhcmdldCkgewogICAgICAgIGludCBsID0gMCwgciA9IG51bXMubGVuZ3RoOwogICAgICAgIHdoaWxlIChsIDwgcikgewogICAgICAgICAgICBpbnQgbWlkID0gKGwgKyByKSA+Pj4gMTsKICAgICAgICAgICAgaWYgKG51bXNbbWlkXSA+PSB0YXJnZXQpIHsKICAgICAgICAgICAgICAgIHIgPSBtaWQ7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBsID0gbWlkICsgMTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 35
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 35
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pCc57Si5Yy66Ze05aSW5bem5L6n6YO95bCP5LqOIHRhcmdldO+8jOWPs+S+p+mDveWkp+S6juetieS6jiB0YXJnZXTjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNlYXJjaEluc2VydCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('6L+U5Zue5o+S5YWl5L2N572u5YWB6K64562J5LqOIG51bXMubGVuZ3Ro77yb6Zet5Yy66Ze05ZKM5Y2K5byA5Yy66Ze05pu05paw5LiN6IO95re355So44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obG9nIG4p77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+U5Zue5o+S5YWl5L2N572u5YWB6K64562J5LqOIG51bXMubGVuZ3Ro77yb6Zet5Yy66Ze05ZKM5Y2K5byA5Yy66Ze05pu05paw5LiN6IO95re355So44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNlYXJjaEluc2VydCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzZWFyY2hJbnNlcnQoaW50W10gbnVtcywgaW50IHRhcmdldCkgewogICAgICAgIGludCBsID0gMCwgciA9IHt7YmxhbmtfMX19OwogICAgICAgIHdoaWxlICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICBpbnQgbWlkID0gKGwgKyByKSA+Pj4gMTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICByID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGw7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtcy5sZW5ndGgiLCJibGFua18yIjoibCA8IHIiLCJibGFua18zIjoibnVtc1ttaWRdID49IHRhcmdldCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJsb3dlcl9ib3VuZCIsIuaPkuWFpeS9jee9riIsIuS6jOWIhui+ueeVjCIsIuaVsOe7hCIsIuS6jOWIhuafpeaJviJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 35
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-64: #74 搜索二维矩阵

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    74, 64, CONVERT(FROM_BASE64('5pCc57Si5LqM57u055+p6Zi1') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5ruh6Laz5LiL6L+w5Lik5p2h5bGe5oCn55qEIGBtIHggbmAg5pW05pWw55+p6Zi177yaCgotIOavj+ihjOS4reeahOaVtOaVsOS7juW3puWIsOWPs+aMiemdnuS4peagvOmAkuWinumhuuW6j+aOkuWIl+OAggotIOavj+ihjOeahOesrOS4gOS4quaVtOaVsOWkp+S6juWJjeS4gOihjOeahOacgOWQjuS4gOS4quaVtOaVsOOAggoK57uZ5L2g5LiA5Liq5pW05pWwIGB0YXJnZXRgIO+8jOWmguaenCBgdGFyZ2V0YCDlnKjnn6npmLXkuK3vvIzov5Tlm54gYHRydWVgIO+8m+WQpuWIme+8jOi/lOWbniBgZmFsc2VgIOOAgioq56S65L6LIDHvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jb20vdXBsb2Fkcy8yMDIwLzEwLzA1L21hdC5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mm1hdHJpeCA9IFtbMSwzLDUsN10sWzEwLDExLDE2LDIwXSxbMjMsMzAsMzQsNjBdXSwgdGFyZ2V0ID0gMwrovpPlh7rvvJp0cnVlCmBgYCoq56S65L6LIDLvvJoqKiFb6aKY55uu56S65oSP5Zu+XShodHRwczovL2Fzc2V0cy5sZWV0Y29kZS5jbi9hbGl5dW4tbGMtdXBsb2FkL3VwbG9hZHMvMjAyMC8xMS8yNS9tYXQyLmpwZykKCmBgYHRleHQK6L6T5YWl77yabWF0cml4ID0gW1sxLDMsNSw3XSxbMTAsMTEsMTYsMjBdLFsyMywzMCwzNCw2MF1dLCB0YXJnZXQgPSAxMwrovpPlh7rvvJpmYWxzZQpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBtYXRyaXgubGVuZ3RoYAotIGBuID09IG1hdHJpeFtpXS5sZW5ndGhgCi0gYDEgPD0gbSwgbiA8PSAxMDBgCi0gYC0xMDQgPD0gbWF0cml4W2ldW2pdLCB0YXJnZXQgPD0gMTA0YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3NlYXJjaC1hLTJkLW1hdHJpeC8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc2VhcmNoLWEtMmQtbWF0cml4Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqKIG3Dl24g55+p6Zi16KeG5Li66ZW/5bqmIG1uIOeahOacieW6j+S4gOe7tOaVsOe7hO+8jG1pZCDmmKDlsITkuLogbWF0cml4W21pZC9uXVttaWQlbl3jgIIg5pys6aKY5Zu057uV44CM5pCc57Si5LqM57u055+p6Zi144CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5q+P6L2u5LqM5YiG5Yy66Ze05LuN5YyF5ZCr55uu5qCH5Y+v6IO95a+55bqU55qE5LiA57u05LiL5qCH44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LiA57u05pig5bCE55qE5ZCr5LmJ77yM5YaN5qOA5p+lbWlk6Zmk5qih5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IG1pZCA9IChsZWZ0ICsgcmlnaHQpID4+IDE7CiAgICAgICAgICAgIGludCB4ID0gbWlkIC8gbiwgeSA9IG1pZCAlIG47CiAgICAgICAgICAgIGlmIChtYXRyaXhbeF1beV0gPj0gdGFyZ2V0KSB7CiAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGxlZnQgPSBtaWQgKyAxOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gc2VhcmNoTWF0cml4KGludFtdW10gbWF0cml4LCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgaW50IG0gPSBtYXRyaXgubGVuZ3RoLCBuID0gbWF0cml4WzBdLmxlbmd0aDsKICAgICAgICBpbnQgbGVmdCA9IDAsIHJpZ2h0ID0gbSAqIG4gLSAxOwogICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgaW50IG1pZCA9IChsZWZ0ICsgcmlnaHQpID4+IDE7CiAgICAgICAgICAgIGludCB4ID0gbWlkIC8gbiwgeSA9IG1pZCAlIG47CiAgICAgICAgICAgIGlmIChtYXRyaXhbeF1beV0gPj0gdGFyZ2V0KSB7CiAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGxlZnQgPSBtaWQgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBtYXRyaXhbbGVmdCAvIG5dW2xlZnQgJSBuXSA9PSB0YXJnZXQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 74
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 74
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 74
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u5LqM5YiG5Yy66Ze05LuN5YyF5ZCr55uu5qCH5Y+v6IO95a+55bqU55qE5LiA57u05LiL5qCH44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNlYXJjaE1hdHJpeCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5LiA57u06ZW/5bqm5ZKMIG1pZCDorqHnrpfms6jmhI/muqLlh7rvvJvnqbrnn6npmLXpnIDlhYjliKTmlq3jgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obG9nKG1uKSnvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiA57u06ZW/5bqm5ZKMIG1pZCDorqHnrpfms6jmhI/muqLlh7rvvJvnqbrnn6npmLXpnIDlhYjliKTmlq3jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNlYXJjaE1hdHJpeCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gc2VhcmNoTWF0cml4KGludFtdW10gbWF0cml4LCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgaW50IG0gPSB7e2JsYW5rXzF9fSwgbiA9IG1hdHJpeFswXS5sZW5ndGg7CiAgICAgICAgaW50IGxlZnQgPSAwLCByaWdodCA9IG0gKiBuIC0gMTsKICAgICAgICB3aGlsZSAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgaW50IG1pZCA9IChsZWZ0ICsgcmlnaHQpID4+IDE7CiAgICAgICAgICAgIGludCB4ID0gbWlkIC8gbiwgeSA9IG1pZCAlIG47CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgcmlnaHQgPSBtaWQ7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBsZWZ0ID0gbWlkICsgMTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbWF0cml4W2xlZnQgLyBuXVtsZWZ0ICUgbl0gPT0gdGFyZ2V0OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibWF0cml4Lmxlbmd0aCIsImJsYW5rXzIiOiJsZWZ0IDwgcmlnaHQiLCJibGFua18zIjoibWF0cml4W3hdW3ldID49IHRhcmdldCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuIDnu7TmmKDlsIQiLCJtaWTpmaTmqKEiLCLlhajlsYDmnInluo8iLCLmlbDnu4QiLCLkuozliIbmn6Xmib4iLCLnn6npmLUiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 74
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-65: #34 在排序数组中查找元素的第一个和最后一个位置

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    34, 65, CONVERT(FROM_BASE64('5Zyo5o6S5bqP5pWw57uE5Lit5p+l5om+5YWD57Sg55qE56ys5LiA5Liq5ZKM5pyA5ZCO5LiA5Liq5L2N572u') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5oyJ54Wn6Z2e6YCS5YeP6aG65bqP5o6S5YiX55qE5pW05pWw5pWw57uEIGBudW1zYO+8jOWSjOS4gOS4quebruagh+WAvCBgdGFyZ2V0YOOAguivt+S9oOaJvuWHuue7meWumuebruagh+WAvOWcqOaVsOe7hOS4reeahOW8gOWni+S9jee9ruWSjOe7k+adn+S9jee9ruOAggoK5aaC5p6c5pWw57uE5Lit5LiN5a2Y5Zyo55uu5qCH5YC8IGB0YXJnZXRg77yM6L+U5ZueIGBbLTEsIC0xXWDjgIIKCuS9oOW/hemhu+iuvuiuoeW5tuWunueOsOaXtumXtOWkjeadguW6puS4uiBgTyhsb2cgbilgIOeahOeul+azleino+WGs+atpOmXrumimOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFs1LDcsNyw4LDgsMTBdLCB0YXJnZXQgPSA4Cui+k+WHuu+8mlszLDRdCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFs1LDcsNyw4LDgsMTBdLCB0YXJnZXQgPSA2Cui+k+WHuu+8mlstMSwtMV0KYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gW10sIHRhcmdldCA9IDAK6L6T5Ye677yaWy0xLC0xXQpgYGAqKuaPkOekuu+8mioqLSBgMCA8PSBudW1zLmxlbmd0aCA8PSAxMDVgCi0gYC0xMDkgPD0gbnVtc1tpXSA8PSAxMDlgCi0gYG51bXNgIOaYr+S4gOS4qumdnumAkuWHj+aVsOe7hAotIGAtMTA5IDw9IHRhcmdldCA8PSAxMDlgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvZmluZC1maXJzdC1hbmQtbGFzdC1wb3NpdGlvbi1vZi1lbGVtZW50LWluLXNvcnRlZC1hcnJheS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZmluZC1maXJzdC1hbmQtbGFzdC1wb3NpdGlvbi1vZi1lbGVtZW50LWluLXNvcnRlZC1hcnJheS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5YiG5Yir5LqM5YiG56ys5LiA5LiqID49dGFyZ2V0IOeahOS9jee9ruWSjOesrOS4gOS4qiA+dGFyZ2V0IOeahOS9jee9ru+8jOWMuumXtOS4uiBbbGVmdCwgcmlnaHQtMV3jgIIg5pys6aKY5Zu057uV44CM5Zyo5o6S5bqP5pWw57uE5Lit5p+l5om+5YWD57Sg55qE56ys5LiA5Liq5ZKM5pyA5ZCO5LiA5Liq5L2N572u44CN6JC95a6e6L+Z5LiA5qih5Z6L77yabG93ZXJfYm91bmQg5aeL57uI5a+75om+5ruh6Laz6LCT6K+N55qE5pyA5bem5L2N572u77yM5Y+z6L6555WM55SxIHRhcmdldCsxIOaIluS4peagvOWkp+S6juafpeivouW+l+WIsOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5bem5Y+z6L6555WM55qE5ZCr5LmJ77yM5YaN5qOA5p+lbG93ZXJfYm91bmTlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGxlZnQgPCByaWdodCkgewogICAgICAgICAgICBpbnQgbWlkID0gbGVmdCArIChyaWdodCAtIGxlZnQpIC8gMjsKICAgICAgICAgICAgaWYgKG51bXNbbWlkXSA+PSB0YXJnZXQpIHsKICAgICAgICAgICAgICAgIHJpZ2h0ID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHNlYXJjaFJhbmdlKGludFtdIG51bXMsIGludCB0YXJnZXQpIHsKICAgICAgICBpbnQgbGVmdCA9IGxvd2VyQm91bmQobnVtcywgdGFyZ2V0KTsKICAgICAgICBpZiAobGVmdCA9PSBudW1zLmxlbmd0aCB8fCBudW1zW2xlZnRdICE9IHRhcmdldCkgewogICAgICAgICAgICByZXR1cm4gbmV3IGludFtdIHstMSwgLTF9OwogICAgICAgIH0KICAgICAgICBpbnQgcmlnaHQgPSB1cHBlckJvdW5kKG51bXMsIHRhcmdldCkgLSAxOwogICAgICAgIHJldHVybiBuZXcgaW50W10ge2xlZnQsIHJpZ2h0fTsKICAgIH0KCiAgICBwcml2YXRlIGludCBsb3dlckJvdW5kKGludFtdIG51bXMsIGludCB0YXJnZXQpIHsKICAgICAgICBpbnQgbGVmdCA9IDAsIHJpZ2h0ID0gbnVtcy5sZW5ndGg7CiAgICAgICAgd2hpbGUgKGxlZnQgPCByaWdodCkgewogICAgICAgICAgICBpbnQgbWlkID0gbGVmdCArIChyaWdodCAtIGxlZnQpIC8gMjsKICAgICAgICAgICAgaWYgKG51bXNbbWlkXSA+PSB0YXJnZXQpIHsKICAgICAgICAgICAgICAgIHJpZ2h0ID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGxlZnQ7CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgdXBwZXJCb3VuZChpbnRbXSBudW1zLCBpbnQgdGFyZ2V0KSB7CiAgICAgICAgaW50IGxlZnQgPSAwLCByaWdodCA9IG51bXMubGVuZ3RoOwogICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgaW50IG1pZCA9IGxlZnQgKyAocmlnaHQgLSBsZWZ0KSAvIDI7CiAgICAgICAgICAgIGlmIChudW1zW21pZF0gPiB0YXJnZXQpIHsKICAgICAgICAgICAgICAgIHJpZ2h0ID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGxlZnQ7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 34
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 34
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('bG93ZXJfYm91bmQg5aeL57uI5a+75om+5ruh6Laz6LCT6K+N55qE5pyA5bem5L2N572u77yM5Y+z6L6555WM55SxIHRhcmdldCsxIOaIluS4peagvOWkp+S6juafpeivouW+l+WIsOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNlYXJjaFJhbmdlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('dGFyZ2V0KzEg5Y+v6IO95rqi5Ye677yM5pyA5aW95YaZ54us56uL5LiK55WM77yb5om+5Yiw5bem6L6555WM5ZCO56Gu6K6k5YC856Gu5a6e562J5LqOIHRhcmdldOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obG9nIG4p77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('dGFyZ2V0KzEg5Y+v6IO95rqi5Ye677yM5pyA5aW95YaZ54us56uL5LiK55WM77yb5om+5Yiw5bem6L6555WM5ZCO56Gu6K6k5YC856Gu5a6e562J5LqOIHRhcmdldOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNlYXJjaFJhbmdlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHNlYXJjaFJhbmdlKGludFtdIG51bXMsIGludCB0YXJnZXQpIHsKICAgICAgICBpbnQgbGVmdCA9IHt7YmxhbmtfMX19OwogICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICByZXR1cm4gbmV3IGludFtdIHstMSwgLTF9OwogICAgICAgIH0KICAgICAgICBpbnQgcmlnaHQgPSB1cHBlckJvdW5kKG51bXMsIHRhcmdldCkgLSAxOwogICAgICAgIHJldHVybiBuZXcgaW50W10ge2xlZnQsIHJpZ2h0fTsKICAgIH0KCiAgICBwcml2YXRlIGludCBsb3dlckJvdW5kKGludFtdIG51bXMsIGludCB0YXJnZXQpIHsKICAgICAgICBpbnQgbGVmdCA9IDAsIHJpZ2h0ID0gbnVtcy5sZW5ndGg7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgIGludCBtaWQgPSBsZWZ0ICsgKHJpZ2h0IC0gbGVmdCkgLyAyOwogICAgICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgICAgIHJpZ2h0ID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQoKICAgIHByaXZhdGUgaW50IHVwcGVyQm91bmQoaW50W10gbnVtcywgaW50IHRhcmdldCkgewogICAgICAgIGludCBsZWZ0ID0gMCwgcmlnaHQgPSBudW1zLmxlbmd0aDsKICAgICAgICB3aGlsZSAobGVmdCA8IHJpZ2h0KSB7CiAgICAgICAgICAgIGludCBtaWQgPSBsZWZ0ICsgKHJpZ2h0IC0gbGVmdCkgLyAyOwogICAgICAgICAgICBpZiAobnVtc1ttaWRdID4gdGFyZ2V0KSB7CiAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGxlZnQgPSBtaWQgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBsZWZ0OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibG93ZXJCb3VuZChudW1zLCB0YXJnZXQpIiwiYmxhbmtfMiI6ImxlZnQgPT0gbnVtcy5sZW5ndGggfHwgbnVtc1tsZWZ0XSAhPSB0YXJnZXQiLCJibGFua18zIjoibGVmdCA8IHJpZ2h0IiwiYmxhbmtfNCI6Im51bXNbbWlkXSA+PSB0YXJnZXQiLCJibGFua181IjoibGVmdCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlt6blj7PovrnnlYwiLCJsb3dlcl9ib3VuZCIsIuWtmOWcqOaAp+ajgOafpSIsIuaVsOe7hCIsIuS6jOWIhuafpeaJviJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 34
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-66: #33 搜索旋转排序数组

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    33, 66, CONVERT(FROM_BASE64('5pCc57Si5peL6L2s5o6S5bqP5pWw57uE') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5pW05pWw5pWw57uEIGBudW1zYCDmjInljYfluo/mjpLliJfvvIzmlbDnu4TkuK3nmoTlgLwqKuS6kuS4jeebuOWQjCoq44CCCgrlnKjkvKDpgJLnu5nlh73mlbDkuYvliY3vvIxgbnVtc2Ag5Zyo6aKE5YWI5pyq55+l55qE5p+Q5Liq5LiL5qCHIGBrYO+8iGAwIDw9IGsgPCBudW1zLmxlbmd0aGDvvInkuIrov5vooYzkuoYqKuWQkeW3puaXi+i9rCoq77yM5L2/5pWw57uE5Y+Y5Li6IGBbbnVtc1trXSwgbnVtc1trKzFdLCAuLi4sIG51bXNbbi0xXSwgbnVtc1swXSwgbnVtc1sxXSwgLi4uLCBudW1zW2stMV1dYO+8iOS4i+aghyoq5LuOIDAg5byA5aeLKirorqHmlbDvvInjgILkvovlpoLvvIwgYFswLDEsMiw0LDUsNiw3XWAg5LiL5qCHIGAzYCDkuIrlkJHlt6bml4vovazlkI7lj6/og73lj5jkuLogYFs0LDUsNiw3LDAsMSwyXWAg44CCCgrnu5nkvaAqKuaXi+i9rOWQjioq55qE5pWw57uEIGBudW1zYCDlkozkuIDkuKrmlbTmlbAgYHRhcmdldGAg77yM5aaC5p6cIGBudW1zYCDkuK3lrZjlnKjov5nkuKrnm67moIflgLwgYHRhcmdldGAg77yM5YiZ6L+U5Zue5a6D55qE5LiL5qCH77yM5ZCm5YiZ6L+U5ZueIGAtMWAg44CCCgrkvaDlv4Xpobvorr7orqHkuIDkuKrml7bpl7TlpI3mnYLluqbkuLogYE8obG9nIG4pYCDnmoTnrpfms5Xop6PlhrPmraTpl67popjjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbNCw1LDYsNywwLDEsMl0sIHRhcmdldCA9IDAK6L6T5Ye677yaNApgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbNCw1LDYsNywwLDEsMl0sIHRhcmdldCA9IDMK6L6T5Ye677yaLTEKYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzFdLCB0YXJnZXQgPSAwCui+k+WHuu+8mi0xCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDUwMDBgCi0gYC0xMDQgPD0gbnVtc1tpXSA8PSAxMDRgCi0gYG51bXNgIOS4reeahOavj+S4quWAvOmDvSoq54us5LiA5peg5LqMKiotIOmimOebruaVsOaNruS/neivgSBgbnVtc2Ag5Zyo6aKE5YWI5pyq55+l55qE5p+Q5Liq5LiL5qCH5LiK6L+b6KGM5LqG5peL6L2sCi0gYC0xMDQgPD0gdGFyZ2V0IDw9IDEwNGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9zZWFyY2gtaW4tcm90YXRlZC1zb3J0ZWQtYXJyYXkvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3NlYXJjaC1pbi1yb3RhdGVkLXNvcnRlZC1hcnJheS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5LqM5YiG5Lit6Iez5bCR5pyJ5LiA5Y2K5Yy66Ze05pyJ5bqP77yb5Yik5patIHRhcmdldCDmmK/lkKbokL3lnKjmnInluo/ljYrovrnvvIzlho3lhrPlrprkv53nlZnlk6rkuIDkvqfjgIIg5pys6aKY5Zu057uV44CM5pCc57Si5peL6L2s5o6S5bqP5pWw57uE44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5q+P6L2u6YO96IO96K+G5Yir5LiA5Liq5pyJ5bqP5Y2K5Yy677yM5bm25L+d6K+B55uu5qCH6Iul5a2Y5Zyo5LuN5Zyo5pu05paw5ZCO55qE6Zet5Yy66Ze044CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5peL6L2s5pWw57uE55qE5ZCr5LmJ77yM5YaN5qOA5p+l5pyJ5bqP5Y2K5Yy65aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IG1pZCA9IChsZWZ0ICsgcmlnaHQpID4+IDE7CiAgICAgICAgICAgIGlmIChudW1zWzBdIDw9IG51bXNbbWlkXSkgewogICAgICAgICAgICAgICAgaWYgKG51bXNbMF0gPD0gdGFyZ2V0ICYmIHRhcmdldCA8PSBudW1zW21pZF0pIHsKICAgICAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzZWFyY2goaW50W10gbnVtcywgaW50IHRhcmdldCkgewogICAgICAgIGludCBuID0gbnVtcy5sZW5ndGg7CiAgICAgICAgaW50IGxlZnQgPSAwLCByaWdodCA9IG4gLSAxOwogICAgICAgIHdoaWxlIChsZWZ0IDwgcmlnaHQpIHsKICAgICAgICAgICAgaW50IG1pZCA9IChsZWZ0ICsgcmlnaHQpID4+IDE7CiAgICAgICAgICAgIGlmIChudW1zWzBdIDw9IG51bXNbbWlkXSkgewogICAgICAgICAgICAgICAgaWYgKG51bXNbMF0gPD0gdGFyZ2V0ICYmIHRhcmdldCA8PSBudW1zW21pZF0pIHsKICAgICAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBpZiAobnVtc1ttaWRdIDwgdGFyZ2V0ICYmIHRhcmdldCA8PSBudW1zW24gLSAxXSkgewogICAgICAgICAgICAgICAgICAgIGxlZnQgPSBtaWQgKyAxOwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbnVtc1tsZWZ0XSA9PSB0YXJnZXQgPyBsZWZ0IDogLTE7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 33
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 33
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u6YO96IO96K+G5Yir5LiA5Liq5pyJ5bqP5Y2K5Yy677yM5bm25L+d6K+B55uu5qCH6Iul5a2Y5Zyo5LuN5Zyo5pu05paw5ZCO55qE6Zet5Yy66Ze044CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNlYXJjaCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('562J5Y+35b2S5bGe5Yaz5a6a6L6555WM56e75Yqo77yb6aKY55uu5peg6YeN5aSN5YC877yM5Yik5pat5bem5Y2K5pyJ5bqP5Y+v55SoIG51bXNbbGVmdF08PW51bXNbbWlkXeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obG9nIG4p77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('562J5Y+35b2S5bGe5Yaz5a6a6L6555WM56e75Yqo77yb6aKY55uu5peg6YeN5aSN5YC877yM5Yik5pat5bem5Y2K5pyJ5bqP5Y+v55SoIG51bXNbbGVmdF08PW51bXNbbWlkXeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNlYXJjaCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzZWFyY2goaW50W10gbnVtcywgaW50IHRhcmdldCkgewogICAgICAgIGludCBuID0gbnVtcy5sZW5ndGg7CiAgICAgICAgaW50IGxlZnQgPSAwLCByaWdodCA9IG4gLSAxOwogICAgICAgIHdoaWxlICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICBpbnQgbWlkID0gKGxlZnQgKyByaWdodCkgPj4gMTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgICAgICAgICByaWdodCA9IG1pZDsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgbGVmdCA9IG1pZCArIDE7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgICAgICAgICBsZWZ0ID0gbWlkICsgMTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgcmlnaHQgPSBtaWQ7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibGVmdCA8IHJpZ2h0IiwiYmxhbmtfMiI6Im51bXNbMF0gPD0gbnVtc1ttaWRdIiwiYmxhbmtfMyI6Im51bXNbMF0gPD0gdGFyZ2V0ICYmIHRhcmdldCA8PSBudW1zW21pZF0iLCJibGFua180IjoibnVtc1ttaWRdIDwgdGFyZ2V0ICYmIHRhcmdldCA8PSBudW1zW24gLSAxXSIsImJsYW5rXzUiOiJudW1zW2xlZnRdID09IHRhcmdldCA/IGxlZnQgOiAtMSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLml4vovazmlbDnu4QiLCLmnInluo/ljYrljLoiLCLnm67moIfljLrpl7QiLCLmlbDnu4QiLCLkuozliIbmn6Xmib4iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 33
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-67: #153 寻找旋转排序数组中的最小值

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    153, 67, CONVERT(FROM_BASE64('5a+75om+5peL6L2s5o6S5bqP5pWw57uE5Lit55qE5pyA5bCP5YC8') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5bey55+l5LiA5Liq6ZW/5bqm5Li6IGBuYCDnmoTmlbDnu4TvvIzpooTlhYjmjInnhafljYfluo/mjpLliJfvvIznu4/nlLEgYDFgIOWIsCBgbmAg5qyhKirml4vovawqKuWQju+8jOW+l+WIsOi+k+WFpeaVsOe7hOOAguS+i+Wmgu+8jOWOn+aVsOe7hCBgbnVtcyA9IFswLDEsMiw0LDUsNiw3XWAg5Zyo5Y+Y5YyW5ZCO5Y+v6IO95b6X5Yiw77yaCgotIOiLpeaXi+i9rCBgNGAg5qyh77yM5YiZ5Y+v5Lul5b6X5YiwIGBbNCw1LDYsNywwLDEsMl1gCi0g6Iul5peL6L2sIGA3YCDmrKHvvIzliJnlj6/ku6XlvpfliLAgYFswLDEsMiw0LDUsNiw3XWAKCuazqOaEj++8jOaVsOe7hCBgW2FbMF0sIGFbMV0sIGFbMl0sIC4uLiwgYVtuLTFdXWAqKuaXi+i9rOS4gOasoSoq55qE57uT5p6c5Li65pWw57uEIGBbYVtuLTFdLCBhWzBdLCBhWzFdLCBhWzJdLCAuLi4sIGFbbi0yXV1gIOOAggoK57uZ5L2g5LiA5Liq5YWD57Sg5YC8KirkupLkuI3nm7jlkIwqKueahOaVsOe7hCBgbnVtc2Ag77yM5a6D5Y6f5p2l5piv5LiA5Liq5Y2H5bqP5o6S5YiX55qE5pWw57uE77yM5bm25oyJ5LiK6L+w5oOF5b2i6L+b6KGM5LqG5aSa5qyh5peL6L2s44CC6K+35L2g5om+5Ye65bm26L+U5Zue5pWw57uE5Lit55qEKirmnIDlsI/lhYPntKAqKuOAggoK5L2g5b+F6aG76K6+6K6h5LiA5Liq5pe26Ze05aSN5p2C5bqm5Li6IGBPKGxvZyBuKWAg55qE566X5rOV6Kej5Yaz5q2k6Zeu6aKY44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzMsNCw1LDEsMl0K6L6T5Ye677yaMQrop6Pph4rvvJrljp/mlbDnu4TkuLogWzEsMiwzLDQsNV0g77yM5peL6L2sIDMg5qyh5b6X5Yiw6L6T5YWl5pWw57uE44CCCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFs0LDUsNiw3LDAsMSwyXQrovpPlh7rvvJowCuino+mHiu+8muWOn+aVsOe7hOS4uiBbMCwxLDIsNCw1LDYsN10g77yM5peL6L2sIDQg5qyh5b6X5Yiw6L6T5YWl5pWw57uE44CCCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxMSwxMywxNSwxN10K6L6T5Ye677yaMTEK6Kej6YeK77ya5Y6f5pWw57uE5Li6IFsxMSwxMywxNSwxN10g77yM5peL6L2sIDQg5qyh5b6X5Yiw6L6T5YWl5pWw57uE44CCCmBgYCoq5o+Q56S677yaKiotIGBuID09IG51bXMubGVuZ3RoYAotIGAxIDw9IG4gPD0gNTAwMGAKLSBgLTUwMDAgPD0gbnVtc1tpXSA8PSA1MDAwYAotIGBudW1zYCDkuK3nmoTmiYDmnInmlbTmlbAqKuS6kuS4jeebuOWQjCoqLSBgbnVtc2Ag5Y6f5p2l5piv5LiA5Liq5Y2H5bqP5o6S5bqP55qE5pWw57uE77yM5bm26L+b6KGM5LqGIGAxYCDoh7MgYG5gIOasoeaXi+i9rAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2ZpbmQtbWluaW11bS1pbi1yb3RhdGVkLXNvcnRlZC1hcnJheS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZmluZC1taW5pbXVtLWluLXJvdGF0ZWQtc29ydGVkLWFycmF5Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqKIG51bXNbbWlkXSDkuI4gbnVtc1tyaWdodF0g5q+U6L6D77yabWlkIOWkp+S6jiByaWdodCDor7TmmI7mnIDlsI/lgLzlnKjlj7PkvqfvvIzlkKbliJnmnIDlsI/lgLzlnKggbWlkIOWPiuWFtuW3puS+p+OAgiDmnKzpopjlm7Tnu5XjgIzlr7vmib7ml4vovazmjpLluo/mlbDnu4TkuK3nmoTmnIDlsI/lgLzjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmnIDlsI/lgLzlp4vnu4jkvY3kuo7pl63ljLrpl7QgW2xlZnQscmlnaHRd44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LiO5Y+z56uv5q+U6L6D55qE5ZCr5LmJ77yM5YaN5qOA5p+l5L+d55WZbWlk5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKGwgPCByKSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgICAgIGlmIChudW1zW21pZF0gPiBudW1zW251bXMubGVuZ3RoIC0gMV0pIHsKICAgICAgICAgICAgICAgIGwgPSBtaWQgKyAxOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgciA9IG1pZDs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaW5kTWluKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbCA9IDAsIHIgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgd2hpbGUgKGwgPCByKSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgICAgIGlmIChudW1zW21pZF0gPiBudW1zW251bXMubGVuZ3RoIC0gMV0pIHsKICAgICAgICAgICAgICAgIGwgPSBtaWQgKyAxOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgciA9IG1pZDsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbnVtc1tsXTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 153
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 153
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5bCP5YC85aeL57uI5L2N5LqO6Zet5Yy66Ze0IFtsZWZ0LHJpZ2h0XeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZpbmRNaW4g5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5L+d55WZIG1pZCDml7bopoHku6QgcmlnaHQ9bWlk77yb5peg6YeN5aSN5YmN5o+Q5LiL5aSn5LqO5omN5LukIGxlZnQ9bWlkKzHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obG9nIG4p77yM56m66Ze0IE8oMSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5L+d55WZIG1pZCDml7bopoHku6QgcmlnaHQ9bWlk77yb5peg6YeN5aSN5YmN5o+Q5LiL5aSn5LqO5omN5LukIGxlZnQ9bWlkKzHjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZpbmRNaW4g55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaW5kTWluKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbCA9IDAsIHIgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgbCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICByID0gbWlkOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibCA8IHIiLCJibGFua18yIjoibnVtc1ttaWRdID4gbnVtc1tudW1zLmxlbmd0aCAtIDFdIiwiYmxhbmtfMyI6Im51bXNbbF0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuI7lj7Pnq6/mr5TovoMiLCLkv53nlZltaWQiLCLml4vovazmnIDlsI/lgLwiLCLmlbDnu4QiLCLkuozliIbmn6Xmib4iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 153
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-68: #4 寻找两个正序数组的中位数

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    4, 68, CONVERT(FROM_BASE64('5a+75om+5Lik5Liq5q2j5bqP5pWw57uE55qE5Lit5L2N5pWw') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5a6a5Lik5Liq5aSn5bCP5YiG5Yir5Li6IGBtYCDlkowgYG5gIOeahOato+W6j++8iOS7juWwj+WIsOWkp++8ieaVsOe7hCBgbnVtczFgIOWSjCBgbnVtczJg44CC6K+35L2g5om+5Ye65bm26L+U5Zue6L+Z5Lik5Liq5q2j5bqP5pWw57uE55qEKirkuK3kvY3mlbAqKuOAggoK566X5rOV55qE5pe26Ze05aSN5p2C5bqm5bqU6K+l5Li6IGBPKGxvZyAobStuKSlgIOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtczEgPSBbMSwzXSwgbnVtczIgPSBbMl0K6L6T5Ye677yaMi4wMDAwMArop6Pph4rvvJrlkIjlubbmlbDnu4QgPSBbMSwyLDNdIO+8jOS4reS9jeaVsCAyCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtczEgPSBbMSwyXSwgbnVtczIgPSBbMyw0XQrovpPlh7rvvJoyLjUwMDAwCuino+mHiu+8muWQiOW5tuaVsOe7hCA9IFsxLDIsMyw0XSDvvIzkuK3kvY3mlbAgKDIgKyAzKSAvIDIgPSAyLjUKYGBgKirmj5DnpLrvvJoqKi0gYG51bXMxLmxlbmd0aCA9PSBtYAotIGBudW1zMi5sZW5ndGggPT0gbmAKLSBgMCA8PSBtIDw9IDEwMDBgCi0gYDAgPD0gbiA8PSAxMDAwYAotIGAxIDw9IG0gKyBuIDw9IDIwMDBgCi0gYC0xMDYgPD0gbnVtczFbaV0sIG51bXMyW2ldIDw9IDEwNmAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9tZWRpYW4tb2YtdHdvLXNvcnRlZC1hcnJheXMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL21lZGlhbi1vZi10d28tc29ydGVkLWFycmF5cy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqK5Lit5L2N5pWw6L2s5oiQ5Lik5Liq5pyJ5bqP5pWw57uE5ZCI5bm25ZCO55qE56ysIGsg5bCP6Zeu6aKY77ya5q+U6L6D5ZCE6Ieq56ysIGsvMiDkuKrlgJnpgInvvIzkuIDmrKHmt5jmsbDkuI3lj6/og73ljIXlkKvnrZTmoYjnmoTkuIDmrrXjgIIg5pys6aKY5Zu057uV44CM5a+75om+5Lik5Liq5q2j5bqP5pWw57uE55qE5Lit5L2N5pWw44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6YCS5b2SIGYoaSxqLGspIOeahOetlOahiOWni+e7iOaYryBudW1zMVtpLi5dIOS4jiBudW1zMltqLi5dIOWQiOW5tuWQjueahOesrCBrIOWwj+WFg+e0oOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF56ysa+Wwj+eahOWQq+S5ie+8jOWGjeajgOafpemAkuW9kua3mOaxsOWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIGlmIChqID49IG4pIHsKICAgICAgICAgICAgcmV0dXJuIG51bXMxW2kgKyBrIC0gMV07CiAgICAgICAgfQogICAgICAgIGlmIChrID09IDEpIHsKICAgICAgICAgICAgcmV0dXJuIE1hdGgubWluKG51bXMxW2ldLCBudW1zMltqXSk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CiAgICBwcml2YXRlIGludFtdIG51bXMxOwogICAgcHJpdmF0ZSBpbnRbXSBudW1zMjsKCiAgICBwdWJsaWMgZG91YmxlIGZpbmRNZWRpYW5Tb3J0ZWRBcnJheXMoaW50W10gbnVtczEsIGludFtdIG51bXMyKSB7CiAgICAgICAgbSA9IG51bXMxLmxlbmd0aDsKICAgICAgICBuID0gbnVtczIubGVuZ3RoOwogICAgICAgIHRoaXMubnVtczEgPSBudW1zMTsKICAgICAgICB0aGlzLm51bXMyID0gbnVtczI7CiAgICAgICAgaW50IGEgPSBmKDAsIDAsIChtICsgbiArIDEpIC8gMik7CiAgICAgICAgaW50IGIgPSBmKDAsIDAsIChtICsgbiArIDIpIC8gMik7CiAgICAgICAgcmV0dXJuIChhICsgYikgLyAyLjA7CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgZihpbnQgaSwgaW50IGosIGludCBrKSB7CiAgICAgICAgaWYgKGkgPj0gbSkgewogICAgICAgICAgICByZXR1cm4gbnVtczJbaiArIGsgLSAxXTsKICAgICAgICB9CiAgICAgICAgaWYgKGogPj0gbikgewogICAgICAgICAgICByZXR1cm4gbnVtczFbaSArIGsgLSAxXTsKICAgICAgICB9CiAgICAgICAgaWYgKGsgPT0gMSkgewogICAgICAgICAgICByZXR1cm4gTWF0aC5taW4obnVtczFbaV0sIG51bXMyW2pdKTsKICAgICAgICB9CiAgICAgICAgaW50IHAgPSBrIC8gMjsKICAgICAgICBpbnQgeCA9IGkgKyBwIC0gMSA8IG0gPyBudW1zMVtpICsgcCAtIDFdIDogMSA8PCAzMDsKICAgICAgICBpbnQgeSA9IGogKyBwIC0gMSA8IG4gPyBudW1zMltqICsgcCAtIDFdIDogMSA8PCAzMDsKICAgICAgICByZXR1cm4geCA8IHkgPyBmKGkgKyBwLCBqLCBrIC0gcCkgOiBmKGksIGogKyBwLCBrIC0gcCk7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 4
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 4
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 4
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YCS5b2SIGYoaSxqLGspIOeahOetlOahiOWni+e7iOaYryBudW1zMVtpLi5dIOS4jiBudW1zMltqLi5dIOWQiOW5tuWQjueahOesrCBrIOWwj+WFg+e0oOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZpbmRNZWRpYW5Tb3J0ZWRBcnJheXMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Lu75LiA5pWw57uE6ICX5bC95pe255u05o6l5LuO5Y+m5LiA5pWw57uE5Y+W77ybaz0xIOWPluS4pOmmluWFg+e0oOacgOWwj+WAvO+8jOWBtuaVsOaAu+mVv+W6pueahOS4pOWAvOaxguW5s+Wdh+imgeeUqCBkb3VibGXjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5qyhIGsg57qm5YeP5Y2K77yM5pe26Ze0IE8obG9nKG0rbikp77yM6YCS5b2S56m66Ze0IE8obG9nKG0rbikp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Lu75LiA5pWw57uE6ICX5bC95pe255u05o6l5LuO5Y+m5LiA5pWw57uE5Y+W77ybaz0xIOWPluS4pOmmluWFg+e0oOacgOWwj+WAvO+8jOWBtuaVsOaAu+mVv+W6pueahOS4pOWAvOaxguW5s+Wdh+imgeeUqCBkb3VibGXjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZpbmRNZWRpYW5Tb3J0ZWRBcnJheXMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnQgbTsKICAgIHByaXZhdGUgaW50IG47CiAgICBwcml2YXRlIGludFtdIG51bXMxOwogICAgcHJpdmF0ZSBpbnRbXSBudW1zMjsKCiAgICBwdWJsaWMgZG91YmxlIGZpbmRNZWRpYW5Tb3J0ZWRBcnJheXMoaW50W10gbnVtczEsIGludFtdIG51bXMyKSB7CiAgICAgICAgbSA9IG51bXMxLmxlbmd0aDsKICAgICAgICBuID0gbnVtczIubGVuZ3RoOwogICAgICAgIHRoaXMubnVtczEgPSBudW1zMTsKICAgICAgICB0aGlzLm51bXMyID0gbnVtczI7CiAgICAgICAgaW50IGEgPSB7e2JsYW5rXzF9fTsKICAgICAgICBpbnQgYiA9IGYoMCwgMCwgKG0gKyBuICsgMikgLyAyKTsKICAgICAgICByZXR1cm4ge3tibGFua18yfX07CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgZihpbnQgaSwgaW50IGosIGludCBrKSB7CiAgICAgICAgaWYgKGkgPj0gbSkgewogICAgICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICAgICAgfQogICAgICAgIGlmIChqID49IG4pIHsKICAgICAgICAgICAgcmV0dXJuIHt7YmxhbmtfNH19OwogICAgICAgIH0KICAgICAgICBpZiAoayA9PSAxKSB7CiAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzV9fTsKICAgICAgICB9CiAgICAgICAgaW50IHAgPSBrIC8gMjsKICAgICAgICBpbnQgeCA9IGkgKyBwIC0gMSA8IG0gPyBudW1zMVtpICsgcCAtIDFdIDogMSA8PCAzMDsKICAgICAgICBpbnQgeSA9IGogKyBwIC0gMSA8IG4gPyBudW1zMltqICsgcCAtIDFdIDogMSA8PCAzMDsKICAgICAgICByZXR1cm4geCA8IHkgPyBmKGkgKyBwLCBqLCBrIC0gcCkgOiBmKGksIGogKyBwLCBrIC0gcCk7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZigwLCAwLCAobSArIG4gKyAxKSAvIDIpIiwiYmxhbmtfMiI6IihhICsgYikgLyAyLjAiLCJibGFua18zIjoibnVtczJbaiArIGsgLSAxXSIsImJsYW5rXzQiOiJudW1zMVtpICsgayAtIDFdIiwiYmxhbmtfNSI6Ik1hdGgubWluKG51bXMxW2ldLCBudW1zMltqXSkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnrKxr5bCPIiwi6YCS5b2S5reY5rGwIiwi5pWw57uE6ICX5bC9Iiwi5pWw57uEIiwi5LqM5YiG5p+l5om+Iiwi5YiG5rK7Il0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 4
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-69: #20 有效的括号

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    20, 69, CONVERT(FROM_BASE64('5pyJ5pWI55qE5ous5Y+3') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5Y+q5YyF5ousIGAnKCdg77yMYCcpJ2DvvIxgJ3snYO+8jGAnfSdg77yMYCdbJ2DvvIxgJ10nYCDnmoTlrZfnrKbkuLIgYHNgIO+8jOWIpOaWreWtl+espuS4suaYr+WQpuacieaViOOAggoK5pyJ5pWI5a2X56ym5Liy6ZyA5ruh6Laz77yaCgoxLiDlt6bmi6zlj7flv4XpobvnlKjnm7jlkIznsbvlnovnmoTlj7Pmi6zlj7fpl63lkIjjgIIKMi4g5bem5ous5Y+35b+F6aG75Lul5q2j56Gu55qE6aG65bqP6Zet5ZCI44CCCjMuIOavj+S4quWPs+aLrOWPt+mDveacieS4gOS4quWvueW6lOeahOebuOWQjOexu+Wei+eahOW3puaLrOWPt+OAgioq56S65L6LIDHvvJoqKioq6L6T5YWl77yaKipzID0gIigpIioq6L6T5Ye677yaKip0cnVlKirnpLrkvosgMu+8mioqKirovpPlhaXvvJoqKnMgPSAiKClbXXt9Iioq6L6T5Ye677yaKip0cnVlKirnpLrkvosgM++8mioqKirovpPlhaXvvJoqKnMgPSAiKF0iKirovpPlh7rvvJoqKmZhbHNlKirnpLrkvosgNO+8mioqKirovpPlhaXvvJoqKnMgPSAiKFtdKSIqKui+k+WHuu+8mioqdHJ1ZSoq56S65L6LIDXvvJoqKioq6L6T5YWl77yaKipzID0gIihbKV0iKirovpPlh7rvvJoqKmZhbHNlKirmj5DnpLrvvJoqKi0gYDEgPD0gcy5sZW5ndGggPD0gMTA0YAotIGBzYCDku4XnlLHmi6zlj7cgYCcoKVtde30nYCDnu4TmiJAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy92YWxpZC1wYXJlbnRoZXNlcy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvdmFsaWQtcGFyZW50aGVzZXMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('6YGH5bem5ous5Y+35oqK5pyf5pyb55qE5Y+z5ous5Y+35YWl5qCI77yM6YGH5Y+z5ous5Y+35b+F6aG75LiO5qCI6aG25Yy56YWN44CCIOacrOmimOWbtOe7leOAjOacieaViOeahOaLrOWPt+OAjeiQveWunui/meS4gOaooeWei++8muagiOS7juW6leWIsOmhtuS/neWtmOWwmuacqumXreWQiOaLrOWPt+aMiemhuuW6j+acn+W+heeahOmXreWQiOespuWPt+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ous5Y+35Yy56YWN55qE5ZCr5LmJ77yM5YaN5qOA5p+l5pyf5pyb5Y+z5ous5Y+35aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aWYgKGMgPT0gJygnIHx8IGMgPT0gJ3snIHx8IGMgPT0gJ1snKSB7CiAgICAgICAgICAgICAgICBzdGsucHVzaChjKTsKICAgICAgICAgICAgfSBlbHNlIGlmIChzdGsuaXNFbXB0eSgpIHx8ICFtYXRjaChzdGsucG9wKCksIGMpKSB7CiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNWYWxpZChTdHJpbmcgcykgewogICAgICAgIERlcXVlPENoYXJhY3Rlcj4gc3RrID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGZvciAoY2hhciBjIDogcy50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGlmIChjID09ICcoJyB8fCBjID09ICd7JyB8fCBjID09ICdbJykgewogICAgICAgICAgICAgICAgc3RrLnB1c2goYyk7CiAgICAgICAgICAgIH0gZWxzZSBpZiAoc3RrLmlzRW1wdHkoKSB8fCAhbWF0Y2goc3RrLnBvcCgpLCBjKSkgewogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBzdGsuaXNFbXB0eSgpOwogICAgfQoKICAgIHByaXZhdGUgYm9vbGVhbiBtYXRjaChjaGFyIGwsIGNoYXIgcikgewogICAgICAgIHJldHVybiAobCA9PSAnKCcgJiYgciA9PSAnKScpIHx8IChsID09ICd7JyAmJiByID09ICd9JykgfHwgKGwgPT0gJ1snICYmIHIgPT0gJ10nKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 20
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 20
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5qCI5LuO5bqV5Yiw6aG25L+d5a2Y5bCa5pyq6Zet5ZCI5ous5Y+35oyJ6aG65bqP5pyf5b6F55qE6Zet5ZCI56ym5Y+344CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGlzVmFsaWQg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Y+z5ous5Y+35Yiw5p2l5pe25YWI5Yik56m677yb6YGN5Y6G57uT5p2f5qCI5b+F6aG75Li656m644CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+z5ous5Y+35Yiw5p2l5pe25YWI5Yik56m677yb6YGN5Y6G57uT5p2f5qCI5b+F6aG75Li656m644CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGlzVmFsaWQg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gaXNWYWxpZChTdHJpbmcgcykgewogICAgICAgIERlcXVlPENoYXJhY3Rlcj4gc3RrID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGZvciAoY2hhciBjIDogcy50b0NoYXJBcnJheSgpKSB7CiAgICAgICAgICAgIGlmIChjID09ICcoJyB8fCBjID09ICd7JyB8fCBjID09ICdbJykgewogICAgICAgICAgICAgICAgc3RrLnB1c2goYyk7CiAgICAgICAgICAgIH0gZWxzZSBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9CgogICAgcHJpdmF0ZSBib29sZWFuIG1hdGNoKGNoYXIgbCwgY2hhciByKSB7CiAgICAgICAgcmV0dXJuIChsID09ICcoJyAmJiByID09ICcpJykgfHwgKGwgPT0gJ3snICYmIHIgPT0gJ30nKSB8fCAobCA9PSAnWycgJiYgciA9PSAnXScpOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoic3RrLmlzRW1wdHkoKSB8fCAhbWF0Y2goc3RrLnBvcCgpLCBjKSIsImJsYW5rXzIiOiJmYWxzZSIsImJsYW5rXzMiOiJzdGsuaXNFbXB0eSgpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmi6zlj7fljLnphY0iLCLmnJ/mnJvlj7Pmi6zlj7ciLCLmoIgiLCLlrZfnrKbkuLIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 20
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-70: #155 最小栈

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    155, 70, CONVERT(FROM_BASE64('5pyA5bCP5qCI') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('6K6+6K6h5LiA5Liq5pSv5oyBIGBwdXNoYCDvvIxgcG9wYCDvvIxgdG9wYCDmk43kvZzvvIzlubbog73lnKjluLjmlbDml7bpl7TlhoXmo4DntKLliLDmnIDlsI/lhYPntKDnmoTmoIjjgIIKCuWunueOsCBgTWluU3RhY2tgIOexuzoKCi0gYE1pblN0YWNrKClgIOWIneWni+WMluWghuagiOWvueixoeOAggotIGB2b2lkIHB1c2goaW50IHZhbHVlKWAg5bCG5YWD57SgIGB2YWx1ZWAg5o6o5YWl5aCG5qCI44CCCi0gYHZvaWQgcG9wKClgIOWIoOmZpOWghuagiOmhtumDqOeahOWFg+e0oOOAggotIGBpbnQgdG9wKClgIOiOt+WPluWghuagiOmhtumDqOeahOWFg+e0oOOAggotIGBpbnQgZ2V0TWluKClgIOiOt+WPluWghuagiOS4reeahOacgOWwj+WFg+e0oOOAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpe+8mgpbIk1pblN0YWNrIiwicHVzaCIsInB1c2giLCJwdXNoIiwiZ2V0TWluIiwicG9wIiwidG9wIiwiZ2V0TWluIl0KW1tdLFstMl0sWzBdLFstM10sW10sW10sW10sW11dCgrovpPlh7rvvJoKW251bGwsbnVsbCxudWxsLG51bGwsLTMsbnVsbCwwLC0yXQoK6Kej6YeK77yaCk1pblN0YWNrIG1pblN0YWNrID0gbmV3IE1pblN0YWNrKCk7Cm1pblN0YWNrLnB1c2goLTIpOwptaW5TdGFjay5wdXNoKDApOwptaW5TdGFjay5wdXNoKC0zKTsKbWluU3RhY2suZ2V0TWluKCk7ICAgLS0+IOi/lOWbniAtMy4KbWluU3RhY2sucG9wKCk7Cm1pblN0YWNrLnRvcCgpOyAgICAgIC0tPiDov5Tlm54gMC4KbWluU3RhY2suZ2V0TWluKCk7ICAgLS0+IOi/lOWbniAtMi4KYGBgKirmj5DnpLrvvJoqKi0gYC0yMzEgPD0gdmFsIDw9IDIzMSAtIDFgCi0gYHBvcGDjgIFgdG9wYCDlkowgYGdldE1pbmAg5pON5L2c5oC75piv5ZyoKirpnZ7nqbrmoIgqKuS4iuiwg+eUqAotIGBwdXNoYCwgYHBvcGAsIGB0b3BgLCBhbmQgYGdldE1pbmDmnIDlpJrooqvosIPnlKggYDMgKiAxMDRgIOasoQoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL21pbi1zdGFjay8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbWluLXN0YWNrLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5LiA5Liq5qCI5a2Y5pWw5o2u77yM5Y+m5LiA5Liq5qCI5ZCM5q2l5a2Y5oiq6Iez5b2T5YmN5L2N572u55qE5pyA5bCP5YC877yM5oiW5q+P5Liq6IqC54K55ZCM5pe25L+d5a2Y5b2T5YmN5pyA5bCP5YC844CCIOacrOmimOWbtOe7leOAjOacgOWwj+agiOOAjeiQveWunui/meS4gOaooeWei++8muacgOWwj+agiOagiOmhtuWni+e7iOetieS6juaVsOaNruagiOaJgOacieeOsOWtmOWFg+e0oOeahOacgOWwj+WAvOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6L6F5Yqp5pyA5bCP5qCI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5ZCM5q2l5Y6L5qCI5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cHVibGljIHZvaWQgcHVzaChpbnQgdmFsKSB7CiAgICAgICAgc3RrMS5wdXNoKHZhbCk7CiAgICAgICAgc3RrMi5wdXNoKE1hdGgubWluKHZhbCwgc3RrMi5wZWVrKCkpKTsKICAgIH0KCiAgICBwdWJsaWMgdm9pZCBwb3AoKSB7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgTWluU3RhY2sgewogICAgcHJpdmF0ZSBEZXF1ZTxJbnRlZ2VyPiBzdGsxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgcHJpdmF0ZSBEZXF1ZTxJbnRlZ2VyPiBzdGsyID0gbmV3IEFycmF5RGVxdWU8PigpOwoKICAgIHB1YmxpYyBNaW5TdGFjaygpIHsKICAgICAgICBzdGsyLnB1c2goSW50ZWdlci5NQVhfVkFMVUUpOwogICAgfQoKICAgIHB1YmxpYyB2b2lkIHB1c2goaW50IHZhbCkgewogICAgICAgIHN0azEucHVzaCh2YWwpOwogICAgICAgIHN0azIucHVzaChNYXRoLm1pbih2YWwsIHN0azIucGVlaygpKSk7CiAgICB9CgogICAgcHVibGljIHZvaWQgcG9wKCkgewogICAgICAgIHN0azEucG9wKCk7CiAgICAgICAgc3RrMi5wb3AoKTsKICAgIH0KCiAgICBwdWJsaWMgaW50IHRvcCgpIHsKICAgICAgICByZXR1cm4gc3RrMS5wZWVrKCk7CiAgICB9CgogICAgcHVibGljIGludCBnZXRNaW4oKSB7CiAgICAgICAgcmV0dXJuIHN0azIucGVlaygpOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 155
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4) WHERE p.leetcode_number = 155
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5bCP5qCI5qCI6aG25aeL57uI562J5LqO5pWw5o2u5qCI5omA5pyJ546w5a2Y5YWD57Sg55qE5pyA5bCP5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIE1pblN0YWNrIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('55u4562J5pyA5bCP5YC85Lmf6KaB6YeN5aSN5Y6L5YWl77ybcHVzaC9wb3Ag5Lik5qCI5b+F6aG75ZCM5q2l44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5omA5pyJ5pON5L2cIE8oMSnvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('55u4562J5pyA5bCP5YC85Lmf6KaB6YeN5aSN5Y6L5YWl77ybcHVzaC9wb3Ag5Lik5qCI5b+F6aG75ZCM5q2l44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIE1pblN0YWNrIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgTWluU3RhY2sgewogICAgcHJpdmF0ZSBEZXF1ZTxJbnRlZ2VyPiBzdGsxID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgcHJpdmF0ZSBEZXF1ZTxJbnRlZ2VyPiBzdGsyID0gbmV3IEFycmF5RGVxdWU8PigpOwoKICAgIHB1YmxpYyBNaW5TdGFjaygpIHsKICAgICAgICBzdGsyLnt7YmxhbmtfMX19OwogICAgfQoKICAgIHB1YmxpYyB2b2lkIHt7YmxhbmtfMn19IHsKICAgICAgICBzdGsxLnt7YmxhbmtfM319OwogICAgICAgIHN0azIucHVzaChNYXRoLm1pbih2YWwsIHN0azIucGVlaygpKSk7CiAgICB9CgogICAgcHVibGljIHZvaWQgcG9wKCkgewogICAgICAgIHN0azEucG9wKCk7CiAgICAgICAgc3RrMi5wb3AoKTsKICAgIH0KCiAgICBwdWJsaWMgaW50IHRvcCgpIHsKICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9CgogICAgcHVibGljIGludCBnZXRNaW4oKSB7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicHVzaChJbnRlZ2VyLk1BWF9WQUxVRSkiLCJibGFua18yIjoicHVzaChpbnQgdmFsKSIsImJsYW5rXzMiOiJwdXNoKHZhbCkiLCJibGFua180Ijoic3RrMS5wZWVrKCkiLCJibGFua181Ijoic3RrMi5wZWVrKCkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLovoXliqnmnIDlsI/moIgiLCLlkIzmraXljovmoIgiLCJPMeWPluacgOWwjyIsIuagiCIsIuiuvuiuoSJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 155
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-71: #394 字符串解码

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    394, 71, CONVERT(FROM_BASE64('5a2X56ym5Liy6Kej56CB') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq57uP6L+H57yW56CB55qE5a2X56ym5Liy77yM6L+U5Zue5a6D6Kej56CB5ZCO55qE5a2X56ym5Liy44CCCgrnvJbnoIHop4TliJnkuLo6IGBrW2VuY29kZWRfc3RyaW5nXWDvvIzooajnpLrlhbbkuK3mlrnmi6zlj7flhoXpg6jnmoQgYGVuY29kZWRfc3RyaW5nYCDmraPlpb3ph43lpI0gYGtgIOasoeOAguazqOaEjyBga2Ag5L+d6K+B5Li65q2j5pW05pWw44CCCgrkvaDlj6/ku6XorqTkuLrovpPlhaXlrZfnrKbkuLLmgLvmmK/mnInmlYjnmoTvvJvovpPlhaXlrZfnrKbkuLLkuK3msqHmnInpop3lpJbnmoTnqbrmoLzvvIzkuJTovpPlhaXnmoTmlrnmi6zlj7fmgLvmmK/nrKblkIjmoLzlvI/opoHmsYLnmoTjgIIKCuatpOWklu+8jOS9oOWPr+S7peiupOS4uuWOn+Wni+aVsOaNruS4jeWMheWQq+aVsOWtl++8jOaJgOacieeahOaVsOWtl+WPquihqOekuumHjeWkjeeahOasoeaVsCBga2Ag77yM5L6L5aaC5LiN5Lya5Ye6546w5YOPIGAzYWAg5oiWIGAyWzRdYCDnmoTovpPlhaXjgIIKCua1i+ivleeUqOS+i+S/neivgei+k+WHuueahOmVv+W6puS4jeS8mui2hei/hyBgMTA1YOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yacyA9ICIzW2FdMltiY10iCui+k+WHuu+8miJhYWFiY2JjIgpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiM1thMltjXV0iCui+k+WHuu+8miJhY2NhY2NhY2MiCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yacyA9ICIyW2FiY10zW2NkXWVmIgrovpPlh7rvvJoiYWJjYWJjY2RjZGNkZWYiCmBgYCoq56S65L6LIDTvvJoqKmBgYHRleHQK6L6T5YWl77yacyA9ICJhYmMzW2NkXXh5eiIK6L6T5Ye677yaImFiY2NkY2RjZHh5eiIKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gcy5sZW5ndGggPD0gMzBgCi0gYHNgIOeUseWwj+WGmeiLseaWh+Wtl+avjeOAgeaVsOWtl+WSjOaWueaLrOWPtyBgJ1tdJ2Ag57uE5oiQCi0gYHNgIOS/neivgeaYr+S4gOS4qioq5pyJ5pWIKirnmoTovpPlhaXjgIIKLSBgc2Ag5Lit5omA5pyJ5pW05pWw55qE5Y+W5YC86IyD5Zu05Li6IGBbMSwgMzAwXWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9kZWNvZGUtc3RyaW5nLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9kZWNvZGUtc3RyaW5nLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5omr5o+P5a2X56ym5Liy77yM5pWw5a2X57Sv56ev6YeN5aSN5qyh5pWw77yb6YGHIFsg5L+d5a2Y5b2T5YmN5a2X56ym5Liy5ZKM5qyh5pWw5bm26YeN572u77yM6YGHIF0g5by55qCI57uE5ZCI44CCIOacrOmimOWbtOe7leOAjOWtl+espuS4suino+eggeOAjeiQveWunui/meS4gOaooeWei++8muagiOS4reavj+WxguS/neWtmOi/m+WFpeivpeaLrOWPt+WJjeeahOWJjee8gOWSjOivpeWxgumHjeWkjeasoeaVsOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ous5Y+35qCI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5aSa5L2N5qyh5pWw5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fSBlbHNlIGlmIChjID09ICdbJykgewogICAgICAgICAgICAgICAgczEucHVzaChudW0pOwogICAgICAgICAgICAgICAgczIucHVzaChyZXMpOwogICAgICAgICAgICAgICAgbnVtID0gMDsKICAgICAgICAgICAgICAgIHJlcyA9ICIiOwogICAgICAgICAgICB9IGVsc2UgaWYgKGMgPT0gJ10nKSB7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFN0cmluZyBkZWNvZGVTdHJpbmcoU3RyaW5nIHMpIHsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzMSA9IG5ldyBBcnJheURlcXVlPD4oKTsKICAgICAgICBEZXF1ZTxTdHJpbmc+IHMyID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGludCBudW0gPSAwOwogICAgICAgIFN0cmluZyByZXMgPSAiIjsKICAgICAgICBmb3IgKGNoYXIgYyA6IHMudG9DaGFyQXJyYXkoKSkgewogICAgICAgICAgICBpZiAoJzAnIDw9IGMgJiYgYyA8PSAnOScpIHsKICAgICAgICAgICAgICAgIG51bSA9IG51bSAqIDEwICsgYyAtICcwJzsKICAgICAgICAgICAgfSBlbHNlIGlmIChjID09ICdbJykgewogICAgICAgICAgICAgICAgczEucHVzaChudW0pOwogICAgICAgICAgICAgICAgczIucHVzaChyZXMpOwogICAgICAgICAgICAgICAgbnVtID0gMDsKICAgICAgICAgICAgICAgIHJlcyA9ICIiOwogICAgICAgICAgICB9IGVsc2UgaWYgKGMgPT0gJ10nKSB7CiAgICAgICAgICAgICAgICBTdHJpbmdCdWlsZGVyIHQgPSBuZXcgU3RyaW5nQnVpbGRlcigpOwogICAgICAgICAgICAgICAgZm9yIChpbnQgaSA9IDAsIG4gPSBzMS5wb3AoKTsgaSA8IG47ICsraSkgewogICAgICAgICAgICAgICAgICAgIHQuYXBwZW5kKHJlcyk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByZXMgPSBzMi5wb3AoKSArIHQudG9TdHJpbmcoKTsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIHJlcyArPSBTdHJpbmcudmFsdWVPZihjKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gcmVzOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 394
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6YCS5b2S') USING utf8mb4) WHERE p.leetcode_number = 394
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 394
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5qCI5Lit5q+P5bGC5L+d5a2Y6L+b5YWl6K+l5ous5Y+35YmN55qE5YmN57yA5ZKM6K+l5bGC6YeN5aSN5qyh5pWw44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGRlY29kZVN0cmluZyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5aSa5L2N5pWw5a2X6ZyAIG51bT1udW0qMTArZGlnaXTvvJvlj7Pmi6zlj7fnu4TlkIjpobrluo/mmK/lpJblsYLliY3nvIAgKyDlvZPliY3mrrXph43lpI3jgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8o5bGV5byA5ZCO5a2X56ym5Liy6ZW/5bqmKe+8jOepuumXtCBPKOW1jOWll+a3seW6puWPiue7k+aenCnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5aSa5L2N5pWw5a2X6ZyAIG51bT1udW0qMTArZGlnaXTvvJvlj7Pmi6zlj7fnu4TlkIjpobrluo/mmK/lpJblsYLliY3nvIAgKyDlvZPliY3mrrXph43lpI3jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGRlY29kZVN0cmluZyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIFN0cmluZyBkZWNvZGVTdHJpbmcoU3RyaW5nIHMpIHsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzMSA9IG5ldyBBcnJheURlcXVlPD4oKTsKICAgICAgICBEZXF1ZTxTdHJpbmc+IHMyID0gbmV3IEFycmF5RGVxdWU8PigpOwogICAgICAgIGludCBudW0gPSAwOwogICAgICAgIFN0cmluZyByZXMgPSAiIjsKICAgICAgICBmb3IgKGNoYXIgYyA6IHMudG9DaGFyQXJyYXkoKSkgewogICAgICAgICAgICBpZiAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIG51bSA9IG51bSAqIDEwICsgYyAtICcwJzsKICAgICAgICAgICAgfSBlbHNlIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgczEucHVzaChudW0pOwogICAgICAgICAgICAgICAgczIucHVzaChyZXMpOwogICAgICAgICAgICAgICAgbnVtID0gMDsKICAgICAgICAgICAgICAgIHJlcyA9ICIiOwogICAgICAgICAgICB9IGVsc2UgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICBTdHJpbmdCdWlsZGVyIHQgPSBuZXcgU3RyaW5nQnVpbGRlcigpOwogICAgICAgICAgICAgICAgZm9yIChpbnQgaSA9IDAsIG4gPSB7e2JsYW5rXzR9fTsgaSA8IG47ICsraSkgewogICAgICAgICAgICAgICAgICAgIHQuYXBwZW5kKHJlcyk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByZXMgPSB7e2JsYW5rXzV9fTsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIHJlcyArPSBTdHJpbmcudmFsdWVPZihjKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gcmVzOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiJzAnIDw9IGMgJiYgYyA8PSAnOSciLCJibGFua18yIjoiYyA9PSAnWyciLCJibGFua18zIjoiYyA9PSAnXSciLCJibGFua180IjoiczEucG9wKCkiLCJibGFua181IjoiczIucG9wKCkgKyB0LnRvU3RyaW5nKCkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmi6zlj7fmoIgiLCLlpJrkvY3mrKHmlbAiLCLliIblsYLmi7zmjqUiLCLmoIgiLCLpgJLlvZIiLCLlrZfnrKbkuLIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 394
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-72: #739 每日温度

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    739, 72, CONVERT(FROM_BASE64('5q+P5pel5rip5bqm') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pW05pWw5pWw57uEIGB0ZW1wZXJhdHVyZXNgIO+8jOihqOekuuavj+WkqeeahOa4qeW6pu+8jOi/lOWbnuS4gOS4quaVsOe7hCBgYW5zd2VyYCDvvIzlhbbkuK0gYGFuc3dlcltpXWAg5piv5oyH5a+55LqO56ysIGBpYCDlpKnvvIzkuIvkuIDkuKrmm7Tpq5jmuKnluqblh7rnjrDlnKjlh6DlpKnlkI7jgILlpoLmnpzmsJTmuKnlnKjov5nkuYvlkI7pg73kuI3kvJrljYfpq5jvvIzor7flnKjor6XkvY3nva7nlKggYDBgIOadpeS7o+abv+OAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogdGVtcGVyYXR1cmVzID0gWzczLDc0LDc1LDcxLDY5LDcyLDc2LDczXQrovpPlh7o6wqBbMSwxLDQsMiwxLDEsMCwwXQpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IHRlbXBlcmF0dXJlcyA9IFszMCw0MCw1MCw2MF0K6L6T5Ye6OsKgWzEsMSwxLDBdCmBgYCoq56S65L6LIDM6KipgYGB0ZXh0Cui+k+WFpTogdGVtcGVyYXR1cmVzID0gWzMwLDYwLDkwXQrovpPlh7o6IFsxLDEsMF0KYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gdGVtcGVyYXR1cmVzLmxlbmd0aCA8PSAxMDVgCi0gYDMwIDw9IHRlbXBlcmF0dXJlc1tpXSA8PSAxMDBgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvZGFpbHktdGVtcGVyYXR1cmVzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9kYWlseS10ZW1wZXJhdHVyZXMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuO5Y+z5ZCR5bem57u05oqk5rip5bqm5Lil5qC86YCS5aKe55qE5YCZ6YCJ5LiL5qCH5qCI77yb5by55o6J5omA5pyJ5LiN6auY5LqO5b2T5YmN5rip5bqm55qE5LiL5qCH77yM5qCI6aG25bCx5piv5Y+z5L6n5pyA6L+R5pu06auY5rip5bqm44CCIOacrOmimOWbtOe7leOAjOavj+aXpea4qeW6puOAjeiQveWunui/meS4gOaooeWei++8muagiOS4reS4i+agh+WvueW6lOacquadpeS7jeWPr+iDveaIkOS4uuetlOahiOeahOa4qeW6pu+8jOagiOmhtuaYr+W9k+WJjeacgOi/keS4lOS4peagvOabtOmrmOeahOWAmemAieOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LuO5Y+z5omr5o+P55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y2V6LCD5qCI5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('c3RrLnBvcCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmICghc3RrLmlzRW1wdHkoKSkgewogICAgICAgICAgICAgICAgYW5zW2ldID0gc3RrLnBlZWsoKSAtIGk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgc3RrLnB1c2goaSk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIGRhaWx5VGVtcGVyYXR1cmVzKGludFtdIHRlbXBlcmF0dXJlcykgewogICAgICAgIGludCBuID0gdGVtcGVyYXR1cmVzLmxlbmd0aDsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50W10gYW5zID0gbmV3IGludFtuXTsKICAgICAgICBmb3IgKGludCBpID0gbiAtIDE7IGkgPj0gMDsgLS1pKSB7CiAgICAgICAgICAgIHdoaWxlICghc3RrLmlzRW1wdHkoKSAmJiB0ZW1wZXJhdHVyZXNbc3RrLnBlZWsoKV0gPD0gdGVtcGVyYXR1cmVzW2ldKSB7CiAgICAgICAgICAgICAgICBzdGsucG9wKCk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKCFzdGsuaXNFbXB0eSgpKSB7CiAgICAgICAgICAgICAgICBhbnNbaV0gPSBzdGsucGVlaygpIC0gaTsKICAgICAgICAgICAgfQogICAgICAgICAgICBzdGsucHVzaChpKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 739
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 739
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4) WHERE p.leetcode_number = 739
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5qCI5Lit5LiL5qCH5a+55bqU5pyq5p2l5LuN5Y+v6IO95oiQ5Li6562U5qGI55qE5rip5bqm77yM5qCI6aG25piv5b2T5YmN5pyA6L+R5LiU5Lil5qC85pu06auY55qE5YCZ6YCJ44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGRhaWx5VGVtcGVyYXR1cmVzIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5qCI6YeM5b+F6aG75a2Y5LiL5qCH77yb55u4562J5rip5bqm5Lmf6KaB5by55Ye677yM5Zug5Li66aKY55uu6KaB5rGC5Lil5qC85pu06auY44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5Liq5LiL5qCH5YWl5qCI5Ye65qCI5LiA5qyh77yM5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5qCI6YeM5b+F6aG75a2Y5LiL5qCH77yb55u4562J5rip5bqm5Lmf6KaB5by55Ye677yM5Zug5Li66aKY55uu6KaB5rGC5Lil5qC85pu06auY44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGRhaWx5VGVtcGVyYXR1cmVzIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIGRhaWx5VGVtcGVyYXR1cmVzKGludFtdIHRlbXBlcmF0dXJlcykgewogICAgICAgIGludCBuID0gdGVtcGVyYXR1cmVzLmxlbmd0aDsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50W10gYW5zID0gbmV3IGludFtuXTsKICAgICAgICBmb3IgKGludCBpID0gbiAtIDE7IGkgPj0gMDsgLS1pKSB7CiAgICAgICAgICAgIHdoaWxlICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgc3RrLnBvcCgpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgYW5zW2ldID0gc3RrLnBlZWsoKSAtIGk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgc3RrLnB1c2goaSk7CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiIXN0ay5pc0VtcHR5KCkgJiYgdGVtcGVyYXR1cmVzW3N0ay5wZWVrKCldIDw9IHRlbXBlcmF0dXJlc1tpXSIsImJsYW5rXzIiOiIhc3RrLmlzRW1wdHkoKSIsImJsYW5rXzMiOiJhbnMifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLku47lj7Pmiavmj48iLCLljZXosIPmoIgiLCLmnIDov5Hmm7Tpq5giLCLmoIgiLCLmlbDnu4QiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 739
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-73: #84 柱状图中最大的矩形

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    84, 73, CONVERT(FROM_BASE64('5p+x54q25Zu+5Lit5pyA5aSn55qE55+p5b2i') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5a6aICpuKiDkuKrpnZ7otJ/mlbTmlbDvvIznlKjmnaXooajnpLrmn7Hnirblm77kuK3lkITkuKrmn7HlrZDnmoTpq5jluqbjgILmr4/kuKrmn7HlrZDlvbzmraTnm7jpgrvvvIzkuJTlrr3luqbkuLogMSDjgIIKCuaxguWcqOivpeafseeKtuWbvuS4re+8jOiDveWkn+WLvuWLkuWHuuadpeeahOefqeW9oueahOacgOWkp+mdouenr+OAgioq56S65L6LIDE6KiohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9hc3NldHMubGVldGNvZGUuY29tL3VwbG9hZHMvMjAyMS8wMS8wNC9oaXN0b2dyYW0uanBnKQoKYGBgdGV4dArovpPlhaXvvJpoZWlnaHRzID0gWzIsMSw1LDYsMiwzXQrovpPlh7rvvJoxMArop6Pph4rvvJrmnIDlpKfnmoTnn6nlvaLkuLrlm77kuK3nuqLoibLljLrln5/vvIzpnaLnp6/kuLogMTAKYGBgKirnpLrkvosgMu+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjEvMDEvMDQvaGlzdG9ncmFtLTEuanBnKQoKYGBgdGV4dArovpPlhaXvvJogaGVpZ2h0cyA9IFsyLDRdCui+k+WHuu+8miA0CmBgYCoq5o+Q56S677yaKiotIGAxIDw9IGhlaWdodHMubGVuZ3RoIDw9MTA1YAotIGAwIDw9IGhlaWdodHNbaV0gPD0gMTA0YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2xhcmdlc3QtcmVjdGFuZ2xlLWluLWhpc3RvZ3JhbS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbGFyZ2VzdC1yZWN0YW5nbGUtaW4taGlzdG9ncmFtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5Y2V6LCD6YCS5aKe5qCI5L+d5a2Y5p+x5LiL5qCH77yb6YGH5pu055+u5p+x5pe25by55Ye66auY5bqm77yM5Lul5paw5qCI6aG25ZKM5b2T5YmN5L2N572u56Gu5a6a5YW25pyA5aSn5a695bqm44CCIOacrOmimOWbtOe7leOAjOafseeKtuWbvuS4reacgOWkp+eahOefqeW9ouOAjeiQveWunui/meS4gOaooeWei++8muagiOS4reafsemrmOWNleiwg+mAkuWinu+8jOW8ueWHuuafseeahOW3puWPs+esrOS4gOS4quabtOefrui+ueeVjOatpOWIu+mDveW3suehruWumuOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y2V6LCD6YCS5aKe5qCI55qE5ZCr5LmJ77yM5YaN5qOA5p+l5bem5Y+z6L6555WM5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('c3RrLnB1c2goaSk7CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIHJlcyA9IE1hdGgubWF4KHJlcywgaGVpZ2h0c1tpXSAqIChyaWdodFtpXSAtIGxlZnRbaV0gLSAxKSk7CiAgICAgICAgfQogICAgICAgIHJldHVybiByZXM7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsYXJnZXN0UmVjdGFuZ2xlQXJlYShpbnRbXSBoZWlnaHRzKSB7CiAgICAgICAgaW50IHJlcyA9IDAsIG4gPSBoZWlnaHRzLmxlbmd0aDsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50W10gbGVmdCA9IG5ldyBpbnRbbl07CiAgICAgICAgaW50W10gcmlnaHQgPSBuZXcgaW50W25dOwogICAgICAgIEFycmF5cy5maWxsKHJpZ2h0LCBuKTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICB3aGlsZSAoIXN0ay5pc0VtcHR5KCkgJiYgaGVpZ2h0c1tzdGsucGVlaygpXSA+PSBoZWlnaHRzW2ldKSB7CiAgICAgICAgICAgICAgICByaWdodFtzdGsucG9wKCldID0gaTsKICAgICAgICAgICAgfQogICAgICAgICAgICBsZWZ0W2ldID0gc3RrLmlzRW1wdHkoKSA/IC0xIDogc3RrLnBlZWsoKTsKICAgICAgICAgICAgc3RrLnB1c2goaSk7CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIHJlcyA9IE1hdGgubWF4KHJlcywgaGVpZ2h0c1tpXSAqIChyaWdodFtpXSAtIGxlZnRbaV0gLSAxKSk7CiAgICAgICAgfQogICAgICAgIHJldHVybiByZXM7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 84
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 84
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y2V6LCD5qCI') USING utf8mb4) WHERE p.leetcode_number = 84
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5qCI5Lit5p+x6auY5Y2V6LCD6YCS5aKe77yM5by55Ye65p+x55qE5bem5Y+z56ys5LiA5Liq5pu055+u6L6555WM5q2k5Yi76YO95bey56Gu5a6a44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxhcmdlc3RSZWN0YW5nbGVBcmVhIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6ZyA6KaB6aaW5bC+5ZOo5YW157uT566X5omA5pyJ5p+x77yb5by55qCI5ZCO5a695bqm5pivIHJpZ2h0LWxlZnQtMeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5Liq5p+x5YWl5qCI5Ye65qCI5LiA5qyh77yM5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6ZyA6KaB6aaW5bC+5ZOo5YW157uT566X5omA5pyJ5p+x77yb5by55qCI5ZCO5a695bqm5pivIHJpZ2h0LWxlZnQtMeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxhcmdlc3RSZWN0YW5nbGVBcmVhIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsYXJnZXN0UmVjdGFuZ2xlQXJlYShpbnRbXSBoZWlnaHRzKSB7CiAgICAgICAgaW50IHJlcyA9IDAsIG4gPSBoZWlnaHRzLmxlbmd0aDsKICAgICAgICBEZXF1ZTxJbnRlZ2VyPiBzdGsgPSBuZXcgQXJyYXlEZXF1ZTw+KCk7CiAgICAgICAgaW50W10gbGVmdCA9IG5ldyBpbnRbbl07CiAgICAgICAgaW50W10gcmlnaHQgPSBuZXcgaW50W25dOwogICAgICAgIEFycmF5cy5maWxsKHJpZ2h0LCBuKTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgICAgIHJpZ2h0W3N0ay5wb3AoKV0gPSBpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGxlZnRbaV0gPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgc3RrLnB1c2goaSk7CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIHJlcyA9IHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiIXN0ay5pc0VtcHR5KCkgJiYgaGVpZ2h0c1tzdGsucGVlaygpXSA+PSBoZWlnaHRzW2ldIiwiYmxhbmtfMiI6InN0ay5pc0VtcHR5KCkgPyAtMSA6IHN0ay5wZWVrKCkiLCJibGFua18zIjoiTWF0aC5tYXgocmVzLCBoZWlnaHRzW2ldICogKHJpZ2h0W2ldIC0gbGVmdFtpXSAtIDEpKSIsImJsYW5rXzQiOiJyZXMifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLljZXosIPpgJLlop7moIgiLCLlt6blj7PovrnnlYwiLCLlk6jlhbUiLCLmoIgiLCLmlbDnu4QiLCLljZXosIPmoIgiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 84
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-74: #215 数组中的第K个最大元素

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    215, 74, CONVERT(FROM_BASE64('5pWw57uE5Lit55qE56ysS+S4quacgOWkp+WFg+e0oA==') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5pW05pWw5pWw57uEIGBudW1zYCDlkozmlbTmlbAgYGtg77yM6K+36L+U5Zue5pWw57uE5Lit56ysIGBrYCDkuKrmnIDlpKfnmoTlhYPntKDjgIIKCuivt+azqOaEj++8jOS9oOmcgOimgeaJvueahOaYr+aVsOe7hOaOkuW6j+WQjueahOesrCBga2Ag5Liq5pyA5aSn55qE5YWD57Sg77yM6ICM5LiN5piv56ysIGBrYCDkuKrkuI3lkIznmoTlhYPntKDjgIIKCuS9oOW/hemhu+iuvuiuoeW5tuWunueOsOaXtumXtOWkjeadguW6puS4uiBgTyhuKWAg55qE566X5rOV6Kej5Yaz5q2k6Zeu6aKY44CCKirnpLrkvosgMToqKmBgYHRleHQK6L6T5YWlOiBbMywyLDEsNSw2LDRdLCBrID0gMgrovpPlh7o6IDUKYGBgKirnpLrkvosgMjoqKmBgYHRleHQK6L6T5YWlOiBbMywyLDMsMSwyLDQsNSw1LDZdLCBrID0gNArovpPlh7o6IDQKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gayA8PSBudW1zLmxlbmd0aCA8PSAxMDVgCi0gYC0xMDQgPD0gbnVtc1tpXSA8PSAxMDRgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMva3RoLWxhcmdlc3QtZWxlbWVudC1pbi1hbi1hcnJheS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMva3RoLWxhcmdlc3QtZWxlbWVudC1pbi1hbi1hcnJheS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('55So5b+r6YCf6YCJ5oup5oyJ5p6i6L205YiG5Yy677yM5Y+q6YCS5b2S5YyF5ZCr56ysIG4tayDlsI/kvY3nva7nmoTkuIDkvqfjgIIg5pys6aKY5Zu057uV44CM5pWw57uE5Lit55qE56ysS+S4quacgOWkp+WFg+e0oOOAjeiQveWunui/meS4gOaooeWei++8muavj+asoeWIhuWMuuWQjuaeoui9tOS9jeS6juacgOe7iOS9jee9ru+8jOebruagh+S4i+agh+WPquWPr+iDveS9jeS6juWFtuS4gOS+p+aIluWwseaYr+aeoui9tOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5b+r6YCf6YCJ5oup55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YiG5Yy65aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('d2hpbGUgKG51bXNbKytpXSA8IHgpIHsKICAgICAgICAgICAgfQogICAgICAgICAgICB3aGlsZSAobnVtc1stLWpdID4geCkgewogICAgICAgICAgICB9CiAgICAgICAgICAgIGlmIChpIDwgaikgewogICAgICAgICAgICAgICAgaW50IHQgPSBudW1zW2ldOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBudW1zOwogICAgcHJpdmF0ZSBpbnQgazsKCiAgICBwdWJsaWMgaW50IGZpbmRLdGhMYXJnZXN0KGludFtdIG51bXMsIGludCBrKSB7CiAgICAgICAgdGhpcy5udW1zID0gbnVtczsKICAgICAgICB0aGlzLmsgPSBudW1zLmxlbmd0aCAtIGs7CiAgICAgICAgcmV0dXJuIHF1aWNrU29ydCgwLCBudW1zLmxlbmd0aCAtIDEpOwogICAgfQoKICAgIHByaXZhdGUgaW50IHF1aWNrU29ydChpbnQgbCwgaW50IHIpIHsKICAgICAgICBpZiAobCA9PSByKSB7CiAgICAgICAgICAgIHJldHVybiBudW1zW2xdOwogICAgICAgIH0KICAgICAgICBpbnQgaSA9IGwgLSAxLCBqID0gciArIDE7CiAgICAgICAgaW50IHggPSBudW1zWyhsICsgcikgPj4+IDFdOwogICAgICAgIHdoaWxlIChpIDwgaikgewogICAgICAgICAgICB3aGlsZSAobnVtc1srK2ldIDwgeCkgewogICAgICAgICAgICB9CiAgICAgICAgICAgIHdoaWxlIChudW1zWy0tal0gPiB4KSB7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKGkgPCBqKSB7CiAgICAgICAgICAgICAgICBpbnQgdCA9IG51bXNbaV07CiAgICAgICAgICAgICAgICBudW1zW2ldID0gbnVtc1tqXTsKICAgICAgICAgICAgICAgIG51bXNbal0gPSB0OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGlmIChqIDwgaykgewogICAgICAgICAgICByZXR1cm4gcXVpY2tTb3J0KGogKyAxLCByKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHF1aWNrU29ydChsLCBqKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5b+r6YCf6YCJ5oup') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5b+r6YCf6YCJ5oup') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4) WHERE p.leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5qyh5YiG5Yy65ZCO5p6i6L205L2N5LqO5pyA57uI5L2N572u77yM55uu5qCH5LiL5qCH5Y+q5Y+v6IO95L2N5LqO5YW25LiA5L6n5oiW5bCx5piv5p6i6L2044CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZpbmRLdGhMYXJnZXN0IOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('56ysIGsg5aSn5a+55bqU5Y2H5bqP5LiL5qCHIG4ta++8m+maj+acuuaeoui9tOWPr+mBv+WFjeacieW6j+i+k+WFpemAgOWMluOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5bmz5Z2H5pe26Ze0IE8obinvvIzmnIDlnY8gTyhuwrIp77yM5Y6f5Zyw56m66Ze0IE8obG9nIG4pIOmAkuW9kuagiOOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('56ysIGsg5aSn5a+55bqU5Y2H5bqP5LiL5qCHIG4ta++8m+maj+acuuaeoui9tOWPr+mBv+WFjeacieW6j+i+k+WFpemAgOWMluOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZpbmRLdGhMYXJnZXN0IOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBpbnRbXSBudW1zOwogICAgcHJpdmF0ZSBpbnQgazsKCiAgICBwdWJsaWMgaW50IGZpbmRLdGhMYXJnZXN0KGludFtdIG51bXMsIGludCBrKSB7CiAgICAgICAgdGhpcy5udW1zID0gbnVtczsKICAgICAgICB0aGlzLmsgPSBudW1zLmxlbmd0aCAtIGs7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfMX19OwogICAgfQoKICAgIHByaXZhdGUgaW50IHF1aWNrU29ydChpbnQgbCwgaW50IHIpIHsKICAgICAgICBpZiAobCA9PSByKSB7CiAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzJ9fTsKICAgICAgICB9CiAgICAgICAgaW50IGkgPSBsIC0gMSwgaiA9IHIgKyAxOwogICAgICAgIGludCB4ID0gbnVtc1sobCArIHIpID4+PiAxXTsKICAgICAgICB3aGlsZSAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgd2hpbGUgKG51bXNbKytpXSA8IHgpIHsKICAgICAgICAgICAgfQogICAgICAgICAgICB3aGlsZSAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgfQogICAgICAgICAgICBpZiAoaSA8IGopIHsKICAgICAgICAgICAgICAgIGludCB0ID0gbnVtc1tpXTsKICAgICAgICAgICAgICAgIG51bXNbaV0gPSB7e2JsYW5rXzV9fTsKICAgICAgICAgICAgICAgIG51bXNbal0gPSB0OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGlmIChqIDwgaykgewogICAgICAgICAgICByZXR1cm4gcXVpY2tTb3J0KGogKyAxLCByKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHF1aWNrU29ydChsLCBqKTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicXVpY2tTb3J0KDAsIG51bXMubGVuZ3RoIC0gMSkiLCJibGFua18yIjoibnVtc1tsXSIsImJsYW5rXzMiOiJpIDwgaiIsImJsYW5rXzQiOiJudW1zWy0tal0gPiB4IiwiYmxhbmtfNSI6Im51bXNbal0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlv6vpgJ/pgInmi6kiLCLliIbljLoiLCJuLWsiLCLmlbDnu4QiLCLliIbmsrsiLCLmjpLluo8iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 215
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-75: #347 前 K 个高频元素

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    347, 75, CONVERT(FROM_BASE64('5YmNIEsg5Liq6auY6aKR5YWD57Sg') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDlkozkuIDkuKrmlbTmlbAgYGtgIO+8jOivt+S9oOi/lOWbnuWFtuS4reWHuueOsOmikeeOh+WJjSBga2Ag6auY55qE5YWD57Sg44CC5L2g5Y+v5Lul5oyJKirku7vmhI/pobrluo8qKui/lOWbnuetlOahiOOAgioq56S65L6LIDHvvJoqKioq6L6T5YWl77yaKipudW1zID0gWzEsMSwxLDIsMiwzXSwgayA9IDIqKui+k+WHuu+8mioqWzEsMl0qKuekuuS+iyAy77yaKioqKui+k+WFpe+8mioqbnVtcyA9IFsxXSwgayA9IDEqKui+k+WHuu+8mioqWzFdKirnpLrkvosgM++8mioqKirovpPlhaXvvJoqKm51bXMgPSBbMSwyLDEsMiwxLDIsMywxLDMsMl0sIGsgPSAyKirovpPlh7rvvJoqKlsxLDJdKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTA1YAotIGAtMTA0IDw9IG51bXNbaV0gPD0gMTA0YAotIGBrYCDnmoTlj5blgLzojIPlm7TmmK8gYFsxLCDmlbDnu4TkuK3kuI3nm7jlkIznmoTlhYPntKDnmoTkuKrmlbBdYAotIOmimOebruaVsOaNruS/neivgeetlOahiOWUr+S4gO+8jOaNouWPpeivneivtO+8jOaVsOe7hOS4reWJjSBga2Ag5Liq6auY6aKR5YWD57Sg55qE6ZuG5ZCI5piv5ZSv5LiA55qEKirov5vpmLbvvJoqKuS9oOaJgOiuvuiuoeeul+azleeahOaXtumXtOWkjeadguW6pioq5b+F6aG7KirkvJjkuo4gYE8obiBsb2cgbilgIO+8jOWFtuS4rSBgbmAqKuaYr+aVsOe7hOWkp+Wwj+OAggoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3RvcC1rLWZyZXF1ZW50LWVsZW1lbnRzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy90b3Atay1mcmVxdWVudC1lbGVtZW50cy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI57uf6K6h6aKR5qyh77yM5YaN57u05oqk5aSn5bCP5Li6IGsg55qE5bCP5qC55aCG77yM5aCG6aG25piv5b2T5YmN5YmNIGsg6auY6aKR5Lit6aKR5qyh5pyA5L2O6ICF44CCIOacrOmimOWbtOe7leOAjOWJjSBLIOS4qumrmOmikeWFg+e0oOOAjeiQveWunui/meS4gOaooeWei++8muWkhOeQhuWujOS7u+aEj+WJjee8gOWQju+8jOWghuS4reS/neeVmeivpeWJjee8gOmikeasoeacgOmrmOeahOiHs+WkmiBrIOS4quWFg+e0oOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6aKR5qyh5ZOI5biM55qE5ZCr5LmJ77yM5YaN5qOA5p+l5aSn5bCPa+Wwj+agueWghuWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yICh2YXIgZSA6IGNudC5lbnRyeVNldCgpKSB7CiAgICAgICAgICAgIHBxLm9mZmVyKGUpOwogICAgICAgICAgICBpZiAocHEuc2l6ZSgpID4gaykgewogICAgICAgICAgICAgICAgcHEucG9sbCgpOwogICAgICAgICAgICB9CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHRvcEtGcmVxdWVudChpbnRbXSBudW1zLCBpbnQgaykgewogICAgICAgIE1hcDxJbnRlZ2VyLCBJbnRlZ2VyPiBjbnQgPSBuZXcgSGFzaE1hcDw+KCk7CiAgICAgICAgZm9yIChpbnQgeCA6IG51bXMpIHsKICAgICAgICAgICAgY250Lm1lcmdlKHgsIDEsIEludGVnZXI6OnN1bSk7CiAgICAgICAgfQogICAgICAgIFByaW9yaXR5UXVldWU8TWFwLkVudHJ5PEludGVnZXIsIEludGVnZXI+PiBwcQogICAgICAgICAgICA9IG5ldyBQcmlvcml0eVF1ZXVlPD4oQ29tcGFyYXRvci5jb21wYXJpbmdJbnQoTWFwLkVudHJ5OjpnZXRWYWx1ZSkpOwogICAgICAgIGZvciAodmFyIGUgOiBjbnQuZW50cnlTZXQoKSkgewogICAgICAgICAgICBwcS5vZmZlcihlKTsKICAgICAgICAgICAgaWYgKHBxLnNpemUoKSA+IGspIHsKICAgICAgICAgICAgICAgIHBxLnBvbGwoKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gcHEuc3RyZWFtKCkubWFwVG9JbnQoTWFwLkVudHJ5OjpnZXRLZXkpLnRvQXJyYXkoKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qG25o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qG25o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6h5pWw') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6h5pWw') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5b+r6YCf6YCJ5oup') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5b+r6YCf6YCJ5oup') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4) WHERE p.leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5a6M5Lu75oSP5YmN57yA5ZCO77yM5aCG5Lit5L+d55WZ6K+l5YmN57yA6aKR5qyh5pyA6auY55qE6Iez5aSaIGsg5Liq5YWD57Sg44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHRvcEtGcmVxdWVudCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5q+U6L6D5Zmo5oyJ6aKR5qyh6ICM6Z2e5pWw5YC877yb5aCG6LaF6L+HIGsg5ZCO5YaN5by55Ye677yM6L6T5Ye66aG65bqP6YCa5bi45LiN6ZmQ44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('57uf6K6hIE8obinvvIzloIbpmLbmrrUgTyhtIGxvZyBrKe+8jOepuumXtCBPKG0p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+U6L6D5Zmo5oyJ6aKR5qyh6ICM6Z2e5pWw5YC877yb5aCG6LaF6L+HIGsg5ZCO5YaN5by55Ye677yM6L6T5Ye66aG65bqP6YCa5bi45LiN6ZmQ44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHRvcEtGcmVxdWVudCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludFtdIHRvcEtGcmVxdWVudChpbnRbXSBudW1zLCBpbnQgaykgewogICAgICAgIE1hcDxJbnRlZ2VyLCBJbnRlZ2VyPiBjbnQgPSBuZXcgSGFzaE1hcDw+KCk7CiAgICAgICAgZm9yIChpbnQgeCA6IG51bXMpIHsKICAgICAgICAgICAgY250Lm1lcmdlKHgsIDEsIEludGVnZXI6OnN1bSk7CiAgICAgICAgfQogICAgICAgIFByaW9yaXR5UXVldWU8TWFwLkVudHJ5PEludGVnZXIsIEludGVnZXI+PiBwcQogICAgICAgICAgICA9IG5ldyBQcmlvcml0eVF1ZXVlPD4oQ29tcGFyYXRvci5jb21wYXJpbmdJbnQoTWFwLkVudHJ5OjpnZXRWYWx1ZSkpOwogICAgICAgIGZvciAodmFyIGUgOiBjbnQuZW50cnlTZXQoKSkgewogICAgICAgICAgICBwcS57e2JsYW5rXzF9fTsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICBwcS57e2JsYW5rXzN9fTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoib2ZmZXIoZSkiLCJibGFua18yIjoicHEuc2l6ZSgpID4gayIsImJsYW5rXzMiOiJwb2xsKCkiLCJibGFua180IjoicHEuc3RyZWFtKCkubWFwVG9JbnQoTWFwLkVudHJ5OjpnZXRLZXkpLnRvQXJyYXkoKSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpopHmrKHlk4jluIwiLCLlpKflsI9r5bCP5qC55aCGIiwi5aCG6aG25reY5rGwIiwi5pWw57uEIiwi5ZOI5biM6KGoIiwi5YiG5rK7Il0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 347
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-76: #295 数据流的中位数

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    295, 76, CONVERT(FROM_BASE64('5pWw5o2u5rWB55qE5Lit5L2N5pWw') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('KirkuK3kvY3mlbAqKuaYr+acieW6j+aVtOaVsOWIl+ihqOS4reeahOS4remXtOWAvOOAguWmguaenOWIl+ihqOeahOWkp+Wwj+aYr+WBtuaVsO+8jOWImeayoeacieS4remXtOWAvO+8jOS4reS9jeaVsOaYr+S4pOS4quS4remXtOWAvOeahOW5s+Wdh+WAvOOAggoKLSDkvovlpoIgYGFyciA9IFsyLDMsNF1gIOeahOS4reS9jeaVsOaYryBgM2Ag44CCCi0g5L6L5aaCIGBhcnIgPSBbMiwzXWAg55qE5Lit5L2N5pWw5pivIGAoMiArIDMpIC8gMiA9IDIuNWAg44CCCgrlrp7njrAgTWVkaWFuRmluZGVyIOexuzoKCi0gYE1lZGlhbkZpbmRlcigpYCDliJ3lp4vljJYgYE1lZGlhbkZpbmRlcmAg5a+56LGh44CCCi0gYHZvaWQgYWRkTnVtKGludCBudW0pYCDlsIbmlbDmja7mtYHkuK3nmoTmlbTmlbAgYG51bWAg5re75Yqg5Yiw5pWw5o2u57uT5p6E5Lit44CCCi0gYGRvdWJsZSBmaW5kTWVkaWFuKClgIOi/lOWbnuWIsOebruWJjeS4uuatouaJgOacieWFg+e0oOeahOS4reS9jeaVsOOAguS4juWunumZheetlOahiOebuOW3riBgMTAtNWAg5Lul5YaF55qE562U5qGI5bCG6KKr5o6l5Y+X44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaUKWyJNZWRpYW5GaW5kZXIiLCAiYWRkTnVtIiwgImFkZE51bSIsICJmaW5kTWVkaWFuIiwgImFkZE51bSIsICJmaW5kTWVkaWFuIl0KW1tdLCBbMV0sIFsyXSwgW10sIFszXSwgW11dCui+k+WHugpbbnVsbCwgbnVsbCwgbnVsbCwgMS41LCBudWxsLCAyLjBdCgrop6Pph4oKTWVkaWFuRmluZGVyIG1lZGlhbkZpbmRlciA9IG5ldyBNZWRpYW5GaW5kZXIoKTsKbWVkaWFuRmluZGVyLmFkZE51bSgxKTsgICAgLy8gYXJyID0gWzFdCm1lZGlhbkZpbmRlci5hZGROdW0oMik7ICAgIC8vIGFyciA9IFsxLCAyXQptZWRpYW5GaW5kZXIuZmluZE1lZGlhbigpOyAvLyDov5Tlm54gMS41ICgoMSArIDIpIC8gMikKbWVkaWFuRmluZGVyLmFkZE51bSgzKTsgICAgLy8gYXJyWzEsIDIsIDNdCm1lZGlhbkZpbmRlci5maW5kTWVkaWFuKCk7IC8vIHJldHVybiAyLjAKYGBgKirmj5DnpLo6KiotIGAtMTA1IDw9IG51bSA8PSAxMDVgCi0g5Zyo6LCD55SoIGBmaW5kTWVkaWFuYCDkuYvliY3vvIzmlbDmja7nu5PmnoTkuK3oh7PlsJHmnInkuIDkuKrlhYPntKAKLSDmnIDlpJogYDUgKiAxMDRgIOasoeiwg+eUqCBgYWRkTnVtYCDlkowgYGZpbmRNZWRpYW5gCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvZmluZC1tZWRpYW4tZnJvbS1kYXRhLXN0cmVhbS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvZmluZC1tZWRpYW4tZnJvbS1kYXRhLXN0cmVhbS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5aSn5qC55aCG5a2Y6L6D5bCP5LiA5Y2K77yM5bCP5qC55aCG5a2Y6L6D5aSn5LiA5Y2K77yM5L+d5oyBIHNpemUg5beu5LiN6LaF6L+HIDEg5LiU5YmN6ICF5YWD57Sg6YO95LiN5aSn5LqO5ZCO6ICF44CCIOacrOmimOWbtOe7leOAjOaVsOaNrua1geeahOS4reS9jeaVsOOAjeiQveWunui/meS4gOaooeWei++8muS4pOWghuacieW6j+WIhuWJsuWFqOmDqOaVsOaNru+8jOi+g+Wkp+WghuiHs+WkmuWkmuS4gOS4quWFg+e0oOOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y+M5aCG55qE5ZCr5LmJ77yM5YaN5qOA5p+l5aSn5bCP5bmz6KGh5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('bWF4US5vZmZlcihudW0pOwogICAgICAgIG1pblEub2ZmZXIobWF4US5wb2xsKCkpOwogICAgICAgIGlmIChtaW5RLnNpemUoKSAtIG1heFEuc2l6ZSgpID4gMSkgewogICAgICAgICAgICBtYXhRLm9mZmVyKG1pblEucG9sbCgpKTsKICAgICAgICB9CiAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgTWVkaWFuRmluZGVyIHsKICAgIHByaXZhdGUgUHJpb3JpdHlRdWV1ZTxJbnRlZ2VyPiBtaW5RID0gbmV3IFByaW9yaXR5UXVldWU8PigpOwogICAgcHJpdmF0ZSBQcmlvcml0eVF1ZXVlPEludGVnZXI+IG1heFEgPSBuZXcgUHJpb3JpdHlRdWV1ZTw+KENvbGxlY3Rpb25zLnJldmVyc2VPcmRlcigpKTsKCiAgICBwdWJsaWMgTWVkaWFuRmluZGVyKCkgewogICAgfQoKICAgIHB1YmxpYyB2b2lkIGFkZE51bShpbnQgbnVtKSB7CiAgICAgICAgbWF4US5vZmZlcihudW0pOwogICAgICAgIG1pblEub2ZmZXIobWF4US5wb2xsKCkpOwogICAgICAgIGlmIChtaW5RLnNpemUoKSAtIG1heFEuc2l6ZSgpID4gMSkgewogICAgICAgICAgICBtYXhRLm9mZmVyKG1pblEucG9sbCgpKTsKICAgICAgICB9CiAgICB9CgogICAgcHVibGljIGRvdWJsZSBmaW5kTWVkaWFuKCkgewogICAgICAgIHJldHVybiBtaW5RLnNpemUoKSA9PSBtYXhRLnNpemUoKSA/ICgobG9uZykgbWluUS5wZWVrKCkgKyBtYXhRLnBlZWsoKSkgLyAyLjAgOiBtaW5RLnBlZWsoKTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6+6K6h') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5o2u5rWB') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5o2u5rWB') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aCG77yI5LyY5YWI6Zif5YiX77yJ') USING utf8mb4) WHERE p.leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Lik5aCG5pyJ5bqP5YiG5Ymy5YWo6YOo5pWw5o2u77yM6L6D5aSn5aCG6Iez5aSa5aSa5LiA5Liq5YWD57Sg44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIE1lZGlhbkZpbmRlciDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5o+S5YWl5ZCO6KaB5oyJ5Zu65a6a6aG65bqP5pCs6L+Q5bm25bmz6KGh77yb5YG25pWw5Liq5YWD57Sg5rGC5bmz5Z2H5pe255SoIGRvdWJsZSDpmLLmlbTpmaTlkozmuqLlh7rjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('YWRkTnVtIE8obG9nIG4p77yMZmluZE1lZGlhbiBPKDEp77yM56m66Ze0IE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5o+S5YWl5ZCO6KaB5oyJ5Zu65a6a6aG65bqP5pCs6L+Q5bm25bmz6KGh77yb5YG25pWw5Liq5YWD57Sg5rGC5bmz5Z2H5pe255SoIGRvdWJsZSDpmLLmlbTpmaTlkozmuqLlh7rjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIE1lZGlhbkZpbmRlciDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgTWVkaWFuRmluZGVyIHsKICAgIHByaXZhdGUgUHJpb3JpdHlRdWV1ZTxJbnRlZ2VyPiBtaW5RID0gbmV3IFByaW9yaXR5UXVldWU8PigpOwogICAgcHJpdmF0ZSBQcmlvcml0eVF1ZXVlPEludGVnZXI+IG1heFEgPSBuZXcgUHJpb3JpdHlRdWV1ZTw+KENvbGxlY3Rpb25zLnJldmVyc2VPcmRlcigpKTsKCiAgICBwdWJsaWMgTWVkaWFuRmluZGVyKCkgewogICAgfQoKICAgIHB1YmxpYyB2b2lkIGFkZE51bShpbnQgbnVtKSB7CiAgICAgICAgbWF4US57e2JsYW5rXzF9fTsKICAgICAgICBtaW5RLnt7YmxhbmtfMn19OwogICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICBtYXhRLnt7YmxhbmtfNH19OwogICAgICAgIH0KICAgIH0KCiAgICBwdWJsaWMgZG91YmxlIGZpbmRNZWRpYW4oKSB7CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoib2ZmZXIobnVtKSIsImJsYW5rXzIiOiJvZmZlcihtYXhRLnBvbGwoKSkiLCJibGFua18zIjoibWluUS5zaXplKCkgLSBtYXhRLnNpemUoKSA+IDEiLCJibGFua180Ijoib2ZmZXIobWluUS5wb2xsKCkpIiwiYmxhbmtfNSI6Im1pblEuc2l6ZSgpID09IG1heFEuc2l6ZSgpID8gKChsb25nKSBtaW5RLnBlZWsoKSArIG1heFEucGVlaygpKSAvIDIuMCA6IG1pblEucGVlaygpIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlj4zloIYiLCLlpKflsI/lubPooaEiLCLmnInluo/liIblibIiLCLorr7orqEiLCLlj4zmjIfpkogiLCLmlbDmja7mtYEiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 295
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-77: #121 买卖股票的最佳时机

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    121, 77, CONVERT(FROM_BASE64('5Lmw5Y2W6IKh56Wo55qE5pyA5L2z5pe25py6') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5pWw57uEIGBwcmljZXNgIO+8jOWug+eahOesrCBgaWAg5Liq5YWD57SgIGBwcmljZXNbaV1gIOihqOekuuS4gOaUr+e7meWumuiCoeelqOesrCBgaWAg5aSp55qE5Lu35qC844CCCgrkvaDlj6rog73pgInmi6kqKuafkOS4gOWkqSoq5Lmw5YWl6L+Z5Y+q6IKh56Wo77yM5bm26YCJ5oup5ZyoKirmnKrmnaXnmoTmn5DkuIDkuKrkuI3lkIznmoTml6XlrZAqKuWNluWHuuivpeiCoeelqOOAguiuvuiuoeS4gOS4queul+azleadpeiuoeeul+S9oOaJgOiDveiOt+WPlueahOacgOWkp+WIqea2puOAggoK6L+U5Zue5L2g5Y+v5Lul5LuO6L+Z56yU5Lqk5piT5Lit6I635Y+W55qE5pyA5aSn5Yip5ram44CC5aaC5p6c5L2g5LiN6IO96I635Y+W5Lu75L2V5Yip5ram77yM6L+U5ZueIGAwYCDjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mls3LDEsNSwzLDYsNF0K6L6T5Ye677yaNQrop6Pph4rvvJrlnKjnrKwgMiDlpKnvvIjogqHnpajku7fmoLwgPSAx77yJ55qE5pe25YCZ5Lmw5YWl77yM5Zyo56ysIDUg5aSp77yI6IKh56Wo5Lu35qC8ID0gNu+8ieeahOaXtuWAmeWNluWHuu+8jOacgOWkp+WIqea2piA9IDYtMSA9IDUg44CCCuazqOaEj+WIqea2puS4jeiDveaYryA3LTEgPSA2LCDlm6DkuLrljZblh7rku7fmoLzpnIDopoHlpKfkuo7kubDlhaXku7fmoLzvvJvlkIzml7bvvIzkvaDkuI3og73lnKjkubDlhaXliY3ljZblh7rogqHnpajjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpwcmljZXMgPSBbNyw2LDQsMywxXQrovpPlh7rvvJowCuino+mHiu+8muWcqOi/meenjeaDheWGteS4iywg5rKh5pyJ5Lqk5piT5a6M5oiQLCDmiYDku6XmnIDlpKfliKnmtqbkuLogMOOAggpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBwcmljZXMubGVuZ3RoIDw9IDEwNWAKLSBgMCA8PSBwcmljZXNbaV0gPD0gMTA0YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2Jlc3QtdGltZS10by1idXktYW5kLXNlbGwtc3RvY2svKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2Jlc3QtdGltZS10by1idXktYW5kLXNlbGwtc3RvY2svKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5LiA5qyh5omr5o+P57u05oqk5q2k5YmN5pyA5L2O5Lmw5YWl5Lu377yM5bm255So5b2T5YmN5Lu35YeP5pyA5L2O5Lu35pu05paw5pyA5aSn5Yip5ram44CCIOacrOmimOWbtOe7leOAjOS5sOWNluiCoeelqOeahOacgOS9s+aXtuacuuOAjeiQveWunui/meS4gOaooeWei++8muWkhOeQhuWIsOW9k+WkqeaXtiBtaW5QcmljZSDmmK/mraTliY3lkKvlvZPlpKnnmoTmnIDkvY7ku7fvvIxtYXhQcm9maXQg5piv5omA5pyJ5bey5omr5o+P5ZCI5rOV5Lmw5Y2W5a+555qE5pyA5aSn5Yip5ram44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5pyA5L2O5Lmw5Lu355qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y2V5qyh5Lqk5piT5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgdiA6IHByaWNlcykgewogICAgICAgICAgICBhbnMgPSBNYXRoLm1heChhbnMsIHYgLSBtaSk7CiAgICAgICAgICAgIG1pID0gTWF0aC5taW4obWksIHYpOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhQcm9maXQoaW50W10gcHJpY2VzKSB7CiAgICAgICAgaW50IGFucyA9IDAsIG1pID0gcHJpY2VzWzBdOwogICAgICAgIGZvciAoaW50IHYgOiBwcmljZXMpIHsKICAgICAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCB2IC0gbWkpOwogICAgICAgICAgICBtaSA9IE1hdGgubWluKG1pLCB2KTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4) WHERE p.leetcode_number = 121
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 121
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 121
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5Yiw5b2T5aSp5pe2IG1pblByaWNlIOaYr+atpOWJjeWQq+W9k+WkqeeahOacgOS9juS7t++8jG1heFByb2ZpdCDmmK/miYDmnInlt7Lmiavmj4/lkIjms5XkubDljZblr7nnmoTmnIDlpKfliKnmtqbjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1heFByb2ZpdCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5b+F6aG75YWI5Lmw5ZCO5Y2W77yb5YWo56iL5LiL6ZmN5pe2562U5qGI5L+d5oyBIDDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5b+F6aG75YWI5Lmw5ZCO5Y2W77yb5YWo56iL5LiL6ZmN5pe2562U5qGI5L+d5oyBIDDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1heFByb2ZpdCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhQcm9maXQoaW50W10gcHJpY2VzKSB7CiAgICAgICAgaW50IGFucyA9IDAsIG1pID0ge3tibGFua18xfX07CiAgICAgICAgZm9yIChpbnQgdiA6IHByaWNlcykgewogICAgICAgICAgICBhbnMgPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgbWkgPSB7e2JsYW5rXzN9fTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNH19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicHJpY2VzWzBdIiwiYmxhbmtfMiI6Ik1hdGgubWF4KGFucywgdiAtIG1pKSIsImJsYW5rXzMiOiJNYXRoLm1pbihtaSwgdikiLCJibGFua180IjoiYW5zIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmnIDkvY7kubDku7ciLCLljZXmrKHkuqTmmJMiLCLmiavmj48iLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 121
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-78: #55 跳跃游戏

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    55, 78, CONVERT(FROM_BASE64('6Lez6LeD5ri45oiP') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq6Z2e6LSf5pW05pWw5pWw57uEIGBudW1zYCDvvIzkvaDmnIDliJ3kvY3kuo7mlbDnu4TnmoQqKuesrOS4gOS4quS4i+aghyoq44CC5pWw57uE5Lit55qE5q+P5Liq5YWD57Sg5Luj6KGo5L2g5Zyo6K+l5L2N572u5Y+v5Lul6Lez6LeD55qE5pyA5aSn6ZW/5bqm44CCCgrliKTmlq3kvaDmmK/lkKbog73lpJ/liLDovr7mnIDlkI7kuIDkuKrkuIvmoIfvvIzlpoLmnpzlj6/ku6XvvIzov5Tlm54gYHRydWVgIO+8m+WQpuWIme+8jOi/lOWbniBgZmFsc2VgIOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsyLDMsMSwxLDRdCui+k+WHuu+8mnRydWUK6Kej6YeK77ya5Y+v5Lul5YWI6LezIDEg5q2l77yM5LuO5LiL5qCHIDAg5Yiw6L6+5LiL5qCHIDEsIOeEtuWQjuWGjeS7juS4i+aghyAxIOi3syAzIOatpeWIsOi+vuacgOWQjuS4gOS4quS4i+agh+OAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMywyLDEsMCw0XQrovpPlh7rvvJpmYWxzZQrop6Pph4rvvJrml6DorrrmgI7moLfvvIzmgLvkvJrliLDovr7kuIvmoIfkuLogMyDnmoTkvY3nva7jgILkvYbor6XkuIvmoIfnmoTmnIDlpKfot7Pot4Pplb/luqbmmK8gMCDvvIwg5omA5Lul5rC46L+c5LiN5Y+v6IO95Yiw6L6+5pyA5ZCO5LiA5Liq5LiL5qCH44CCCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDEwNGAKLSBgMCA8PSBudW1zW2ldIDw9IDEwNWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9qdW1wLWdhbWUvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2p1bXAtZ2FtZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5omr5o+P5pe257u05oqk5b2T5YmN5Y+v5Yiw6L6+55qE5pyA6L+c5LiL5qCHIGZhcnRoZXN077yb6IulIGkg6LaF6L+HIGZhcnRoZXN0IOWImeS4jeWPr+i+vuOAgiDmnKzpopjlm7Tnu5XjgIzot7Pot4PmuLjmiI/jgI3okL3lrp7ov5nkuIDmqKHlnovvvJrlnKggaSDlj6/ovr7nmoTliY3mj5DkuIvvvIxmYXJ0aGVzdCDmmK/liKnnlKjliY0gaSDkuKrkvY3nva7og73liLDovr7nmoTmnIDov5zngrnjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5pyA6L+c5Y+v6L6+55qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y+v6L6+5YmN57yA5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaSA9IDA7IGkgPCBudW1zLmxlbmd0aDsgKytpKSB7CiAgICAgICAgICAgIGlmIChteCA8IGkpIHsKICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICAgICAgfQogICAgICAgICAgICBteCA9IE1hdGgubWF4KG14LCBpICsgbnVtc1tpXSk7CiAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuSnVtcChpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG14ID0gMDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoOyArK2kpIHsKICAgICAgICAgICAgaWYgKG14IDwgaSkgewogICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICAgICB9CiAgICAgICAgICAgIG14ID0gTWF0aC5tYXgobXgsIGkgKyBudW1zW2ldKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHRydWU7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4) WHERE p.leetcode_number = 55
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4) WHERE p.leetcode_number = 55
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 55
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 55
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5ZyoIGkg5Y+v6L6+55qE5YmN5o+Q5LiL77yMZmFydGhlc3Qg5piv5Yip55So5YmNIGkg5Liq5L2N572u6IO95Yiw6L6+55qE5pyA6L+c54K544CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNhbkp1bXAg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Y+q6IO95LuO5Y+v6L6+5L2N572u5pu05paw5pyA6L+c6L6555WM77yb6L6+5YiwIG4tMSDlj6/mj5DliY3ov5Tlm57jgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5Y+q6IO95LuO5Y+v6L6+5L2N572u5pu05paw5pyA6L+c6L6555WM77yb6L6+5YiwIG4tMSDlj6/mj5DliY3ov5Tlm57jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNhbkp1bXAg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuSnVtcChpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG14ID0gMDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoOyArK2kpIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgICAgICByZXR1cm4ge3tibGFua18yfX07CiAgICAgICAgICAgIH0KICAgICAgICAgICAgbXggPSB7e2JsYW5rXzN9fTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNH19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibXggPCBpIiwiYmxhbmtfMiI6ImZhbHNlIiwiYmxhbmtfMyI6Ik1hdGgubWF4KG14LCBpICsgbnVtc1tpXSkiLCJibGFua180IjoidHJ1ZSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmnIDov5zlj6/ovr4iLCLlj6/ovr7liY3nvIAiLCLotKrlv4MiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 55
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-79: #45 跳跃游戏 II

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    45, 79, CONVERT(FROM_BASE64('6Lez6LeD5ri45oiPIElJ') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq6ZW/5bqm5Li6IGBuYCDnmoQqKjAg57Si5byVKirmlbTmlbDmlbDnu4QgYG51bXNg44CC5Yid5aeL5L2N572u5Zyo5LiL5qCHIDDjgIIKCuavj+S4quWFg+e0oCBgbnVtc1tpXWAg6KGo56S65LuO57Si5byVIGBpYCDlkJHlkI7ot7PovaznmoTmnIDlpKfplb/luqbjgILmjaLlj6Xor53or7TvvIzlpoLmnpzkvaDlnKjntKLlvJUgYGlgIOWkhO+8jOS9oOWPr+S7pei3s+i9rOWIsOS7u+aEjyBgKGkgKyBqKWAg5aSE77yaCgotIGAwIDw9IGogPD0gbnVtc1tpXWAg5LiUCi0gYGkgKyBqIDwgbmAKCui/lOWbnuWIsOi+viBgbiAtIDFgIOeahOacgOWwj+i3s+i3g+asoeaVsOOAgua1i+ivleeUqOS+i+S/neivgeWPr+S7peWIsOi+viBgbiAtIDFg44CCKirnpLrkvosgMToqKmBgYHRleHQK6L6T5YWlOiBudW1zID0gWzIsMywxLDEsNF0K6L6T5Ye6OiAyCuino+mHijog6Lez5Yiw5pyA5ZCO5LiA5Liq5L2N572u55qE5pyA5bCP6Lez6LeD5pWw5pivIDLjgIIKwqAgICAg5LuO5LiL5qCH5Li6IDAg6Lez5Yiw5LiL5qCH5Li6IDEg55qE5L2N572u77yM6LezwqAxwqDmraXvvIznhLblkI7ot7PCoDPCoOatpeWIsOi+vuaVsOe7hOeahOacgOWQjuS4gOS4quS9jee9ruOAggpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IG51bXMgPSBbMiwzLDAsMSw0XQrovpPlh7o6IDIKYGBgKirmj5DnpLo6KiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDEwNGAKLSBgMCA8PSBudW1zW2ldIDw9IDEwMDBgCi0g6aKY55uu5L+d6K+B5Y+v5Lul5Yiw6L6+IGBuIC0gMWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9qdW1wLWdhbWUtaWkvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2p1bXAtZ2FtZS1paS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5oyJ5bGC5qyh6LSq5b+D77ya5omr5o+P5b2T5YmN6Lez6LeD6KaG55uW5Yy66Ze077yM57u05oqk5LiL5LiA6Lez6IO95Yiw55qE5pyA6L+c54K577yb5Yiw6L6+5b2T5YmN6L6555WM5pe25aKe5Yqg5q2l5pWw5bm25omp5bGV6L6555WM44CCIOacrOmimOWbtOe7leOAjOi3s+i3g+a4uOaIjyBJSeOAjeiQveWunui/meS4gOaooeWei++8muWcqCBjdXJyZW50RW5kIOS5i+WJjeeahOaJgOacieeCueWxnuS6juWQjOS4gOi3s+aVsOWxgu+8jG5leHRFbmQg5piv5YaN6Lez5LiA5q2l6IO96KaG55uW55qE5pyA6L+c5L2N572u44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5b2T5YmN6L6555WM55qE5ZCr5LmJ77yM5YaN5qOA5p+l5LiL5LiA5pyA6L+c5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaSA9IDA7IGkgPCBudW1zLmxlbmd0aCAtIDE7ICsraSkgewogICAgICAgICAgICBteCA9IE1hdGgubWF4KG14LCBpICsgbnVtc1tpXSk7CiAgICAgICAgICAgIGlmIChsYXN0ID09IGkpIHsKICAgICAgICAgICAgICAgICsrYW5zOwogICAgICAgICAgICAgICAgbGFzdCA9IG14OwogICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBqdW1wKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgYW5zID0gMCwgbXggPSAwLCBsYXN0ID0gMDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoIC0gMTsgKytpKSB7CiAgICAgICAgICAgIG14ID0gTWF0aC5tYXgobXgsIGkgKyBudW1zW2ldKTsKICAgICAgICAgICAgaWYgKGxhc3QgPT0gaSkgewogICAgICAgICAgICAgICAgKythbnM7CiAgICAgICAgICAgICAgICBsYXN0ID0gbXg7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4) WHERE p.leetcode_number = 45
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4) WHERE p.leetcode_number = 45
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 45
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 45
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5ZyoIGN1cnJlbnRFbmQg5LmL5YmN55qE5omA5pyJ54K55bGe5LqO5ZCM5LiA6Lez5pWw5bGC77yMbmV4dEVuZCDmmK/lho3ot7PkuIDmraXog73opobnm5bnmoTmnIDov5zkvY3nva7jgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGp1bXAg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pyA5ZCO5LiA5Liq5L2N572u5LiN6ZyA6KaB5YaN6Kem5Y+R6Lez6LeD77yM5Zug5q2k5b6q546v5YiwIG4tMu+8m+abtOaWsOacgOi/nOeCueimgeWcqOi+ueeVjOWIpOaWreS5i+WJjeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5pyA5ZCO5LiA5Liq5L2N572u5LiN6ZyA6KaB5YaN6Kem5Y+R6Lez6LeD77yM5Zug5q2k5b6q546v5YiwIG4tMu+8m+abtOaWsOacgOi/nOeCueimgeWcqOi+ueeVjOWIpOaWreS5i+WJjeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGp1bXAg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBqdW1wKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgYW5zID0gMCwgbXggPSAwLCBsYXN0ID0gMDsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bXMubGVuZ3RoIC0gMTsgKytpKSB7CiAgICAgICAgICAgIG14ID0ge3tibGFua18xfX07CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgKythbnM7CiAgICAgICAgICAgICAgICBsYXN0ID0gbXg7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiTWF0aC5tYXgobXgsIGkgKyBudW1zW2ldKSIsImJsYW5rXzIiOiJsYXN0ID09IGkiLCJibGFua18zIjoiYW5zIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlvZPliY3ovrnnlYwiLCLkuIvkuIDmnIDov5wiLCLliIblsYLotKrlv4MiLCLotKrlv4MiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 45
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-80: #763 划分字母区间

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    763, 80, CONVERT(FROM_BASE64('5YiS5YiG5a2X5q+N5Yy66Ze0') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5a2X56ym5LiyIGBzYCDjgILmiJHku6zopoHmiorov5nkuKrlrZfnrKbkuLLliJLliIbkuLrlsL3lj6/og73lpJrnmoTniYfmrrXvvIzlkIzkuIDlrZfmr43mnIDlpJrlh7rnjrDlnKjkuIDkuKrniYfmrrXkuK3jgILkvovlpoLvvIzlrZfnrKbkuLIgYCJhYmFiY2MiYCDog73lpJ/ooqvliIbkuLogYFsiYWJhYiIsICJjYyJdYO+8jOS9huexu+S8vCBgWyJhYmEiLCAiYmNjIl1gIOaIliBgWyJhYiIsICJhYiIsICJjYyJdYCDnmoTliJLliIbmmK/pnZ7ms5XnmoTjgIIKCuazqOaEj++8jOWIkuWIhue7k+aenOmcgOimgea7oei2s++8muWwhuaJgOacieWIkuWIhue7k+aenOaMiemhuuW6j+i/nuaOpe+8jOW+l+WIsOeahOWtl+espuS4suS7jeeEtuaYryBgc2Ag44CCCgrov5Tlm57kuIDkuKrooajnpLrmr4/kuKrlrZfnrKbkuLLniYfmrrXnmoTplb/luqbnmoTliJfooajjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiYWJhYmNiYWNhZGVmZWdkZWhpamhrbGlqIgrovpPlh7rvvJpbOSw3LDhdCuino+mHiu+8mgrliJLliIbnu5PmnpzkuLogImFiYWJjYmFjYSLjgIEiZGVmZWdkZSLjgIEiaGlqaGtsaWoiIOOAggrmr4/kuKrlrZfmr43mnIDlpJrlh7rnjrDlnKjkuIDkuKrniYfmrrXkuK3jgIIK5YOPICJhYmFiY2JhY2FkZWZlZ2RlIiwgImhpamhrbGlqIiDov5nmoLfnmoTliJLliIbmmK/plJnor6/nmoTvvIzlm6DkuLrliJLliIbnmoTniYfmrrXmlbDovoPlsJHjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpzID0gImVjY2JiYmJkZWMiCui+k+WHuu+8mlsxMF0KYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gcy5sZW5ndGggPD0gNTAwYAotIGBzYCDku4XnlLHlsI/lhpnoi7HmloflrZfmr43nu4TmiJAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9wYXJ0aXRpb24tbGFiZWxzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9wYXJ0aXRpb24tbGFiZWxzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5YWI6K6w5b2V5q+P5Liq5a2X56ym5pyA5ZCO5Ye6546w5L2N572u77yM5omr5o+P5pe25omp5bGV5b2T5YmN54mH5q615Y+z56uv77yb5LiL5qCH5Yiw6L6+5Y+z56uv5bCx5YiH5YiG44CCIOacrOmimOWbtOe7leOAjOWIkuWIhuWtl+avjeWMuumXtOOAjeiQveWunui/meS4gOaooeWei++8muW9k+WJjSBlbmQg5piv54mH5q615YaF5omA5pyJ5bey6KeB5a2X56ym5pyA5ZCO5L2N572u55qE5pyA5aSn5YC877yMZW5kIOWJjeS4jeiDveWuieWFqOWIh+WIhuOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5pyA5ZCO5L2N572u55qE5ZCr5LmJ77yM5YaN5qOA5p+l54mH5q615Y+z56uv5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IG14ID0gMCwgaiA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgbXggPSBNYXRoLm1heChteCwgbGFzdFtzLmNoYXJBdChpKSAtICdhJ10pOwogICAgICAgICAgICBpZiAobXggPT0gaSkgewogICAgICAgICAgICAgICAgYW5zLmFkZChpIC0gaiArIDEpOwogICAgICAgICAgICAgICAgaiA9IGkgKyAxOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gcGFydGl0aW9uTGFiZWxzKFN0cmluZyBzKSB7CiAgICAgICAgaW50W10gbGFzdCA9IG5ldyBpbnRbMjZdOwogICAgICAgIGludCBuID0gcy5sZW5ndGgoKTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBsYXN0W3MuY2hhckF0KGkpIC0gJ2EnXSA9IGk7CiAgICAgICAgfQogICAgICAgIExpc3Q8SW50ZWdlcj4gYW5zID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgaW50IG14ID0gMCwgaiA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgbXggPSBNYXRoLm1heChteCwgbGFzdFtzLmNoYXJBdChpKSAtICdhJ10pOwogICAgICAgICAgICBpZiAobXggPT0gaSkgewogICAgICAgICAgICAgICAgYW5zLmFkZChpIC0gaiArIDEpOwogICAgICAgICAgICAgICAgaiA9IGkgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBhbnM7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D566X5rOV') USING utf8mb4) WHERE p.leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6LSq5b+D') USING utf8mb4) WHERE p.leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5b2T5YmNIGVuZCDmmK/niYfmrrXlhoXmiYDmnInlt7Lop4HlrZfnrKbmnIDlkI7kvY3nva7nmoTmnIDlpKflgLzvvIxlbmQg5YmN5LiN6IO95a6J5YWo5YiH5YiG44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHBhcnRpdGlvbkxhYmVscyDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5YiH5YiG6ZW/5bqm5pivIGktc3RhcnQrMe+8jOWIh+WIhuWQjiBzdGFydD1pKzHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIzlrZfnrKbooajnqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5YiH5YiG6ZW/5bqm5pivIGktc3RhcnQrMe+8jOWIh+WIhuWQjiBzdGFydD1pKzHjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHBhcnRpdGlvbkxhYmVscyDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8SW50ZWdlcj4gcGFydGl0aW9uTGFiZWxzKFN0cmluZyBzKSB7CiAgICAgICAgaW50W10gbGFzdCA9IG5ldyBpbnRbMjZdOwogICAgICAgIGludCBuID0ge3tibGFua18xfX07CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgbGFzdFtzLmNoYXJBdChpKSAtICdhJ10gPSBpOwogICAgICAgIH0KICAgICAgICBMaXN0PEludGVnZXI+IGFucyA9IG5ldyBBcnJheUxpc3Q8PigpOwogICAgICAgIGludCBteCA9IDAsIGogPSAwOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIG14ID0ge3tibGFua18yfX07CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgYW5zLmFkZChpIC0gaiArIDEpOwogICAgICAgICAgICAgICAgaiA9IGkgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicy5sZW5ndGgoKSIsImJsYW5rXzIiOiJNYXRoLm1heChteCwgbGFzdFtzLmNoYXJBdChpKSAtICdhJ10pIiwiYmxhbmtfMyI6Im14ID09IGkiLCJibGFua180IjoiYW5zIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmnIDlkI7kvY3nva4iLCLniYfmrrXlj7Pnq68iLCLlronlhajliIfliIYiLCLotKrlv4MiLCLlk4jluIzooagiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 763
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-81: #70 爬楼梯

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    70, 81, CONVERT(FROM_BASE64('54is5qW85qKv') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('5YGH6K6+5L2g5q2j5Zyo54is5qW85qKv44CC6ZyA6KaBIGBuYCDpmLbkvaDmiY3og73liLDovr7mpbzpobbjgIIKCuavj+asoeS9oOWPr+S7peeIrCBgMWAg5oiWIGAyYCDkuKrlj7DpmLbjgILkvaDmnInlpJrlsJHnp43kuI3lkIznmoTmlrnms5Xlj6/ku6XniKzliLDmpbzpobblkaLvvJ8qKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mm4gPSAyCui+k+WHuu+8mjIK6Kej6YeK77ya5pyJ5Lik56eN5pa55rOV5Y+v5Lul54is5Yiw5qW86aG244CCCjEuIDEg6Zi2ICsgMSDpmLYKMi4gMiDpmLYKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpuID0gMwrovpPlh7rvvJozCuino+mHiu+8muacieS4ieenjeaWueazleWPr+S7peeIrOWIsOalvOmhtuOAggoxLiAxIOmYtiArIDEg6Zi2ICsgMSDpmLYKMi4gMSDpmLYgKyAyIOmYtgozLiAyIOmYtiArIDEg6Zi2CmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG4gPD0gNDVgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvY2xpbWJpbmctc3RhaXJzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9jbGltYmluZy1zdGFpcnMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV0g6KGo56S65Yiw56ysIGkg6Zi25pa55rOV5pWw77yM5pyA5ZCO5LiA5q2l5p2l6IeqIGktMSDmiJYgaS0y77yM5Zug5q2kIGRwW2ldPWRwW2ktMV0rZHBbaS0yXeOAgiDmnKzpopjlm7Tnu5XjgIzniKzmpbzmoq/jgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmu5rliqjlj5jph4/liIbliKvkv53lrZjliY3kuKTpmLbnmoTmlrnms5XmlbDvvIzmm7TmlrDlkI7ooajnpLrmlrDnmoTnm7jpgrvkuKTpmLbjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5paQ5rOi6YKj5aWR55qE5ZCr5LmJ77yM5YaN5qOA5p+l5YmN5Lik6Zi25aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGMgPSBhICsgYjsKICAgICAgICAgICAgYSA9IGI7CiAgICAgICAgICAgIGIgPSBjOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYjsKICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBjbGltYlN0YWlycyhpbnQgbikgewogICAgICAgIGludCBhID0gMCwgYiA9IDE7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuOyArK2kpIHsKICAgICAgICAgICAgaW50IGMgPSBhICsgYjsKICAgICAgICAgICAgYSA9IGI7CiAgICAgICAgICAgIGIgPSBjOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYjsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 70
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6w5b+G5YyW') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6w5b+G5YyW') USING utf8mb4) WHERE p.leetcode_number = 70
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 70
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5rua5Yqo5Y+Y6YeP5YiG5Yir5L+d5a2Y5YmN5Lik6Zi255qE5pa55rOV5pWw77yM5pu05paw5ZCO6KGo56S65paw55qE55u46YK75Lik6Zi244CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNsaW1iU3RhaXJzIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('bj0x44CBbj0yIOeahOWIneWAvOimgeS4jueKtuaAgeWumuS5ieS4gOiHtO+8m+a7muWKqOabtOaWsOS4jeiDveimhuebluWwmumcgOS9v+eUqOeahOaXp+WAvOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('bj0x44CBbj0yIOeahOWIneWAvOimgeS4jueKtuaAgeWumuS5ieS4gOiHtO+8m+a7muWKqOabtOaWsOS4jeiDveimhuebluWwmumcgOS9v+eUqOeahOaXp+WAvOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNsaW1iU3RhaXJzIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBjbGltYlN0YWlycyhpbnQgbikgewogICAgICAgIGludCBhID0ge3tibGFua18xfX0sIGIgPSAxOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIGludCBjID0gYSArIGI7CiAgICAgICAgICAgIGEgPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgYiA9IHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICByZXR1cm4gYjsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiMCIsImJsYW5rXzIiOiJiIiwiYmxhbmtfMyI6ImMifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmlpDms6LpgqPlpZEiLCLliY3kuKTpmLYiLCLmu5rliqjlj5jph48iLCLorrDlv4bljJYiLCLmlbDlraYiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 70
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-82: #118 杨辉三角

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    118, 82, CONVERT(FROM_BASE64('5p2o6L6J5LiJ6KeS') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq6Z2e6LSf5pW05pWwICpgbnVtUm93c2DvvIwq55Sf5oiQ44CM5p2o6L6J5LiJ6KeS44CN55qE5YmNICpgbnVtUm93c2Aq6KGM44CCCgrlnKgqKuOAjOadqOi+ieS4ieinkuOAjSoq5Lit77yM5q+P5Liq5pWw5piv5a6D5bem5LiK5pa55ZKM5Y+z5LiK5pa555qE5pWw55qE5ZKM44CCCgohW+mimOebruekuuaEj+Wbvl0oaHR0cHM6Ly9waWMubGVldGNvZGUuY24vMTYyNjkyNzM0NS1EWm1meEItUGFzY2FsVHJpYW5nbGVBbmltYXRlZDIuZ2lmKSoq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogbnVtUm93cyA9IDUK6L6T5Ye6OiBbWzFdLFsxLDFdLFsxLDIsMV0sWzEsMywzLDFdLFsxLDQsNiw0LDFdXQpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IG51bVJvd3MgPSAxCui+k+WHujogW1sxXV0KYGBgKirmj5DnpLo6KiotIGAxIDw9IG51bVJvd3MgPD0gMzBgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvcGFzY2Fscy10cmlhbmdsZS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcGFzY2Fscy10cmlhbmdsZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('6YCQ6KGM5p6E6YCg5p2o6L6J5LiJ6KeS77ya5q+P6KGM6aaW5bC+5Li6IDHvvIzkuK3pl7TlgLznrYnkuo7kuIrkuIDooYzlt6bkuIrlkozlj7PkuIrnmoTlkozjgIIg5pys6aKY5Zu057uV44CM5p2o6L6J5LiJ6KeS44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya55Sf5oiQ56ysIHIg6KGM5pe277yM5YmNIHIg6KGM5bey57uP5a6M5pW05q2j56Gu77yM5b2T5YmN5Lit6Ze05L2N572u5Y+q5L6d6LWW5LiK5LiA6KGM44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF6YCQ6KGM5p6E6YCg55qE5ZCr5LmJ77yM5YaN5qOA5p+l6aaW5bC+5Li6MeWmguS9leS/neaMgeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('TGlzdDxJbnRlZ2VyPiBnID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgICAgIGcuYWRkKDEpOwogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8IGYuZ2V0KGkpLnNpemUoKTsgKytqKSB7CiAgICAgICAgICAgICAgICBnLmFkZChmLmdldChpKS5nZXQoaiAtIDEpICsgZi5nZXQoaSkuZ2V0KGopKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBnLmFkZCgxKTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxJbnRlZ2VyPj4gZ2VuZXJhdGUoaW50IG51bVJvd3MpIHsKICAgICAgICBMaXN0PExpc3Q8SW50ZWdlcj4+IGYgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBmLmFkZChMaXN0Lm9mKDEpKTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bVJvd3MgLSAxOyArK2kpIHsKICAgICAgICAgICAgTGlzdDxJbnRlZ2VyPiBnID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgICAgIGcuYWRkKDEpOwogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8IGYuZ2V0KGkpLnNpemUoKTsgKytqKSB7CiAgICAgICAgICAgICAgICBnLmFkZChmLmdldChpKS5nZXQoaiAtIDEpICsgZi5nZXQoaSkuZ2V0KGopKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBnLmFkZCgxKTsKICAgICAgICAgICAgZi5hZGQoZyk7CiAgICAgICAgfQogICAgICAgIHJldHVybiBmOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 118
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 118
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('55Sf5oiQ56ysIHIg6KGM5pe277yM5YmNIHIg6KGM5bey57uP5a6M5pW05q2j56Gu77yM5b2T5YmN5Lit6Ze05L2N572u5Y+q5L6d6LWW5LiK5LiA6KGM44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGdlbmVyYXRlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6KGM6ZW/5bqm5pivIHJvdysx77yb6aaW5bC+5LiN6KaB5aWX55So5LiN5a2Y5Zyo55qE5LiK5LiA6KGM5LiL5qCH44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6L6T5Ye65pys6LqrIE8obnVtUm93c8KyKSDml7bpl7Tlkoznqbrpl7TjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6KGM6ZW/5bqm5pivIHJvdysx77yb6aaW5bC+5LiN6KaB5aWX55So5LiN5a2Y5Zyo55qE5LiK5LiA6KGM5LiL5qCH44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGdlbmVyYXRlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIExpc3Q8TGlzdDxJbnRlZ2VyPj4gZ2VuZXJhdGUoaW50IG51bVJvd3MpIHsKICAgICAgICBMaXN0PExpc3Q8SW50ZWdlcj4+IGYgPSBuZXcgQXJyYXlMaXN0PD4oKTsKICAgICAgICBmLmFkZChMaXN0Lm9mKDEpKTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG51bVJvd3MgLSAxOyArK2kpIHsKICAgICAgICAgICAgTGlzdDxJbnRlZ2VyPiBnID0gbmV3IEFycmF5TGlzdDw+KCk7CiAgICAgICAgICAgIGcuYWRkKDEpOwogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8IGYuZ2V0KHt7YmxhbmtfMX19KS5zaXplKCk7ICsraikgewogICAgICAgICAgICAgICAgZy5hZGQoZi5nZXQoe3tibGFua18yfX0pLmdldChqIC0gMSkgKyBmLmdldCh7e2JsYW5rXzN9fSkuZ2V0KGopKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBnLmFkZCgxKTsKICAgICAgICAgICAgZi5hZGQoZyk7CiAgICAgICAgfQogICAgICAgIHJldHVybiBmOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaSIsImJsYW5rXzIiOiJpIiwiYmxhbmtfMyI6ImkifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLpgJDooYzmnoTpgKAiLCLpppblsL7kuLoxIiwi5bem5LiK5Y+z5LiKIiwi5pWw57uEIiwi5Yqo5oCB6KeE5YiSIl0=') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 118
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-83: #198 打家劫舍

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    198, 83, CONVERT(FROM_BASE64('5omT5a625Yqr6IiN') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5L2g5piv5LiA5Liq5LiT5Lia55qE5bCP5YG377yM6K6h5YiS5YG356qD5rK/6KGX55qE5oi/5bGL44CC5q+P6Ze05oi/5YaF6YO96JeP5pyJ5LiA5a6a55qE546w6YeR77yM5b2x5ZON5L2g5YG356qD55qE5ZSv5LiA5Yi257qm5Zug57Sg5bCx5piv55u46YK755qE5oi/5bGL6KOF5pyJ55u45LqS6L+e6YCa55qE6Ziy55uX57O757uf77yMKirlpoLmnpzkuKTpl7Tnm7jpgrvnmoTmiL/lsYvlnKjlkIzkuIDmmZrkuIrooqvlsI/lgbfpl6/lhaXvvIzns7vnu5/kvJroh6rliqjmiqXoraYqKuOAggoK57uZ5a6a5LiA5Liq5Luj6KGo5q+P5Liq5oi/5bGL5a2Y5pS+6YeR6aKd55qE6Z2e6LSf5pW05pWw5pWw57uE77yM6K6h566X5L2gKirkuI3op6bliqjorabmiqXoo4Xnva7nmoTmg4XlhrXkuIsqKu+8jOS4gOWknOS5i+WGheiDveWkn+WBt+eqg+WIsOeahOacgOmrmOmHkemineOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yaWzEsMiwzLDFdCui+k+WHuu+8mjQK6Kej6YeK77ya5YG356qDIDEg5Y+35oi/5bGLICjph5Hpop0gPSAxKSDvvIznhLblkI7lgbfnqoMgMyDlj7fmiL/lsYsgKOmHkeminSA9IDMp44CCCsKgICAgIOWBt+eqg+WIsOeahOacgOmrmOmHkeminSA9IDEgKyAzID0gNCDjgIIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpbMiw3LDksMywxXQrovpPlh7rvvJoxMgrop6Pph4rvvJrlgbfnqoMgMSDlj7fmiL/lsYsgKOmHkeminSA9IDIpLCDlgbfnqoMgMyDlj7fmiL/lsYsgKOmHkeminSA9IDkp77yM5o6l552A5YG356qDIDUg5Y+35oi/5bGLICjph5Hpop0gPSAxKeOAggrCoCAgICDlgbfnqoPliLDnmoTmnIDpq5jph5Hpop0gPSAyICsgOSArIDEgPSAxMiDjgIIKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMTAwYAotIGAwIDw9IG51bXNbaV0gPD0gNDAwYAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2hvdXNlLXJvYmJlci8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvaG91c2Utcm9iYmVyLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('6K6w5b+G5YyW6YCS5b2SIGRmcyhpKSDooajnpLrku47nrKwgaSDpl7TmiL/lvIDlp4vog73lgbfliLDnmoTmnIDlpKfph5Hpop3vvIzpgInmi6not7Pov4cgaSDmiJblgbcgaSDlkI7ot7PliLAgaSsy44CCIOacrOmimOWbtOe7leOAjOaJk+WutuWKq+iIjeOAjeiQveWunui/meS4gOaooeWei++8mmRmcyhpKSDopobnm5bku44gaSDlvIDlp4vnmoTlhajpg6jlkIjms5XpgInmi6nvvIznvJPlrZjlkI7lkIzkuIDlkI7nvIDlrZDpl67popjlj6rorqHnrpfkuIDmrKHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5ZCO57yA54q25oCB55qE5ZCr5LmJ77yM5YaN5qOA5p+l6YCJ5oiW5LiN6YCJ5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('cmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGlmIChmW2ldID09IG51bGwpIHsKICAgICAgICAgICAgZltpXSA9IE1hdGgubWF4KG51bXNbaV0gKyBkZnMoaSArIDIpLCBkZnMoaSArIDEpKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbaV07') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBJbnRlZ2VyW10gZjsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgaW50IHJvYihpbnRbXSBudW1zKSB7CiAgICAgICAgdGhpcy5udW1zID0gbnVtczsKICAgICAgICBmID0gbmV3IEludGVnZXJbbnVtcy5sZW5ndGhdOwogICAgICAgIHJldHVybiBkZnMoMCk7CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgZGZzKGludCBpKSB7CiAgICAgICAgaWYgKGkgPj0gbnVtcy5sZW5ndGgpIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGlmIChmW2ldID09IG51bGwpIHsKICAgICAgICAgICAgZltpXSA9IE1hdGgubWF4KG51bXNbaV0gKyBkZnMoaSArIDIpLCBkZnMoaSArIDEpKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbaV07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 198
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 198
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('ZGZzKGkpIOimhuebluS7jiBpIOW8gOWni+eahOWFqOmDqOWQiOazlemAieaLqe+8jOe8k+WtmOWQjuWQjOS4gOWQjue8gOWtkOmXrumimOWPquiuoeeul+S4gOasoeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHJvYiDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('aT49biDov5Tlm54gMO+8m+e8k+WtmOWIpOepuuS4jumHkemineWPr+iDveS4uiAwIOeahOaDheWGteS4jeiDvea3t+a3huOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznvJPlrZjkuI7pgJLlvZLmoIjnqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('aT49biDov5Tlm54gMO+8m+e8k+WtmOWIpOepuuS4jumHkemineWPr+iDveS4uiAwIOeahOaDheWGteS4jeiDvea3t+a3huOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHJvYiDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBJbnRlZ2VyW10gZjsKICAgIHByaXZhdGUgaW50W10gbnVtczsKCiAgICBwdWJsaWMgaW50IHJvYihpbnRbXSBudW1zKSB7CiAgICAgICAgdGhpcy5udW1zID0gbnVtczsKICAgICAgICBmID0gbmV3IEludGVnZXJbbnVtcy5sZW5ndGhdOwogICAgICAgIHJldHVybiB7e2JsYW5rXzF9fTsKICAgIH0KCiAgICBwcml2YXRlIGludCBkZnMoaW50IGkpIHsKICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQogICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICBmW2ldID0ge3tibGFua180fX07CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzV9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZGZzKDApIiwiYmxhbmtfMiI6ImkgPj0gbnVtcy5sZW5ndGgiLCJibGFua18zIjoiZltpXSA9PSBudWxsIiwiYmxhbmtfNCI6Ik1hdGgubWF4KG51bXNbaV0gKyBkZnMoaSArIDIpLCBkZnMoaSArIDEpKSIsImJsYW5rXzUiOiJmW2ldIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlkI7nvIDnirbmgIEiLCLpgInmiJbkuI3pgIkiLCLorrDlv4bljJYiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 198
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-84: #279 完全平方数

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    279, 84, CONVERT(FROM_BASE64('5a6M5YWo5bmz5pa55pWw') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWwIGBuYCDvvIzov5Tlm54gKuWSjOS4uiBgbmAg55qE5a6M5YWo5bmz5pa55pWw55qE5pyA5bCR5pWw6YePKiDjgIIqKuWujOWFqOW5s+aWueaVsCoq5piv5LiA5Liq5pW05pWw77yM5YW25YC8562J5LqO5Y+m5LiA5Liq5pW05pWw55qE5bmz5pa577yb5o2i5Y+l6K+d6K+077yM5YW25YC8562J5LqO5LiA5Liq5pW05pWw6Ieq5LmY55qE56ev44CC5L6L5aaC77yMYDFg44CBYDRg44CBYDlgIOWSjCBgMTZgIOmDveaYr+WujOWFqOW5s+aWueaVsO+8jOiAjCBgM2Ag5ZKMIGAxMWAg5LiN5piv44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpuID0gMTIK6L6T5Ye677yaMwrop6Pph4rvvJoxMiA9IDQgKyA0ICsgNApgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm4gPSAxMwrovpPlh7rvvJoyCuino+mHiu+8mjEzID0gNCArIDkKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbiA8PSAxMDRgCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvcGVyZmVjdC1zcXVhcmVzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9wZXJmZWN0LXNxdWFyZXMvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV0g5piv57uE5oiQIGkg55qE5pyA5bCR5a6M5YWo5bmz5pa55pWw5Liq5pWw77yM5p6a5Li+IGrCsjw9ae+8jOeUqCBkcFtpLWrCsl0rMSDovaznp7vjgIIg5pys6aKY5Zu057uV44CM5a6M5YWo5bmz5pa55pWw44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6K6h566XIGkg5pe25omA5pyJ5pu05bCP6YeR6aKd54q25oCB5bey57uP5pyA5LyY77yM5Zug5q2k5Y+W5omA5pyJ5pyA5ZCO5LiA5Liq5bmz5pa55pWw6YCJ5oup55qE5pyA5bCP5YC844CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5a6M5YWo6IOM5YyF55qE5ZCr5LmJ77yM5YaN5qOA5p+l5bmz5pa55pWw5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('ZlswXSA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPD0gbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSBpICogaTsgaiA8PSBuOyArK2opIHsKICAgICAgICAgICAgICAgIGZbal0gPSBNYXRoLm1pbihmW2pdLCBmW2ogLSBpICogaV0gKyAxKTsKICAgICAgICAgICAgfQogICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBudW1TcXVhcmVzKGludCBuKSB7CiAgICAgICAgaW50IG0gPSAoaW50KSBNYXRoLnNxcnQobik7CiAgICAgICAgaW50W10gZiA9IG5ldyBpbnRbbiArIDFdOwogICAgICAgIEFycmF5cy5maWxsKGYsIDEgPDwgMzApOwogICAgICAgIGZbMF0gPSAwOwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDw9IG07ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gaSAqIGk7IGogPD0gbjsgKytqKSB7CiAgICAgICAgICAgICAgICBmW2pdID0gTWF0aC5taW4oZltqXSwgZltqIC0gaSAqIGldICsgMSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbl07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 279
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 279
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 279
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6K6h566XIGkg5pe25omA5pyJ5pu05bCP6YeR6aKd54q25oCB5bey57uP5pyA5LyY77yM5Zug5q2k5Y+W5omA5pyJ5pyA5ZCO5LiA5Liq5bmz5pa55pWw6YCJ5oup55qE5pyA5bCP5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG51bVNxdWFyZXMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('ZHBbMF09MO+8jOWFtuS9meWIneWni+WMluS4uuWkp+WAvO+8m+W5s+aWueW+queOr+adoeS7tueUqCBqKmo8PWnjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obuKImm4p77yM56m66Ze0IE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('ZHBbMF09MO+8jOWFtuS9meWIneWni+WMluS4uuWkp+WAvO+8m+W5s+aWueW+queOr+adoeS7tueUqCBqKmo8PWnjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG51bVNxdWFyZXMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBudW1TcXVhcmVzKGludCBuKSB7CiAgICAgICAgaW50IG0gPSAoaW50KSBNYXRoLnNxcnQoe3tibGFua18xfX0pOwogICAgICAgIGludFtdIGYgPSBuZXcgaW50W24gKyAxXTsKICAgICAgICBBcnJheXMuZmlsbChmLCAxIDw8IDMwKTsKICAgICAgICBmWzBdID0gMDsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8PSBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IGkgKiBpOyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgZltqXSA9IHt7YmxhbmtfMn19OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibiIsImJsYW5rXzIiOiJNYXRoLm1pbihmW2pdLCBmW2ogLSBpICogaV0gKyAxKSIsImJsYW5rXzMiOiJmW25dIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlrozlhajog4zljIUiLCLlubPmlrnmlbAiLCLmnIDlsJHkuKrmlbAiLCLlub/luqbkvJjlhYjmkJzntKIiLCLmlbDlraYiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 279
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-85: #322 零钱兑换

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    322, 85, CONVERT(FROM_BASE64('6Zu26ZKx5YWR5o2i') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBjb2luc2Ag77yM6KGo56S65LiN5ZCM6Z2i6aKd55qE56Gs5biB77yb5Lul5Y+K5LiA5Liq5pW05pWwIGBhbW91bnRgIO+8jOihqOekuuaAu+mHkemineOAggoK6K6h566X5bm26L+U5Zue5Y+v5Lul5YeR5oiQ5oC76YeR6aKd5omA6ZyA55qEKirmnIDlsJHnmoTnoazluIHkuKrmlbAqKuOAguWmguaenOayoeacieS7u+S9leS4gOenjeehrOW4gee7hOWQiOiDvee7hOaIkOaAu+mHkemine+8jOi/lOWbniBgLTFgIOOAggoK5L2g5Y+v5Lul6K6k5Li65q+P56eN56Gs5biB55qE5pWw6YeP5piv5peg6ZmQ55qE44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpjb2lucyA9IFsxLCAyLCA1XSwgYW1vdW50ID0gMTEK6L6T5Ye677yaMwrop6Pph4rvvJoxMSA9IDUgKyA1ICsgMQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmNvaW5zID0gWzJdLCBhbW91bnQgPSAzCui+k+WHuu+8mi0xCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWl77yaY29pbnMgPSBbMV0sIGFtb3VudCA9IDAK6L6T5Ye677yaMApgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBjb2lucy5sZW5ndGggPD0gMTJgCi0gYDEgPD0gY29pbnNbaV0gPD0gMjMxIC0gMWAKLSBgMCA8PSBhbW91bnQgPD0gMTA0YAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2NvaW4tY2hhbmdlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9jb2luLWNoYW5nZS8p') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbYW1vdW50XSDooajnpLrlh5HmiJDor6Xph5Hpop3nmoTmnIDlsJHnoazluIHmlbDvvIzlr7nmr4/mnprnoazluIHlgZrlrozlhajog4zljIXovaznp7vjgIIg5pys6aKY5Zu057uV44CM6Zu26ZKx5YWR5o2i44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya6YeR6aKd5LuO5bCP5Yiw5aSn6YGN5Y6G5pe277yM5ZCM5LiA56Gs5biB5Y+v6KKr6YeN5aSN5L2/55So77yMZHBbal0g5L+d5oyB5bey6ICD6JmR56Gs5biB5LiL55qE5pyA5LyY5YC844CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5a6M5YWo6IOM5YyF55qE5ZCr5LmJ77yM5YaN5qOA5p+l5LiN5Y+v6L6+5ZOo5YW15aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgeCA6IGNvaW5zKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSB4OyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgZltqXSA9IE1hdGgubWluKGZbal0sIGZbaiAtIHhdICsgMSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbl0gPj0gaW5mID8gLTEgOiBmW25dOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBjb2luQ2hhbmdlKGludFtdIGNvaW5zLCBpbnQgYW1vdW50KSB7CiAgICAgICAgZmluYWwgaW50IGluZiA9IDEgPDwgMzA7CiAgICAgICAgaW50IG4gPSBhbW91bnQ7CiAgICAgICAgaW50W10gZiA9IG5ldyBpbnRbbiArIDFdOwogICAgICAgIEFycmF5cy5maWxsKGYsIGluZik7CiAgICAgICAgZlswXSA9IDA7CiAgICAgICAgZm9yIChpbnQgeCA6IGNvaW5zKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSB4OyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgZltqXSA9IE1hdGgubWluKGZbal0sIGZbaiAtIHhdICsgMSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbl0gPj0gaW5mID8gLTEgOiBmW25dOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 322
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5bm/5bqm5LyY5YWI5pCc57Si') USING utf8mb4) WHERE p.leetcode_number = 322
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 322
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YeR6aKd5LuO5bCP5Yiw5aSn6YGN5Y6G5pe277yM5ZCM5LiA56Gs5biB5Y+v6KKr6YeN5aSN5L2/55So77yMZHBbal0g5L+d5oyB5bey6ICD6JmR56Gs5biB5LiL55qE5pyA5LyY5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNvaW5DaGFuZ2Ug5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LiN5Y+v6L6+54q25oCB5Yid5aeL5YyW5Li6IGFtb3VudCsx77yb5Y+q5pyJIGRwW2otY29pbl0g5Y+v6L6+5pe26L2s56e777yM5pyA57uI5aSn5YC86L+U5ZueIC0x44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8oYW1vdW50wrdjb2lucynvvIznqbrpl7QgTyhhbW91bnQp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN5Y+v6L6+54q25oCB5Yid5aeL5YyW5Li6IGFtb3VudCsx77yb5Y+q5pyJIGRwW2otY29pbl0g5Y+v6L6+5pe26L2s56e777yM5pyA57uI5aSn5YC86L+U5ZueIC0x44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNvaW5DaGFuZ2Ug55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBjb2luQ2hhbmdlKGludFtdIGNvaW5zLCBpbnQgYW1vdW50KSB7CiAgICAgICAgZmluYWwgaW50IGluZiA9IDEgPDwgMzA7CiAgICAgICAgaW50IG4gPSB7e2JsYW5rXzF9fTsKICAgICAgICBpbnRbXSBmID0gbmV3IGludFtuICsgMV07CiAgICAgICAgQXJyYXlzLmZpbGwoZiwgaW5mKTsKICAgICAgICBmWzBdID0gMDsKICAgICAgICBmb3IgKGludCB4IDogY29pbnMpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IHg7IGogPD0gbjsgKytqKSB7CiAgICAgICAgICAgICAgICBmW2pdID0ge3tibGFua18yfX07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfM319OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiYW1vdW50IiwiYmxhbmtfMiI6Ik1hdGgubWluKGZbal0sIGZbaiAtIHhdICsgMSkiLCJibGFua18zIjoiZltuXSA+PSBpbmYgPyAtMSA6IGZbbl0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlrozlhajog4zljIUiLCLkuI3lj6/ovr7lk6jlhbUiLCLmnIDlsJHnoazluIEiLCLlub/luqbkvJjlhYjmkJzntKIiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 322
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-86: #139 单词拆分

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    139, 86, CONVERT(FROM_BASE64('5Y2V6K+N5ouG5YiG') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5a2X56ym5LiyIGBzYCDlkozkuIDkuKrlrZfnrKbkuLLliJfooaggYHdvcmREaWN0YCDkvZzkuLrlrZflhbjjgILlpoLmnpzlj6/ku6XliKnnlKjlrZflhbjkuK3lh7rnjrDnmoTkuIDkuKrmiJblpJrkuKrljZXor43mi7zmjqXlh7ogYHNgIOWImei/lOWbniBgdHJ1ZWDjgIIqKuazqOaEj++8mioq5LiN6KaB5rGC5a2X5YW45Lit5Ye6546w55qE5Y2V6K+N5YWo6YOo6YO95L2/55So77yM5bm25LiU5a2X5YW45Lit55qE5Y2V6K+N5Y+v5Lul6YeN5aSN5L2/55So44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaU6IHMgPSAibGVldGNvZGUiLCB3b3JkRGljdCA9IFsibGVldCIsICJjb2RlIl0K6L6T5Ye6OiB0cnVlCuino+mHijog6L+U5ZueIHRydWUg5Zug5Li6ICJsZWV0Y29kZSIg5Y+v5Lul55SxICJsZWV0IiDlkowgImNvZGUiIOaLvOaOpeaIkOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpTogcyA9ICJhcHBsZXBlbmFwcGxlIiwgd29yZERpY3QgPSBbImFwcGxlIiwgInBlbiJdCui+k+WHujogdHJ1ZQrop6Pph4o6IOi/lOWbniB0cnVlIOWboOS4uiAiYXBwbGVwZW5hcHBsZSIg5Y+v5Lul55SxICJhcHBsZSIgInBlbiIgImFwcGxlIiDmi7zmjqXmiJDjgIIKwqAgICAg5rOo5oSP77yM5L2g5Y+v5Lul6YeN5aSN5L2/55So5a2X5YW45Lit55qE5Y2V6K+N44CCCmBgYCoq56S65L6LIDPvvJoqKmBgYHRleHQK6L6T5YWlOiBzID0gImNhdHNhbmRvZyIsIHdvcmREaWN0ID0gWyJjYXRzIiwgImRvZyIsICJzYW5kIiwgImFuZCIsICJjYXQiXQrovpPlh7o6IGZhbHNlCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IHMubGVuZ3RoIDw9IDMwMGAKLSBgMSA8PSB3b3JkRGljdC5sZW5ndGggPD0gMTAwMGAKLSBgMSA8PSB3b3JkRGljdFtpXS5sZW5ndGggPD0gMjBgCi0gYHNgIOWSjCBgd29yZERpY3RbaV1gIOS7heeUseWwj+WGmeiLseaWh+Wtl+avjee7hOaIkAotIGB3b3JkRGljdGAg5Lit55qE5omA5pyJ5a2X56ym5LiyKirkupLkuI3nm7jlkIwqKgoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL3dvcmQtYnJlYWsvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3dvcmQtYnJlYWsvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV0g6KGo56S65YmNIGkg5Liq5a2X56ym6IO95ZCm55Sx6K+N5YW45ou85oiQ77yM5p6a5Li+5YiH5YiG54K5IGrvvIzoi6UgZHBbal0g5LiUIHNbaixpKSDlnKjor43lhbjliJnkuLrnnJ/jgIIg5pys6aKY5Zu057uV44CM5Y2V6K+N5ouG5YiG44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya56Gu5a6aIGRwW2ldIOaXtu+8jOaJgOacieabtOefreWJjee8gOeahOWPr+WIhuWJsuaAp+W3sue7j+ato+ehruOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5YmN57yARFDnmoTlkKvkuYnvvIzlho3mo4Dmn6XliIfliIbngrnlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaSA9IDE7IGkgPD0gbjsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgaTsgKytqKSB7CiAgICAgICAgICAgICAgICBpZiAoZltqXSAmJiB3b3Jkcy5jb250YWlucyhzLnN1YnN0cmluZyhqLCBpKSkpIHsKICAgICAgICAgICAgICAgICAgICBmW2ldID0gdHJ1ZTsKICAgICAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gd29yZEJyZWFrKFN0cmluZyBzLCBMaXN0PFN0cmluZz4gd29yZERpY3QpIHsKICAgICAgICBTZXQ8U3RyaW5nPiB3b3JkcyA9IG5ldyBIYXNoU2V0PD4od29yZERpY3QpOwogICAgICAgIGludCBuID0gcy5sZW5ndGgoKTsKICAgICAgICBib29sZWFuW10gZiA9IG5ldyBib29sZWFuW24gKyAxXTsKICAgICAgICBmWzBdID0gdHJ1ZTsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8PSBuOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBpOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChmW2pdICYmIHdvcmRzLmNvbnRhaW5zKHMuc3Vic3RyaW5nKGosIGkpKSkgewogICAgICAgICAgICAgICAgICAgIGZbaV0gPSB0cnVlOwogICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBmW25dOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X5YW45qCR') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X5YW45qCR') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6w5b+G5YyW') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6w5b+G5YyW') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('56Gu5a6aIGRwW2ldIOaXtu+8jOaJgOacieabtOefreWJjee8gOeahOWPr+WIhuWJsuaAp+W3sue7j+ato+ehruOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHdvcmRCcmVhayDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('ZHBbMF09dHJ1ZSDooajnpLrnqbrliY3nvIDvvJtzdWJzdHJpbmcg5Y+z56uv5Li6IGkg5LiU6K+N5YW45bqU5pS+5YWlIEhhc2hTZXTjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5py057Sg5pe26Ze0IE8obsKyKe+8iOWPpuiuoeaIquS4su+8ie+8jOepuumXtCBPKG4r6K+N5YW4KeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('ZHBbMF09dHJ1ZSDooajnpLrnqbrliY3nvIDvvJtzdWJzdHJpbmcg5Y+z56uv5Li6IGkg5LiU6K+N5YW45bqU5pS+5YWlIEhhc2hTZXTjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHdvcmRCcmVhayDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gd29yZEJyZWFrKFN0cmluZyBzLCBMaXN0PFN0cmluZz4gd29yZERpY3QpIHsKICAgICAgICBTZXQ8U3RyaW5nPiB3b3JkcyA9IG5ldyBIYXNoU2V0PD4od29yZERpY3QpOwogICAgICAgIGludCBuID0ge3tibGFua18xfX07CiAgICAgICAgYm9vbGVhbltdIGYgPSBuZXcgYm9vbGVhbltuICsgMV07CiAgICAgICAgZlswXSA9IHRydWU7CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPD0gbjsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgaTsgKytqKSB7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgICAgICBmW2ldID0gdHJ1ZTsKICAgICAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua18zfX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicy5sZW5ndGgoKSIsImJsYW5rXzIiOiJmW2pdICYmIHdvcmRzLmNvbnRhaW5zKHMuc3Vic3RyaW5nKGosIGkpKSIsImJsYW5rXzMiOiJmW25dIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLliY3nvIBEUCIsIuWIh+WIhueCuSIsIuepuuWJjee8gCIsIuWtl+WFuOagkSIsIuiusOW/huWMliIsIuaVsOe7hCJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 139
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-87: #300 最长递增子序列

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    300, 87, CONVERT(FROM_BASE64('5pyA6ZW/6YCS5aKe5a2Q5bqP5YiX') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzmib7liLDlhbbkuK3mnIDplb/kuKXmoLzpgJLlop7lrZDluo/liJfnmoTplb/luqbjgIIqKuWtkOW6j+WIlyoq5piv55Sx5pWw57uE5rS+55Sf6ICM5p2l55qE5bqP5YiX77yM5Yig6Zmk77yI5oiW5LiN5Yig6Zmk77yJ5pWw57uE5Lit55qE5YWD57Sg6ICM5LiN5pS55Y+Y5YW25L2Z5YWD57Sg55qE6aG65bqP44CC5L6L5aaC77yMYFszLDYsMiw3XWAg5piv5pWw57uEIGBbMCwzLDEsNiwyLDIsN11gIOeahOWtkOW6j+WIl+OAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxMCw5LDIsNSwzLDcsMTAxLDE4XQrovpPlh7rvvJo0Cuino+mHiu+8muacgOmVv+mAkuWinuWtkOW6j+WIl+aYryBbMiwzLDcsMTAxXe+8jOWboOatpOmVv+W6puS4uiA0IOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMCwxLDAsMywyLDNdCui+k+WHuu+8mjQKYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzcsNyw3LDcsNyw3LDddCui+k+WHuu+8mjEKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbnVtcy5sZW5ndGggPD0gMjUwMGAKLSBgLTEwNCA8PSBudW1zW2ldIDw9IDEwNGAqKui/m+mYtu+8mioqLSDkvaDog73lsIbnrpfms5XnmoTml7bpl7TlpI3mnYLluqbpmY3kvY7liLAgYE8obiBsb2cobikpYCDlkJc/CgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbG9uZ2VzdC1pbmNyZWFzaW5nLXN1YnNlcXVlbmNlLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9sb25nZXN0LWluY3JlYXNpbmctc3Vic2VxdWVuY2UvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV0g6KGo56S65LulIG51bXNbaV0g57uT5bC+55qEIExJUyDplb/luqbvvIzmnprkuL7miYDmnIkgajxpIOS4lCBudW1zW2pdPG51bXNbaV0g55qE5YmN6amx6L2s56e744CCIOacrOmimOWbtOe7leOAjOacgOmVv+mAkuWinuWtkOW6j+WIl+OAjeiQveWunui/meS4gOaooeWei++8muiuoeeulyBpIOaXtu+8jOaJgOacieWPr+iDveWJjempseeahOacgOmVv+mAkuWinumVv+W6pumDveW3suato+ehru+8jOWPluacgOWkp+WAvOWKoOS4gOimhuebluaJgOaciee7k+WwvuS4uiBpIOeahOW6j+WIl+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF57uT5bC+54q25oCB55qE5ZCr5LmJ77yM5YaN5qOA5p+l5p6a5Li+5YmN6amx5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaiA9IDA7IGogPCBpOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChudW1zW2pdIDwgbnVtc1tpXSkgewogICAgICAgICAgICAgICAgICAgIGZbaV0gPSBNYXRoLm1heChmW2ldLCBmW2pdICsgMSk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCBmW2ldKTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsZW5ndGhPZkxJUyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICBpbnRbXSBmID0gbmV3IGludFtuXTsKICAgICAgICBBcnJheXMuZmlsbChmLCAxKTsKICAgICAgICBpbnQgYW5zID0gMTsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG47ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IGk7ICsraikgewogICAgICAgICAgICAgICAgaWYgKG51bXNbal0gPCBudW1zW2ldKSB7CiAgICAgICAgICAgICAgICAgICAgZltpXSA9IE1hdGgubWF4KGZbaV0sIGZbal0gKyAxKTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgICAgICBhbnMgPSBNYXRoLm1heChhbnMsIGZbaV0pOwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 300
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 300
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 300
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6K6h566XIGkg5pe277yM5omA5pyJ5Y+v6IO95YmN6amx55qE5pyA6ZW/6YCS5aKe6ZW/5bqm6YO95bey5q2j56Gu77yM5Y+W5pyA5aSn5YC85Yqg5LiA6KaG55uW5omA5pyJ57uT5bC+5Li6IGkg55qE5bqP5YiX44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxlbmd0aE9mTElTIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5LiqIGRwIOWIneWni+S4uiAx77yb5q+U6L6D5b+F6aG75Lil5qC85bCP5LqO77yM562U5qGI5piv5omA5pyJIGRwW2ldIOacgOWkp+WAvOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obsKyKe+8jOepuumXtCBPKG4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5q+P5LiqIGRwIOWIneWni+S4uiAx77yb5q+U6L6D5b+F6aG75Lil5qC85bCP5LqO77yM562U5qGI5piv5omA5pyJIGRwW2ldIOacgOWkp+WAvOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxlbmd0aE9mTElTIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsZW5ndGhPZkxJUyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IG4gPSBudW1zLmxlbmd0aDsKICAgICAgICBpbnRbXSBmID0gbmV3IGludFtuXTsKICAgICAgICBBcnJheXMuZmlsbChmLCAxKTsKICAgICAgICBpbnQgYW5zID0gMTsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG47ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IGk7ICsraikgewogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgICAgICAgICAgZltpXSA9IHt7YmxhbmtfMn19OwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgICAgIGFucyA9IHt7YmxhbmtfM319OwogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtc1tqXSA8IG51bXNbaV0iLCJibGFua18yIjoiTWF0aC5tYXgoZltpXSwgZltqXSArIDEpIiwiYmxhbmtfMyI6Ik1hdGgubWF4KGFucywgZltpXSkiLCJibGFua180IjoiYW5zIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnu5PlsL7nirbmgIEiLCLmnprkuL7liY3pqbEiLCLkuKXmoLzpgJLlop4iLCLmlbDnu4QiLCLkuozliIbmn6Xmib4iLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 300
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-88: #152 乘积最大子数组

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    152, 88, CONVERT(FROM_BASE64('5LmY56ev5pyA5aSn5a2Q5pWw57uE') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzor7fkvaDmib7lh7rmlbDnu4TkuK3kuZjnp6/mnIDlpKfnmoTpnZ7nqbrov57nu60g5a2Q5pWw57uE77yI6K+l5a2Q5pWw57uE5Lit6Iez5bCR5YyF5ZCr5LiA5Liq5pWw5a2X77yJ77yM5bm26L+U5Zue6K+l5a2Q5pWw57uE5omA5a+55bqU55qE5LmY56ev44CCCgrmtYvor5XnlKjkvovnmoTnrZTmoYjmmK/kuIDkuKoqKjMyLeS9jSoq5pW05pWw44CCKiror7fms6jmhI8qKu+8jOS4gOS4quWPquWMheWQq+S4gOS4quWFg+e0oOeahOaVsOe7hOeahOS5mOenr+aYr+i/meS4quWFg+e0oOeahOWAvOOAgioq56S65L6LIDE6KipgYGB0ZXh0Cui+k+WFpTogbnVtcyA9IFsyLDMsLTIsNF0K6L6T5Ye6OiA2Cuino+mHijrCoOWtkOaVsOe7hCBbMiwzXSDmnInmnIDlpKfkuZjnp68gNuOAggpgYGAqKuekuuS+iyAyOioqYGBgdGV4dArovpPlhaU6IG51bXMgPSBbLTIsMCwtMV0K6L6T5Ye6OiAwCuino+mHijrCoOe7k+aenOS4jeiDveS4uiAyLCDlm6DkuLogWy0yLC0xXSDkuI3mmK/lrZDmlbDnu4TjgIIKYGBgKirmj5DnpLo6KiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDIgKiAxMDRgCi0gYC0xMCA8PSBudW1zW2ldIDw9IDEwYAotIGBudW1zYCDnmoTku7vkvZXlrZDmlbDnu4TnmoTkuZjnp6/pg70qKuS/neivgSoq5piv5LiA5LiqKiozMi3kvY0qKuaVtOaVsAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL21heGltdW0tcHJvZHVjdC1zdWJhcnJheS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbWF4aW11bS1wcm9kdWN0LXN1YmFycmF5Lyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5ZCM5pe257u05oqk5Lul5b2T5YmN5L2N572u57uT5bC+55qE5pyA5aSn56ev5ZKM5pyA5bCP56ev77yM6LSf5pWw5Lya6K6p5Lik6ICF6KeS6Imy5LqS5o2i44CCIOacrOmimOWbtOe7leOAjOS5mOenr+acgOWkp+WtkOaVsOe7hOOAjeiQveWunui/meS4gOaooeWei++8muabtOaWsOWQjiBtYXhFbmRpbmcvbWluRW5kaW5nIOWIhuWIq+aYr+aJgOacieS7peW9k+WJjeWFg+e0oOe7k+WwvuWtkOaVsOe7hOS5mOenr+eahOacgOWkpy/mnIDlsI/lgLzjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5pyA5aSn5pyA5bCP56ev55qE5ZCr5LmJ77yM5YaN5qOA5p+l6LSf5pWw57+76L2s5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGZmID0gZiwgZ2cgPSBnOwogICAgICAgICAgICBmID0gTWF0aC5tYXgobnVtc1tpXSwgTWF0aC5tYXgoZmYgKiBudW1zW2ldLCBnZyAqIG51bXNbaV0pKTsKICAgICAgICAgICAgZyA9IE1hdGgubWluKG51bXNbaV0sIE1hdGgubWluKGZmICogbnVtc1tpXSwgZ2cgKiBudW1zW2ldKSk7CiAgICAgICAgICAgIGFucyA9IE1hdGgubWF4KGFucywgZik7CiAgICAgICAgfQogICAgICAgIHJldHVybiBhbnM7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhQcm9kdWN0KGludFtdIG51bXMpIHsKICAgICAgICBpbnQgZiA9IG51bXNbMF0sIGcgPSBudW1zWzBdLCBhbnMgPSBudW1zWzBdOwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbnVtcy5sZW5ndGg7ICsraSkgewogICAgICAgICAgICBpbnQgZmYgPSBmLCBnZyA9IGc7CiAgICAgICAgICAgIGYgPSBNYXRoLm1heChudW1zW2ldLCBNYXRoLm1heChmZiAqIG51bXNbaV0sIGdnICogbnVtc1tpXSkpOwogICAgICAgICAgICBnID0gTWF0aC5taW4obnVtc1tpXSwgTWF0aC5taW4oZmYgKiBudW1zW2ldLCBnZyAqIG51bXNbaV0pKTsKICAgICAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCBmKTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 152
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 152
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pu05paw5ZCOIG1heEVuZGluZy9taW5FbmRpbmcg5YiG5Yir5piv5omA5pyJ5Lul5b2T5YmN5YWD57Sg57uT5bC+5a2Q5pWw57uE5LmY56ev55qE5pyA5aSnL+acgOWwj+WAvOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1heFByb2R1Y3Qg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('6K6h566X5b2T5YmN54q25oCB5YmN5L+d5a2Y5pen5YC877yM5LiN6IO95YWI6KaG55uWIG1heCDlho3nrpcgbWlu77ybMCDkvJroh6rnhLbph43lkK/lrZDmlbDnu4TjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K6h566X5b2T5YmN54q25oCB5YmN5L+d5a2Y5pen5YC877yM5LiN6IO95YWI6KaG55uWIG1heCDlho3nrpcgbWlu77ybMCDkvJroh6rnhLbph43lkK/lrZDmlbDnu4TjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1heFByb2R1Y3Qg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYXhQcm9kdWN0KGludFtdIG51bXMpIHsKICAgICAgICBpbnQgZiA9IHt7YmxhbmtfMX19OwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbnVtcy5sZW5ndGg7ICsraSkgewogICAgICAgICAgICBpbnQgZmYgPSBmLCBnZyA9IGc7CiAgICAgICAgICAgIGYgPSB7e2JsYW5rXzJ9fTsKICAgICAgICAgICAgZyA9IHt7YmxhbmtfM319OwogICAgICAgICAgICBhbnMgPSB7e2JsYW5rXzR9fTsKICAgICAgICB9CiAgICAgICAgcmV0dXJuIHt7YmxhbmtfNX19OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtc1swXSwgZyA9IG51bXNbMF0sIGFucyA9IG51bXNbMF0iLCJibGFua18yIjoiTWF0aC5tYXgobnVtc1tpXSwgTWF0aC5tYXgoZmYgKiBudW1zW2ldLCBnZyAqIG51bXNbaV0pKSIsImJsYW5rXzMiOiJNYXRoLm1pbihudW1zW2ldLCBNYXRoLm1pbihmZiAqIG51bXNbaV0sIGdnICogbnVtc1tpXSkpIiwiYmxhbmtfNCI6Ik1hdGgubWF4KGFucywgZikiLCJibGFua181IjoiYW5zIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLmnIDlpKfmnIDlsI/np68iLCLotJ/mlbDnv7vovawiLCLml6fnirbmgIEiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 152
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-89: #416 分割等和子集

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    416, 89, CONVERT(FROM_BASE64('5YiG5Ymy562J5ZKM5a2Q6ZuG') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5LiqKirlj6rljIXlkKvmraPmlbTmlbAqKueahCoq6Z2e56m6KirmlbDnu4QgYG51bXNgIOOAguivt+S9oOWIpOaWreaYr+WQpuWPr+S7peWwhui/meS4quaVsOe7hOWIhuWJsuaIkOS4pOS4quWtkOmbhu+8jOS9v+W+l+S4pOS4quWtkOmbhueahOWFg+e0oOWSjOebuOetieOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDUsMTEsNV0K6L6T5Ye677yadHJ1ZQrop6Pph4rvvJrmlbDnu4Tlj6/ku6XliIblibLmiJAgWzEsIDUsIDVdIOWSjCBbMTFdIOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMSwyLDMsNV0K6L6T5Ye677yaZmFsc2UK6Kej6YeK77ya5pWw57uE5LiN6IO95YiG5Ymy5oiQ5Lik5Liq5YWD57Sg5ZKM55u4562J55qE5a2Q6ZuG44CCCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDIwMGAKLSBgMSA8PSBudW1zW2ldIDw9IDEwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9wYXJ0aXRpb24tZXF1YWwtc3Vic2V0LXN1bS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvcGFydGl0aW9uLWVxdWFsLXN1YnNldC1zdW0vKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5oC75ZKM5Li65aWH5pWw55u05o6l5aSx6LSl77yb55So5LqM57u0IDAvMSDog4zljIXvvIxmW2ldW2pdIOihqOekuuWJjSBpIOS4quaVsOiDveWQpuWHkeWHuuWSjCBq44CCIOacrOmimOWbtOe7leOAjOWIhuWJsuetieWSjOWtkOmbhuOAjeiQveWunui/meS4gOaooeWei++8muavj+S4queKtuaAgeWPquS7juS4jemAieesrCBpIOS4quaVsOaIluS7juS4iuS4gOihjOmAieaLqeWug+i9rOenu++8jOWboOatpOavj+S4quWFg+e0oOiHs+WkmuS9v+eUqOS4gOasoeOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LqM57u0MDHog4zljIXnmoTlkKvkuYnvvIzlho3mo4Dmn6XliY1p5Liq5pWw5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('Ym9vbGVhbltdIGYgPSBuZXcgYm9vbGVhblttICsgMV07CiAgICAgICAgZlswXSA9IHRydWU7CiAgICAgICAgZm9yIChpbnQgeCA6IG51bXMpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IG07IGogPj0geDsgLS1qKSB7CiAgICAgICAgICAgICAgICBmW2pdIHw9IGZbaiAtIHhdOwogICAgICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuUGFydGl0aW9uKGludFtdIG51bXMpIHsKCiAgICAgICAgaW50IHMgPSAwOwogICAgICAgIGZvciAoaW50IHggOiBudW1zKSB7CiAgICAgICAgICAgIHMgKz0geDsKICAgICAgICB9CiAgICAgICAgaWYgKHMgJSAyID09IDEpIHsKICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgIH0KICAgICAgICBpbnQgbSA9IHMgPj4gMTsKICAgICAgICBib29sZWFuW10gZiA9IG5ldyBib29sZWFuW20gKyAxXTsKICAgICAgICBmWzBdID0gdHJ1ZTsKICAgICAgICBmb3IgKGludCB4IDogbnVtcykgewogICAgICAgICAgICBmb3IgKGludCBqID0gbTsgaiA+PSB4OyAtLWopIHsKICAgICAgICAgICAgICAgIGZbal0gfD0gZltqIC0geF07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbV07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 416
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 416
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5Liq54q25oCB5Y+q5LuO5LiN6YCJ56ysIGkg5Liq5pWw5oiW5LuO5LiK5LiA6KGM6YCJ5oup5a6D6L2s56e777yM5Zug5q2k5q+P5Liq5YWD57Sg6Iez5aSa5L2/55So5LiA5qyh44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGNhblBhcnRpdGlvbiDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('ZlswXVswXT10cnVl77yb5Y+q5pyJIGo+PW51bXNbaS0xXSDml7bmiY3og73orr/pl64gZltpLTFdW2otbnVtc1tpLTFdXeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obsK3c3VtKe+8jOepuumXtCBPKG7Ct3N1bSnjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('ZlswXVswXT10cnVl77yb5Y+q5pyJIGo+PW51bXNbaS0xXSDml7bmiY3og73orr/pl64gZltpLTFdW2otbnVtc1tpLTFdXeOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGNhblBhcnRpdGlvbiDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGJvb2xlYW4gY2FuUGFydGl0aW9uKGludFtdIG51bXMpIHsKCiAgICAgICAgaW50IHMgPSAwOwogICAgICAgIGZvciAoaW50IHggOiBudW1zKSB7CiAgICAgICAgICAgIHMgKz0geDsKICAgICAgICB9CiAgICAgICAgaWYgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIHJldHVybiB7e2JsYW5rXzJ9fTsKICAgICAgICB9CiAgICAgICAgaW50IG0gPSBzID4+IDE7CiAgICAgICAgYm9vbGVhbltdIGYgPSBuZXcgYm9vbGVhblttICsgMV07CiAgICAgICAgZlswXSA9IHRydWU7CiAgICAgICAgZm9yIChpbnQgeCA6IG51bXMpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IG07IGogPj0geDsgLS1qKSB7CiAgICAgICAgICAgICAgICBmW2pdIHw9IHt7YmxhbmtfM319OwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicyAlIDIgPT0gMSIsImJsYW5rXzIiOiJmYWxzZSIsImJsYW5rXzMiOiJmW2ogLSB4XSIsImJsYW5rXzQiOiJmW21dIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuoznu7QwMeiDjOWMhSIsIuWJjWnkuKrmlbAiLCLnm67moIfljYrlkowiLCLmlbDnu4QiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 416
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-90: #32 最长有效括号

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    32, 90, CONVERT(FROM_BASE64('5pyA6ZW/5pyJ5pWI5ous5Y+3') USING utf8mb4), 'HARD', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5Y+q5YyF5ZCrIGAnKCdgIOWSjCBgJyknYCDnmoTlrZfnrKbkuLLvvIzmib7lh7rmnIDplb/mnInmlYjvvIjmoLzlvI/mraPnoa7kuJTov57nu63vvInmi6zlj7cg5a2Q5LiyIOeahOmVv+W6puOAggoK5bem5Y+z5ous5Y+35Yy56YWN77yM5Y2z5q+P5Liq5bem5ous5Y+36YO95pyJ5a+55bqU55qE5Y+z5ous5Y+35bCG5YW26Zet5ZCI55qE5a2X56ym5Liy5piv5qC85byP5q2j56Gu55qE77yM5q+U5aaCIGAiKCgpKCkpImDjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiKCgpIgrovpPlh7rvvJoyCuino+mHiu+8muacgOmVv+acieaViOaLrOWPt+WtkOS4suaYryAiKCkiCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yacyA9ICIpKCkoKSkiCui+k+WHuu+8mjQK6Kej6YeK77ya5pyA6ZW/5pyJ5pWI5ous5Y+35a2Q5Liy5pivICIoKSgpIgpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiIgrovpPlh7rvvJowCmBgYCoq5o+Q56S677yaKiotIGAwIDw9IHMubGVuZ3RoIDw9IDMgKiAxMDRgCi0gYHNbaV1gIOS4uiBgJygnYCDmiJYgYCcpJ2AKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9sb25nZXN0LXZhbGlkLXBhcmVudGhlc2VzLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9sb25nZXN0LXZhbGlkLXBhcmVudGhlc2VzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV0g6KGo56S65Lul5LiL5qCHIGkg57uT5bC+55qE5pyA6ZW/5pyJ5pWI5ous5Y+36ZW/5bqm77yb6YGHICcpJyDml7bmoLnmja7liY3kuIDkuKrlrZfnrKbmiJbliY3kuIDmrrXkuYvliY3nmoTljLnphY0gJygnIOi9rOenu+OAgiDmnKzpopjlm7Tnu5XjgIzmnIDplb/mnInmlYjmi6zlj7fjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmr4/kuKogZHBbaV0g5Y+q5o+P6L+w5b+F6aG75ZyoIGkg57uT5bC+55qE5ZCI5rOV6L+e57ut5q6177yM562U5qGI5Y+W5YWo5bGA5pyA5aSn44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF57uT5bC+RFDnmoTlkKvkuYnvvIzlho3mo4Dmn6XljLnphY3lt6bmi6zlj7flpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('fSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICBpbnQgaiA9IGkgLSBmW2kgLSAxXSAtIDE7CiAgICAgICAgICAgICAgICAgICAgaWYgKGogPiAwICYmIHMuY2hhckF0KGogLSAxKSA9PSAnKCcpIHsKICAgICAgICAgICAgICAgICAgICAgICAgZltpXSA9IGZbaSAtIDFdICsgMiArIGZbaiAtIDFdOwogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsb25nZXN0VmFsaWRQYXJlbnRoZXNlcyhTdHJpbmcgcykgewogICAgICAgIGludCBuID0gcy5sZW5ndGgoKTsKICAgICAgICBpbnRbXSBmID0gbmV3IGludFtuICsgMV07CiAgICAgICAgaW50IGFucyA9IDA7CiAgICAgICAgZm9yIChpbnQgaSA9IDI7IGkgPD0gbjsgKytpKSB7CiAgICAgICAgICAgIGlmIChzLmNoYXJBdChpIC0gMSkgPT0gJyknKSB7CiAgICAgICAgICAgICAgICBpZiAocy5jaGFyQXQoaSAtIDIpID09ICcoJykgewogICAgICAgICAgICAgICAgICAgIGZbaV0gPSBmW2kgLSAyXSArIDI7CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIGludCBqID0gaSAtIGZbaSAtIDFdIC0gMTsKICAgICAgICAgICAgICAgICAgICBpZiAoaiA+IDAgJiYgcy5jaGFyQXQoaiAtIDEpID09ICcoJykgewogICAgICAgICAgICAgICAgICAgICAgICBmW2ldID0gZltpIC0gMV0gKyAyICsgZltqIC0gMV07CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgYW5zID0gTWF0aC5tYXgoYW5zLCBmW2ldKTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 32
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5qCI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5qCI') USING utf8mb4) WHERE p.leetcode_number = 32
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 32
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5LiqIGRwW2ldIOWPquaPj+i/sOW/hemhu+WcqCBpIOe7k+WwvueahOWQiOazlei/nue7reaute+8jOetlOahiOWPluWFqOWxgOacgOWkp+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxvbmdlc3RWYWxpZFBhcmVudGhlc2VzIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6K6h566X6Leo6L+H5YmN5LiA5ZCI5rOV5q6155qE5LiL5qCHIGktZHBbaS0xXS0xIOaXtuimgeWFiOWIpOmdnui0n++8jOW5tuWPr+WGjeWKoOabtOWJjemdoueahCBkcOOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTyhuKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6K6h566X6Leo6L+H5YmN5LiA5ZCI5rOV5q6155qE5LiL5qCHIGktZHBbaS0xXS0xIOaXtuimgeWFiOWIpOmdnui0n++8jOW5tuWPr+WGjeWKoOabtOWJjemdoueahCBkcOOAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxvbmdlc3RWYWxpZFBhcmVudGhlc2VzIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsb25nZXN0VmFsaWRQYXJlbnRoZXNlcyhTdHJpbmcgcykgewogICAgICAgIGludCBuID0ge3tibGFua18xfX07CiAgICAgICAgaW50W10gZiA9IG5ldyBpbnRbbiArIDFdOwogICAgICAgIGludCBhbnMgPSAwOwogICAgICAgIGZvciAoaW50IGkgPSAyOyBpIDw9IG47ICsraSkgewogICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgICAgIGZbaV0gPSBmW2kgLSAyXSArIDI7CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIGludCBqID0gaSAtIGZbaSAtIDFdIC0gMTsKICAgICAgICAgICAgICAgICAgICBpZiAoe3tibGFua180fX0pIHsKICAgICAgICAgICAgICAgICAgICAgICAgZltpXSA9IHt7YmxhbmtfNX19OwogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGFucyA9IE1hdGgubWF4KGFucywgZltpXSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGFuczsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicy5sZW5ndGgoKSIsImJsYW5rXzIiOiJzLmNoYXJBdChpIC0gMSkgPT0gJyknIiwiYmxhbmtfMyI6InMuY2hhckF0KGkgLSAyKSA9PSAnKCciLCJibGFua180IjoiaiA+IDAgJiYgcy5jaGFyQXQoaiAtIDEpID09ICcoJyIsImJsYW5rXzUiOiJmW2kgLSAxXSArIDIgKyBmW2ogLSAxXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnu5PlsL5EUCIsIuWMuemFjeW3puaLrOWPtyIsIui3qOautei/nuaOpSIsIuagiCIsIuWtl+espuS4siIsIuWKqOaAgeinhOWIkiJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 32
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-91: #62 不同路径

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    62, 91, CONVERT(FROM_BASE64('5LiN5ZCM6Lev5b6E') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5LiA5Liq5py65Zmo5Lq65L2N5LqO5LiA5LiqIGBtIHggbmAqKue9keagvOeahOW3puS4iuinkiDvvIjotbflp4vngrnlnKjkuIvlm77kuK3moIforrDkuLog4oCcU3RhcnTigJ0g77yJ44CCCgrmnLrlmajkurrmr4/mrKHlj6rog73lkJHkuIvmiJbogIXlkJHlj7Pnp7vliqjkuIDmraXjgILmnLrlmajkurror5Xlm77ovr7liLDnvZHmoLznmoTlj7PkuIvop5LvvIjlnKjkuIvlm77kuK3moIforrDkuLog4oCcRmluaXNo4oCdIO+8ieOAggoK6Zeu5oC75YWx5pyJ5aSa5bCR5p2h5LiN5ZCM55qE6Lev5b6E77yfKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vcGljLmxlZXRjb2RlLmNuLzE2OTc0MjI3NDAtYWR4bXNJLWltYWdlLnBuZykKCmBgYHRleHQK6L6T5YWl77yabSA9IDMsIG4gPSA3Cui+k+WHuu+8mjI4CmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabSA9IDMsIG4gPSAyCui+k+WHuu+8mjMK6Kej6YeK77yaCuS7juW3puS4iuinkuW8gOWni++8jOaAu+WFseaciSAzIOadoei3r+W+hOWPr+S7peWIsOi+vuWPs+S4i+inkuOAggoxLiDlkJHlj7MgLT4g5ZCR5LiLIC0+IOWQkeS4iwoyLiDlkJHkuIsgLT4g5ZCR5LiLIC0+IOWQkeWPswozLiDlkJHkuIsgLT4g5ZCR5Y+zIC0+IOWQkeS4iwpgYGAqKuekuuS+iyAz77yaKipgYGB0ZXh0Cui+k+WFpe+8mm0gPSA3LCBuID0gMwrovpPlh7rvvJoyOApgYGAqKuekuuS+iyA077yaKipgYGB0ZXh0Cui+k+WFpe+8mm0gPSAzLCBuID0gMwrovpPlh7rvvJo2CmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG0sIG4gPD0gMTAwYAotIOmimOebruaVsOaNruS/neivgeetlOahiOWwj+S6juetieS6jiBgMiAqIDEwOWAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy91bmlxdWUtcGF0aHMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3VuaXF1ZS1wYXRocy8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5LqM57u0IGRwW2ldW2pdIOihqOekuuWIsOagvOWtkCAoaSxqKSDnmoTot6/lvoTmlbDvvIzmnaXoh6rkuIrmlrnkuI7lt6bmlrnkuYvlkozjgIIg5pys6aKY5Zu057uV44CM5LiN5ZCM6Lev5b6E44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5oyJ6KGM5YiX5q2j5bqP6K6h566X5pe277yM5b2T5YmN5qC86ZyA6KaB55qE5LiK5pa55ZKM5bem5pa554q25oCB6YO95bey57uP5a6M5oiQ44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LqM57u0572R5qC8RFDnmoTlkKvkuYnvvIzlho3mo4Dmn6XkuIrliqDlt6blpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChpID4gMCkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gKz0gZltpIC0gMV1bal07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoaiA+IDApIHs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCB1bmlxdWVQYXRocyhpbnQgbSwgaW50IG4pIHsKICAgICAgICB2YXIgZiA9IG5ldyBpbnRbbV1bbl07CiAgICAgICAgZlswXVswXSA9IDE7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmIChpID4gMCkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gKz0gZltpIC0gMV1bal07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoaiA+IDApIHsKICAgICAgICAgICAgICAgICAgICBmW2ldW2pdICs9IGZbaV1baiAtIDFdOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBmW20gLSAxXVtuIC0gMV07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 62
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 62
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 62
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('57uE5ZCI5pWw5a2m') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('57uE5ZCI5pWw5a2m') USING utf8mb4) WHERE p.leetcode_number = 62
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5oyJ6KGM5YiX5q2j5bqP6K6h566X5pe277yM5b2T5YmN5qC86ZyA6KaB55qE5LiK5pa55ZKM5bem5pa554q25oCB6YO95bey57uP5a6M5oiQ44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHVuaXF1ZVBhdGhzIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6LW354K56K6+5Li6IDHvvJvnrKzkuIDooYzmiJbnrKzkuIDliJflj6rmnInkuIDkuKrmnaXmupDvvIzovrnnlYzliKTmlq3kuI3lj6/orr/pl67otJ/kuIvmoIfjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM56m66Ze0IE8obW4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6LW354K56K6+5Li6IDHvvJvnrKzkuIDooYzmiJbnrKzkuIDliJflj6rmnInkuIDkuKrmnaXmupDvvIzovrnnlYzliKTmlq3kuI3lj6/orr/pl67otJ/kuIvmoIfjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHVuaXF1ZVBhdGhzIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCB1bmlxdWVQYXRocyhpbnQgbSwgaW50IG4pIHsKICAgICAgICB2YXIgZiA9IG5ldyBpbnRbbV1bbl07CiAgICAgICAgZlswXVswXSA9IDE7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gKz0ge3tibGFua18yfX07CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18zfX0pIHsKICAgICAgICAgICAgICAgICAgICBmW2ldW2pdICs9IHt7YmxhbmtfNH19OwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzV9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiaSA+IDAiLCJibGFua18yIjoiZltpIC0gMV1bal0iLCJibGFua18zIjoiaiA+IDAiLCJibGFua180IjoiZltpXVtqIC0gMV0iLCJibGFua181IjoiZlttIC0gMV1bbiAtIDFdIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuoznu7TnvZHmoLxEUCIsIuS4iuWKoOW3piIsIui1t+eCuSIsIuaVsOWtpiIsIuWKqOaAgeinhOWIkiIsIue7hOWQiOaVsOWtpiJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 62
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-92: #64 最小路径和

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    64, 92, CONVERT(FROM_BASE64('5pyA5bCP6Lev5b6E5ZKM') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5YyF5ZCr6Z2e6LSf5pW05pWw55qEIGBtIHggbmAg572R5qC8IGBncmlkYCDvvIzor7fmib7lh7rkuIDmnaHku47lt6bkuIrop5LliLDlj7PkuIvop5LnmoTot6/lvoTvvIzkvb/lvpfot6/lvoTkuIrnmoTmlbDlrZfmgLvlkozkuLrmnIDlsI/jgIIqKuivtOaYju+8mioq5q+P5qyh5Y+q6IO95ZCR5LiL5oiW6ICF5ZCR5Y+z56e75Yqo5LiA5q2l44CCKirnpLrkvosgMe+8mioqIVvpopjnm67npLrmhI/lm75dKGh0dHBzOi8vYXNzZXRzLmxlZXRjb2RlLmNvbS91cGxvYWRzLzIwMjAvMTEvMDUvbWlucGF0aC5qcGcpCgpgYGB0ZXh0Cui+k+WFpe+8mmdyaWQgPSBbWzEsMywxXSxbMSw1LDFdLFs0LDIsMV1dCui+k+WHuu+8mjcK6Kej6YeK77ya5Zug5Li66Lev5b6EIDHihpIz4oaSMeKGkjHihpIxIOeahOaAu+WSjOacgOWwj+OAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mmdyaWQgPSBbWzEsMiwzXSxbNCw1LDZdXQrovpPlh7rvvJoxMgpgYGAqKuaPkOekuu+8mioqLSBgbSA9PSBncmlkLmxlbmd0aGAKLSBgbiA9PSBncmlkW2ldLmxlbmd0aGAKLSBgMSA8PSBtLCBuIDw9IDIwMGAKLSBgMCA8PSBncmlkW2ldW2pdIDw9IDIwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9taW5pbXVtLXBhdGgtc3VtLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9taW5pbXVtLXBhdGgtc3VtLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5LqM57u0IGRwIOe0r+WKoOWIsOavj+agvOeahOacgOWwj+i3r+W+hOWSjO+8jOi9rOenu+S4uiBncmlkW2ldW2pdK21pbijkuIos5bemKeOAgiDmnKzpopjlm7Tnu5XjgIzmnIDlsI/ot6/lvoTlkozjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrlpITnkIbliLDlvZPliY3moLzml7bvvIzkuIrmlrnlkozlt6bmlrnnirbmgIHlt7Lnu4/mmK/liLDlkIToh6rkvY3nva7nmoTmnIDkvJjot6/lvoTlkozjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LqM57u0RFDnmoTlkKvkuYnvvIzlho3mo4Dmn6XkuIrlt6bovaznp7vlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBmW2ldW2pdID0gTWF0aC5taW4oZltpIC0gMV1bal0sIGZbaV1baiAtIDFdKSArIGdyaWRbaV1bal07CiAgICAgICAgICAgIH0KICAgICAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtaW5QYXRoU3VtKGludFtdW10gZ3JpZCkgewogICAgICAgIGludCBtID0gZ3JpZC5sZW5ndGgsIG4gPSBncmlkWzBdLmxlbmd0aDsKICAgICAgICBpbnRbXVtdIGYgPSBuZXcgaW50W21dW25dOwogICAgICAgIGZbMF1bMF0gPSBncmlkWzBdWzBdOwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbTsgKytpKSB7CiAgICAgICAgICAgIGZbaV1bMF0gPSBmW2kgLSAxXVswXSArIGdyaWRbaV1bMF07CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgIGZbMF1bal0gPSBmWzBdW2ogLSAxXSArIGdyaWRbMF1bal07CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDwgbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgICAgICBmW2ldW2pdID0gTWF0aC5taW4oZltpIC0gMV1bal0sIGZbaV1baiAtIDFdKSArIGdyaWRbaV1bal07CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbSAtIDFdW24gLSAxXTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 64
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 64
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 64
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('55+p6Zi1') USING utf8mb4) WHERE p.leetcode_number = 64
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5Yiw5b2T5YmN5qC85pe277yM5LiK5pa55ZKM5bem5pa554q25oCB5bey57uP5piv5Yiw5ZCE6Ieq5L2N572u55qE5pyA5LyY6Lev5b6E5ZKM44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1pblBhdGhTdW0g5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('56ys5LiA6KGM5ZKM56ys5LiA5YiX5Y+q5pyJ5Y2V5LiA5p2l5rqQ77yM5b+F6aG75YWI5YiG5Yir5Yid5aeL5YyW44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM6aKd5aSW56m66Ze0IE8obW4p44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('56ys5LiA6KGM5ZKM56ys5LiA5YiX5Y+q5pyJ5Y2V5LiA5p2l5rqQ77yM5b+F6aG75YWI5YiG5Yir5Yid5aeL5YyW44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1pblBhdGhTdW0g55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtaW5QYXRoU3VtKGludFtdW10gZ3JpZCkgewogICAgICAgIGludCBtID0gZ3JpZC5sZW5ndGgsIG4gPSBncmlkWzBdLmxlbmd0aDsKICAgICAgICBpbnRbXVtdIGYgPSBuZXcgaW50W21dW25dOwogICAgICAgIGZbMF1bMF0gPSB7e2JsYW5rXzF9fTsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8IG07ICsraSkgewogICAgICAgICAgICBmW2ldWzBdID0ge3tibGFua18yfX07CiAgICAgICAgfQogICAgICAgIGZvciAoaW50IGogPSAxOyBqIDwgbjsgKytqKSB7CiAgICAgICAgICAgIGZbMF1bal0gPSB7e2JsYW5rXzN9fTsKICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPCBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDE7IGogPCBuOyArK2opIHsKICAgICAgICAgICAgICAgIGZbaV1bal0gPSBNYXRoLm1pbihmW2kgLSAxXVtqXSwgZltpXVtqIC0gMV0pICsgZ3JpZFtpXVtqXTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4ge3tibGFua180fX07CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiZ3JpZFswXVswXSIsImJsYW5rXzIiOiJmW2kgLSAxXVswXSArIGdyaWRbaV1bMF0iLCJibGFua18zIjoiZlswXVtqIC0gMV0gKyBncmlkWzBdW2pdIiwiYmxhbmtfNCI6ImZbbSAtIDFdW24gLSAxXSJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuoznu7REUCIsIuS4iuW3pui9rOenuyIsIui+ueeVjOWIneWni+WMliIsIuaVsOe7hCIsIuWKqOaAgeinhOWIkiIsIuefqemYtSJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 64
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-93: #5 最长回文子串

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    5, 93, CONVERT(FROM_BASE64('5pyA6ZW/5Zue5paH5a2Q5Liy') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5LiA5Liq5a2X56ym5LiyIGBzYO+8jOaJvuWIsCBgc2Ag5Lit5pyA6ZW/55qEIOWbnuaWhyDlrZDkuLLjgIIqKuekuuS+iyAx77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiYmFiYWQiCui+k+WHuu+8miJiYWIiCuino+mHiu+8miJhYmEiIOWQjOagt+aYr+espuWQiOmimOaEj+eahOetlOahiOOAggpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mnMgPSAiY2JiZCIK6L6T5Ye677yaImJiIgpgYGAqKuaPkOekuu+8mioqLSBgMSA8PSBzLmxlbmd0aCA8PSAxMDAwYAotIGBzYCDku4XnlLHmlbDlrZflkozoi7HmloflrZfmr43nu4TmiJAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9sb25nZXN0LXBhbGluZHJvbWljLXN1YnN0cmluZy8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbG9uZ2VzdC1wYWxpbmRyb21pYy1zdWJzdHJpbmcvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('5Lul5q+P5Liq5L2N572u5Li65aWH5pWw5Lit5b+D5ZKM5q+P5Liq55u46YK76Ze06ZqZ5Li65YG25pWw5Lit5b+D5ZCR5Lik5L6n5omp5bGV77yM6K6w5b2V5pyA6ZW/5Zue5paH5Yy66Ze044CCIOacrOmimOWbtOe7leOAjOacgOmVv+WbnuaWh+WtkOS4suOAjeiQveWunui/meS4gOaooeWei++8muS4gOasoeaJqeWxleS4rSBbbGVmdCsxLHJpZ2h0LTFdIOWni+e7iOaYr+WbnuaWh++8jOWBnOatouaXtuW+l+WIsOivpeS4reW/g+eahOacgOmVv+WbnuaWh+OAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Lit5b+D5omp5bGV55qE5ZCr5LmJ77yM5YaN5qOA5p+l5aWH5YG25Lit5b+D5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIH0KICAgICAgICByZXR1cm4gcy5zdWJzdHJpbmcoc3RhcnQsIHN0YXJ0ICsgbXgpOwogICAgfQoKICAgIHByaXZhdGUgaW50IGYoaW50IGwsIGludCByKSB7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBTdHJpbmcgczsKICAgIHByaXZhdGUgaW50IG47CgogICAgcHVibGljIFN0cmluZyBsb25nZXN0UGFsaW5kcm9tZShTdHJpbmcgcykgewogICAgICAgIHRoaXMucyA9IHM7CiAgICAgICAgbiA9IHMubGVuZ3RoKCk7CiAgICAgICAgaW50IHN0YXJ0ID0gMCwgbXggPSAxOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSB7CiAgICAgICAgICAgIGludCBhID0gZihpLCBpKTsKICAgICAgICAgICAgaW50IGIgPSBmKGksIGkgKyAxKTsKICAgICAgICAgICAgaW50IHQgPSBNYXRoLm1heChhLCBiKTsKICAgICAgICAgICAgaWYgKG14IDwgdCkgewogICAgICAgICAgICAgICAgbXggPSB0OwogICAgICAgICAgICAgICAgc3RhcnQgPSBpIC0gKCh0IC0gMSkgPj4gMSk7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIHMuc3Vic3RyaW5nKHN0YXJ0LCBzdGFydCArIG14KTsKICAgIH0KCiAgICBwcml2YXRlIGludCBmKGludCBsLCBpbnQgcikgewogICAgICAgIHdoaWxlIChsID49IDAgJiYgciA8IG4gJiYgcy5jaGFyQXQobCkgPT0gcy5jaGFyQXQocikpIHsKICAgICAgICAgICAgLS1sOwogICAgICAgICAgICArK3I7CiAgICAgICAgfQogICAgICAgIHJldHVybiByIC0gbCAtIDE7CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 5
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 5
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 5
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 5
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LiA5qyh5omp5bGV5LitIFtsZWZ0KzEscmlnaHQtMV0g5aeL57uI5piv5Zue5paH77yM5YGc5q2i5pe25b6X5Yiw6K+l5Lit5b+D55qE5pyA6ZW/5Zue5paH44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxvbmdlc3RQYWxpbmRyb21lIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('6KaB5ZCM5pe25qOA5p+l5aWH5YG25Lit5b+D77yb5Yy66Ze06ZW/5bqm5LiOIHN1YnN0cmluZyDlj7Pnq6/lvIDljLrpl7TlrrnmmJPlt67kuIDjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obsKyKe+8jOepuumXtCBPKDEp44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6KaB5ZCM5pe25qOA5p+l5aWH5YG25Lit5b+D77yb5Yy66Ze06ZW/5bqm5LiOIHN1YnN0cmluZyDlj7Pnq6/lvIDljLrpl7TlrrnmmJPlt67kuIDjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxvbmdlc3RQYWxpbmRyb21lIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHJpdmF0ZSBTdHJpbmcgczsKICAgIHByaXZhdGUgaW50IG47CgogICAgcHVibGljIFN0cmluZyBsb25nZXN0UGFsaW5kcm9tZShTdHJpbmcgcykgewogICAgICAgIHRoaXMucyA9IHM7CiAgICAgICAgbiA9IHt7YmxhbmtfMX19OwogICAgICAgIGludCBzdGFydCA9IDAsIG14ID0gMTsKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG47ICsraSkgewogICAgICAgICAgICBpbnQgYSA9IHt7YmxhbmtfMn19OwogICAgICAgICAgICBpbnQgYiA9IHt7YmxhbmtfM319OwogICAgICAgICAgICBpbnQgdCA9IHt7YmxhbmtfNH19OwogICAgICAgICAgICBpZiAoe3tibGFua181fX0pIHsKICAgICAgICAgICAgICAgIG14ID0gdDsKICAgICAgICAgICAgICAgIHN0YXJ0ID0gaSAtICgodCAtIDEpID4+IDEpOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBzLnN1YnN0cmluZyhzdGFydCwgc3RhcnQgKyBteCk7CiAgICB9CgogICAgcHJpdmF0ZSBpbnQgZihpbnQgbCwgaW50IHIpIHsKICAgICAgICB3aGlsZSAobCA+PSAwICYmIHIgPCBuICYmIHMuY2hhckF0KGwpID09IHMuY2hhckF0KHIpKSB7CiAgICAgICAgICAgIC0tbDsKICAgICAgICAgICAgKytyOwogICAgICAgIH0KICAgICAgICByZXR1cm4gciAtIGwgLSAxOwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoicy5sZW5ndGgoKSIsImJsYW5rXzIiOiJmKGksIGkpIiwiYmxhbmtfMyI6ImYoaSwgaSArIDEpIiwiYmxhbmtfNCI6Ik1hdGgubWF4KGEsIGIpIiwiYmxhbmtfNSI6Im14IDwgdCJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuK3lv4PmianlsZUiLCLlpYflgbbkuK3lv4MiLCLmnIDplb/ljLrpl7QiLCLlj4zmjIfpkogiLCLlrZfnrKbkuLIiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 5
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-94: #1143 最长公共子序列

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    1143, 94, CONVERT(FROM_BASE64('5pyA6ZW/5YWs5YWx5a2Q5bqP5YiX') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5Lik5Liq5a2X56ym5LiyIGB0ZXh0MWAg5ZKMIGB0ZXh0MmDvvIzov5Tlm57ov5nkuKTkuKrlrZfnrKbkuLLnmoTmnIDplb8qKuWFrOWFseWtkOW6j+WIlyoq55qE6ZW/5bqm44CC5aaC5p6c5LiN5a2Y5ZyoKirlhazlhbHlrZDluo/liJcqKu+8jOi/lOWbniBgMGAg44CCCgrkuIDkuKrlrZfnrKbkuLLnmoQqKuWtkOW6j+WIlyoqKirmmK/mjIfov5nmoLfkuIDkuKrmlrDnmoTlrZfnrKbkuLLvvJrlroPmmK/nlLHljp/lrZfnrKbkuLLlnKjkuI3mlLnlj5jlrZfnrKbnmoTnm7jlr7npobrluo/nmoTmg4XlhrXkuIvliKDpmaTmn5DkupvlrZfnrKbvvIjkuZ/lj6/ku6XkuI3liKDpmaTku7vkvZXlrZfnrKbvvInlkI7nu4TmiJDnmoTmlrDlrZfnrKbkuLLjgIIKCi0g5L6L5aaC77yMYCJhY2UiYCDmmK8gYCJhYmNkZSJgIOeahOWtkOW6j+WIl++8jOS9hiBgImFlYyJgIOS4jeaYryBgImFiY2RlImAg55qE5a2Q5bqP5YiX44CCCgrkuKTkuKrlrZfnrKbkuLLnmoQqKuWFrOWFseWtkOW6j+WIlyoq5piv6L+Z5Lik5Liq5a2X56ym5Liy5omA5YWx5ZCM5oul5pyJ55qE5a2Q5bqP5YiX44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJp0ZXh0MSA9ICJhYmNkZSIsIHRleHQyID0gImFjZSIK6L6T5Ye677yaMwrop6Pph4rvvJrmnIDplb/lhazlhbHlrZDluo/liJfmmK8gImFjZSIg77yM5a6D55qE6ZW/5bqm5Li6IDMg44CCCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yadGV4dDEgPSAiYWJjIiwgdGV4dDIgPSAiYWJjIgrovpPlh7rvvJozCuino+mHiu+8muacgOmVv+WFrOWFseWtkOW6j+WIl+aYryAiYWJjIiDvvIzlroPnmoTplb/luqbkuLogMyDjgIIKYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJp0ZXh0MSA9ICJhYmMiLCB0ZXh0MiA9ICJkZWYiCui+k+WHuu+8mjAK6Kej6YeK77ya5Lik5Liq5a2X56ym5Liy5rKh5pyJ5YWs5YWx5a2Q5bqP5YiX77yM6L+U5ZueIDAg44CCCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IHRleHQxLmxlbmd0aCwgdGV4dDIubGVuZ3RoIDw9IDEwMDBgCi0gYHRleHQxYCDlkowgYHRleHQyYCDku4XnlLHlsI/lhpnoi7HmloflrZfnrKbnu4TmiJDjgIIKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9sb25nZXN0LWNvbW1vbi1zdWJzZXF1ZW5jZS8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbG9uZ2VzdC1jb21tb24tc3Vic2VxdWVuY2UvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV1bal0g6KGo56S6IHRleHQxIOWJjSBpIOS4quWtl+espuS4jiB0ZXh0MiDliY0gaiDkuKrlrZfnrKbnmoQgTENTIOmVv+W6pu+8m+ebuOetieWPluW3puS4iisx77yM5ZCm5YiZ5Y+W5LiK5LiO5bem5pyA5aSn44CCIOacrOmimOWbtOe7leOAjOacgOmVv+WFrOWFseWtkOW6j+WIl+OAjeiQveWunui/meS4gOaooeWei++8muWhq+WIsCAoaSxqKSDml7bvvIzmiYDmnInmm7Tnn63liY3nvIDnu4TlkIjpg73lt7Lnu4/lvpfliLDmnIDkvJggTENT44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5Y+M5bqP5YiXRFDnmoTlkKvkuYnvvIzlho3mo4Dmn6XliY3nvIDnirbmgIHlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('Zm9yIChpbnQgaSA9IDE7IGkgPD0gbTsgKytpKSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgaWYgKHRleHQxLmNoYXJBdChpIC0gMSkgPT0gdGV4dDIuY2hhckF0KGogLSAxKSkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSBmW2kgLSAxXVtqIC0gMV0gKyAxOwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICBmW2ldW2pdID0gTWF0aC5tYXgoZltpIC0gMV1bal0sIGZbaV1baiAtIDFdKTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsb25nZXN0Q29tbW9uU3Vic2VxdWVuY2UoU3RyaW5nIHRleHQxLCBTdHJpbmcgdGV4dDIpIHsKICAgICAgICBpbnQgbSA9IHRleHQxLmxlbmd0aCgpLCBuID0gdGV4dDIubGVuZ3RoKCk7CiAgICAgICAgaW50W11bXSBmID0gbmV3IGludFttICsgMV1bbiArIDFdOwogICAgICAgIGZvciAoaW50IGkgPSAxOyBpIDw9IG07ICsraSkgewogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8PSBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh0ZXh0MS5jaGFyQXQoaSAtIDEpID09IHRleHQyLmNoYXJBdChqIC0gMSkpIHsKICAgICAgICAgICAgICAgICAgICBmW2ldW2pdID0gZltpIC0gMV1baiAtIDFdICsgMTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgZltpXVtqXSA9IE1hdGgubWF4KGZbaSAtIDFdW2pdLCBmW2ldW2ogLSAxXSk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGZbbV1bbl07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 1143
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 1143
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 1143
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aGr5YiwIChpLGopIOaXtu+8jOaJgOacieabtOefreWJjee8gOe7hOWQiOmDveW3sue7j+W+l+WIsOacgOS8mCBMQ1PjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGxvbmdlc3RDb21tb25TdWJzZXF1ZW5jZSDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5a2X56ym5LiL5qCH5pivIGktMeOAgWotMe+8m+epuuWJjee8gOihjOWIl+S/neaMgSAw44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM56m66Ze0IE8obW4p77yM5Y+v5rua5Yqo5YiwIE8obinjgII=') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5a2X56ym5LiL5qCH5pivIGktMeOAgWotMe+8m+epuuWJjee8gOihjOWIl+S/neaMgSAw44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGxvbmdlc3RDb21tb25TdWJzZXF1ZW5jZSDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBsb25nZXN0Q29tbW9uU3Vic2VxdWVuY2UoU3RyaW5nIHRleHQxLCBTdHJpbmcgdGV4dDIpIHsKICAgICAgICBpbnQgbSA9IHt7YmxhbmtfMX19OwogICAgICAgIGludFtdW10gZiA9IG5ldyBpbnRbbSArIDFdW24gKyAxXTsKICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8PSBtOyArK2kpIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IDE7IGogPD0gbjsgKytqKSB7CiAgICAgICAgICAgICAgICBpZiAoe3tibGFua18yfX0pIHsKICAgICAgICAgICAgICAgICAgICBmW2ldW2pdID0gZltpIC0gMV1baiAtIDFdICsgMTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgZltpXVtqXSA9IHt7YmxhbmtfM319OwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoidGV4dDEubGVuZ3RoKCksIG4gPSB0ZXh0Mi5sZW5ndGgoKSIsImJsYW5rXzIiOiJ0ZXh0MS5jaGFyQXQoaSAtIDEpID09IHRleHQyLmNoYXJBdChqIC0gMSkiLCJibGFua18zIjoiTWF0aC5tYXgoZltpIC0gMV1bal0sIGZbaV1baiAtIDFdKSIsImJsYW5rXzQiOiJmW21dW25dIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlj4zluo/liJdEUCIsIuWJjee8gOeKtuaAgSIsIuW3puS4iui9rOenuyIsIuWtl+espuS4siIsIuWKqOaAgeinhOWIkiJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 1143
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-95: #72 编辑距离

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    72, 95, CONVERT(FROM_BASE64('57yW6L6R6Led56a7') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5L2g5Lik5Liq5Y2V6K+NIGB3b3JkMWAg5ZKMIGB3b3JkMmDvvIwgKuivt+i/lOWbnuWwhiBgd29yZDFgIOi9rOaNouaIkCBgd29yZDJgIOaJgOS9v+eUqOeahOacgOWwkeaTjeS9nOaVsCogIOOAggoK5L2g5Y+v5Lul5a+55LiA5Liq5Y2V6K+N6L+b6KGM5aaC5LiL5LiJ56eN5pON5L2c77yaCgotIOaPkuWFpeS4gOS4quWtl+espgotIOWIoOmZpOS4gOS4quWtl+espgotIOabv+aNouS4gOS4quWtl+espioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yad29yZDEgPSAiaG9yc2UiLCB3b3JkMiA9ICJyb3MiCui+k+WHuu+8mjMK6Kej6YeK77yaCmhvcnNlIC0+IHJvcnNlICjlsIYgJ2gnIOabv+aNouS4uiAncicpCnJvcnNlIC0+IHJvc2UgKOWIoOmZpCAncicpCnJvc2UgLT4gcm9zICjliKDpmaQgJ2UnKQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mndvcmQxID0gImludGVudGlvbiIsIHdvcmQyID0gImV4ZWN1dGlvbiIK6L6T5Ye677yaNQrop6Pph4rvvJoKaW50ZW50aW9uIC0+IGluZW50aW9uICjliKDpmaQgJ3QnKQppbmVudGlvbiAtPiBlbmVudGlvbiAo5bCGICdpJyDmm7/mjaLkuLogJ2UnKQplbmVudGlvbiAtPiBleGVudGlvbiAo5bCGICduJyDmm7/mjaLkuLogJ3gnKQpleGVudGlvbiAtPiBleGVjdGlvbiAo5bCGICduJyDmm7/mjaLkuLogJ2MnKQpleGVjdGlvbiAtPiBleGVjdXRpb24gKOaPkuWFpSAndScpCmBgYCoq5o+Q56S677yaKiotIGAwIDw9IHdvcmQxLmxlbmd0aCwgd29yZDIubGVuZ3RoIDw9IDUwMGAKLSBgd29yZDFgIOWSjCBgd29yZDJgIOeUseWwj+WGmeiLseaWh+Wtl+avjee7hOaIkAoKLS0tCgrljp/popjvvJpbTGVldENvZGUg5Lit5paH56uZXShodHRwczovL2xlZXRjb2RlLmNuL3Byb2JsZW1zL2VkaXQtZGlzdGFuY2UvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL2VkaXQtZGlzdGFuY2UvKQ==') USING utf8mb4),
    CONVERT(FROM_BASE64('ZHBbaV1bal0g6KGo56S6IHdvcmQxIOWJjSBpIOS4quWtl+espuWPmOaIkCB3b3JkMiDliY0gaiDkuKrlrZfnrKbnmoTmnIDlsJHmk43kvZzvvJvmnKvlrZfnrKbkuI3lkIzlj5bliKDjgIHlop7jgIHmm7/mjaLkuInogIXmnIDlsI8rMeOAgiDmnKzpopjlm7Tnu5XjgIznvJbovpHot53nprvjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmr4/kuKrnirbmgIHopobnm5bkuKTkuKrliY3nvIDpl7Tlhajpg6jlj6/og73mnIDlkI7kuIDmraXvvIzlj5bmnIDlsI/lkI7ljbPkuLror6XlrZDpl67popjmnIDkvJjop6PjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF57yW6L6R6Led56a755qE5ZCr5LmJ77yM5YaN5qOA5p+l5aKe5Yig5pS55aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('ZltpXVswXSA9IGk7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgaWYgKHdvcmQxLmNoYXJBdChpIC0gMSkgPT0gd29yZDIuY2hhckF0KGogLSAxKSkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSBmW2kgLSAxXVtqIC0gMV07CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSBNYXRoLm1pbihmW2kgLSAxXVtqXSwgTWF0aC5taW4oZltpXVtqIC0gMV0sIGZbaSAtIDFdW2ogLSAxXSkpICsgMTs=') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtaW5EaXN0YW5jZShTdHJpbmcgd29yZDEsIFN0cmluZyB3b3JkMikgewogICAgICAgIGludCBtID0gd29yZDEubGVuZ3RoKCksIG4gPSB3b3JkMi5sZW5ndGgoKTsKICAgICAgICBpbnRbXVtdIGYgPSBuZXcgaW50W20gKyAxXVtuICsgMV07CiAgICAgICAgZm9yIChpbnQgaiA9IDE7IGogPD0gbjsgKytqKSB7CiAgICAgICAgICAgIGZbMF1bal0gPSBqOwogICAgICAgIH0KICAgICAgICBmb3IgKGludCBpID0gMTsgaSA8PSBtOyArK2kpIHsKICAgICAgICAgICAgZltpXVswXSA9IGk7CiAgICAgICAgICAgIGZvciAoaW50IGogPSAxOyBqIDw9IG47ICsraikgewogICAgICAgICAgICAgICAgaWYgKHdvcmQxLmNoYXJBdChpIC0gMSkgPT0gd29yZDIuY2hhckF0KGogLSAxKSkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSBmW2kgLSAxXVtqIC0gMV07CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSBNYXRoLm1pbihmW2kgLSAxXVtqXSwgTWF0aC5taW4oZltpXVtqIC0gMV0sIGZbaSAtIDFdW2ogLSAxXSkpICsgMTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gZlttXVtuXTsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5aSa57u05Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 72
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5a2X56ym5Liy') USING utf8mb4) WHERE p.leetcode_number = 72
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Yqo5oCB6KeE5YiS') USING utf8mb4) WHERE p.leetcode_number = 72
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P5Liq54q25oCB6KaG55uW5Lik5Liq5YmN57yA6Ze05YWo6YOo5Y+v6IO95pyA5ZCO5LiA5q2l77yM5Y+W5pyA5bCP5ZCO5Y2z5Li66K+l5a2Q6Zeu6aKY5pyA5LyY6Kej44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1pbkRpc3RhbmNlIOaXtuacgOmcgOimgeajgOafpeWTquS4qui+ueeVjOaIluabtOaWsOmhuuW6j++8nw==') USING utf8mb4), CONVERT(FROM_BASE64('ZHBbaV1bMF09aeOAgWRwWzBdW2pdPWrvvJvlrZfnrKbnm7jlkIznm7TmjqXnu6fmib/lt6bkuIrvvIzkuI3pop3lpJbliqDmk43kvZzjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obW4p77yM56m66Ze0IE8obW4p77yM5Y+v5rua5Yqo5LyY5YyW44CC') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('ZHBbaV1bMF09aeOAgWRwWzBdW2pdPWrvvJvlrZfnrKbnm7jlkIznm7TmjqXnu6fmib/lt6bkuIrvvIzkuI3pop3lpJbliqDmk43kvZzjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1pbkRpc3RhbmNlIOeahOi/lOWbnuivreS5ie+8jOWGjeaMieivpeivreS5ieabtOaWsOWxgOmDqOeKtuaAgeOAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtaW5EaXN0YW5jZShTdHJpbmcgd29yZDEsIFN0cmluZyB3b3JkMikgewogICAgICAgIGludCBtID0ge3tibGFua18xfX07CiAgICAgICAgaW50W11bXSBmID0gbmV3IGludFttICsgMV1bbiArIDFdOwogICAgICAgIGZvciAoaW50IGogPSAxOyBqIDw9IG47ICsraikgewogICAgICAgICAgICBmWzBdW2pdID0gajsKICAgICAgICB9CiAgICAgICAgZm9yIChpbnQgaSA9IDE7IGkgPD0gbTsgKytpKSB7CiAgICAgICAgICAgIGZbaV1bMF0gPSBpOwogICAgICAgICAgICBmb3IgKGludCBqID0gMTsgaiA8PSBuOyArK2opIHsKICAgICAgICAgICAgICAgIGlmICh7e2JsYW5rXzJ9fSkgewogICAgICAgICAgICAgICAgICAgIGZbaV1bal0gPSB7e2JsYW5rXzN9fTsKICAgICAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICAgICAgZltpXVtqXSA9IE1hdGgubWluKGZbaSAtIDFdW2pdLCBNYXRoLm1pbihmW2ldW2ogLSAxXSwgZltpIC0gMV1baiAtIDFdKSkgKyAxOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzR9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoid29yZDEubGVuZ3RoKCksIG4gPSB3b3JkMi5sZW5ndGgoKSIsImJsYW5rXzIiOiJ3b3JkMS5jaGFyQXQoaSAtIDEpID09IHdvcmQyLmNoYXJBdChqIC0gMSkiLCJibGFua18zIjoiZltpIC0gMV1baiAtIDFdIiwiYmxhbmtfNCI6ImZbbV1bbl0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLnvJbovpHot53nprsiLCLlop7liKDmlLkiLCLnqbrliY3nvIAiLCLlrZfnrKbkuLIiLCLliqjmgIHop4TliJIiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 72
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-96: #136 只出现一次的数字

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    136, 96, CONVERT(FROM_BASE64('5Y+q5Ye6546w5LiA5qyh55qE5pWw5a2X') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5L2g5LiA5LiqKirpnZ7nqboqKuaVtOaVsOaVsOe7hCBgbnVtc2Ag77yM6Zmk5LqG5p+Q5Liq5YWD57Sg5Y+q5Ye6546w5LiA5qyh5Lul5aSW77yM5YW25L2Z5q+P5Liq5YWD57Sg5Z2H5Ye6546w5Lik5qyh44CC5om+5Ye66YKj5Liq5Y+q5Ye6546w5LqG5LiA5qyh55qE5YWD57Sg44CCCgrkvaDlv4Xpobvorr7orqHlubblrp7njrDnur/mgKfml7bpl7TlpI3mnYLluqbnmoTnrpfms5XmnaXop6PlhrPmraTpl67popjvvIzkuJTor6Xnrpfms5Xlj6rkvb/nlKjluLjph4/pop3lpJbnqbrpl7TjgIIqKuekuuS+iyAxIO+8mioqKirovpPlhaXvvJoqKm51bXMgPSBbMiwyLDFdKirovpPlh7rvvJoqKjEqKuekuuS+iyAyIO+8mioqKirovpPlhaXvvJoqKm51bXMgPSBbNCwxLDIsMSwyXSoq6L6T5Ye677yaKio0KirnpLrkvosgMyDvvJoqKioq6L6T5YWl77yaKipudW1zID0gWzFdKirovpPlh7rvvJoqKjEqKuaPkOekuu+8mioqLSBgMSA8PSBudW1zLmxlbmd0aCA8PSAzICogMTA0YAotIGAtMyAqIDEwNCA8PSBudW1zW2ldIDw9IDMgKiAxMDRgCi0g6Zmk5LqG5p+Q5Liq5YWD57Sg5Y+q5Ye6546w5LiA5qyh5Lul5aSW77yM5YW25L2Z5q+P5Liq5YWD57Sg5Z2H5Ye6546w5Lik5qyh44CCCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvc2luZ2xlLW51bWJlci8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvc2luZ2xlLW51bWJlci8p') USING utf8mb4),
    CONVERT(FROM_BASE64('5oqK5omA5pyJ5pWw5a2X5byC5oiW77yM5oiQ5a+55pWw5a2X5ZugIHheeD0wIOaKtea2iO+8jOacgOe7iOeVmeS4i+WPquWHuueOsOS4gOasoeeahOaVsOWtl+OAgiDmnKzpopjlm7Tnu5XjgIzlj6rlh7rnjrDkuIDmrKHnmoTmlbDlrZfjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmiavmj4/liY3nvIDnmoQgeG9yIOetieS6juivpeWJjee8gOaJgOacieWFg+e0oOWHuueOsOWlh+aVsOasoemDqOWIhueahOW8guaIluOAgg==') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5byC5oiW5oq15raI55qE5ZCr5LmJ77yM5YaN5qOA5p+leOW8guaIlnjlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGFucyA9IDA7CiAgICAgICAgZm9yIChpbnQgdiA6IG51bXMpIHsKICAgICAgICAgICAgYW5zIF49IHY7CiAgICAgICAgfQogICAgICAgIHJldHVybiBhbnM7CiAgICB9') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzaW5nbGVOdW1iZXIoaW50W10gbnVtcykgewogICAgICAgIGludCBhbnMgPSAwOwogICAgICAgIGZvciAoaW50IHYgOiBudW1zKSB7CiAgICAgICAgICAgIGFucyBePSB2OwogICAgICAgIH0KICAgICAgICByZXR1cm4gYW5zOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4) WHERE p.leetcode_number = 136
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4) WHERE p.leetcode_number = 136
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 136
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5omr5o+P5YmN57yA55qEIHhvciDnrYnkuo7or6XliY3nvIDmiYDmnInlhYPntKDlh7rnjrDlpYfmlbDmrKHpg6jliIbnmoTlvILmiJbjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNpbmdsZU51bWJlciDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('5L2/55So5L2N5byC5oiWIF4g6ICM6Z2e6YC76L6R6L+Q566X77ybMCDlkozotJ/mlbDlkIzmoLfpgILnlKjjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5L2/55So5L2N5byC5oiWIF4g6ICM6Z2e6YC76L6R6L+Q566X77ybMCDlkozotJ/mlbDlkIzmoLfpgILnlKjjgII=') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNpbmdsZU51bWJlciDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBzaW5nbGVOdW1iZXIoaW50W10gbnVtcykgewogICAgICAgIGludCBhbnMgPSAwOwogICAgICAgIGZvciAoaW50IHYgOiB7e2JsYW5rXzF9fSkgewogICAgICAgICAgICBhbnMgXj0ge3tibGFua18yfX07CiAgICAgICAgfQogICAgICAgIHJldHVybiB7e2JsYW5rXzN9fTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtcyIsImJsYW5rXzIiOiJ2IiwiYmxhbmtfMyI6ImFucyJ9') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlvILmiJbmirXmtogiLCJ45byC5oiWeCIsIuS9jei/kOeulyIsIuaVsOe7hCJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 136
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-97: #169 多数元素

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    169, 97, CONVERT(FROM_BASE64('5aSa5pWw5YWD57Sg') USING utf8mb4), 'EASY', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5aSn5bCP5Li6IGBuYCoq55qE5pWw57uEIGBudW1zYCDvvIzov5Tlm57lhbbkuK3nmoTlpJrmlbDlhYPntKDjgILlpJrmlbDlhYPntKDmmK/mjIflnKjmlbDnu4TkuK3lh7rnjrDmrKHmlbAqKuWkp+S6jioqYOKMiiBuLzIg4oyLYCDnmoTlhYPntKDjgIIKCuS9oOWPr+S7peWBh+iuvuaVsOe7hOaYr+mdnuepuueahO+8jOW5tuS4lOe7meWumueahOaVsOe7hOaAu+aYr+WtmOWcqOWkmuaVsOWFg+e0oOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFszLDIsM10K6L6T5Ye677yaMwpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMiwyLDEsMSwxLDIsMl0K6L6T5Ye677yaMgpgYGAqKuaPkOekuu+8mioqLSBgbiA9PSBudW1zLmxlbmd0aGAKLSBgMSA8PSBuIDw9IDUgKiAxMDRgCi0gYC0xMDkgPD0gbnVtc1tpXSA8PSAxMDlgCi0g6L6T5YWl5L+d6K+B5pWw57uE5Lit5LiA5a6a5pyJ5LiA5Liq5aSa5pWw5YWD57Sg44CCKirov5vpmLbvvJoqKuWwneivleiuvuiuoeaXtumXtOWkjeadguW6puS4uiBPKG4p44CB56m66Ze05aSN5p2C5bqm5Li6IE8oMSkg55qE566X5rOV6Kej5Yaz5q2k6Zeu6aKY44CCCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvbWFqb3JpdHktZWxlbWVudC8pIMK3IFtMZWV0Q29kZV0oaHR0cHM6Ly9sZWV0Y29kZS5jb20vcHJvYmxlbXMvbWFqb3JpdHktZWxlbWVudC8p') USING utf8mb4),
    CONVERT(FROM_BASE64('Qm95ZXItTW9vcmUg5oqV56Wo77ya57u05oqk5YCZ6YCJIGNhbmRpZGF0ZSDlkoznpajmlbAgY291bnTvvJvnm7jlkIzliqDnpajvvIzkuI3lkIzmirXmtojvvIznpajmlbDlvZLpm7bml7bmjaLlgJnpgInjgIIg5pys6aKY5Zu057uV44CM5aSa5pWw5YWD57Sg44CN6JC95a6e6L+Z5LiA5qih5Z6L77ya5aSE55CG5Lu75oSP5YmN57yA5ZCO77yM5oiQ5a+55oq15raI5LiN5ZCM5YWD57Sg5LiN5Lya5raI6Zmk55yf5q2j6LaF6L+H5LiA5Y2K55qE5aSa5pWw5YWD57Sg44CC') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riFQm95ZXItTW9vcmXnmoTlkKvkuYnvvIzlho3mo4Dmn6XnpajmlbDmirXmtojlpoLkvZXkv53mjIHjgII=') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGNudCA9IDAsIG0gPSAwOwogICAgICAgIGZvciAoaW50IHggOiBudW1zKSB7CiAgICAgICAgICAgIGlmIChjbnQgPT0gMCkgewogICAgICAgICAgICAgICAgbSA9IHg7CiAgICAgICAgICAgICAgICBjbnQgPSAxOwogICAgICAgICAgICB9IGVsc2Ugew==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYWpvcml0eUVsZW1lbnQoaW50W10gbnVtcykgewogICAgICAgIGludCBjbnQgPSAwLCBtID0gMDsKICAgICAgICBmb3IgKGludCB4IDogbnVtcykgewogICAgICAgICAgICBpZiAoY250ID09IDApIHsKICAgICAgICAgICAgICAgIG0gPSB4OwogICAgICAgICAgICAgICAgY250ID0gMTsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGNudCArPSBtID09IHggPyAxIDogLTE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIG07CiAgICB9Cn0=') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5ZOI5biM6KGo') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5YiG5rK7') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('6K6h5pWw') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('6K6h5pWw') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5aSE55CG5Lu75oSP5YmN57yA5ZCO77yM5oiQ5a+55oq15raI5LiN5ZCM5YWD57Sg5LiN5Lya5raI6Zmk55yf5q2j6LaF6L+H5LiA5Y2K55qE5aSa5pWw5YWD57Sg44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG1ham9yaXR5RWxlbWVudCDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('Y291bnQg5Li6IDAg5pe26KaB5YWI6K6+572u5b2T5YmN5YCZ6YCJ5YaN5Yqg56Wo77yb6aKY55uu5L+d6K+B5aSa5pWw5YWD57Sg5a2Y5Zyo44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('Y291bnQg5Li6IDAg5pe26KaB5YWI6K6+572u5b2T5YmN5YCZ6YCJ5YaN5Yqg56Wo77yb6aKY55uu5L+d6K+B5aSa5pWw5YWD57Sg5a2Y5Zyo44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG1ham9yaXR5RWxlbWVudCDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBtYWpvcml0eUVsZW1lbnQoaW50W10gbnVtcykgewogICAgICAgIGludCBjbnQgPSAwLCBtID0gMDsKICAgICAgICBmb3IgKGludCB4IDoge3tibGFua18xfX0pIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICBtID0ge3tibGFua18zfX07CiAgICAgICAgICAgICAgICBjbnQgPSAxOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgY250ICs9IG0gPT0geCA/IDEgOiAtMTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgICByZXR1cm4gbTsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtcyIsImJsYW5rXzIiOiJjbnQgPT0gMCIsImJsYW5rXzMiOiJ4In0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyJCb3llci1Nb29yZSIsIuelqOaVsOaKtea2iCIsIuWkmuaVsOWAmemAiSIsIuaVsOe7hCIsIuWTiOW4jOihqCIsIuWIhuayuyJd') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 169
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-98: #75 颜色分类

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    75, 98, CONVERT(FROM_BASE64('6aKc6Imy5YiG57G7') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5YyF5ZCr57qi6Imy44CB55m96Imy5ZKM6JOd6Imy44CB5YWxIGBuYCoq5Liq5YWD57Sg55qE5pWw57uEIGBudW1zYCDvvIwqKlvljp/lnLBdKGh0dHBzOi8vYmFpa2UuYmFpZHUuY29tL2l0ZW0vJUU1JThFJTlGJUU1JTlDJUIwJUU3JUFFJTk3JUU2JUIzJTk1KSoq5a+55a6D5Lus6L+b6KGM5o6S5bqP77yM5L2/5b6X55u45ZCM6aKc6Imy55qE5YWD57Sg55u46YK777yM5bm25oyJ54Wn57qi6Imy44CB55m96Imy44CB6JOd6Imy6aG65bqP5o6S5YiX44CCCgrmiJHku6zkvb/nlKjmlbTmlbAgYDBg44CBIGAxYCDlkowgYDJgIOWIhuWIq+ihqOekuue6ouiJsuOAgeeZveiJsuWSjOiTneiJsuOAggoK5b+F6aG75Zyo5LiN5L2/55So5bqT5YaF572u55qEIHNvcnQg5Ye95pWw55qE5oOF5Ya15LiL6Kej5Yaz6L+Z5Liq6Zeu6aKY44CCKirnpLrkvosgMe+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzIsMCwyLDEsMSwwXQrovpPlh7rvvJpbMCwwLDEsMSwyLDJdCmBgYCoq56S65L6LIDLvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsyLDAsMV0K6L6T5Ye677yaWzAsMSwyXQpgYGAqKuaPkOekuu+8mioqLSBgbiA9PSBudW1zLmxlbmd0aGAKLSBgMSA8PSBuIDw9IDMwMGAKLSBgbnVtc1tpXWAg5Li6IGAwYOOAgWAxYCDmiJYgYDJgKirov5vpmLbvvJoqKi0g5L2g6IO95oOz5Ye65LiA5Liq5LuF5L2/55So5bi45pWw56m66Ze055qE5LiA6Laf5omr5o+P566X5rOV5ZCX77yfCgotLS0KCuWOn+mimO+8mltMZWV0Q29kZSDkuK3mlofnq5ldKGh0dHBzOi8vbGVldGNvZGUuY24vcHJvYmxlbXMvc29ydC1jb2xvcnMvKSDCtyBbTGVldENvZGVdKGh0dHBzOi8vbGVldGNvZGUuY29tL3Byb2JsZW1zL3NvcnQtY29sb3JzLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('RHV0Y2ggTmF0aW9uYWwgRmxhZyDkuInmjIfpkojvvJpsZWZ0IOWJjeWFqOaYryAw77yMcmlnaHQg5ZCO5YWo5pivIDLvvIxpIOaJq+aPj+acquefpeWMuuOAgiDmnKzpopjlm7Tnu5XjgIzpopzoibLliIbnsbvjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrmr4/ova7lvIDlp4sgWzAsbGVmdCkg5Li6IDDjgIFbbGVmdCxpKSDkuLogMeOAgShyaWdodCxuKSDkuLogMu+8jFtpLHJpZ2h0XSDmnKrliIbnsbvjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LiJ6Lev5YiS5YiG55qE5ZCr5LmJ77yM5YaN5qOA5p+l5pyq55+l5Yy65aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGkgPSAtMSwgaiA9IG51bXMubGVuZ3RoLCBrID0gMDsKICAgICAgICB3aGlsZSAoayA8IGopIHsKICAgICAgICAgICAgaWYgKG51bXNba10gPT0gMCkgewogICAgICAgICAgICAgICAgc3dhcChudW1zLCArK2ksIGsrKyk7CiAgICAgICAgICAgIH0gZWxzZSBpZiAobnVtc1trXSA9PSAyKSB7CiAgICAgICAgICAgICAgICBzd2FwKG51bXMsIC0taiwgayk7') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgc29ydENvbG9ycyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IGkgPSAtMSwgaiA9IG51bXMubGVuZ3RoLCBrID0gMDsKICAgICAgICB3aGlsZSAoayA8IGopIHsKICAgICAgICAgICAgaWYgKG51bXNba10gPT0gMCkgewogICAgICAgICAgICAgICAgc3dhcChudW1zLCArK2ksIGsrKyk7CiAgICAgICAgICAgIH0gZWxzZSBpZiAobnVtc1trXSA9PSAyKSB7CiAgICAgICAgICAgICAgICBzd2FwKG51bXMsIC0taiwgayk7CiAgICAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICAgICArK2s7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9CgogICAgcHJpdmF0ZSB2b2lkIHN3YXAoaW50W10gbnVtcywgaW50IGksIGludCBqKSB7CiAgICAgICAgaW50IHQgPSBudW1zW2ldOwogICAgICAgIG51bXNbaV0gPSBudW1zW2pdOwogICAgICAgIG51bXNbal0gPSB0OwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4) WHERE p.leetcode_number = 75
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 75
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 75
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5o6S5bqP') USING utf8mb4) WHERE p.leetcode_number = 75
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u5byA5aeLIFswLGxlZnQpIOS4uiAw44CBW2xlZnQsaSkg5Li6IDHjgIEocmlnaHQsbikg5Li6IDLvvIxbaSxyaWdodF0g5pyq5YiG57G744CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIHNvcnRDb2xvcnMg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LiOIHJpZ2h0IOS6pOaNouWQjiBpIOS4jeiDveeri+WNs+WJjei/m++8jOWboOS4uuaNouadpeeahOWAvOWwmuacquajgOafpe+8m+S4jiBsZWZ0IOS6pOaNouWQjuWPr+WJjei/m+OAgg==') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiOIHJpZ2h0IOS6pOaNouWQjiBpIOS4jeiDveeri+WNs+WJjei/m++8jOWboOS4uuaNouadpeeahOWAvOWwmuacquajgOafpe+8m+S4jiBsZWZ0IOS6pOaNouWQjuWPr+WJjei/m+OAgg==') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIHNvcnRDb2xvcnMg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgc29ydENvbG9ycyhpbnRbXSBudW1zKSB7CiAgICAgICAgaW50IGkgPSAtMSwgaiA9IG51bXMubGVuZ3RoLCBrID0gMDsKICAgICAgICB3aGlsZSAoe3tibGFua18xfX0pIHsKICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICBzd2FwKG51bXMsICsraSwgaysrKTsKICAgICAgICAgICAgfSBlbHNlIGlmICh7e2JsYW5rXzN9fSkgewogICAgICAgICAgICAgICAgc3dhcChudW1zLCAtLWosIGspOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgKytrOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQoKICAgIHByaXZhdGUgdm9pZCBzd2FwKGludFtdIG51bXMsIGludCBpLCBpbnQgaikgewogICAgICAgIGludCB0ID0ge3tibGFua180fX07CiAgICAgICAgbnVtc1tpXSA9IHt7YmxhbmtfNX19OwogICAgICAgIG51bXNbal0gPSB0OwogICAgfQp9') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoiayA8IGoiLCJibGFua18yIjoibnVtc1trXSA9PSAwIiwiYmxhbmtfMyI6Im51bXNba10gPT0gMiIsImJsYW5rXzQiOiJudW1zW2ldIiwiYmxhbmtfNSI6Im51bXNbal0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuInot6/liJLliIYiLCLmnKrnn6XljLoiLCLkuqTmjaLlkI7mjIfpkogiLCLmlbDnu4QiLCLlj4zmjIfpkogiLCLmjpLluo8iXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 75
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-99: #31 下一个排列

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    31, 99, CONVERT(FROM_BASE64('5LiL5LiA5Liq5o6S5YiX') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('5pW05pWw5pWw57uE55qE5LiA5LiqKirmjpLliJcqKuWwseaYr+WwhuWFtuaJgOacieaIkOWRmOS7peW6j+WIl+aIlue6v+aAp+mhuuW6j+aOkuWIl+OAggoKLSDkvovlpoLvvIxgYXJyID0gWzEsMiwzXWAg77yM5Lul5LiL6L+Z5Lqb6YO95Y+v5Lul6KeG5L2cIGBhcnJgIOeahOaOkuWIl++8mmBbMSwyLDNdYOOAgWBbMSwzLDJdYOOAgWBbMywxLDJdYOOAgWBbMiwzLDFdYCDjgIIKCuaVtOaVsOaVsOe7hOeahCoq5LiL5LiA5Liq5o6S5YiXKirmmK/mjIflhbbmlbTmlbDnmoTkuIvkuIDkuKrlrZflhbjluo/mm7TlpKfnmoTmjpLliJfjgILmm7TmraPlvI/lnLDvvIzlpoLmnpzmlbDnu4TnmoTmiYDmnInmjpLliJfmoLnmja7lhbblrZflhbjpobrluo/ku47lsI/liLDlpKfmjpLliJflnKjkuIDkuKrlrrnlmajkuK3vvIzpgqPkuYjmlbDnu4TnmoQqKuS4i+S4gOS4quaOkuWIlyoq5bCx5piv5Zyo6L+Z5Liq5pyJ5bqP5a655Zmo5Lit5o6S5Zyo5a6D5ZCO6Z2i55qE6YKj5Liq5o6S5YiX44CC5aaC5p6c5LiN5a2Y5Zyo5LiL5LiA5Liq5pu05aSn55qE5o6S5YiX77yM6YKj5LmI6L+Z5Liq5pWw57uE5b+F6aG76YeN5o6S5Li65a2X5YW45bqP5pyA5bCP55qE5o6S5YiX77yI5Y2z77yM5YW25YWD57Sg5oyJ5Y2H5bqP5o6S5YiX77yJ44CCCgotIOS+i+Wmgu+8jGBhcnIgPSBbMSwyLDNdYCDnmoTkuIvkuIDkuKrmjpLliJfmmK8gYFsxLDMsMl1gIOOAggotIOexu+S8vOWcsO+8jGBhcnIgPSBbMiwzLDFdYCDnmoTkuIvkuIDkuKrmjpLliJfmmK8gYFszLDEsMl1gIOOAggotIOiAjCBgYXJyID0gWzMsMiwxXWAg55qE5LiL5LiA5Liq5o6S5YiX5pivIGBbMSwyLDNdYCDvvIzlm6DkuLogYFszLDIsMV1gIOS4jeWtmOWcqOS4gOS4quWtl+WFuOW6j+abtOWkp+eahOaOkuWIl+OAggoK57uZ5L2g5LiA5Liq5pW05pWw5pWw57uEIGBudW1zYCDvvIzmib7lh7ogYG51bXNgIOeahOS4i+S4gOS4quaOkuWIl+OAggoK5b+F6aG7Kipb5Y6f5ZywXShodHRwczovL2JhaWtlLmJhaWR1LmNvbS9pdGVtLyVFNSU4RSU5RiVFNSU5QyVCMCVFNyVBRSU5NyVFNiVCMyU5NSkqKuS/ruaUue+8jOWPquWFgeiuuOS9v+eUqOmineWkluW4uOaVsOepuumXtOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDIsM10K6L6T5Ye677yaWzEsMywyXQpgYGAqKuekuuS+iyAy77yaKipgYGB0ZXh0Cui+k+WFpe+8mm51bXMgPSBbMywyLDFdCui+k+WHuu+8mlsxLDIsM10KYGBgKirnpLrkvosgM++8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzEsMSw1XQrovpPlh7rvvJpbMSw1LDFdCmBgYCoq5o+Q56S677yaKiotIGAxIDw9IG51bXMubGVuZ3RoIDw9IDEwMGAKLSBgMCA8PSBudW1zW2ldIDw9IDEwMGAKCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9uZXh0LXBlcm11dGF0aW9uLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9uZXh0LXBlcm11dGF0aW9uLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5LuO5Y+z5om+56ys5LiA5Liq5LiL6ZmN5L2N572uIGnvvIzlho3ku47lj7Pmib7pppbkuKrlpKfkuo4gbnVtc1tpXSDnmoQgaiDkuqTmjaLvvIzmnIDlkI7lj43ovawgaSsxIOWQjue8gOOAgiDmnKzpopjlm7Tnu5XjgIzkuIvkuIDkuKrmjpLliJfjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrljp/lkI7nvIDmmK/pnZ7pgJLlop7nmoTvvJvkuqTmjaLmnIDlsI/lj6/lop7lpKfnmoTmlbDlubbmiorlkI7nvIDlj5jkuLrmnIDlsI/ljYfluo/vvIzlvpfliLDntKfpgrvnmoTmm7TlpKfmjpLliJfjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5LiL6ZmN5ouQ54K555qE5ZCr5LmJ77yM5YaN5qOA5p+l5Y+z5L6n5pyA5bCP5aSn5YC85aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('fQogICAgICAgIGlmIChpID49IDApIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IG4gLSAxOyBqID4gaTsgLS1qKSB7CiAgICAgICAgICAgICAgICBpZiAobnVtc1tqXSA+IG51bXNbaV0pIHsKICAgICAgICAgICAgICAgICAgICBzd2FwKG51bXMsIGksIGopOwogICAgICAgICAgICAgICAgICAgIGJyZWFrOw==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgbmV4dFBlcm11dGF0aW9uKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludCBpID0gbiAtIDI7CiAgICAgICAgZm9yICg7IGkgPj0gMDsgLS1pKSB7CiAgICAgICAgICAgIGlmIChudW1zW2ldIDwgbnVtc1tpICsgMV0pIHsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIGlmIChpID49IDApIHsKICAgICAgICAgICAgZm9yIChpbnQgaiA9IG4gLSAxOyBqID4gaTsgLS1qKSB7CiAgICAgICAgICAgICAgICBpZiAobnVtc1tqXSA+IG51bXNbaV0pIHsKICAgICAgICAgICAgICAgICAgICBzd2FwKG51bXMsIGksIGopOwogICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgfQoKICAgICAgICBmb3IgKGludCBqID0gaSArIDEsIGsgPSBuIC0gMTsgaiA8IGs7ICsraiwgLS1rKSB7CiAgICAgICAgICAgIHN3YXAobnVtcywgaiwgayk7CiAgICAgICAgfQogICAgfQoKICAgIHByaXZhdGUgdm9pZCBzd2FwKGludFtdIG51bXMsIGludCBpLCBpbnQgaikgewogICAgICAgIGludCB0ID0gbnVtc1tqXTsKICAgICAgICBudW1zW2pdID0gbnVtc1tpXTsKICAgICAgICBudW1zW2ldID0gdDsKICAgIH0KfQ==') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4) WHERE p.leetcode_number = 31
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 31
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 31
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5Y6f5ZCO57yA5piv6Z2e6YCS5aKe55qE77yb5Lqk5o2i5pyA5bCP5Y+v5aKe5aSn55qE5pWw5bm25oqK5ZCO57yA5Y+Y5Li65pyA5bCP5Y2H5bqP77yM5b6X5Yiw57Sn6YK755qE5pu05aSn5o6S5YiX44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIG5leHRQZXJtdXRhdGlvbiDml7bmnIDpnIDopoHmo4Dmn6Xlk6rkuKrovrnnlYzmiJbmm7TmlrDpobrluo/vvJ8=') USING utf8mb4), CONVERT(FROM_BASE64('6Iul5om+5LiN5Yiw5LiL6ZmN5L2N572u6K+05piO5bey5piv5pyA5aSn5o6S5YiX77yM55u05o6l5Y+N6L2s5YWo6YOo77yb5q+U6L6D5b+F6aG75Lil5qC85aSn5LqO44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5pe26Ze0IE8obinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6Iul5om+5LiN5Yiw5LiL6ZmN5L2N572u6K+05piO5bey5piv5pyA5aSn5o6S5YiX77yM55u05o6l5Y+N6L2s5YWo6YOo77yb5q+U6L6D5b+F6aG75Lil5qC85aSn5LqO44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIG5leHRQZXJtdXRhdGlvbiDnmoTov5Tlm57or63kuYnvvIzlho3mjInor6Xor63kuYnmm7TmlrDlsYDpg6jnirbmgIHjgII=') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIHZvaWQgbmV4dFBlcm11dGF0aW9uKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbiA9IG51bXMubGVuZ3RoOwogICAgICAgIGludCBpID0gbiAtIDI7CiAgICAgICAgZm9yICg7IGkgPj0gMDsgLS1pKSB7CiAgICAgICAgICAgIGlmICh7e2JsYW5rXzF9fSkgewogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgIGZvciAoaW50IGogPSBuIC0gMTsgaiA+IGk7IC0taikgewogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICAgICAgc3dhcChudW1zLCBpLCBqKTsKICAgICAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KCiAgICAgICAgZm9yIChpbnQgaiA9IGkgKyAxLCBrID0gbiAtIDE7IGogPCBrOyArK2osIC0taykgewogICAgICAgICAgICBzd2FwKG51bXMsIGosIGspOwogICAgICAgIH0KICAgIH0KCiAgICBwcml2YXRlIHZvaWQgc3dhcChpbnRbXSBudW1zLCBpbnQgaSwgaW50IGopIHsKICAgICAgICBpbnQgdCA9IHt7YmxhbmtfNH19OwogICAgICAgIG51bXNbal0gPSB7e2JsYW5rXzV9fTsKICAgICAgICBudW1zW2ldID0gdDsKICAgIH0KfQ==') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibnVtc1tpXSA8IG51bXNbaSArIDFdIiwiYmxhbmtfMiI6ImkgPj0gMCIsImJsYW5rXzMiOiJudW1zW2pdID4gbnVtc1tpXSIsImJsYW5rXzQiOiJudW1zW2pdIiwiYmxhbmtfNSI6Im51bXNbaV0ifQ==') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLkuIvpmY3mi5DngrkiLCLlj7PkvqfmnIDlsI/lpKflgLwiLCLlj43ovazlkI7nvIAiLCLmlbDnu4QiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 31
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

-- Hot100-100: #287 寻找重复数

INSERT INTO problem (
    leetcode_number, hot100_order, title, difficulty, description_markdown,
    core_idea, hint, key_code, full_code, status, created_at, updated_at
) VALUES (
    287, 100, CONVERT(FROM_BASE64('5a+75om+6YeN5aSN5pWw') USING utf8mb4), 'MEDIUM', CONVERT(FROM_BASE64('57uZ5a6a5LiA5Liq5YyF5ZCrIGBuICsgMWAg5Liq5pW05pWw55qE5pWw57uEIGBudW1zYCDvvIzlhbbmlbDlrZfpg73lnKggYFsxLCBuXWAg6IyD5Zu05YaF77yI5YyF5ousIGAxYCDlkowgYG5g77yJ77yM5Y+v55+l6Iez5bCR5a2Y5Zyo5LiA5Liq6YeN5aSN55qE5pW05pWw44CCCgrlgYforr4gYG51bXNgIOWPquaciSoq5LiA5Liq6YeN5aSN55qE5pW05pWwKirvvIzov5Tlm54qKui/meS4qumHjeWkjeeahOaVsCoq44CCCgrkvaDorr7orqHnmoTop6PlhrPmlrnmoYjlv4XpobsqKuS4jeS/ruaUuSoq5pWw57uEIGBudW1zYCDkuJTlj6rnlKjluLjph4/nuqcgYE8oMSlgIOeahOmineWkluepuumXtOOAgioq56S65L6LIDHvvJoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFsxLDMsNCwyLDJdCui+k+WHuu+8mjIKYGBgKirnpLrkvosgMu+8mioqYGBgdGV4dArovpPlhaXvvJpudW1zID0gWzMsMSwzLDQsMl0K6L6T5Ye677yaMwpgYGAqKuekuuS+iyAzIDoqKmBgYHRleHQK6L6T5YWl77yabnVtcyA9IFszLDMsMywzLDNdCui+k+WHuu+8mjMKYGBgKirmj5DnpLrvvJoqKi0gYDEgPD0gbiA8PSAxMDVgCi0gYG51bXMubGVuZ3RoID09IG4gKyAxYAotIGAxIDw9IG51bXNbaV0gPD0gbmAKLSBgbnVtc2Ag5LitKirlj6rmnInkuIDkuKrmlbTmlbAqKuWHuueOsCoq5Lik5qyh5oiW5aSa5qyhKirvvIzlhbbkvZnmlbTmlbDlnYflj6rlh7rnjrAqKuS4gOasoSoqKirov5vpmLbvvJoqKi0g5aaC5L2V6K+B5piOIGBudW1zYCDkuK3oh7PlsJHlrZjlnKjkuIDkuKrph43lpI3nmoTmlbDlrZc/Ci0g5L2g5Y+v5Lul6K6+6K6h5LiA5Liq57q/5oCn57qn5pe26Ze05aSN5p2C5bqmIGBPKG4pYCDnmoTop6PlhrPmlrnmoYjlkJfvvJ8KCi0tLQoK5Y6f6aKY77yaW0xlZXRDb2RlIOS4reaWh+ermV0oaHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9maW5kLXRoZS1kdXBsaWNhdGUtbnVtYmVyLykgwrcgW0xlZXRDb2RlXShodHRwczovL2xlZXRjb2RlLmNvbS9wcm9ibGVtcy9maW5kLXRoZS1kdXBsaWNhdGUtbnVtYmVyLyk=') USING utf8mb4),
    CONVERT(FROM_BASE64('5Zyo5YC85Z+fIFsxLG5dIOS4iuS6jOWIhiBtaWTvvIznu5/orqHmlbDnu4TkuK0gPD1taWQg55qE5YWD57Sg5pWw77yb6Iul6K6h5pWw5aSn5LqOIG1pZO+8jOmHjeWkjeWAvOiQveWcqOW3puWNiu+8jOWQpuWImeWcqOWPs+WNiuOAgiDmnKzpopjlm7Tnu5XjgIzlr7vmib7ph43lpI3mlbDjgI3okL3lrp7ov5nkuIDmqKHlnovvvJrph43lpI3lgLzlp4vnu4jkvY3kuo7lvZPliY3lgLzln5/ljLrpl7TvvJvpuL3lt6Lljp/nkIbkv53or4HorqHmlbDotoXlh7rlj6/lrrnnurPkuI3lkIzlgLzmlbDnmoTkuIDkvqflkKvph43lpI3lgLzjgII=') USING utf8mb4), CONVERT(FROM_BASE64('5YWI5YaZ5riF5YC85Z+f5LqM5YiG55qE5ZCr5LmJ77yM5YaN5qOA5p+l6K6h5pWw5aaC5L2V5L+d5oyB44CC') USING utf8mb4), CONVERT(FROM_BASE64('aW50IGNudCA9IDA7CiAgICAgICAgICAgIGZvciAoaW50IHYgOiBudW1zKSB7CiAgICAgICAgICAgICAgICBpZiAodiA8PSBtaWQpIHsKICAgICAgICAgICAgICAgICAgICArK2NudDsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQ==') USING utf8mb4), CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaW5kRHVwbGljYXRlKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbCA9IDAsIHIgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgd2hpbGUgKGwgPCByKSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgICAgIGludCBjbnQgPSAwOwogICAgICAgICAgICBmb3IgKGludCB2IDogbnVtcykgewogICAgICAgICAgICAgICAgaWYgKHYgPD0gbWlkKSB7CiAgICAgICAgICAgICAgICAgICAgKytjbnQ7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKGNudCA+IG1pZCkgewogICAgICAgICAgICAgICAgciA9IG1pZDsKICAgICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgIGwgPSBtaWQgKyAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAgIHJldHVybiBsOwogICAgfQp9') USING utf8mb4), 1, NOW(), NOW()
) ON DUPLICATE KEY UPDATE
    hot100_order = VALUES(hot100_order), title = VALUES(title), difficulty = VALUES(difficulty),
    description_markdown = VALUES(description_markdown), core_idea = VALUES(core_idea), hint = VALUES(hint),
    key_code = VALUES(key_code), full_code = VALUES(full_code), status = 1, updated_at = NOW();

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5oqA5ben') USING utf8mb4) WHERE p.leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5L2N6L+Q566X') USING utf8mb4) WHERE p.leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5pWw57uE') USING utf8mb4) WHERE p.leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5Y+M5oyH6ZKI') USING utf8mb4) WHERE p.leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO tag (name, created_at) VALUES (CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4), NOW()) ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problem_tag (problem_id, tag_id)
SELECT p.id, t.id FROM problem p JOIN tag t ON t.name = CONVERT(FROM_BASE64('5LqM5YiG5p+l5om+') USING utf8mb4) WHERE p.leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z6aKY6YeH55So5LuA5LmI5qC45b+D54q25oCB5oiW5LiN5Y+Y6YeP77yM5Li65LuA5LmI6IO95b6X5Yiw5q2j56Gu562U5qGI77yf') USING utf8mb4), CONVERT(FROM_BASE64('6YeN5aSN5YC85aeL57uI5L2N5LqO5b2T5YmN5YC85Z+f5Yy66Ze077yb6bi95bei5Y6f55CG5L+d6K+B6K6h5pWw6LaF5Ye65Y+v5a6557qz5LiN5ZCM5YC85pWw55qE5LiA5L6n5ZCr6YeN5aSN5YC844CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5omL5YaZIGZpbmREdXBsaWNhdGUg5pe25pyA6ZyA6KaB5qOA5p+l5ZOq5Liq6L6555WM5oiW5pu05paw6aG65bqP77yf') USING utf8mb4), CONVERT(FROM_BASE64('5LqM5YiG55qE5piv5YC85Z+f5LiN5piv5pWw57uE5LiL5qCH77yb5bem6L6555WM5bqU5LuOIDEg5byA5aeL77yM6K6h5pWw5p2h5Lu25pivIDw9bWlk44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO recall_question (problem_id, question_text, answer_text, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('6L+Z5aWX6Kej5rOV55qE5Li76KaB5pe26Ze05ZKM6aKd5aSW56m66Ze05aSN5p2C5bqm5piv5LuA5LmI77yf') USING utf8mb4), CONVERT(FROM_BASE64('5q+P6L2u5omr5o+P5pWw57uE77yM5pe26Ze0IE8obiBsb2cgbinvvIznqbrpl7QgTygxKeOAgg==') USING utf8mb4), 3, NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LqM5YiG55qE5piv5YC85Z+f5LiN5piv5pWw57uE5LiL5qCH77yb5bem6L6555WM5bqU5LuOIDEg5byA5aeL77yM6K6h5pWw5p2h5Lu25pivIDw9bWlk44CC') USING utf8mb4), 1, NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO problem_mistake (problem_id, content, sort_order, created_at, updated_at)
SELECT id, CONVERT(FROM_BASE64('5LiN6KaB5Y+q6IOM5Luj56CB77ya5YWI56Gu6K6kIGZpbmREdXBsaWNhdGUg55qE6L+U5Zue6K+t5LmJ77yM5YaN5oyJ6K+l6K+t5LmJ5pu05paw5bGA6YOo54q25oCB44CC') USING utf8mb4), 2, NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE content = VALUES(content), updated_at = NOW();

INSERT INTO dictation_template (
    problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at
)
SELECT id, 'JAVA', CONVERT(FROM_BASE64('Y2xhc3MgU29sdXRpb24gewogICAgcHVibGljIGludCBmaW5kRHVwbGljYXRlKGludFtdIG51bXMpIHsKICAgICAgICBpbnQgbCA9IDAsIHIgPSBudW1zLmxlbmd0aCAtIDE7CiAgICAgICAgd2hpbGUgKHt7YmxhbmtfMX19KSB7CiAgICAgICAgICAgIGludCBtaWQgPSAobCArIHIpID4+IDE7CiAgICAgICAgICAgIGludCBjbnQgPSAwOwogICAgICAgICAgICBmb3IgKGludCB2IDogbnVtcykgewogICAgICAgICAgICAgICAgaWYgKHt7YmxhbmtfMn19KSB7CiAgICAgICAgICAgICAgICAgICAgKytjbnQ7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICAgICAgaWYgKHt7YmxhbmtfM319KSB7CiAgICAgICAgICAgICAgICByID0gbWlkOwogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAgbCA9IG1pZCArIDE7CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgcmV0dXJuIGw7CiAgICB9Cn0=') USING utf8mb4), CONVERT(FROM_BASE64('eyJibGFua18xIjoibCA8IHIiLCJibGFua18yIjoidiA8PSBtaWQiLCJibGFua18zIjoiY250ID4gbWlkIn0=') USING utf8mb4),
       CONVERT(FROM_BASE64('WyLlgLzln5/kuozliIYiLCLorqHmlbAiLCLpuL3lt6Lljp/nkIYiLCLkvY3ov5DnrpciLCLmlbDnu4QiLCLlj4zmjIfpkogiXQ==') USING utf8mb4), NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json),
    keyword_json = VALUES(keyword_json), updated_at = NOW();

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem WHERE leetcode_number = 287
ON DUPLICATE KEY UPDATE problem_id = VALUES(problem_id);
