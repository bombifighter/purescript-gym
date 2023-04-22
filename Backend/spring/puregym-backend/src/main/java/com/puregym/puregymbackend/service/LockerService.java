package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.FreeLockerIdWrapper;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.entity.Locker;
import com.puregym.puregymbackend.repository.LockerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Service
public class LockerService {

    @Autowired
    LockerRepository lockerRepository;

    @PersistenceContext
    EntityManager entityManager;

    public List<Locker> getAllLockers() {
        return new ArrayList<>(lockerRepository.findAll());
    }

    public List<Locker> getLockerByIdAndGender(String gender, Long id) {
        return new ArrayList<>(lockerRepository.findByGenderAndId(gender, id));
    }

    public List<FreeLockerIdWrapper> getFreeGenderLocker(String gender) {
        Query q = entityManager.createNativeQuery("SELECT id FROM locker WHERE gender = ?1 AND isFree = 'true' LIMIT 1", "FreeLockerIdWrapper")
                .setParameter(1, gender);
        return (List<FreeLockerIdWrapper>) q.getResultList();
    }

    public void occupyLocker(Long id, String gender) {
        lockerRepository.occupyLocker(id, gender);
    }

    public void freeupLocker(Long id, String gender) {
        lockerRepository.freeupLocker(id, gender);
    }
}
