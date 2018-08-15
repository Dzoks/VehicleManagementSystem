package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.Status;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusRepository extends JpaRepository<Status, Integer> {
}
