package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Location;
import com.telegroup_ltd.vehicle_management.repository.LocationRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Scope("request")
@RequestMapping("api/location")
public class LocationController extends GenericHasCompanyIdAndDeletableController<Location, Integer> {

    private LocationRepository repository;

    public LocationController(LocationRepository repo) {
        super(repo);
        repository = repo;
    }
}
