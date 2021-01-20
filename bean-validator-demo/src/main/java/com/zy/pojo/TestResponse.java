package com.zy.pojo;

import lombok.Data;

@Data
public class TestResponse<T> extends BaseResponse<T> {
    private String test;
}
