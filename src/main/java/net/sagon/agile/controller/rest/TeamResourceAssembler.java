package net.sagon.agile.controller.rest;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.mvc.ResourceAssemblerSupport;
import org.springframework.stereotype.Component;

import net.sagon.agile.dto.TeamResource;
import net.sagon.agile.model.Team;

@Component
public class TeamResourceAssembler extends ResourceAssemblerSupport<Team, TeamResource> {

    public TeamResourceAssembler() {
        super(Team.class, TeamResource.class);
    }

    @Override
    public List<TeamResource> toResources(Iterable<? extends Team> teams) {
        List<TeamResource> resources = new ArrayList<TeamResource>();
        for(Team team : teams) {
            resources.add(toResource(team));
        }
        return resources;
    }

    @Override
    public TeamResource toResource(Team team) {
        try {
        	TeamResource teamResource = new TeamResource(team, linkTo(TeamAPIController.class, TeamAPIController.class.getMethod("get", String.class), team.getId()).withSelfRel());
            teamResource.add(teamResourcesLink(team));

        	return teamResource;

        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }

    private Link teamResourcesLink(Team team) {
        try {
            return linkTo(TeamAPIController.class, TeamAPIController.class.getMethod("getTeamResources", String.class), team.getId()).withRel("resources");
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }
}
