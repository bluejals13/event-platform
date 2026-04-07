package com.eventplatform.repository;

import com.eventplatform.domain.Event;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

@Repository
public class MysqlEventRepository implements EventRepository {

    private final ConcurrentHashMap<String, Event> store = new ConcurrentHashMap<>();

    @Override
    public void save(Event event) {
        store.put(event.getId(), event);
        System.out.println("[MySQL] Saved event: " + event.getId());
    }

    @Override
    public Optional<Event> findById(String id) {
        return Optional.ofNullable(store.get(id));
    }
}
