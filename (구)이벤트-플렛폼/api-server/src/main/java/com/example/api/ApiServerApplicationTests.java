package com.example.api_server;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import com.example.api.ApiServerApplication; // 추가된 부분

@SpringBootTest(classes = ApiServerApplication.class) // 애플리케이션 시작 클래스를 명시적으로 지정
public class ApiServerApplicationTests {

    @Test
    void contextLoads() {
    }
}
