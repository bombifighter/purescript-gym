package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.GuestLocker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GuestLockerRepository extends JpaRepository<GuestLocker, Long> {
}
