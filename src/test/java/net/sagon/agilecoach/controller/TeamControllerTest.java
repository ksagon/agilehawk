package net.sagon.agilecoach.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.BufferedInputStream;
import java.io.FileInputStream;

import net.sagon.agilecoach.AbstractSpringTest;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

public class TeamControllerTest extends AbstractSpringTest {

    @Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
    }

    @Test
	public void getTeam() throws Exception {
        this.mockMvc.perform(get("/team")
        		.accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
        .andExpect(status().isOk());
	}

    @Test
	public void canInstantiateTeamController() throws Exception {
		TeamController teamController = new TeamController();
		assertNotNull(teamController);
	}

    @Test
	public void canGetTeamFromController() throws Exception {
		TeamController teamController = new TeamController();
		assertNotNull(teamController.getTeam(new ModelMap(), new MockHttpServletRequest()));
	}

    @Test
	public void canLoadTeamFromResource() throws Exception {
        try( BufferedInputStream issues = new BufferedInputStream(new FileInputStream(ClassLoader.getSystemResource("work.csv").getFile())) ) {
	        MockMultipartFile issueFile = new MockMultipartFile("issues", "", "text/plain", issues);
	        IssuesHolder issueHolder = new IssuesHolder();
	        issueHolder.setIssues(issueFile);

	        this.mockMvc.perform(MockMvcRequestBuilders.fileUpload("/team/load").file(issueFile)
	        		.param("start", "2016-02-01")
	        		.param("end", "2016-02-02"))
	        	.andDo(print())
	            .andExpect(status().is(200));
        }
    }
}
