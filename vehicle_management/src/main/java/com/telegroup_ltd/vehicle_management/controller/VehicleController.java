package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Vehicle;
import com.telegroup_ltd.vehicle_management.repository.VehicleRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Scope("request")
@RequestMapping("api/vehicle")
public class VehicleController extends GenericHasCompanyIdAndDeletableController<Vehicle, Integer> {

    private VehicleRepository repository;

    public VehicleController(VehicleRepository repo) {
        super(repo);
        repository = repo;
    }
}
