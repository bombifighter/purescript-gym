package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "membership")
@SqlResultSetMapping(
        name = "OccasionsLeftWrapper",
        classes = {
                @ConstructorResult(
                        targetClass = OccasionsLeftWrapper.class,
                        columns = {
                                @ColumnResult(name="id", type = Long.class),
                                @ColumnResult(name="occasionsLeft", type = String.class)
                        }
                )
        }
)
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
