package com.telegroup_ltd.vehicle_management.repository.repositoryCustom;

import java.math.BigDecimal;
import java.sql.Timestamp;

public interface ExpenseRepositoryCustom {

    BigDecimal sumValueByVehicleIdAndCompanyIdAndDeletedAndExpenseTypeAndDateBetween(Integer vehicleId, Integer companyId, Byte deleted, Integer expenseTypeId, Timestamp startDate, Timestamp endDate);
    BigDecimal sumValueByCompanyIdAndDeletedAndExpenseTypeAndDateBetween(Integer companyId,Byte deleted,Integer expenseTypeId, Timestamp startDate, Timestamp endDate);
}
