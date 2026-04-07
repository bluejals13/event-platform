package com.example.api;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;


@RestController
@RequestMapping("/hello")
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "Hello, Event Platform!";
    }

    @GetMapping("/api/events")
    public String events() {
        return "List of events will appear here!";
    }
}
