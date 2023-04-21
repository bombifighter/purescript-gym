package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.GuestLocker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GuestLockerRepository extends JpaRepository<GuestLocker, Long> {

    class GuestLockerId {
        Long id;

        public Long getId() {
            return id;
        }
    }

    @Query(value = "SELECT id, guestId, lockerId, lockerGender, startTime, endTime FROM guestlocker WHERE lockerGender = ?1 and lockerId = ?1 ORDER BY startTime desc", nativeQuery = true)
    List<GuestLocker> getHistory(String gender, Long id);

    @Query(value = "SELECT ifnull(max(id),0) as id FROM guestlocker", nativeQuery = true)
    List<GuestLockerId> getLastGuestLocker();

    @Query(value = "UPDATE guestlocker SET endTime = ?1 WHERE guestId = ?2 and lockerId = ?3 and lockerGender = ?4 and endTime = '0'", nativeQuery = true)
    void endGuestLocker(String newEndTime, Long guestId, Long lockerId, String lockerGender);
}
