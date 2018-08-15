package com.telegroup_ltd.vehicle_management.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "location_has_vehicle", schema = "vehicle_reservation", catalog = "")
@IdClass(LocationHasVehiclePK.class)
public class LocationHasVehicle {
    private Timestamp startDate;
    private Timestamp endDate;
    private Integer vehicleId;
    private Integer locationId;

    @Id
    @Column(name = "start_date", nullable = false)
    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    @Basic
    @Column(name = "end_date", nullable = true)
    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    @Id
    @Column(name = "vehicle_id", nullable = false)
    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    @Id
    @Column(name = "location_id", nullable = false)
    public Integer getLocationId() {
        return locationId;
    }

    public void setLocationId(Integer locationId) {
        this.locationId = locationId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LocationHasVehicle that = (LocationHasVehicle) o;
        return Objects.equals(startDate, that.startDate) &&
                Objects.equals(vehicleId, that.vehicleId) &&
                Objects.equals(locationId, that.locationId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(startDate, vehicleId, locationId);
    }
}
