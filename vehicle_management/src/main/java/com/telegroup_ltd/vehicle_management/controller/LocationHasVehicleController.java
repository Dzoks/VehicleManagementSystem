package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericController;
import com.telegroup_ltd.vehicle_management.model.LocationHasVehicle;
import com.telegroup_ltd.vehicle_management.model.LocationHasVehiclePK;
import com.telegroup_ltd.vehicle_management.repository.LocationHasVehicleRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@Scope("request")
@RequestMapping("api/location-has-vehicle")
public class LocationHasVehicleController extends GenericController<LocationHasVehicle, LocationHasVehiclePK> {

    private LocationHasVehicleRepository repository;

    public LocationHasVehicleController(LocationHasVehicleRepository repo) {
        super(repo);
        repository = repo;
    }
}
