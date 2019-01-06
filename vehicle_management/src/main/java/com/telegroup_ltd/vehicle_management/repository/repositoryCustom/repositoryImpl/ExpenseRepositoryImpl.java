package com.telegroup_ltd.vehicle_management.repository.repositoryCustom.repositoryImpl;

import com.telegroup_ltd.vehicle_management.common.CustomRepositoryImpl;
import com.telegroup_ltd.vehicle_management.repository.repositoryCustom.ExpenseRepositoryCustom;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ExpenseRepositoryImpl extends CustomRepositoryImpl implements ExpenseRepositoryCustom {
    private static final String SQL_SUM_VEHICLE ="select sum(value) from expense where vehicle_id=? and company_id=? and deleted=? and expense_type_id=? and date between ? and ?;";
    private static final String SQL_SUM_COMPANY ="select sum(value) from expense where company_id=? and deleted=? and expense_type_id=? and date between ? and ?;" ;

    @Override
    public BigDecimal sumValueByVehicleIdAndCompanyIdAndDeletedAndExpenseTypeAndDateBetween(Integer vehicleId, Integer companyId, Byte deleted, Integer expenseTypeId, Timestamp startDate, Timestamp endDate) {
        return (BigDecimal)entityManager.createNativeQuery(SQL_SUM_VEHICLE).setParameter(1,vehicleId).setParameter(2,companyId).setParameter(3,deleted).setParameter(4,expenseTypeId).
                setParameter(5,startDate).setParameter(6,endDate).getSingleResult();
    }

    @Override
    public BigDecimal sumValueByCompanyIdAndDeletedAndExpenseTypeAndDateBetween(Integer companyId, Byte deleted, Integer expenseTypeId, Timestamp startDate, Timestamp endDate) {
        return (BigDecimal)entityManager.createNativeQuery(SQL_SUM_COMPANY).setParameter(1,companyId).setParameter(2,deleted).setParameter(3,expenseTypeId).
                setParameter(4,startDate).setParameter(5,endDate).getSingleResult();
    }
}
