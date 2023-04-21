package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ActiveGuest {

    private Long guestId;
    private String guestName;
    private String gender;
    private Long lockerId;
    private String startTime;
}
