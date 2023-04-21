package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "clubmember")
public class ClubMember {

    @Id
    private Long id;

    @Column
    private Long guestId;

    @Column
    private String endDate;
}
