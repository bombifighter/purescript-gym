package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.*;
import com.puregym.puregymbackend.error.GuestNotFoundException;
import com.puregym.puregymbackend.repository.GuestRepository;
import com.puregym.puregymbackend.repository.MembershipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GuestService {

    @Autowired
    GuestRepository guestRepository;

    @Autowired
    LockerService lockerService;

    @Autowired
    GuestLockerService guestLockerService;

    @Autowired
    MembershipService membershipService;

    public List<Guest> getAllGuest() {
        return new ArrayList<>(guestRepository.findAll());
    }

    public List<Guest> getGuestById(Long Id) {
        Guest guest = guestRepository.findById(Id)
                .orElseThrow(() -> new GuestNotFoundException(Id));
        List<Guest> list = new ArrayList<>();
        list.add(guest);
        return list;
    }

    public void insertGuest(Guest newGuest) {
        guestRepository.save(newGuest);
    }

    public void updateGuest(Long Id, Guest modifiedGuest) {
        guestRepository.findById(Id)
                .map(x -> {
                    x.setGender(modifiedGuest.getGender());
                    x.setBdate(modifiedGuest.getBdate());
                    x.setName(modifiedGuest.getName());
                    x.setPhone(modifiedGuest.getPhone());
                    x.setEmail(modifiedGuest.getEmail());
                    return guestRepository.save(x);
                })
                .orElseThrow(() -> new GuestNotFoundException(Id));
    }

    public void deleteGuest(Long Id) {
        guestRepository.deleteById(Id);
    }

    public List<ActiveGuest> getActiveGuests(){
        return new ArrayList<>(guestRepository.getAllActive());
    }

    public List<InactiveGuest> getInactiveGuests(String date) {
        return new ArrayList<>(guestRepository.getAllInactive(date));
    }

    public List<LastIdWrapper> getLastGuestId() {
        return new ArrayList<>(guestRepository.getLastId());
    }

    public void checkinGuest(CheckinGuest checkinGuest) {
        Long freeLockerId = lockerService.getFreeGenderLocker(checkinGuest.getGender()).get(0).getId() + 1;
        Long newId = guestLockerService.getLastGuestLockerId().get(0).getId();
        String startTime = checkinGuest.getDate() + " " + checkinGuest.getTime();
        GuestLocker newGuestLocker = new GuestLocker(newId, checkinGuest.getGuestId(), freeLockerId, checkinGuest.getGender(), startTime, "0");
        guestLockerService.insertGuestLocker(newGuestLocker);
        lockerService.occupyLocker(freeLockerId, checkinGuest.getGender());
        OccasionsLeftWrapper occasionsLeft = membershipService.getOccasionsLeft(checkinGuest.getGuestId(), checkinGuest.getDate()).get(0);
        if (occasionsLeft.getOccasionsLeft() > 0) {
            membershipService.setOccasions(occasionsLeft.getOccasionsLeft() - 1, occasionsLeft.getId());
        }
    }

    public void checkoutGuest(CheckoutGuest checkoutGuest) {
        guestLockerService.endGuestLocker(checkoutGuest.getDateTime(), checkoutGuest.getGuestId(), checkoutGuest.getLockerId(), checkoutGuest.getGender());
        lockerService.freeupLocker(checkoutGuest.getLockerId(), checkoutGuest.getGender());
    }
}
