package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.entity.Membership;
import com.puregym.puregymbackend.entity.OccasionsLeftWrapper;
import com.puregym.puregymbackend.repository.MembershipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MembershipService {

    @Autowired
    MembershipRepository membershipRepository;

    public List<Membership> findMembershipByGuestId(Long guestId) {
        return new ArrayList<>(membershipRepository.getMembershipsById(guestId));
    }

    public List<LastIdWrapper> getLastId() {
        return new ArrayList<>(membershipRepository.getLastId());
    }

    public void insertMembership(Membership membership) {
        membershipRepository.save(membership);
    }

    public List<OccasionsLeftWrapper> getOccasionsLeft(Long guestId, String endDate) {
        return new ArrayList<>(membershipRepository.getOccasionsLeft(guestId, endDate));
    }

    public void setOccasions(Long occasionsLeft, Long id) {
        membershipRepository.setOccasions(occasionsLeft, id);
    }
}
