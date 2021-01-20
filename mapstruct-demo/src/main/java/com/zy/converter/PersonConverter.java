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

    @Mappings(@Mapping(source = "name",target = "userName"))
    PersonDTO do2dto(PersonDO personDO);

    
}
