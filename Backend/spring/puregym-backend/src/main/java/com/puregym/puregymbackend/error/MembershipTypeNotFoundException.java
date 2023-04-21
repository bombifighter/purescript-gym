package com.puregym.puregymbackend.error;

public class MembershipTypeNotFoundException extends RuntimeException{

    public MembershipTypeNotFoundException(Long Id) {
        super("MembershipType with '" + Id + "' ID not found");
    }
}
