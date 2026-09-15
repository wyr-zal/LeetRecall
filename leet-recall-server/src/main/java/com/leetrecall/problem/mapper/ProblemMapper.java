package com.leetrecall.problem.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.vo.ProblemLastActivityVO;
import com.leetrecall.problem.vo.ProblemSearchItemVO;
import com.leetrecall.review.vo.ReviewQueueRow;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

public interface ProblemMapper extends BaseMapper<Problem> {

    @Select("""
            SELECT p.id AS problem_id, p.leetcode_number, p.title, p.difficulty,
                   COALESCE(pp.mastery_level, 'NEW') AS mastery_level,
                   CASE WHEN EXISTS (
                       SELECT 1 FROM review_record rr
                       WHERE rr.problem_id = p.id
                         AND rr.reviewed_at >= #{dayStart}
                         AND rr.reviewed_at < #{dayEnd}
                   ) THEN TRUE ELSE FALSE END AS completed,
                   (
                       SELECT rr2.review_result FROM review_record rr2
                       WHERE rr2.problem_id = p.id
                         AND rr2.reviewed_at >= #{dayStart}
                         AND rr2.reviewed_at < #{dayEnd}
                       ORDER BY rr2.reviewed_at DESC LIMIT 1
                   ) AS today_result
            FROM problem p
            LEFT JOIN problem_progress pp ON pp.problem_id = p.id
            WHERE p.status = 1
              AND (
                  pp.next_review_at IS NULL
                  OR pp.next_review_at < #{dayEnd}
                  OR EXISTS (
                      SELECT 1 FROM review_record today_rr
                      WHERE today_rr.problem_id = p.id
                        AND today_rr.reviewed_at >= #{dayStart}
                        AND today_rr.reviewed_at < #{dayEnd}
                  )
              )
            ORDER BY completed ASC,
                     COALESCE(p.hot100_order, 2147483647) ASC,
                     p.leetcode_number ASC
            """)
    List<ReviewQueueRow> selectTodayReviewRows(
            @Param("dayStart") LocalDateTime dayStart,
            @Param("dayEnd") LocalDateTime dayEnd
    );

    /**
     * 题目的最近一次"复习痕迹"时间：回忆答案、笔记、默写提交、代码批注四者取最晚。
     * 回忆答案必须非空白才算，只点了会/不会但没写字的提交不计入。
     * 四个来源全空时返回 NULL，由调用方按"未复习"处理。
     *
     * <p>同时返回"内容更新痕迹"时间 content_updated_at：只有存在外部导入记录的题目才取
     * problem.updated_at，其余返回 NULL。这样可以排除 V5～V8 批量种子迁移写入的 updated_at
     * （那批题目全是同一秒，并非用户动作），避免整库题目都被误判成已更新。</p>
     */
    @Select("""
            <script>
            SELECT p.id AS problem_id,
                   NULLIF(GREATEST(
                       COALESCE((
                           SELECT MAX(rr.reviewed_at)
                           FROM review_record rr,
                                JSON_TABLE(COALESCE(rr.user_recall_json, JSON_ARRAY()), '$[*]'
                                    COLUMNS (answer TEXT PATH '$.answer')) recall
                           WHERE rr.problem_id = p.id
                             AND TRIM(COALESCE(recall.answer, '')) != ''
                       ), CAST('1000-01-01' AS DATETIME)),
                       COALESCE((
                           SELECT pn.updated_at FROM problem_note pn WHERE pn.problem_id = p.id
                       ), CAST('1000-01-01' AS DATETIME)),
                       COALESCE((
                           SELECT MAX(dr.created_at) FROM dictation_record dr WHERE dr.problem_id = p.id
                       ), CAST('1000-01-01' AS DATETIME)),
                       COALESCE((
                           SELECT MAX(pca.updated_at)
                           FROM problem_code_annotation pca WHERE pca.problem_id = p.id
                       ), CAST('1000-01-01' AS DATETIME))
                   ), CAST('1000-01-01' AS DATETIME)) AS last_activity_at,
                   CASE WHEN EXISTS (
                       SELECT 1 FROM external_import_draft eid
                       WHERE eid.published_problem_id = p.id
                         AND eid.status = 'IMPORTED'
                   ) THEN p.updated_at ELSE NULL END AS content_updated_at
            FROM problem p
            WHERE p.id IN
            <foreach collection='problemIds' item='problemId' open='(' separator=',' close=')'>
                #{problemId}
            </foreach>
            </script>
            """)
    List<ProblemLastActivityVO> selectLastActivityByProblemIds(
            @Param("problemIds") List<Long> problemIds
    );

    @Select("""
            SELECT id AS problem_id, leetcode_number, title
            FROM problem
            WHERE status = 1
              AND (title LIKE CONCAT('%', #{keyword}, '%')
                   OR CAST(leetcode_number AS CHAR) LIKE CONCAT('%', #{keyword}, '%'))
            ORDER BY COALESCE(hot100_order, 2147483647), leetcode_number
            LIMIT 8
            """)
    List<ProblemSearchItemVO> search(@Param("keyword") String keyword);
}
