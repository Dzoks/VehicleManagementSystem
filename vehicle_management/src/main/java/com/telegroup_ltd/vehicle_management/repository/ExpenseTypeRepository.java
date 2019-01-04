package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.model.ExpenseType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExpenseTypeRepository extends JpaRepository<ExpenseType, Integer> {

}
