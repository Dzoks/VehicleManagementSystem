package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.exception.BadRequestException;
import com.telegroup_ltd.vehicle_management.common.exception.ForbiddenException;
import com.telegroup_ltd.vehicle_management.controller.genericController.GenericController;
import com.telegroup_ltd.vehicle_management.model.Company;
import com.telegroup_ltd.vehicle_management.repository.CompanyRepository;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("api/company")
@Scope("request")
public class CompanyController extends GenericController<Company, Integer> {


    private CompanyRepository companyRepository;

    public CompanyController(CompanyRepository repo) {
        super(repo);
        this.companyRepository = repo;
    }

    @Override
    public List<Company> getAll() throws ForbiddenException {
        return companyRepository.getAllByDeletedIs((byte)0);
    }

    @Override
    public String delete(@PathVariable Integer id) throws BadRequestException, ForbiddenException {
        Company company=companyRepository.findById(id).orElse(null);
        if (company==null)
            throw new BadRequestException("Bad Request");
        company.setDeleted((byte)1);
        logDeleteAction(company);
        return "Success";
    }
}
