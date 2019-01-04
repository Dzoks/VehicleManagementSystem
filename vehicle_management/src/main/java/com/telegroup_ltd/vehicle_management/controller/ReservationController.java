package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.model.Reservation;
import com.telegroup_ltd.vehicle_management.model.modelCustom.ReservationExpense;
import com.telegroup_ltd.vehicle_management.repository.ExpenseRepository;
import com.telegroup_ltd.vehicle_management.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;



@RestController
@Scope("request")
@RequestMapping("api/reservation")
public class ReservationController extends GenericHasCompanyIdAndDeletableController<Reservation,Integer> {

    private final ReservationRepository reservationRepository;

    private final ExpenseController expenseController;

    @Autowired
    public ReservationController(JpaRepository<Reservation, Integer> repo, ReservationRepository reservationRepository, ExpenseController expenseController) {
        super(repo);
        this.reservationRepository = reservationRepository;
        this.expenseController = expenseController;
    }



    @RequestMapping("/byVehicle/{vehicleId}")
    public List<Reservation> getAllByVehicle(@PathVariable Integer vehicleId){
        return reservationRepository.findAllByVehicleIdAndDeleted(vehicleId,(byte)0);
    }


    @RequestMapping(value = "/checkAvailability",method = RequestMethod.POST)
    public boolean checkAvailability(@RequestBody Reservation request){
        return reservationRepository.countAllByVehicleIdAndCompanyIdAndDeletedAndStartDateBeforeAndEndDateAfter(request.getVehicleId(),userBean.getUser().getCompanyId(),(byte)0, request.getStartDate(),request.getStartDate())==0;
    }

    @RequestMapping(value = "/getMaxTime",method = RequestMethod.POST)
    public Timestamp getMaxTime(@RequestBody Reservation request){
        Reservation reservation=reservationRepository.findFirstByVehicleIdAndCompanyIdAndDeletedAndStartDateAfter(request.getVehicleId(),userBean.getUser().getCompanyId(),(byte)0,request.getStartDate());
        if (reservation==null){
            return Timestamp.valueOf(LocalDateTime.MAX);
        }
        return reservation.getStartDate();
    }

    @RequestMapping(value = "/getMinTime",method = RequestMethod.POST)
    public Timestamp getMinTime(@RequestBody Reservation request){
        Reservation reservation=reservationRepository.findFirstByVehicleIdAndCompanyIdAndDeletedAndEndDateBefore(request.getVehicleId(),userBean.getUser().getCompanyId(),(byte)0,request.getEndDate());
        if (reservation==null){
            return Timestamp.valueOf(LocalDateTime.MIN);
        }
        return reservation.getEndDate();
    }


    @RequestMapping(value = "/custom",method = RequestMethod.POST)
    @Transactional
    public Reservation addCustom(@RequestBody ReservationExpense reservationExpense) throws BadRequestException, ForbiddenException {
        Reservation reservation=super.insert(reservationExpense.getReservation());
        for (Expense expense:reservationExpense.getExpenses()){
            expense.setReservationId(reservation.getId());
            expenseController.insert(expense);
        }
        return reservation;
    }

    @RequestMapping(value = "/custom/{reservationId}",method = RequestMethod.PUT)
    @Transactional
    public Reservation updateCustom(@RequestBody ReservationExpense reservationExpense,@PathVariable Integer reservationId) throws BadRequestException, ForbiddenException {
        if (super.update(reservationId,reservationExpense.getReservation()).equals("Success")){

            for (Expense expense : reservationExpense.getExpenses()) {
                if (expense.getId()==null) {
                    expense.setReservationId(reservationId);
                    expenseController.insert(expense);
                }else{
                    expenseController.update(expense.getId(),expense);
                }
            }
            for (Integer id:reservationExpense.getExpensesToDelete()){
                expenseController.delete(id);
            }
            return reservationExpense.getReservation();
        }
        throw new BadRequestException("Neuspješna izmjena!");
    }

    @RequestMapping(value = "/custom/{reservationId}")
    public ReservationExpense getCustom(@PathVariable Integer reservationId) throws ForbiddenException, BadRequestException {
        Reservation reservation=super.findById(reservationId);
        if (reservation==null)
            throw new BadRequestException("Bad Request!");
        ReservationExpense reservationExpense=new ReservationExpense();
        reservationExpense.setReservation(reservation);
        reservationExpense.setExpenses(expenseController.getByVehicleAndReservation(reservation.getVehicleId(),reservationId));
        return reservationExpense;
    }

    @Override
    @Transactional
    public String delete(@PathVariable Integer id) throws BadRequestException, ForbiddenException {
        Reservation reservation=findById(id);
        List<Expense> expenses=expenseController.getByVehicleAndReservation(reservation.getVehicleId(),id);
        for (Expense expense:expenses){
            expenseController.delete(expense.getId());
        }
        return super.delete(id);
    }
}
