package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.GuestLocker;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.GuestLockerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Service
public class GuestLockerService {

    @Autowired
    GuestLockerRepository guestLockerRepository;

    @PersistenceContext
    EntityManager entityManager;

    public List<GuestLocker> getHistory(String gender, Long id) {
        return new ArrayList<>(guestLockerRepository.getHistory(gender, id));
    }

    public List<LastIdWrapper> getLastGuestLockerId() {
        Query q = entityManager.createNativeQuery("SELECT ifnull(max(id),0) as lastId FROM guestlocker", "LastIdWrapper");
        return (List<LastIdWrapper>) q.getResultList();
    }

    public void insertGuestLocker(GuestLocker newGuestLocker) {
        guestLockerRepository.save(newGuestLocker);
    }

    public void endGuestLocker(String newEndTime, Long guestId, Long lockerId, String lockerGender) {
        guestLockerRepository.endGuestLocker(newEndTime, guestId, lockerId, lockerGender);
    }
}
