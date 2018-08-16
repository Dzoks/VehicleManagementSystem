package com.telegroup_ltd.vehicle_management.repository.repositoryCustom;

import com.telegroup_ltd.vehicle_management.model.modelCustom.LoggerCompanyUserRole;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LoggerRepositoryCustom {

    List<LoggerCompanyUserRole> getExtendedAll();
    List<LoggerCompanyUserRole> getExtendedByCompany(Integer companyId);


}
