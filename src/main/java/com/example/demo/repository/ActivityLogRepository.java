package com.example.demo.repository;

import com.example.demo.model.ActivityLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ActivityLogRepository extends JpaRepository<ActivityLog, Long> {
    List<ActivityLog> findByUserIdOrderByCreatedAtDesc(Long userId);
    List<ActivityLog> findByActionOrderByCreatedAtDesc(String action);
    List<ActivityLog> findByEntityOrderByCreatedAtDesc(String entity);
    List<ActivityLog> findByCreatedAtBetweenOrderByCreatedAtDesc(LocalDateTime start, LocalDateTime end);
    List<ActivityLog> findTop100ByOrderByCreatedAtDesc();
}
