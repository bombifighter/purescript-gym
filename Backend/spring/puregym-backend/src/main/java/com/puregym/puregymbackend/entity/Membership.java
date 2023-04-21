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

    @Column
    private Long guestId;

    @Column
    private Long membershipTypeId;

    @Column
    private String endDate;

    @Column
    private Long occasionsLeft;
}
