package net.sagon.agilecoach.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import net.sagon.agilecoach.AbstractSpringTest;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

public class ResourceControllerTest extends AbstractSpringTest {

    @Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
    }

    @Test
    public void canCreateResourceController() {
        ResourceController resourceController = new ResourceController();
        assertNotNull(resourceController);
    }

    @Test
    public void getResource() throws Exception {
        this.mockMvc.perform(get("/resource")
                .accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
        .andExpect(status().isOk());

    }
}
