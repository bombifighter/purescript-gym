package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.ActiveGuest;
import com.puregym.puregymbackend.entity.Guest;
import com.puregym.puregymbackend.entity.InactiveGuest;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.Entity;
import java.util.List;

@Repository
public interface GuestRepository extends JpaRepository<Guest, Long> {

    @Query(value = "SELECT g.id as guestId, g.name as guestName, g.gender as gender, gl.lockerId as lockerId, gl.startTime as startTime FROM guest as g INNER JOIN guestlocker as gl ON g.id = gl.guestId WHERE gl.endTime = '0'", nativeQuery = true)
    List<ActiveGuest> getAllActive();

    @Query(value = "SELECT g.id as guestId, g.name as guestName, g.gender as gender, g.bdate as bdate FROM guest as g INNER JOIN membership as m ON g.id = m.guestId WHERE m.endDate >= ?1 AND NOT m.occasionsLeft = 0 AND NOT g.id IN (SELECT distinct guestId FROM guestlocker WHERE endTime = '0')", nativeQuery = true)
    List<InactiveGuest> getAllInactive(String date);

    @Query(value = "SELECT ifnull(max(id),0) as lastId FROM guest", nativeQuery = true)
    List<LastIdWrapper> getLastId();
}
