package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.*;
import com.puregym.puregymbackend.service.GuestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/guest")
public class GuestController {

    @Autowired
    GuestService guestService;

    @GetMapping(path = "/getAll")
    List<Guest> getGuests() {
        return guestService.getAllGuest();
    }

    @GetMapping(path = "/getById/{id}")
    List<Guest> getGuestById(@PathVariable Long id) {
        return guestService.getGuestById(id);
    }

    @PostMapping(path = "/insertGuest")
    @ResponseStatus(HttpStatus.CREATED)
    void addGuest(@RequestBody Guest newGuest) {
        guestService.insertGuest(newGuest);
    }

    @PutMapping("/updateGuest/{id}")
    void updateGuest(@PathVariable Long id, @RequestBody Guest updatedGuest) {
        guestService.updateGuest(id, updatedGuest);
    }

    @DeleteMapping("/deleteGuest/{id}")
    void deleteGuest(@PathVariable Long id) {
        guestService.deleteGuest(id);
    }

    @GetMapping(path = "/getActive")
    List<ActiveGuest> getActiveGuests() {
        return guestService.getActiveGuests();
    }

    @GetMapping(path = "/getInactive/{date}")
    List<InactiveGuest> getInactiveGuests(@PathVariable String date) {
        return guestService.getInactiveGuests(date);
    }

    @GetMapping(path = "/getLastId")
    List<LastIdWrapper> getLastGuestId() {
        return guestService.getLastGuestId();
    }

    @PostMapping(path = "/checkin")
    @ResponseStatus(HttpStatus.CREATED)
    void checkinGuest(@RequestBody CheckinGuest checkinGuest) {
        guestService.checkinGuest(checkinGuest);
    }

    @PostMapping(path = "/checkout")
    @ResponseStatus(HttpStatus.CREATED)
    void checkoutGuest(@RequestBody CheckoutGuest checkoutGuest) {
        guestService.checkoutGuest(checkoutGuest);
    }
}
