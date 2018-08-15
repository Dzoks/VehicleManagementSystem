package com.telegroup_ltd.vehicle_management.common;


import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.session.UserBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

public class CommonController {

    @Autowired
    protected UserBean userBean;


    @ExceptionHandler(BadRequestException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public String handleException(BadRequestException e) {
        return e.getMessage();
    }

    @ExceptionHandler(ForbiddenException.class)
    @ResponseStatus(value = HttpStatus.FORBIDDEN)
    public String handleException(ForbiddenException e) {
        return e.getMessage();
    }
}
