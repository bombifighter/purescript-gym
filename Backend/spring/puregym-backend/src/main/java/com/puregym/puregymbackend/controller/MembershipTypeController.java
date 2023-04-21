package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.MembershipType;
import com.puregym.puregymbackend.service.MembershipTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/membershipType")
public class MembershipTypeController {

    @Autowired
    MembershipTypeService membershipTypeService;

    @GetMapping(path = "/getMembershipById/{id}")
    List<MembershipType> getMembershipTypeById(@PathVariable Long id) {
        return membershipTypeService.getTypeById(id);
    }

    @GetMapping(path = "/getAll")
    List<MembershipType> getMembershipTypes() {
        return membershipTypeService.getAllTypes();
    }
}
