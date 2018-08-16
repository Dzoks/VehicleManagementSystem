package com.telegroup_ltd.vehicle_management.session;


import com.telegroup_ltd.vehicle_management.model.User;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
@Scope("session")
public class UserBean {

    private User user;
    private Boolean loggedIn;

    @PostConstruct
    void init() {
        user = new User();
        user.setId(1);
        user.setCompanyId(1);
        user.setRoleId(1);
        //Change when login made
        loggedIn = false;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getLoggedIn() {
        return loggedIn;
    }

    public void setLoggedIn(Boolean loggedIn) {
        this.loggedIn = loggedIn;
    }
}
