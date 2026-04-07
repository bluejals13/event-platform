package com.eventplatform.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class FeatureFlagService {

    @Value("${feature.dual-write:false}")
    private boolean dualWrite;

    @Value("${feature.read-mysql:false}")
    private boolean readMysql;

    public boolean isDualWrite() { return dualWrite; }

    public boolean useMysqlRead() { return readMysql; }
}
