package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericController;
import com.telegroup_ltd.vehicle_management.model.Model;
import com.telegroup_ltd.vehicle_management.repository.ModelRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@Scope("request")
@RequestMapping("api/model")
public class ModelController extends GenericController<Model, Integer> {

    private ModelRepository repository;

    public ModelController(ModelRepository repo) {
        super(repo);
        repository = repo;
    }
}
