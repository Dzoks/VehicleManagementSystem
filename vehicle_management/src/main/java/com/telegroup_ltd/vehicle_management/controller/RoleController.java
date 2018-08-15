package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.ReadOnlyController;
import com.telegroup_ltd.vehicle_management.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("role")
public class RoleController extends ReadOnlyController<Role, Integer> {

    public RoleController(JpaRepository<Role,Integer> repo) {
        super(repo);
    }

}
