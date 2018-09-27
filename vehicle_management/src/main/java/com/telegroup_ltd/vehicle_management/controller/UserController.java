package com.telegroup_ltd.vehicle_management.controller;


import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdController;
import com.telegroup_ltd.vehicle_management.model.LoginInfo;
import com.telegroup_ltd.vehicle_management.model.User;
import com.telegroup_ltd.vehicle_management.model.modelCustom.UserLocation;
import com.telegroup_ltd.vehicle_management.repository.LocationRepository;
import com.telegroup_ltd.vehicle_management.repository.UserRepository;
import com.telegroup_ltd.vehicle_management.util.Notification;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("api/user")
@Scope("request")
public class UserController extends GenericHasCompanyIdController<User, Integer> {

    private UserRepository repository;
    private final Notification notification;

    @Value(value = "${status.active}")
    private Integer statusActive;
    @Value(value = "${status.on_hold}")
    private Integer statusOnHold;
    @Value(value = "${status.inactive}")
    private Integer statusInactive;
    @Value(value = "${role.system_admin}")
    private Integer roleSystemAdministrator;
    @Value(value = "${notification.all}")
    private Integer notificationAll;
    @Value(value = "${badRequest.delete}")
    private String badRequestDelete;

    private final LocationController locationController;

    @Autowired
    public UserController(UserRepository repo, Notification notification, LocationController locationController) {
        super(repo);
        repository = repo;
        this.notification = notification;
        this.locationController = locationController;
    }

    @Override
    public List getAll() throws ForbiddenException {
        return repository.getAllExtendedByCompanyIdAndStatusIdNot(userBean.getUser().getCompanyId(),statusInactive);
    }


    @Transactional
    @Override
    public UserLocation insert(@RequestBody User object) throws BadRequestException, ForbiddenException {

        if (!roleSystemAdministrator.equals(object.getRoleId()))
            object.setNotificationTypeId(notificationAll);
        for(User sameEmailUser:repository.getAllByEmail(object.getEmail())){
            if (bothNullOrEqual(object.getCompanyId(),sameEmailUser.getCompanyId())&&!sameEmailUser.getStatusId().equals(statusInactive))
                throw new BadRequestException("E-mail već postoji!");
        }
        object.setToken(RandomStringUtils.randomAlphanumeric(64));
        notification.sendInvite(object.getEmail(),object.getToken());
        User user=super.insert(object);
        String locationName=locationController.findById(user.getLocationId()).getLabel();
        return new UserLocation(user,locationName);

    }

    @RequestMapping("byCompany/{companyId}")
    public List getByCompanyId(@PathVariable Integer companyId) throws ForbiddenException {
        if (!userBean.getUser().getRoleId().equals(roleSystemAdministrator) && !companyId.equals(userBean.getUser().getCompanyId()))
            throw new ForbiddenException("Forbidden");
        return repository.getAllExtendedByCompanyIdAndStatusIdNot(companyId.equals(0) ? null : companyId, statusInactive);
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
        User user = repository.login(userInformation.getUsername(), userInformation.getPassword(), userInformation.getCompanyName());
        if (user != null) {
            userBean.setLoggedIn(true);
            userBean.setUser(user);
            return user;
        }
        throw new ForbiddenException("Forbidden");
    }

    @Override
    public String delete(@PathVariable Integer id) throws BadRequestException, ForbiddenException {
        User object = findById(id);
        if (object == null)
            throw new BadRequestException(badRequestDelete);
        object.setToken(null);
        object.setStatusId(statusInactive);
        logDeleteAction(object);
        return "Success";
    }


    @RequestMapping(value = "/check/{token}",method = RequestMethod.GET)
    public Integer checkToken(@PathVariable String token) throws ForbiddenException {
        User user=repository.getByToken(token);
        if (user==null || user.getRegistrationDate().toLocalDateTime().plusDays(1).isBefore(LocalDateTime.now()))
            throw new ForbiddenException("Forbidden");
        return user.getId();
    }

    @Transactional
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String register(@RequestBody User user) throws ForbiddenException, BadRequestException {
        User realUser=repository.findById(user.getId()).orElse(null);
        if (realUser==null)
            throw new ForbiddenException("Forbidden!");
        if (realUser.getRegistrationDate().toLocalDateTime().plusDays(1).isBefore(LocalDateTime.now()))
            throw new ForbiddenException("Token je istekao");
        for(User sameUsernameUser:repository.getAllByUsername(user.getUsername())){
            if (bothNullOrEqual(realUser.getCompanyId(),sameUsernameUser.getCompanyId())&&!sameUsernameUser.getStatusId().equals(statusInactive))
                throw new BadRequestException("Korisničko ime već postoji!");
        }
        realUser.setFirstName(user.getFirstName());
        realUser.setLastName(user.getLastName());
        realUser.setUsername(user.getUsername());
        realUser.setPassword(hashPassword(user.getPassword()));
        realUser.setToken(null);
        realUser.setStatusId(statusActive);
        return "Success";
    }

    private boolean bothNullOrEqual(Object first,Object second){
        if (first==null && second ==null)
            return true;
        if (first!=null && first.equals(second))
            return true;
        return false;
    }

    private String hashPassword( String plainText)  {
        MessageDigest digest= null;
        try {
            digest = MessageDigest.getInstance("SHA-512");
            return Hex.encodeHexString(digest.digest(plainText.getBytes()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }

    }


}
