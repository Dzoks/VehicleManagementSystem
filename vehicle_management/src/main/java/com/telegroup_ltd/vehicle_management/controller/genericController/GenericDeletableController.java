package com.telegroup_ltd.vehicle_management.controller.genericController;

import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.common.interfaces.Deletable;
import com.telegroup_ltd.vehicle_management.common.interfaces.DeletableRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.Serializable;
import java.util.List;

public abstract class GenericDeletableController<T extends Deletable, ID extends Serializable> extends GenericController<T, ID> {

    private DeletableRepository<T> repo;
    @Value("${badRequest.update}")
    private String badRequestUpdate;

    @Value("${badRequest.delete}")
    private String badRequestDelete;


    public GenericDeletableController(JpaRepository<T, ID> repo) {
        super(repo);
        if (repo instanceof DeletableRepository)
            this.repo = (DeletableRepository) repo;
        else throw new RuntimeException("Repository must implement " + DeletableRepository.class.getSimpleName());
    }

    @Override
    public List<T> getAll() throws ForbiddenException {
        return repo.getAllByDeletedIs((byte) 0);
    }

    @Override
    public T findById(@PathVariable ID id) throws ForbiddenException {
        T object = super.findById(id);
        if (object == null || object.getDeleted().equals((byte) 1))
            object = null;
        return object;
    }

    @Override
    public String update(@PathVariable ID id, @RequestBody T object) throws BadRequestException, ForbiddenException {
        if (findById(id) == null)
            throw new BadRequestException(badRequestUpdate);
        return super.update(id, object);
    }


    @Override
    public String delete(@PathVariable ID id) throws BadRequestException, ForbiddenException {
        T object = findById(id);
        if (object == null)
            throw new BadRequestException(badRequestDelete);
        object.setDeleted((byte) 1);
        logDeleteAction(object);
        return "Success";
    }
}
