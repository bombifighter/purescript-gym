package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.Locker;
import com.puregym.puregymbackend.repository.LockerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LockerService {

    @Autowired
    LockerRepository lockerRepository;

    public List<Locker> getAllLockers() {
        return new ArrayList<>(lockerRepository.findAll());
    }

    public List<Locker> getLockerByIdAndGender(String gender, Long id) {
        return new ArrayList<>(lockerRepository.findByGenderAndId(gender, id));
    }

    public List<LockerRepository.LockerId> getFreeGenderLocker(String gender) {
        return new ArrayList<>(lockerRepository.getFreeGenderLocker(gender));
    }

    public void occupyLocker(Long id, String gender) {
        lockerRepository.occupyLocker(id, gender);
    }

    public void freeupLocker(Long id, String gender) {
        lockerRepository.freeupLocker(id, gender);
    }
}
