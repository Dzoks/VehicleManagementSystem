package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdRepository;
import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.repository.repositoryCustom.UserRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer>, UserRepositoryCustom, HasCompanyIdRepository<User> {

    List<User> getAllByCompanyIdAndStatusIdNot(Integer companyId, Integer statusId);
}
