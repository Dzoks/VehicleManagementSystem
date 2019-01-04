package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.sql.Timestamp;
import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation,Integer>, HasCompanyIdAndDeletableRepository<Reservation> {
    List<Reservation> findAllByVehicleIdAndDeleted(Integer vehicleId,Byte deleted);
    Integer countAllByVehicleIdAndCompanyIdAndDeletedAndStartDateBeforeAndEndDateAfter(Integer vehicleId,Integer companyId, Byte deleted, Timestamp startDateBefore,Timestamp endDateAfter);
    Integer countAllByVehicleIdAndCompanyIdAndDeletedAndStartDateBetween(Integer vehicleId,Integer companyId, Byte deleted, Timestamp startDateFirst,Timestamp startDateSecond);
    Integer countAllByVehicleIdAndCompanyIdAndDeletedAndEndDateBetween(Integer vehicleId,Integer companyId, Byte deleted, Timestamp endDateFirst,Timestamp endDateSecond);
    Reservation findFirstByVehicleIdAndCompanyIdAndDeletedAndStartDateAfter(Integer vehicleId,Integer companyId,Byte deleted, Timestamp startDateAfter);
    Reservation findFirstByVehicleIdAndCompanyIdAndDeletedAndEndDateBefore(Integer vehicleId,Integer companyId,Byte deleted, Timestamp endDateBefore);


}
