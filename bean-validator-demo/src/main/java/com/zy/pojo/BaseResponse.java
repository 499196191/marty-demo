package com.zy.pojo;

import lombok.Data;

@Data
public class BaseResponse<T> {
    private boolean success;
    private String responseMessage;
    private int responseCode;
    private T data;
}
