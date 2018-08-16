package com.telegroup_ltd.vehicle_management.controller;


import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericController;
import com.telegroup_ltd.vehicle_management.model.LoginInfo;
import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("user")
@Scope("request")
public class UserController extends GenericController<User,Integer> {

    private UserRepository repository;

    @Value(value = "${role.system_admin}")
    private Integer roleSystemAdmin;

    public UserController(UserRepository repo) {
        super(repo);
        repository=repo;
    }

    @Override
    public List<User> getAll() throws  ForbiddenException {
        throw new ForbiddenException("Forbidden");
    }

    @RequestMapping("/{companyId}/{roleId}")
    public List<User> getByCompanyIdAndRoleId(@PathVariable Integer companyId,@PathVariable Integer roleId) throws ForbiddenException{
        if (!userBean.getUser().getRoleId().equals(roleSystemAdmin) && roleId.equals(roleSystemAdmin))
            throw new ForbiddenException("Forbidden");
        return repository.getAllByCompanyIdAndRoleId(companyId.equals(0)?null:companyId,roleId);
    }

    @RequestMapping(value = {"/state"})
    public User checkState() throws ForbiddenException {
        if (userBean.getLoggedIn())
            return userBean.getUser();
        throw new ForbiddenException("Forbidden");
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null)
            session.invalidate();
        return "Success";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public User login(@RequestBody LoginInfo userInformation) throws ForbiddenException {
        User user = repository.login(userInformation.getUsername(),userInformation.getPassword(),userInformation.getCompanyName());
        if (user!=null){
            userBean.setLoggedIn(true);
            userBean.setUser(user);
            return user;
        }
        throw new ForbiddenException("Forbidden");
    }

}
