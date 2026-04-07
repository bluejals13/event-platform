package com.eventplatform.controller;

import com.eventplatform.domain.Event;
import com.eventplatform.repository.*;
import com.eventplatform.service.FeatureFlagService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/events")
public class EventController {

    private final KafkaEventPublisher kafkaPublisher;
    private final EventRepository postgres;
    private final EventRepository mysql;
    private final FeatureFlagService flag;

    public EventController(KafkaEventPublisher kafkaPublisher,
                           PostgresEventRepository postgres,
                           MysqlEventRepository mysql,
                           FeatureFlagService flag) {
        this.kafkaPublisher = kafkaPublisher;
        this.postgres = postgres;
        this.mysql = mysql;
        this.flag = flag;
    }

    private EventRepository getRepository() {
        return flag.isDualWrite() ? new DualWriteEventRepository(postgres, mysql) : postgres;
    }

    @PostMapping
    public ResponseEntity<String> createEvent(@RequestBody EventDto dto) {
        Event event = new Event(UUID.randomUUID().toString(), dto.getType(), dto.getPayload());

        // DB 저장
        getRepository().save(event);

        // Kafka 발행
        kafkaPublisher.publish(event.getId(), dto.getPayload());

        return ResponseEntity.status(HttpStatus.CREATED).body(event.getId());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Event> getEvent(@PathVariable String id) {
        Optional<Event> result = flag.useMysqlRead() ? mysql.findById(id) : postgres.findById(id);
        return result.map(ResponseEntity::ok)
                     .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found"));
    }
}

