package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "locker")
public class Locker {

    @Id
    private Long id;

    @Column
    private String gender;

    @Column(name = "isFree")
    private String isFree;
}
