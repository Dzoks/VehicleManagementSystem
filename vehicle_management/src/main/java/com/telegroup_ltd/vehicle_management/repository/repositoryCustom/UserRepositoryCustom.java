package com.telegroup_ltd.vehicle_management.repository.repositoryCustom;

import com.telegroup_ltd.vehicle_management.model.User;

public interface UserRepositoryCustom {

    User login(String username, String password, String companyName);

}
