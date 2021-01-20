package com.zy.pojo;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class User {

    private String idempotentNo;

    @NotNull(
            message = "userName can't be null"
    )
    private String userName;
}
