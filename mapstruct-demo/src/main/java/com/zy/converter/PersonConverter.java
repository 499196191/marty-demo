package com.zy.converter;

import com.zy.entity.PersonDO;
import com.zy.entity.PersonDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PersonConverter {
    PersonConverter INSTANCE = Mappers.getMapper(PersonConverter.class);

    @Mappings({
            @Mapping(source = "name",target = "userName"),
            @Mapping(target = "birthday",dateFormat = "yyyy-MM-dd HH:mm:ss"),
            @Mapping(target = "address", expression = "java(address2String(personDO.getAddress()))")
    })
    PersonDTO do2dto(PersonDO personDO);

    default String address2String(PersonDO.Address address) {
        if (address != null) {
            return address.getName();
        } else {
            return null;
        }
    }

}
