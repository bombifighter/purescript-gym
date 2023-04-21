package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CheckinGuest {

    private Long guestId;
    private String gender;
    private String date;
    private String time;
}
