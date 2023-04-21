package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.ClubMember;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.ClubMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClubMemberService {

    @Autowired
    ClubMemberRepository clubMemberRepository;

    public List<ClubMember> findClubMembershipByGuestId(Long guestId) {
        return new ArrayList<>(clubMemberRepository.getClubMembershipsById(guestId));
    }

    public List<LastIdWrapper> getLastId() {
        return new ArrayList<>(clubMemberRepository.getLastId());
    }

    public void insertClubMember(ClubMember clubMember) {
        clubMemberRepository.save(clubMember);
    }
}
