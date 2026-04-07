package com.eventplatform.worker.processor;

import com.eventplatform.domain.Event;
import org.springframework.stereotype.Component;

@Component
public class EventProcessor {

    public void process(Event event) {
        // 예: DB write, 상태 업데이트
        System.out.println("[Worker] Processing event: " + event.getId());
        // 실제 DB write 로직은 repository 호출
    }
}
