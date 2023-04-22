package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.Membership;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MembershipRepository extends JpaRepository<Membership, Long> {

    @Query(value = "SELECT id, guestId, membershipTypeId, endDate, occasionsLeft FROM membership WHERE guestId = ?1", nativeQuery = true)
    List<Membership> getMembershipsById(Long guestId);
}
