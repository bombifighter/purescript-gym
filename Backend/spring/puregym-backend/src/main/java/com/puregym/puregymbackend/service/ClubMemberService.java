package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.ClubMember;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.ClubMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Service
public class ClubMemberService {

    @Autowired
    ClubMemberRepository clubMemberRepository;

    public List<ClubMember> findClubMembershipByGuestId(Long guestId) {
        return new ArrayList<>(clubMemberRepository.getClubMembershipsById(guestId));
    }

    public List<LastIdWrapper> getLastId(EntityManager entityManager) {
        String queryString = "SELECT ifnull(max(id),0) as lastId FROM clubmember";
        Query query = entityManager.createNativeQuery(queryString);
        List<LastIdWrapper> list = new ArrayList<>();
        LastIdWrapper lastId = new LastIdWrapper((Object[]) query.getSingleResult());
        list.add(lastId);
        return list;
        //return new ArrayList<>(clubMemberRepository.getLastId());
    }

    public void insertClubMember(ClubMember clubMember) {
        clubMemberRepository.save(clubMember);
    }
}
