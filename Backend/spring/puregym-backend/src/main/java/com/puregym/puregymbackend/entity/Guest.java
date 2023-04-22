package com.puregym.puregymbackend.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "guest")
@SqlResultSetMappings( {
        @SqlResultSetMapping(
                name = "ActiveGuest",
                classes = {
                        @ConstructorResult(
                                targetClass = ActiveGuest.class,
                                columns = {
                                        @ColumnResult(name="guestId", type = Long.class),
                                        @ColumnResult(name="guestName", type = String.class),
                                        @ColumnResult(name="gender", type = String.class),
                                        @ColumnResult(name="lockerId", type = Long.class),
                                        @ColumnResult(name="startTime", type = String.class)
                                }
                        )
                }
        ),
        @SqlResultSetMapping(
                name = "InactiveGuest",
                classes = {
                        @ConstructorResult(
                                targetClass = InactiveGuest.class,
                                columns = {
                                        @ColumnResult(name="guestId", type = Long.class),
                                        @ColumnResult(name="guestName", type = String.class),
                                        @ColumnResult(name="gender", type = String.class),
                                        @ColumnResult(name="bdate", type = String.class)
                                }
                        )
                }
        )
})
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

