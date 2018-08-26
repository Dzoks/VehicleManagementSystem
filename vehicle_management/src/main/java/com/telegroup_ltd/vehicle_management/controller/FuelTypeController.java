package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.ReadOnlyController;
import com.telegroup_ltd.vehicle_management.model.FuelType;
import org.springframework.context.annotation.Scope;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/fuel-type")
@RestController
@Scope("session")
public class FuelTypeController extends ReadOnlyController<FuelType,Integer> {
    public FuelTypeController(JpaRepository<FuelType, Integer> repo) {
        super(repo);
    }
}
