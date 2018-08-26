package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericDeletableController;
import com.telegroup_ltd.vehicle_management.model.Company;
import com.telegroup_ltd.vehicle_management.repository.CompanyRepository;
import com.telegroup_ltd.vehicle_management.util.Notification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("api/company")
@Scope("request")
public class CompanyController extends GenericDeletableController<Company, Integer> {

    private CompanyRepository repository;


    final
    Notification notification;
    @Autowired
    public CompanyController(CompanyRepository repo, Notification notification) {
        super(repo);
        repository = repo;
        this.notification = notification;
    }

    @RequestMapping("/mail/{to}")
    public String sendMail( @PathVariable String to){
        notification.sendMail("test@etfbl.net",to,"TEST","TEST BODY");
        return "Success!";
    }
}
