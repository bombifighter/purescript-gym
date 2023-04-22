package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "membershiptype")
public class MembershipType {

    @Id
    private Long id;

    @Column
    private String name;

    @Column(name = "isPass")
    private String isPass;

    @Column
    private Long occasions;

    @Column(name = "fullPrice")
    private Long fullPrice;

    @Column(name = "studentPrice")
    private Long studentPrice;

    @Column(name = "clubPrice")
    private Long clubPrice;
}
