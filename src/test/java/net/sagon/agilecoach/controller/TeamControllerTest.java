package net.sagon.agilecoach.controller;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.io.BufferedInputStream;
import java.io.FileInputStream;

import javax.servlet.http.HttpServletRequest;

import net.sagon.agilecoach.model.Team;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
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
        this.mockMvc.perform(get("/team").session(givenSessionTeam()).accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
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
		assertNotNull(teamController.getTeam(new ModelMap(), givenRequestTeam()));
	}

    @Test
	public void canLoadTeamFromResource() throws Exception {
        try( BufferedInputStream issues = new BufferedInputStream(new FileInputStream(ClassLoader.getSystemResource("work.csv").getFile())) ) {
	        MockMultipartFile issueFile = new MockMultipartFile("issues", "", "text/plain", issues);
	        IssuesHolder issueHolder = new IssuesHolder();
	        issueHolder.setIssues(issueFile);

	        this.mockMvc.perform(MockMvcRequestBuilders.fileUpload("/team/load").file(issueFile))
	            .andExpect(status().is(200));
        }
    }

    private HttpServletRequest givenRequestTeam() {
    	MockHttpServletRequest request = new MockHttpServletRequest();
    	request.setSession(givenSessionTeam());
    	
    	return request;
    }
    
    private MockHttpSession givenSessionTeam() {
    	MockHttpSession session = new MockHttpSession();
    	session.setAttribute("team", new Team());
    	
    	return session;
    }
}
