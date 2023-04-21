package com.puregym.puregymbackend.controller;

import com.puregym.puregymbackend.entity.Locker;
import com.puregym.puregymbackend.service.LockerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/locker")
public class LockerController {

    @Autowired
    LockerService lockerService;

    @GetMapping(path = "/getAll")
    List<Locker> getLockers() {
        return lockerService.getAllLockers();
    }

    @GetMapping(path = "/get/{gender}/{id}")
    List<Locker> getGuestById(@PathVariable String gender, @PathVariable Long id) {
        return lockerService.getLockerByIdAndGender(gender, id);
    }
}
