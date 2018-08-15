package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.ReadOnlyController;
import com.telegroup_ltd.vehicle_management.model.NotificationType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("notification-type")
public class NotificationTypeController extends ReadOnlyController<NotificationType,Integer> {
    public NotificationTypeController(JpaRepository<NotificationType, Integer> repo) {
        super(repo);
    }
}
