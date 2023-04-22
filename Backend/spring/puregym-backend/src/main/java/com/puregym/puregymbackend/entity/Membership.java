package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "membership")
@SqlResultSetMapping(
        name = "OccasionsLeftWrapper",
        classes = {
                @ConstructorResult(
                        targetClass = OccasionsLeftWrapper.class,
                        columns = {
                                @ColumnResult(name="id", type = Long.class),
                                @ColumnResult(name="occasionsLeft", type = Long.class)
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
