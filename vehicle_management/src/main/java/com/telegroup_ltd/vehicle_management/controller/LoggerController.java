package com.telegroup_ltd.vehicle_management.controller;


import com.telegroup_ltd.vehicle_management.common.ReadOnlyController;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.model.Logger;
import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.model.modelCustom.LoggerCompanyUserRole;
import com.telegroup_ltd.vehicle_management.repository.LoggerRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Scope("request")
@RequestMapping("logger")
public class LoggerController extends ReadOnlyController<Logger,Integer> {

    private LoggerRepository repository;

    @Value(value = "${role.system_admin}")
    private Integer roleSystemAdmin;

    public LoggerController(LoggerRepository repo) {
        super(repo);
        this.repository=repo;
    }

    @Override
    public List getAll() throws ForbiddenException {
        User loggedUser=userBean.getUser();
       // if (loggedUser.getRoleId().equals(roleSystemAdmin))
        return repository.getExtendedAll();
       // else return repository.getExtendedByCompany(loggedUser.getCompanyId());
    }
}
