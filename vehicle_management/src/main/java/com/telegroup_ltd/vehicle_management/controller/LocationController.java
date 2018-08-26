package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Location;
import com.telegroup_ltd.vehicle_management.repository.LocationRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Scope("request")
@RequestMapping("api/location")
public class LocationController extends GenericHasCompanyIdAndDeletableController<Location, Integer> {

    private LocationRepository repository;

    public LocationController(LocationRepository repo) {
        super(repo);
        repository = repo;
    }


    @RequestMapping("/byCompany/{id}")
    public List<Location> getByCompany(@PathVariable Integer id){
        return repository.getAllByCompanyIdAndDeletedIs(id,(byte)0);
    }
}
