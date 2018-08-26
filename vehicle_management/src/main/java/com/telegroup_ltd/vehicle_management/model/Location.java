package com.telegroup_ltd.vehicle_management.model;

import com.telegroup_ltd.vehicle_management.common.interfaces.Deletable;
import com.telegroup_ltd.vehicle_management.common.interfaces.HasCompanyId;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class Location implements Deletable, HasCompanyId {
    private Integer id;
    private String label;
    private Double lat;
    private Double lng;
    private Integer companyId;
    private Byte deleted;

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
    @Column(name = "label", nullable = false, length = 64)
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Basic
    @Column(name = "lat", nullable = false, precision = 0)
    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    @Basic
    @Column(name = "lng", nullable = false, precision = 0)
    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
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
    @Column(name = "deleted", nullable = false,insertable = false)
    public Byte getDeleted() {
        return deleted;
    }

    public void setDeleted(Byte deleted) {
        this.deleted = deleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Location location = (Location) o;
        return Objects.equals(id, location.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Location{" +
                "id=" + id +
                ", name='" + label + '\'' +
                ", latitude=" + lng +
                ", longitude=" + lng +
                ", companyId=" + companyId +
                ", deleted=" + deleted +
                '}';
    }
}
