package com.telegroup_ltd.vehicle_management.model.modelCustom;

import com.telegroup_ltd.vehicle_management.model.Vehicle;



public class VehicleLocation extends Vehicle {

    private String locationName;

    public  VehicleLocation(){
        super();
    }

    public VehicleLocation(Integer id, String manufacturer, String model, String name, String registration, String description, Byte deleted, Integer companyId, Integer fuelTypeId, Integer locationId, String locationName) {
        super(id, manufacturer, model, name, registration, description, deleted, companyId, fuelTypeId, locationId);
        this.locationName = locationName;
    }

    public VehicleLocation(Vehicle vehicle,String locationName){
        super(vehicle.getId(),vehicle.getManufacturer(),vehicle.getModel(),vehicle.getName(),vehicle.getRegistration(),
                vehicle.getDescription(),vehicle.getDeleted(),vehicle.getCompanyId(),vehicle.getFuelTypeId(),vehicle.getLocationId());
        this.locationName=locationName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }
}
