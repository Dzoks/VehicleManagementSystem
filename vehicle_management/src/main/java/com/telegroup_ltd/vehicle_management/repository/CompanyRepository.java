package com.telegroup_ltd.vehicle_management.repository;

import com.telegroup_ltd.vehicle_management.model.Company;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyRepository extends JpaRepository<Company, Integer> {
}
