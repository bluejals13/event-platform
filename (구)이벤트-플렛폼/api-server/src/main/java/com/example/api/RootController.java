package com.example.api; // ApiServerApplication과 동일한 패키지 혹은 하위 패키지

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {

    @GetMapping("/")  // 루트 경로 매핑
    public String home() {
        return "API Server is running!";
    }
}
