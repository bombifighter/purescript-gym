package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.ClubMember;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.ClubMemberRepository;
import com.puregym.puregymbackend.service.ClubMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/clubmember")
public class ClubMemberController {

    @Autowired
    ClubMemberService clubMemberService;

    @PersistenceContext
    private EntityManager entityManager;

    @GetMapping(path = "/findMembershipsById/{id}")
    List<ClubMember> getMembershipsById(@PathVariable Long id) {
        return clubMemberService.findClubMembershipByGuestId(id);
    }

    @GetMapping(path = "/getLastId")
    List<LastIdWrapper> getLastClubMemberId() {
        return clubMemberService.getLastId(entityManager);
    }

    @PostMapping(path = "/insertClubMember")
    @ResponseStatus(HttpStatus.CREATED)
    void addClubMember(@RequestBody ClubMember newClubMember) {
        clubMemberService.insertClubMember(newClubMember);
    }
}
