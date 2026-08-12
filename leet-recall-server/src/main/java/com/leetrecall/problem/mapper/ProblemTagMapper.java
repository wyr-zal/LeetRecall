package com.leetrecall.problem.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.problem.entity.ProblemTag;
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
}

