package com.leetrecall.problem.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.problem.entity.ProblemTag;
import com.leetrecall.problem.vo.ProblemTagNameVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ProblemTagMapper extends BaseMapper<ProblemTag> {

    @Select("""
            SELECT t.name
            FROM tag t
            JOIN problem_tag pt ON pt.tag_id = t.id
            WHERE pt.problem_id = #{problemId}
            ORDER BY pt.id
            LIMIT #{limit}
            """)
    List<String> selectTagNames(@Param("problemId") Long problemId, @Param("limit") int limit);

    /** 编辑场景必须拿到全部标签：selectTagNames 带 LIMIT，回写时会静默丢弃超出的标签。 */
    @Select("""
            SELECT t.name
            FROM tag t
            JOIN problem_tag pt ON pt.tag_id = t.id
            WHERE pt.problem_id = #{problemId}
            ORDER BY pt.id
            """)
    List<String> selectAllTagNames(@Param("problemId") Long problemId);

    @Select("""
            <script>
            SELECT pt.problem_id, t.name
            FROM problem_tag pt
            JOIN tag t ON t.id = pt.tag_id
            WHERE pt.problem_id IN
            <foreach collection='problemIds' item='problemId' open='(' separator=',' close=')'>
                #{problemId}
            </foreach>
            ORDER BY pt.problem_id, pt.id
            </script>
            """)
    List<ProblemTagNameVO> selectTagNamesByProblemIds(@Param("problemIds") List<Long> problemIds);
}
