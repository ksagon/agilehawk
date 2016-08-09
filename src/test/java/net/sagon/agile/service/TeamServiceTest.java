package net.sagon.agile.service;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;

import java.util.ArrayList;
import java.util.List;

import net.sagon.agile.AbstractSpringTest;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;
import net.sagon.agile.repository.ResourceRepo;
import net.sagon.agile.repository.TeamRepo;
import net.sagon.agile.service.TeamService;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class TeamServiceTest extends AbstractSpringTest {

    @Autowired
    private TeamService teamService;
    
    @Autowired
    private TeamRepo repo;
    
    @Autowired
    private ResourceRepo resourceRepo;

    @Before
    public void before() {
        resourceRepo.deleteAll();
        repo.deleteAll();
    }

    @After
    public void after() {
        resourceRepo.deleteAll();
        repo.deleteAll();
    }

    @Test
    public void canSaveTeam() {
        Team team = new Team("Team Alpha Dog", "Team Alpha Dog");

        teamService.save(team);

        Team result = teamService.find("Team Alpha Dog");

        assertThat(result, is(team));
    }

    @Test
    public void canLoadAllTeams() throws Exception {
        List<Team> teams = new ArrayList<Team>();

        teams.add(new Team("Alpha", "Alpha"));
        teams.add(new Team("Omega", "Omega"));

        teamService.save(teams);

        Iterable<Team> foundTeams = teamService.findAll();

        assertThat(foundTeams.spliterator().getExactSizeIfKnown(), is(2L));
    }

    @Test
    public void canDelete() throws Exception {
        Team team = new Team("deletedOne", "deletedOne");
        teamService.save(team);
        assertNotNull(teamService.find("deletedOne"));

        teamService.delete("deletedOne");
        assertNull(teamService.find("deletedOne"));
    }
    
    @Test
    public void canAddResourceToTeamAndPersist() throws Exception {
        Team team = new Team("Uncle Bob", "Uncle Bob");
        team.addResource(new Resource("Jerry Java", "Jerry Java", 200000));
        team.addResource(new Resource("Ruby Ron", "Ruby Ron", 60000));
        teamService.save(team);

        Team foundTeam = teamService.find("Uncle Bob");
        assertThat(foundTeam.getResources().size(), is(2));
    }
}
