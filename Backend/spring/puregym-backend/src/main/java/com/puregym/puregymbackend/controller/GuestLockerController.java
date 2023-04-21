package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.GuestLocker;
import com.puregym.puregymbackend.entity.Locker;
import com.puregym.puregymbackend.service.GuestLockerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/guestLocker")
public class GuestLockerController {

    @Autowired
    GuestLockerService guestLockerService;

    @GetMapping(path = "/getHistory/{gender}/{id}")
    List<GuestLocker> getGuestLockerHistory(@PathVariable String gender, @PathVariable Long id) {
        return guestLockerService.getHistory(gender, id);
    }
}
