package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Integer>, HasCompanyIdAndDeletableRepository<Vehicle> {

    List<Vehicle> getAllByLocationIdAndCompanyIdAndDeletedIs(Integer locationId,Integer companyId, Byte deleted);

    Vehicle findByRegistrationAndDeleted(String registration,Byte deleted);
}
