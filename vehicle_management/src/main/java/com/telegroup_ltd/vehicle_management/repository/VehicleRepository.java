package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRepository extends JpaRepository<Vehicle, Integer>, HasCompanyIdAndDeletableRepository<Vehicle> {
}
