package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "guestlocker")
public class GuestLocker {

    @Id
    private Long id;

    @Column
    private Long guestId;

    @Column
    private Long lockerId;

    @Column
    private String lockerGender;

    @Column
    private String startTime;

    @Column
    private String endTime;
}
