package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.GuestLocker;
import com.puregym.puregymbackend.repository.GuestLockerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GuestLockerService {

    @Autowired
    GuestLockerRepository guestLockerRepository;

    public List<GuestLocker> getHistory(String gender, Long id) {
        return new ArrayList<>(guestLockerRepository.getHistory(gender, id));
    }

    public List<GuestLockerRepository.GuestLockerId> getLastGuestLockerId() {
        return new ArrayList<>(guestLockerRepository.getLastGuestLocker());
    }

    public void insertGuestLocker(GuestLocker newGuestLocker) {
        guestLockerRepository.save(newGuestLocker);
    }

    public void endGuestLocker(String newEndTime, Long guestId, Long lockerId, String lockerGender) {
        guestLockerRepository.endGuestLocker(newEndTime, guestId, lockerId, lockerGender);
    }
}
