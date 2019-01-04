package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.repository.ExpenseRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Scope("request")
@RequestMapping("api/expense")
public class ExpenseController extends GenericHasCompanyIdAndDeletableController<Expense, Integer> {

    private ExpenseRepository repository;

    public ExpenseController(ExpenseRepository repo) {
        super(repo);
        repository = repo;
    }



    @RequestMapping("/byVehicle/{vehicleId}")
    public List<Expense> getByVehicle(@PathVariable Integer vehicleId){
        return repository.getAllByVehicleIdAndCompanyIdAndDeletedOrderByDateDesc(vehicleId,userBean.getUser().getCompanyId(),(byte)0);
    }

    @RequestMapping("/byVehicle/{vehicleId}/reservation/{reservationId}")
    public List<Expense> getByVehicleAndReservation(@PathVariable Integer vehicleId,@PathVariable Integer reservationId){
        return repository.getAllByVehicleIdAndCompanyIdAndReservationIdAndDeletedOrderByDateDesc(vehicleId,userBean.getUser().getCompanyId(),reservationId,(byte)0);
    }

}
