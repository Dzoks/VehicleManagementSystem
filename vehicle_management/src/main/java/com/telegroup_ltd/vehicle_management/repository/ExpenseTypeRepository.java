package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.ExpenseType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpenseTypeRepository extends JpaRepository<ExpenseType, Integer> {
}
