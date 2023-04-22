package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.Locker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LockerRepository extends JpaRepository<Locker, Long> {

    @Query(value = "SELECT id, gender, isFree FROM locker WHERE gender = ?1 and id = ?2", nativeQuery = true)
    List<Locker> findByGenderAndId(String gender, Long id);

    @Query(value = "UPDATE locker SET isFree = 'false' WHERE id = ?1 AND gender = ?2", nativeQuery = true)
    void occupyLocker(Long id, String gender);

    @Query(value = "UPDATE locker SET isFree = 'true' WHERE id = ?1 AND gender = ?2", nativeQuery = true)
    void freeupLocker(Long id, String gender);
}
