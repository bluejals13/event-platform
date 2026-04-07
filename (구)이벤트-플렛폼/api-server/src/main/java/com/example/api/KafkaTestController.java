package com.example.api;

import org.springframework.web.bind.annotation.RequestMapping; // 추가된 부분
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KafkaTestController {

    @RequestMapping("/")
    public String home() {
        return "Hello, Kafka!";
    }
}
