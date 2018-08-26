package com.telegroup_ltd.vehicle_management.model.modelCustom;

import com.telegroup_ltd.vehicle_management.model.User;
import org.hibernate.annotations.ColumnTransformer;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.MappedSuperclass;
import javax.persistence.SqlResultSetMapping;
import java.sql.Timestamp;
import java.util.Date;

@SqlResultSetMapping(
        name = "UserLocationMapping",
        classes = @ConstructorResult(
                targetClass = UserLocation.class,
                columns = {
                        @ColumnResult(name = "id", type = Integer.class),
                        @ColumnResult(name = "username", type = String.class),
                        @ColumnResult(name = "first_name", type = String.class),
                        @ColumnResult(name = "last_name", type = String.class),
                        @ColumnResult(name = "registration_date", type = Date.class),
                        @ColumnResult(name = "email", type = String.class),
                        @ColumnResult(name = "role_id", type = Integer.class),
                        @ColumnResult(name = "status_id", type = Integer.class),
                        @ColumnResult(name = "company_id", type = Integer.class),
                        @ColumnResult(name = "notification_type_id", type = Integer.class),
                        @ColumnResult(name = "location_id", type = Integer.class),
                        @ColumnResult(name = "location_name",type = String.class)
                }
        )
)

@MappedSuperclass
public class UserLocation extends User {
    private String locationName;

    public UserLocation(){
        super();
    }

    public UserLocation(Integer id, String username, String firstName, String lastName, Date registrationDate, String email, Integer roleId, Integer statusId, Integer companyId, Integer notificationTypeId, Integer locationId, String locationName) {
        super(id, username, firstName, lastName, registrationDate, email, roleId, statusId, companyId, notificationTypeId, locationId);
        this.locationName = locationName;
    }

    public UserLocation(User user,String locationName){

        super(user.getId(),user.getUsername(),user.getFirstName(), user.getLastName(),
                null,user.getEmail(),user.getRoleId(),user.getStatusId(),user.getCompanyId(),
                user.getNotificationTypeId(),user.getLocationId());
        user.setRegistrationDate(user.getRegistrationDate() == null ? null : new Timestamp(user.getRegistrationDate().getTime()));
        this.locationName=locationName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }
}
