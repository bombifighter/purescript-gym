package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.ClubMember;
import com.puregym.puregymbackend.entity.LastIdWrapper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClubMemberRepository extends JpaRepository<ClubMember, Long> {

    @Query(value = "SELECT id, guestId, endDate FROM clubmember WHERE guestId = ?1", nativeQuery = true)
    List<ClubMember> getClubMembershipsById(Long guestId);

    //@Query(value = "SELECT ifnull(max(id),0) as lastId FROM clubmember", nativeQuery = true)
    //List<LastIdWrapper> getLastId();
}
