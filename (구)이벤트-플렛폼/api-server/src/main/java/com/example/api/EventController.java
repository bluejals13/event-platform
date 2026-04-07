package com.eventplatform.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EventController {

    @GetMapping("/api/events")  // @RequestMapping 대신 @GetMapping 사용
    public String getEvents() {
        return "Hello from API Server!";
    }
}
