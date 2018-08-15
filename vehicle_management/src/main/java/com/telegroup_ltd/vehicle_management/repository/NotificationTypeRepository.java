package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.NotificationType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationTypeRepository extends JpaRepository<NotificationType, Integer> {
}
