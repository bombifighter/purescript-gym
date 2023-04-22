package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.Locker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LockerRepository extends JpaRepository<Locker, Long> {

    @Query(value = "SELECT id, gender, isFree FROM locker", nativeQuery = true)
    List<Locker> getAll();

    @Query(value = "SELECT id, gender, isFree FROM locker WHERE gender = ?1 and id = ?2", nativeQuery = true)
    List<Locker> findByGenderAndId(String gender, Long id);
}
