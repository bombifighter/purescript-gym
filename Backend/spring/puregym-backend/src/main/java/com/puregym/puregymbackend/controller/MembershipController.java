package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.entity.Membership;
import com.puregym.puregymbackend.repository.MembershipRepository;
import com.puregym.puregymbackend.service.MembershipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/membership")
public class MembershipController {

    @Autowired
    MembershipService membershipService;

    @GetMapping(path = "/findMembershipsById/{id}")
    List<Membership> getMembershipsById(@PathVariable Long id) {
        return membershipService.findMembershipByGuestId(id);
    }

    @GetMapping(path = "/getLastId")
    List<LastIdWrapper> getLastMembershipId() {
        return membershipService.getLastId();
    }

    @PostMapping(path = "/insertMembership")
    @ResponseStatus(HttpStatus.CREATED)
    void addMembership(@RequestBody Membership newMembership) {
        membershipService.insertMembership(newMembership);
    }
}
