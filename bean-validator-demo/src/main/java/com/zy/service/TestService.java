package com.zy.service;

import com.zy.anno.Facade;
import com.zy.pojo.TestResponse;
import com.zy.pojo.User;
import org.springframework.stereotype.Service;

@Service
public class TestService {

    @Facade
    public TestResponse<User> query(User user) {
        return null;
    }

}
