package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
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
