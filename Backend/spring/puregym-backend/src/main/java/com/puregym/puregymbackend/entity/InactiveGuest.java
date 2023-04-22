package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InactiveGuest {

    private Long guestId;
    private String guestName;
    private String gender;
    private String bdate;
}
