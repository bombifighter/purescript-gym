package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class InactiveGuest {

    private Long guestId;
    private String guestName;
    private String gender;
    private String bdate;
}
