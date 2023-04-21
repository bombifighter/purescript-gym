package com.puregym.puregymbackend.service;

import com.puregym.puregymbackend.entity.MembershipType;
import com.puregym.puregymbackend.error.MembershipTypeNotFoundException;
import com.puregym.puregymbackend.repository.MembershipTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MembershipTypeService {

    @Autowired
    MembershipTypeRepository membershipTypeRepository;

    public List<MembershipType> getTypeById(Long Id) {
        MembershipType membershipType = membershipTypeRepository.findById(Id)
                .orElseThrow(() -> new MembershipTypeNotFoundException(Id));
        List<MembershipType> list = new ArrayList<>();
        list.add(membershipType);
        return list;
    }

    public List<MembershipType> getAllTypes() {
        return new ArrayList<>(membershipTypeRepository.findAll());
    }
}
