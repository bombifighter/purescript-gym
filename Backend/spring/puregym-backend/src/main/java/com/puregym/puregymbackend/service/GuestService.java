package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.Guest;
import com.puregym.puregymbackend.error.GuestNotFoundExcepton;
import com.puregym.puregymbackend.repository.GuestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GuestService {

    @Autowired
    GuestRepository guestRepository;

    public List<Guest> getAllGuest() {
        return new ArrayList<>(guestRepository.findAll());
    }

    public List<Guest> getGuestById(Long Id) {
        Guest guest = guestRepository.findById(Id)
                .orElseThrow(() -> new GuestNotFoundExcepton(Id));
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
                .orElseThrow(() -> new GuestNotFoundExcepton(Id));
    }

    public void deleteGuest(Long Id) {
        guestRepository.deleteById(Id);
    }

}
