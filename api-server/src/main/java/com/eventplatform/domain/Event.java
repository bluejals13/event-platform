package com.eventplatform.domain;

import java.time.LocalDateTime;

public class Event {
    private String id;
    private String type;
    private String payload;
    private LocalDateTime createdAt;

    public Event(String id, String type, String payload) {
        this.id = id;
        this.type = type;
        this.payload = payload;
        this.createdAt = LocalDateTime.now();
    }

    // Getters & Setters
    public String getId() { return id; }
    public String getType() { return type; }
    public String getPayload() { return payload; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
