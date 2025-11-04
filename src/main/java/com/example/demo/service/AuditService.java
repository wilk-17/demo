package com.example.demo.service;

import com.example.demo.model.ActivityLog;
import com.example.demo.repository.ActivityLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuditService {

    @Autowired
    private ActivityLogRepository activityLogRepository;

    @Transactional
    public void logActivity(Long userId, String action, String entity, Long entityId, 
                           String description, String ipAddress) {
        ActivityLog log = new ActivityLog(userId, action, entity, entityId, description, ipAddress);
        activityLogRepository.save(log);
    }

    public List<ActivityLog> getRecentActivities(int limit) {
        return activityLogRepository.findTop100ByOrderByCreatedAtDesc();
    }

    public List<ActivityLog> getActivitiesByUser(Long userId) {
        return activityLogRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public List<ActivityLog> getActivitiesByAction(String action) {
        return activityLogRepository.findByActionOrderByCreatedAtDesc(action);
    }

    public List<ActivityLog> getActivitiesByDateRange(LocalDateTime start, LocalDateTime end) {
        return activityLogRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(start, end);
    }
}
