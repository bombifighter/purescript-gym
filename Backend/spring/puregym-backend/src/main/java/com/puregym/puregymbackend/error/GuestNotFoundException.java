package com.puregym.puregymbackend.error;

public class GuestNotFoundException extends RuntimeException{

    public GuestNotFoundException(Long Id) {
        super("Guest with '" + Id + "' ID not found");
    }
}
