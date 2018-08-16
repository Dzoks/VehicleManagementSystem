package com.telegroup_ltd.vehicle_management.model.modelCustom;

import com.telegroup_ltd.vehicle_management.model.Logger;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.MappedSuperclass;
import javax.persistence.SqlResultSetMapping;
import java.io.Serializable;
import java.util.Date;
import java.sql.Timestamp;

@SqlResultSetMapping(
        name = "LoggerMapping",
        classes = @ConstructorResult(
                targetClass = LoggerCompanyUserRole.class,
                columns = {
                        @ColumnResult(name = "id",type=Integer.class),
                        @ColumnResult(name = "action_type",type=String.class),
                        @ColumnResult(name = "action_details",type=String.class),
                        @ColumnResult(name = "table_name",type=String.class),
                        @ColumnResult(name = "created",type=Date.class),
                        @ColumnResult(name = "atomic",type = Byte.class),
                        @ColumnResult(name = "user_id",type=Integer.class),
                        @ColumnResult(name = "company_id",type=Integer.class),
                        @ColumnResult(name="company_name",type=String.class),
                        @ColumnResult(name = "username",type=String.class),
                        @ColumnResult(name="role",type=String.class)

                }
        )
)


@MappedSuperclass
public class LoggerCompanyUserRole extends Logger implements Serializable {

    private String companyName;
    private String username;
    private String role;

    public LoggerCompanyUserRole(){
    }

    public LoggerCompanyUserRole(Integer id, String actionType, String actionDetails, String tableName, Date created, Byte atomic, Integer userId, Integer companyId, String companyName, String username, String role) {
        super(id, actionType, actionDetails, tableName, created, atomic, userId, companyId);
        this.companyName = companyName;
        this.username = username;
        this.role = role;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
