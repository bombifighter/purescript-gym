package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.Guest;
import com.puregym.puregymbackend.service.GuestService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GuestRepository extends JpaRepository<Guest, Long> {

    class ActiveGuest {
        Long guestId;
        String guestName;
        String gender;
        Long lockerId;
        String startTime;
    }

    class InactiveGuest {
        Long guestId;
        String guestName;
        String gender;
        String bdate;
    }

    @Query(value = "SELECT g.id as guestId, g.name as guestName, g.gender as gender, gl.lockerId as lockerId, gl.startTime as startTime FROM guest as g INNER JOIN guestlocker as gl ON g.id = gl.guestId WHERE gl.endTime = '0'", nativeQuery = true)
    List<ActiveGuest> getAllActive();

    @Query(value = "SELECT g.id as guestId, g.name as guestName, g.gender as gender, g.bdate as bdate FROM guest as g INNER JOIN membership as m ON g.id = m.guestId WHERE m.endDate >= ?1 AND NOT m.occasionsLeft = 0 AND NOT g.id IN (SELECT distinct guestId FROM guestlocker WHERE endTime = '0')", nativeQuery = true)
    List<InactiveGuest> getAllInactive(String date);
}
