package com.telegroup_ltd.vehicle_management.model;

import com.telegroup_ltd.vehicle_management.common.interfaces.Deletable;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class Company implements Deletable {
    private Integer id;
    private String name;
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
    @Column(name = "name", nullable = false, length = 64)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "deleted", nullable = false, insertable = false)
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
        Company company = (Company) o;
        return Objects.equals(id, company.id);
    }

    @Override
    public String toString() {
        return "Company{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", deleted=" + deleted +
                '}';
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
