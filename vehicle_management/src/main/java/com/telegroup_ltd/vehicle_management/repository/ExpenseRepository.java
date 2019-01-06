package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.repository.repositoryCustom.ExpenseRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExpenseRepository extends JpaRepository<Expense, Integer>, HasCompanyIdAndDeletableRepository<Expense>, ExpenseRepositoryCustom {


    List<Expense> getAllByVehicleIdAndCompanyIdAndDeletedOrderByDateDesc(Integer vehicleId,Integer companyId,Byte deleted);
    List<Expense> getAllByVehicleIdAndCompanyIdAndReservationIdAndDeletedOrderByDateDesc(Integer vehicleId,Integer companyId,Integer reservationId,Byte deleted);
}
