package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.ClubMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClubMemberRepositroy extends JpaRepository<ClubMember, Long> {
}
