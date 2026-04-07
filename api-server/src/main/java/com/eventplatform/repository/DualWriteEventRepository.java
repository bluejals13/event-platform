package com.eventplatform.repository;

import com.eventplatform.domain.Event;

public class DualWriteEventRepository implements EventRepository {

    private final EventRepository primary;
    private final EventRepository secondary;

    public DualWriteEventRepository(EventRepository primary, EventRepository secondary) {
        this.primary = primary;
        this.secondary = secondary;
    }

    @Override
    public void save(Event event) {
        primary.save(event);
        secondary.save(event);
    }

    @Override
    public Optional<Event> findById(String id) {
        return primary.findById(id); // 읽기는 기본 primary
    }
}
