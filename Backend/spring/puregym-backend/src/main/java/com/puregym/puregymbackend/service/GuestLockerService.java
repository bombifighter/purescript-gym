package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.GuestLocker;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.repository.GuestLockerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Transactional
    public void endGuestLocker(String newEndTime, Long guestId, Long lockerId, String lockerGender) {
        Query q = entityManager.createNativeQuery("UPDATE guestlocker SET endTime = ?1 WHERE guestId = ?2 and lockerId = ?3 and lockerGender = ?4 and endTime = '0'")
                .setParameter(1, newEndTime)
                .setParameter(2, guestId)
                .setParameter(3, lockerId)
                .setParameter(4, lockerGender);
        q.executeUpdate();
    }

    @Transactional
    public void deleteGuestLockerByGuestId(Long guestId) {
        Query q = entityManager.createNativeQuery("DELETE FROM guestlocker WHERE guestId = ?1")
                .setParameter(1, guestId);
        q.executeUpdate();
    }
}
