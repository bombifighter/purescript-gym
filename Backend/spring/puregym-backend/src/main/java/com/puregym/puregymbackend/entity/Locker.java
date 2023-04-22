package com.puregym.puregymbackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@IdClass(Locker.class)
@AllArgsConstructor
@NoArgsConstructor
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
public class Locker implements Serializable {

    @Id
    private Long id;

    @Id
    private String gender;

    @Column(name = "isFree")
    private String isFree;
}
