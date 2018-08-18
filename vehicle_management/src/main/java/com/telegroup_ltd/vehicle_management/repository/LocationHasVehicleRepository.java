package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.LocationHasVehicle;
import com.telegroup_ltd.vehicle_management.model.LocationHasVehiclePK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationHasVehicleRepository extends JpaRepository<LocationHasVehicle, LocationHasVehiclePK> {
}
