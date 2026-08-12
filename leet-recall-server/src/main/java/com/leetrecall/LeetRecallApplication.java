package com.leetrecall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan({
        "com.leetrecall.problem.mapper",
        "com.leetrecall.review.mapper",
        "com.leetrecall.dictation.mapper",
        "com.leetrecall.externalimport.mapper"
})
@SpringBootApplication
public class LeetRecallApplication {

    public static void main(String[] args) {
        SpringApplication.run(LeetRecallApplication.class, args);
    }
}
