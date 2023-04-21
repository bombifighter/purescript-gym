package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.LastIdWrapper;
import com.puregym.puregymbackend.entity.Membership;
import com.puregym.puregymbackend.entity.OccasionsLeftWrapper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MembershipRepository extends JpaRepository<Membership, Long> {

    @Query(value = "SELECT id, guestId, membershipTypeId, endDate, occasionsLeft FROM membership WHERE guestId = ?1", nativeQuery = true)
    List<Membership> getMembershipsById(Long guestId);

    @Query(value = "SELECT ifnull(max(id),0) as lastId FROM membership", nativeQuery = true)
    List<LastIdWrapper> getLastId();

    @Query(value = "SELECT id, occasionsLeft FROM membership WHERE guestId = ?1 and endDate >= ?2 and not occasionsLeft = 0", nativeQuery = true)
    List<OccasionsLeftWrapper> getOccasionsLeft(Long guestId, String endDate);

    @Query(value = "UPDATE membership SET occasionsLeft = ?1 where id = ?2", nativeQuery = true)
    void setOccasions(Long newOccasions, Long id);
}
