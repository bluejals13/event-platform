package com.eventplatform.service;

import org.apache.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class KafkaEventPublisher {

    private final KafkaTemplate<String, String> kafkaTemplate;

    public KafkaEventPublisher(KafkaTemplate<String, String> kafkaTemplate,
                               EventProperties properties) {
        this.kafkaTemplate = kafkaTemplate;
        this.properties = properties;
    }


 public void publish(String key, String payload) {
        kafkaTemplate.send(properties.getTopic(), key, payload)
                     .addCallback(
                         success -> System.out.println("[KafkaPublisher] Sent: " + key),
                         failure -> System.err.println("[KafkaPublisher] Failed: " + key)
                     );
    }
}
