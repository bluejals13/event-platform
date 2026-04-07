package com.eventplatform.repository;

import com.eventplatform.domain.Event;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

@Repository
public class PostgresEventRepository implements EventRepository {

    // 예시용 메모리 맵
    private final ConcurrentHashMap<String, Event> store = new ConcurrentHashMap<>();

    @Override
    public void save(Event event) {
        // 실제라면 JDBC / JPA 사용
        store.put(event.getId(), event);
        System.out.println("[Postgres] Saved event: " + event.getId());
    }

    @Override
    public Optional<Event> findById(String id) {
        return Optional.ofNullable(store.get(id));
    }
}
