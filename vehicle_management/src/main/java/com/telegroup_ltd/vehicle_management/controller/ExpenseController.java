package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.repository.ExpenseRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Scope("request")
@RequestMapping("/api/expense")
public class ExpenseController extends GenericHasCompanyIdAndDeletableController<Expense, Integer> {

    private ExpenseRepository repository;

    public ExpenseController(ExpenseRepository repo) {
        super(repo);
        repository = repo;
    }
}
