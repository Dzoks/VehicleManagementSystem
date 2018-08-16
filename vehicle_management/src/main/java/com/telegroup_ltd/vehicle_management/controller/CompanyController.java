package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericController;
import com.telegroup_ltd.vehicle_management.model.Company;
import com.telegroup_ltd.vehicle_management.repository.CompanyRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("api/company")
@Scope("request")
public class CompanyController extends GenericController<Company, Integer> {


    private CompanyRepository companyRepository;

    public CompanyController(CompanyRepository repo) {
        super(repo);
        this.companyRepository = repo;
    }
}
