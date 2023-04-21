package com.puregym.puregymbackend.entity;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@AllArgsConstructor
@Entity
@Table(name = "guestlocker")
public class GuestLocker {

    @Id
    private Long id;

    @Column(name = "guestId")
    private Long guestId;

    @Column(name = "lockerId")
    private Long lockerId;

    @Column(name = "lockerGender")
    private String lockerGender;

    @Column(name = "startTime")
    private String startTime;

    @Column(name = "endTime")
    private String endTime;
}
