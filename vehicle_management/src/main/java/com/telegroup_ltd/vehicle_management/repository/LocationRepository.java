package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdAndDeletableRepository;
import com.telegroup_ltd.vehicle_management.model.Location;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationRepository extends JpaRepository<Location, Integer>, HasCompanyIdAndDeletableRepository<Location> {
}
