package com.telegroup_ltd.vehicle_management.repository.repositoryCustom.repositoryImpl;

import com.telegroup_ltd.vehicle_management.common.CustomRepositoryImpl;
import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.model.modelCustom.UserLocation;
import com.telegroup_ltd.vehicle_management.repository.repositoryCustom.UserRepositoryCustom;

import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureQuery;
import java.util.List;


public class UserRepositoryImpl extends CustomRepositoryImpl implements UserRepositoryCustom {

    private static final String SQL_LOGIN_NO_COMPANY = "select id, username, first_name, last_name, registration_date," +
            "email, role_id, status_id, company_id, notification_type_id, location_id from user where username=? and password=SHA2(?,512)" +
            " and company_id is null;";
    private static final String SQL_LOGIN = "select u.id, username, first_name, last_name, registration_date," +
            "email, role_id, status_id, company_id, notification_type_id, location_id from user u inner join company c on u.company_id=c.id where username=? and password=SHA2(?,512) and c.name=?;";
    private static final String SQL_GET_EXTENDED ="select u.*,l.label as location_name from user u left join location l " +
            "on u.location_id = l.id where u.company_id=? and status_id!=?";
    private static final String SQL_NO_EXTENDED ="select u.*,'' as location_name from user u where u.company_id  is null and status_id!=?";

    @Override
    public User login(String username, String password, String companyName) {
        if ("".equals(companyName))
            return (User) entityManager.createNativeQuery(SQL_LOGIN_NO_COMPANY, "UserMapping").
                    setParameter(1, username).setParameter(2, password).getResultList().stream().findFirst().orElse(null);
        return (User) entityManager.createNativeQuery(SQL_LOGIN, "UserMapping").
                setParameter(1, username).setParameter(2, password).setParameter(3, companyName).getResultList().stream().findFirst().orElse(null);
    }

    @Override
    public List<UserLocation> getAllExtendedByCompanyIdAndStatusIdNot(Integer companyId, Integer statusId) {
        if (companyId!=null)
        return entityManager.createNativeQuery(SQL_GET_EXTENDED,"UserLocationMapping").
                setParameter(1,companyId).setParameter(2,statusId).getResultList();
        else return entityManager.createNativeQuery(SQL_NO_EXTENDED,"UserLocationMapping").
                setParameter(1,statusId).getResultList();
    }

}
