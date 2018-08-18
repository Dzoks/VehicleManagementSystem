package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdController;
import com.telegroup_ltd.vehicle_management.model.Manufacturer;
import com.telegroup_ltd.vehicle_management.repository.ManufacturerRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Scope("request")
@RequestMapping("api/manufacturer")
public class ManufacturerController extends GenericHasCompanyIdController<Manufacturer, Integer> {

    private ManufacturerRepository repository;

    public ManufacturerController(ManufacturerRepository repo) {
        super(repo);
        repository = repo;
    }
}
