package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericHasCompanyIdAndDeletableController;
import com.telegroup_ltd.vehicle_management.model.Vehicle;
import com.telegroup_ltd.vehicle_management.model.modelCustom.VehicleLocation;
import com.telegroup_ltd.vehicle_management.repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Scope("request")
@RequestMapping("api/vehicle")
public class VehicleController extends GenericHasCompanyIdAndDeletableController<Vehicle, Integer> {

    private VehicleRepository repository;

    private final LocationController locationController;
    @Value(value = "${badRequest.registrationNotUnique}")
    private String registrationNotUnique;

    @Autowired
    public VehicleController(VehicleRepository repo, LocationController locationController) {
        super(repo);
        repository = repo;
        this.locationController = locationController;
    }

    @Override
    public List getAll() throws ForbiddenException {
        List<VehicleLocation> list=new ArrayList<>();
        Map<Integer,String> locationMap=new HashMap<>();
        super.getAll().forEach(vehicle -> {
            String location=locationMap.get(vehicle.getLocationId());
            if (location==null){
                try {
                    location=locationController.findById(vehicle.getLocationId()).getLabel();
                    locationMap.put(vehicle.getLocationId(),location);
                } catch (ForbiddenException e) {
                    e.printStackTrace();
                }
            }
            list.add(new VehicleLocation(vehicle,location));
        });
        return list;
    }

    @Override
    @Transactional
    public VehicleLocation insert(@RequestBody Vehicle object) throws BadRequestException, ForbiddenException {
        Vehicle sameName=repository.findByRegistrationAndDeleted(object.getRegistration(),(byte)0);
        if (sameName!=null)
            throw new BadRequestException(registrationNotUnique);
        Vehicle inserted= super.insert(object);
        String location=locationController.findById(inserted.getLocationId()).getLabel();
        return new VehicleLocation(inserted,location);
    }

    @RequestMapping("/byLocation/{id}")
    public List<Vehicle> getByLocation(@PathVariable Integer id){
        return repository.getAllByLocationIdAndCompanyIdAndDeletedIs(id,userBean.getUser().getCompanyId(),(byte)0);
    }
}
