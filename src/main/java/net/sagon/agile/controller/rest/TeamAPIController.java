package net.sagon.agile.controller.rest;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import net.sagon.agile.dto.ResourceResource;
import net.sagon.agile.dto.TeamResource;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;
import net.sagon.agile.service.TeamService;

@RestController
public class TeamAPIController {
    @Autowired
    private TeamService teamService;

    @Autowired
    private TeamResourceAssembler teamResourceAssembler;

    @RequestMapping(value = "/api/teams", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public PagedResources<TeamResource> getTeams(@PageableDefault(page=0, size=5) final Pageable pageable, final PagedResourcesAssembler<Team> assembler ) {
        Page<Team> teamPage = teamService.findAll(pageable);

        return assembler.toResource(teamPage, teamResourceAssembler);
    }

    @RequestMapping(value = "/api/teams/{teamId}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public TeamResource getTeam( @PathVariable final String teamId ) {
        Team team = teamService.find(teamId);

        return teamResourceAssembler.toResource(team);
    }

    @RequestMapping(value = "/api/teams/{teamId}", method = RequestMethod.PUT, produces = {"application/json"})
    @ResponseBody
    public TeamResource updateTeam( @PathVariable final String teamId, @Valid @RequestBody Team team ) {
        Team teamToUpdate = teamService.find(teamId);
        
        teamToUpdate.setEnd(team.getEnd());
        teamToUpdate.setStart(team.getStart());
        teamToUpdate.setName(team.getName());

        teamService.save(teamToUpdate);

        return teamResourceAssembler.toResource(teamToUpdate);
    }

    @RequestMapping(value = "/api/teams", method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public TeamResource createTeam( @Valid @RequestBody Team team ) {
        teamService.save(team);

        return teamResourceAssembler.toResource(team);
    }

    @RequestMapping(value = "/api/teams/{teamId}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public TeamResource deleteTeam( @PathVariable final String teamId ) {
        Team teamToUpdate = teamService.find(teamId);
        
        teamService.delete(teamId);

        return teamResourceAssembler.toResource(teamToUpdate);
    }
}
