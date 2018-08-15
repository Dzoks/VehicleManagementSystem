package com.telegroup_ltd.vehicle_management.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;

public class LocationHasVehiclePK implements Serializable {
    private Timestamp startDate;
    private Integer vehicleId;
    private Integer locationId;

    @Column(name = "start_date", nullable = false)
    @Id
    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    @Column(name = "vehicle_id", nullable = false)
    @Id
    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    @Column(name = "location_id", nullable = false)
    @Id
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
        LocationHasVehiclePK that = (LocationHasVehiclePK) o;
        return Objects.equals(startDate, that.startDate) &&
                Objects.equals(vehicleId, that.vehicleId) &&
                Objects.equals(locationId, that.locationId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(startDate, vehicleId, locationId);
    }
}
