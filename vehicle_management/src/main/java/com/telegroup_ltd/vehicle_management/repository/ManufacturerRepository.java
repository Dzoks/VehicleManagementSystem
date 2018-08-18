package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyIdRepository;
import com.telegroup_ltd.vehicle_management.model.Manufacturer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ManufacturerRepository extends JpaRepository<Manufacturer, Integer>, HasCompanyIdRepository<Manufacturer> {
}
