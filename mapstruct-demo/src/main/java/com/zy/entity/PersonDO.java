package com.zy.entity;

import lombok.Data;

import java.util.Date;

@Data
public class PersonDO {
    private Integer id;
    private String name;
    private int age;
    private Date birthday;
    private Address address;

    @Data
    public static class Address{
        private String name;
        private String phone;
    }
}
