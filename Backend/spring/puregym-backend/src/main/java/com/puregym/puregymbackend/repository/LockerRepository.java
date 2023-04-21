package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.Locker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LockerRepository extends JpaRepository<Locker, Long> {
}
