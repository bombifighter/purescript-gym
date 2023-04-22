package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "clubmember")
@SqlResultSetMapping(
        name = "LastIdWrapper",
        classes = {
                @ConstructorResult(
                        targetClass = LastIdWrapper.class,
                        columns = {
                                @ColumnResult(name="lastId", type = Long.class)
                        }
                )
        }
)
public class ClubMember {

    @Id
    private Long id;

    @Column(name = "guestId")
    private Long guestId;

    @Column(name = "endDate")
    private String endDate;
}
