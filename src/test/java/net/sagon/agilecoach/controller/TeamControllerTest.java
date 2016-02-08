package net.sagon.agilecoach.controller;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import net.sagon.agilecoach.model.Team;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/mvc-config.xml"})
public class TeamControllerTest {

    @Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
    }

    @Test
	public void getTeam() throws Exception {
        this.mockMvc.perform(get("/agile/team").accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
        .andExpect(status().isOk())
        .andExpect(model().attribute("team", isA(Team.class)));
	}

    @Test
	public void canInstantiateTeamController() throws Exception {
		TeamController teamController = new TeamController();
		assertNotNull(teamController);
	}

    @Test
	public void canGetTeamFromController() throws Exception {
		TeamController teamController = new TeamController();
		assertNotNull(teamController.getTeam(new ModelMap()));
	}
}
