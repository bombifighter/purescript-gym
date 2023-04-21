package com.puregym.puregymbackend.entity;

import lombok.Data;

@Data
public class LastIdWrapper {

    private Long lastId;

    public LastIdWrapper(Object[] columns) {
        this.lastId = (Long) columns[0];
    }
}
