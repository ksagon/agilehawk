package net.sagon.agile;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/mvc-config.xml", 
        "file:src/test/resources/spring/application-config-test.xml",
        "file:src/main/resources/spring/application-config-dozer.xml"})
public class AbstractSpringTest {

    @Test
    public void dummy() throws Exception {}
}
