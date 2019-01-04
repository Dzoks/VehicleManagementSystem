package com.telegroup_ltd.vehicle_management.model.modelCustom;

import com.telegroup_ltd.vehicle_management.model.Expense;
import com.telegroup_ltd.vehicle_management.model.Reservation;

import java.util.List;

public class ReservationExpense {
    private Reservation reservation;
    private List<Expense> expenses;
    private List<Integer> expensesToDelete;

    public List<Integer> getExpensesToDelete() {
        return expensesToDelete;
    }

    public void setExpensesToDelete(List<Integer> expensesToDelete) {
        this.expensesToDelete = expensesToDelete;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public List<Expense> getExpenses() {
        return expenses;
    }

    public void setExpenses(List<Expense> expenses) {
        this.expenses = expenses;
    }
}
