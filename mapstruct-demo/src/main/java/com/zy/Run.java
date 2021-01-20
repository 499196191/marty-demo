package com.zy;

import com.zy.converter.PersonConverter;
import com.zy.entity.PersonDO;
import com.zy.entity.PersonDTO;

import java.util.Date;

public class Run {

    public static void main(String[] args) {
        PersonDO personDO = new PersonDO();
        personDO.setName("Marty");
        personDO.setAge(26);
        personDO.setBirthday(new Date());
        personDO.setId(1);
        PersonDTO personDTO = PersonConverter.INSTANCE.do2dto(personDO);
        System.out.println(personDTO);
    }
}
