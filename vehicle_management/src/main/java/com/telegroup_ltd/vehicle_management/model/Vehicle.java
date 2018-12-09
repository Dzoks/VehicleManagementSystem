package com.telegroup_ltd.vehicle_management.model;

import com.telegroup_ltd.vehicle_management.common.interfaces.Deletable;
import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyId;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class Vehicle implements HasCompanyId, Deletable {
    private Integer id;
    private String manufacturer;
    private String model;
    private String registration;
    private String description;
    private Byte deleted;
    private Integer companyId;
    private Integer fuelTypeId;
    private Integer locationId;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    @Basic
    @Column(name = "description", nullable = true, length = 255)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "deleted", nullable = true)
    public Byte getDeleted() {
        return deleted;
    }

    public void setDeleted(Byte deleted) {
        this.deleted = deleted;
    }


    @Basic
    @Column(name = "company_id", nullable = false)
    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    @Basic
    @Column(name = "registration", nullable = false, length = 64)
    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vehicle vehicle = (Vehicle) o;
        return Objects.equals(id, vehicle.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", deleted=" + deleted +
                ", model='" + model + '\'' +
                ", manufacturer='" + manufacturer + '\'' +
                ", companyId=" + companyId +
                ", registration='" + registration + '\'' +
                ", fuelTypeId=" + fuelTypeId +
                ", locationId=" + locationId +
                '}';
    }

    @Basic
    @Column(name = "fuel_type_id", nullable = false)
    public Integer getFuelTypeId() {
        return fuelTypeId;
    }

    public void setFuelTypeId(Integer fuelTypeId) {
        this.fuelTypeId = fuelTypeId;
    }

    @Basic
    @Column(name = "location_id", nullable = true)
    public Integer getLocationId() {
        return locationId;
    }


    public void setLocationId(Integer locationId) {
        this.locationId = locationId;
    }
    @Basic
    @Column(name = "manufacturer", nullable = false)
    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }
    @Basic
    @Column(name = "model", nullable = false)
    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Vehicle(){

    }
    public Vehicle(Integer id, String manufacturer, String model, String registration, String description, Byte deleted, Integer companyId, Integer fuelTypeId, Integer locationId) {
        this.id = id;
        this.manufacturer = manufacturer;
        this.model = model;
        this.registration = registration;
        this.description = description;
        this.deleted = deleted;
        this.companyId = companyId;
        this.fuelTypeId = fuelTypeId;
        this.locationId = locationId;
    }
}
