package com.telegroup_ltd.vehicle_management.common.exception;

public class BadRequestException extends Exception {
    private static final long serialVersionUID = -1300922631131923484L;

    public BadRequestException(String message) {
        super(message);
    }
}
