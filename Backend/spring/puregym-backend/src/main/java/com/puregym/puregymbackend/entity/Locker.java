package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "locker")
@SqlResultSetMapping(
        name = "FreeLockerIdWrapper",
        classes = {
                @ConstructorResult(
                        targetClass = FreeLockerIdWrapper.class,
                        columns = {
                                @ColumnResult(name="id", type = Long.class)
                        }
                )
        }
)
public class Locker {

    @Id
    private Long id;

    @Column
    private String gender;

    @Column(name = "isFree")
    private String isFree;
}
