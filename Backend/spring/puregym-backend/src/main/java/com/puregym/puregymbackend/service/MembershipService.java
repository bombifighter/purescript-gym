package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.entity.Membership;
import com.puregym.puregymbackend.entity.OccasionsLeftWrapper;
import com.puregym.puregymbackend.repository.MembershipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Service
public class MembershipService {

    @Autowired
    MembershipRepository membershipRepository;

    @PersistenceContext
    EntityManager entityManager;

    public List<Membership> findMembershipByGuestId(Long guestId) {
        return new ArrayList<>(membershipRepository.getMembershipsById(guestId));
    }

    public List<LastIdWrapper> getLastId() {
        Query q = entityManager.createNativeQuery("SELECT ifnull(max(id),0) as lastId FROM membership", "LastIdWrapper");
        return (List<LastIdWrapper>) q.getResultList();
    }

    public void insertMembership(Membership membership) {
        membershipRepository.save(membership);
    }

    public List<OccasionsLeftWrapper> getOccasionsLeft(Long guestId, String endDate) {
        Query q = entityManager.createNativeQuery("SELECT id, occasionsLeft FROM membership WHERE guestId = ?1 and endDate >= ?2 and not occasionsLeft = 0", "OccasionsLeftWrapper")
                .setParameter(1, guestId)
                .setParameter(2, endDate);
        return (List<OccasionsLeftWrapper>) q.getResultList();
    }

    public void setOccasions(Long occasionsLeft, Long id) {
        membershipRepository.setOccasions(occasionsLeft, id);
    }
}
