package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "guest")
public class Guest {

    @Id
    private Long id;

    @Column
    private String name;

    @Column
    private String gender;

    @Column
    private String bdate;

    @Column
    private String phone;

    @Column
    private String email;
}

