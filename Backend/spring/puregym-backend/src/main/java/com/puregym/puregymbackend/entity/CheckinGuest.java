package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckinGuest {

    private Long guestId;
    private String gender;
    private String date;
    private String time;
}
