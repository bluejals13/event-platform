package com.eventplatform.worker.consumer;

import com.eventplatform.domain.Event;
import com.eventplatform.worker.processor.EventProcessor;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
public class EventConsumer {

    private final EventProcessor processor;

    public EventConsumer(EventProcessor processor) {
        this.processor = processor;
    }

    @KafkaListener(topics = "events", groupId = "event-group")
    public void consume(ConsumerRecord<String, String> record) {
        // Kafka 메시지 단순 Event 변환
        Event event = new Event(record.key(), "KAFKA", record.value());
        System.out.println("[Worker] Consumed event: " + event.getId());
        processor.process(event);
    }
}
