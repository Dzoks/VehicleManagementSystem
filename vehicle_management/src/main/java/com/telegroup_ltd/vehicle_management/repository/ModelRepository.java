package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.Model;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ModelRepository extends JpaRepository<Model, Integer> {
}
