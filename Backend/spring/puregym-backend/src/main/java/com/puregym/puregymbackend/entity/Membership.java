package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "membership")
public class Membership {

    @Id
    private Long id;

    @Column(name = "guestId")
    private Long guestId;

    @Column(name = "membershipTypeId")
    private Long membershipTypeId;

    @Column(name = "endDate")
    private String endDate;

    @Column(name = "occasionsLeft")
    private Long occasionsLeft;
}
