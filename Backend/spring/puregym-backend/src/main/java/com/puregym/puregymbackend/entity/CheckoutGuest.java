package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CheckoutGuest {

    private Long guestId;
    private String gender;
    private Long lockerId;
    private String dateTime;
}
