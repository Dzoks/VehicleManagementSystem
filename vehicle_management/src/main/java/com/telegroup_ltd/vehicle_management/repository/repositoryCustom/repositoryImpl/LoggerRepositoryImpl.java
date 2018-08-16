package com.telegroup_ltd.vehicle_management.repository.repositoryCustom.repositoryImpl;

import com.telegroup_ltd.vehicle_management.common.GenericRepository;
import com.telegroup_ltd.vehicle_management.model.modelCustom.LoggerCompanyUserRole;
import com.telegroup_ltd.vehicle_management.repository.repositoryCustom.LoggerRepositoryCustom;
import java.util.List;

public class LoggerRepositoryImpl extends GenericRepository implements LoggerRepositoryCustom {

    private static final String SQL_GET_ALL="select l.id, l.action_type, l.action_details, l.table_name, l.created, l.user_id, l.atomic," +
            " l.company_id,c.name as company_name,u.username,r.name as role from logger l inner join user u on l.user_id = u.id" +
            " inner join role r on u.role_id = r.id left join company c on l.company_id = c.id;";

    private static final String SQL_GET_ALL_BY_COMPANY="select l.id, l.action_type, l.action_details, l.table_name, l.created, l.user_id, l.atomic," +
            " l.company_id,c.name as company_name,u.username,r.name as role from logger l inner join user u on l.user_id = u.id" +
            " inner join role r on u.role_id = r.id inner join company c on l.company_id = c.id";




    @Override
    public List<LoggerCompanyUserRole> getExtendedAll() {
        return entityManager.createNativeQuery(SQL_GET_ALL,"LoggerMapping").getResultList();
    }

    @Override
    public List<LoggerCompanyUserRole> getExtendedByCompany(Integer companyId) {
        return entityManager.createNativeQuery(SQL_GET_ALL_BY_COMPANY,"LoggerMapping").setParameter(1,companyId).getResultList();
    }
}
