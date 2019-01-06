package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.model.ExpenseType;
import com.telegroup_ltd.vehicle_management.model.Reservation;
import com.telegroup_ltd.vehicle_management.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@Scope("request")
@RequestMapping("api/expense")
public class ExpenseController extends GenericHasCompanyIdAndDeletableController<Expense, Integer> {

    private ExpenseRepository repository;

    private final ExpenseTypeController expenseTypeController;

    @Autowired
    public ExpenseController(ExpenseRepository repo, ExpenseTypeController expenseTypeController) {
        super(repo);
        repository = repo;
        this.expenseTypeController = expenseTypeController;
    }



    @RequestMapping("/byVehicle/{vehicleId}")
    public List<Expense> getByVehicle(@PathVariable Integer vehicleId){
        return repository.getAllByVehicleIdAndCompanyIdAndDeletedOrderByDateDesc(vehicleId,userBean.getUser().getCompanyId(),(byte)0);
    }

    @RequestMapping("/byVehicle/{vehicleId}/reservation/{reservationId}")
    public List<Expense> getByVehicleAndReservation(@PathVariable Integer vehicleId,@PathVariable Integer reservationId){

        return repository.getAllByVehicleIdAndCompanyIdAndReservationIdAndDeletedOrderByDateDesc(vehicleId,userBean.getUser().getCompanyId(),reservationId,(byte)0);
    }


    @RequestMapping(value = "/vehicleReport",method = RequestMethod.POST)
    public List<Expense> vehicleReport(@RequestBody Reservation period) throws ForbiddenException {
        List<Expense> expenses=new ArrayList<>();
        for(ExpenseType type:expenseTypeController.getAll()){
            Expense expense=new Expense();
            expense.setDescription(type.getValue());
            expense.setValue(repository.sumValueByVehicleIdAndCompanyIdAndDeletedAndExpenseTypeAndDateBetween(period.getVehicleId(),period.getCompanyId(),(byte)0,type.getId(),period.getStartDate(),period.getEndDate()));
            expenses.add(expense);
        }
        return expenses;
    }


    @RequestMapping(value = "/allReport",method = RequestMethod.POST)
    public List<Expense> allReport(@RequestBody Reservation period) throws ForbiddenException {
        List<Expense> expenses=new ArrayList<>();
        for(ExpenseType type:expenseTypeController.getAll()){
            Expense expense=new Expense();
            expense.setDescription(type.getValue());
            expense.setValue(repository.sumValueByCompanyIdAndDeletedAndExpenseTypeAndDateBetween(period.getCompanyId(),(byte)0,type.getId(),period.getStartDate(),period.getEndDate()));
            expenses.add(expense);
        }
        return expenses;
    }

}
