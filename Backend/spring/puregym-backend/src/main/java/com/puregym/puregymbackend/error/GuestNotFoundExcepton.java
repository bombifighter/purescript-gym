package com.puregym.puregymbackend.error;

public class GuestNotFoundExcepton extends RuntimeException{

    public GuestNotFoundExcepton(Long Id) {
        super("Guest with '" + Id + "' ID not found");
    }
}
