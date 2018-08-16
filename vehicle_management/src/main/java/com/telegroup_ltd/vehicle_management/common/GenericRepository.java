package com.telegroup_ltd.vehicle_management.common;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class GenericRepository {

    @PersistenceContext
    protected EntityManager entityManager;
}
