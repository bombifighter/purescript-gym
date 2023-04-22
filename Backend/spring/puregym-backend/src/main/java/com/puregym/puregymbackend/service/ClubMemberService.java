package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.ClubMember;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.ClubMemberRepository;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Service
public class ClubMemberService {

    @Autowired
    ClubMemberRepository clubMemberRepository;

    @PersistenceContext
    EntityManager entityManager;

    public List<ClubMember> findClubMembershipByGuestId(Long guestId) {
        return new ArrayList<>(clubMemberRepository.getClubMembershipsById(guestId));
    }

    public List<LastIdWrapper> getLastId() {
        Query q = entityManager.createNativeQuery("SELECT ifnull(max(id),0) as lastId FROM clubmember", "LastIdWrapper");
        return (List<LastIdWrapper>) q.getResultList();
    }

    public void insertClubMember(ClubMember clubMember) {
        clubMemberRepository.save(clubMember);
    }
}
