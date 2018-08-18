package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Expense;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpenseRepository extends JpaRepository<Expense, Integer>, HasCompanyIdAndDeletableRepository<Expense> {
}
