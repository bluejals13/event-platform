package com.eventplatform.repository;

import com.eventplatform.domain.Event;
import java.util.Optional;

public interface EventRepository {
    void save(Event event);
    Optional<Event> findById(String id);
}
