package com.zy;

import com.zy.pojo.TestResponse;
import com.zy.pojo.User;
import com.zy.service.TestService;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class Test {

    @Autowired
    private TestService testService;

    @org.junit.Test
    public void test1(){
        User user = new User();
        TestResponse testResponse = testService.query(user);
        int i = 0;
    }
}
