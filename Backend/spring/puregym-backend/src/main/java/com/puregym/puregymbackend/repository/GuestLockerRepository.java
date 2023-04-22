package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.GuestLocker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GuestLockerRepository extends JpaRepository<GuestLocker, Long> {

    @Query(value = "SELECT id, guestId, lockerId, lockerGender, startTime, endTime FROM guestlocker WHERE lockerGender = ?1 and lockerId = ?2 ORDER BY startTime desc", nativeQuery = true)
    List<GuestLocker> getHistory(String lockerGender, Long lockerId);
}
