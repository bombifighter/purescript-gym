package com.puregym.puregymbackend.repository;

import com.puregym.puregymbackend.entity.MembershipType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MembershipTypeRepository extends JpaRepository<MembershipType, Long> {
}
