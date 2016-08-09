package net.sagon.agile.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.hamcrest.CoreMatchers.*;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.util.List;
import java.util.Map;

import net.sagon.agile.AbstractSpringTest;
import net.sagon.agile.controller.AnalysisDates;
import net.sagon.agile.controller.TeamController;
import net.sagon.agile.model.IssueLoader;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;
import net.sagon.agile.service.ResourceService;
import net.sagon.agile.service.TeamService;

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
    
    @Autowired
    private TeamController controller;
    
    @Autowired
    private TeamService service;
    
    @Autowired
    private ResourceService resourceService;

    @Autowired
    private IssueLoader loader;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();

        loader.reset();
        loader.clearRepo();
    }

    @Test
	public void getTeam() throws Exception {
        this.mockMvc.perform(get("/team")
        		.accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
        .andExpect(status().isOk());
	}

    @Test
    public void getTeams() throws Exception {
        this.mockMvc.perform(get("/teams")
                .accept(MediaType.parseMediaType(MediaType.TEXT_HTML_VALUE)))
        .andExpect(status().isOk());
    }

    @Test
	public void canInstantiateTeamController() throws Exception {
		assertNotNull(controller);
	}

    @Test
	public void canGetTeamFromController() throws Exception {
		assertNotNull(controller.getTeam(new ModelMap(), new MockHttpServletRequest(), new AnalysisDates()));
	}

    @Test
    public void canAddResourceToTeam() throws Exception {
        givenTeam("Alpha");
        controller.addResource("Alpha", new Resource("Sagon", "Kevin Sagon", 100000), null);

        Team team = service.find("Alpha");
        assertThat(team.getResources().size(), is(1));
        assertThat(team.getResources().iterator().next().getId(), is("Sagon"));
        assertThat(team.getResources().iterator().next().getName(), is("Kevin Sagon"));
    }

    @Test
    public void canAddExistingResourceToTeam() throws Exception {
        givenTeam("Beta");
        givenResource("Erin Sagon");

        controller.addResource("Beta", "Erin Sagon");

        Team team = service.find("Beta");
        assertThat(team.getResources().size(), is(1));
        assertThat(team.getResources().iterator().next().getId(), is("Erin Sagon"));
        assertThat(team.getResources().iterator().next().getName(), is("Erin Sagon"));
    }

    @Test
    public void canGetResourcesNotOnTeam() throws Exception {
        givenTeam("Alpha");
        givenResource("Erin Sagon");
        givenResource("Jimmy Sagon");

        controller.addResource("Alpha", new Resource("Sagon", "Kevin Sagon", 100000), null);

        Map<String, String> resourcesNotOnTeam = controller.getResourcesNotOnTeam("Alpha");

        assertNotNull(resourcesNotOnTeam);
        assertThat(resourcesNotOnTeam.size(), is(2));
    }
    
    @Test
    public void canGetResourcesNotOnTeamByURL() throws Exception {
        String teamId = "Alpha";

        this.mockMvc.perform(get("/team/" + teamId + "/resource?filter=eligible")
                .accept(MediaType.parseMediaType(MediaType.APPLICATION_JSON_UTF8_VALUE)))
        .andExpect(status().isOk());
    }

    private void givenTeam(String teamName) {
        Team t = new Team(teamName, teamName);
        service.save(t);
    }

    private void givenResource(String resourceName) {
        Resource r = new Resource(resourceName, resourceName);
        resourceService.save(r);
    }

    @Test
	public void canLoadTeamFromResource() throws Exception {
        try( BufferedInputStream issues = new BufferedInputStream(new FileInputStream(ClassLoader.getSystemResource("work.csv").getFile())) ) {
	        MockMultipartFile issueFile = new MockMultipartFile("issues", "", "text/plain", issues);

	        this.mockMvc.perform(MockMvcRequestBuilders.fileUpload("/issue/load").file(issueFile)
	        		.param("start", "2016-02-01")
	        		.param("end", "2016-02-02"))
	        	.andDo(print())
	            .andExpect(status().is(302));
        }
    }
}
