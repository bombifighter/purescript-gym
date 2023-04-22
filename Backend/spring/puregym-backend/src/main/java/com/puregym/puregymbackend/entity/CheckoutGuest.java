package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckoutGuest {

    private Long guestId;
    private String gender;
    private Long lockerId;
    private String dateTime;
}
