package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "membershiptype")
public class MembershipType {

    @Id
    private Long id;

    @Column
    private String name;

    @Column
    private String isPass;

    @Column
    private Long occasions;

    @Column
    private Long fullPrice;

    @Column
    private Long studentPrice;

    @Column
    private Long clubPrice;
}
