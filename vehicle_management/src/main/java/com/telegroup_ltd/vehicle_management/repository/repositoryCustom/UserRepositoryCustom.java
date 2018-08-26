package com.telegroup_ltd.vehicle_management.repository.repositoryCustom;

import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.model.modelCustom.UserLocation;

import java.util.List;

public interface UserRepositoryCustom {

    User login(String username, String password, String companyName);

    List<UserLocation> getAllExtendedByCompanyIdAndStatusIdNot(Integer companyId, Integer statusId);
}
