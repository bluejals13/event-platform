package com.eventplatform.controller;

import com.eventplatform.service.FeatureFlagService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/ops/db")
public class OpsController {

    private final FeatureFlagService flag;

    public OpsController(FeatureFlagService flag) {
        this.flag = flag;
    }

    @PostMapping("/dual-write/on")
    public String enableDualWrite() {
        // 예시: 실제로는 DB/Redis/Config 연동
        System.out.println("[Ops] Dual write ON");
        return "Dual write enabled";
    }

    @PostMapping("/dual-write/off")
    public String disableDualWrite() {
        System.out.println("[Ops] Dual write OFF");
        return "Dual write disabled";
    }

    @PostMapping("/read/mysql")
    public String switchReadMysql() {
        System.out.println("[Ops] Read MySQL ON");
        return "Read MySQL enabled";
    }

    @PostMapping("/read/postgres")
    public String switchReadPostgres() {
        System.out.println("[Ops] Read Postgres ON");
        return "Read Postgres enabled";
    }
}
