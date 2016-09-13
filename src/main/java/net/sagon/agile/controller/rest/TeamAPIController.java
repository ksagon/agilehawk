package net.sagon.agile.controller.rest;

import java.util.List;

import javax.validation.Valid;

import org.dozer.Mapper;
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
import net.sagon.agile.service.ResourceService;
import net.sagon.agile.service.TeamService;

@RestController
@RequestMapping("/api/teams")
public class TeamAPIController implements ModelAPIController<TeamResource, Team> {
	@Autowired
	private Mapper mapper;

	@Autowired
    private ResourceService resourceService;

	@Autowired
    private TeamService teamService;

    @Autowired
    private TeamResourceAssembler teamResourceAssembler;

    @Autowired
    private TeamResourceResourceAssembler teamResourceResourceAssembler;

    @RequestMapping(method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public PagedResources<TeamResource> get(@PageableDefault(page=0, size=5) final Pageable pageable, final PagedResourcesAssembler<Team> assembler ) {
        Page<Team> teamPage = teamService.findAll(pageable);

        return assembler.toResource(teamPage, teamResourceAssembler);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public TeamResource get( @PathVariable final String id ) {
        Team team = teamService.find(id);

        return teamResourceAssembler.toResource(team);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, produces = {"application/json"})
    @ResponseBody
    public TeamResource update( @PathVariable final String id, @Valid @RequestBody Team team ) {
        Team teamToUpdate = teamService.find(id);
        
        mapper.map(team, teamToUpdate);

        teamService.save(teamToUpdate);

        return teamResourceAssembler.toResource(teamToUpdate);
    }

    @RequestMapping(method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public TeamResource create( @Valid @RequestBody Team team ) {
        teamService.save(team);

        return teamResourceAssembler.toResource(team);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public TeamResource delete( @PathVariable final String id ) {
        Team teamToUpdate = teamService.find(id);
        
        teamService.delete(id);

        return teamResourceAssembler.toResource(teamToUpdate);
    }

    @RequestMapping(value = "/{id}/resources", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public List<ResourceResource> getTeamResources( @PathVariable final String id ) {
        Team team = teamService.find(id);

        return teamResourceResourceAssembler.toResources(team, team.getResources());
    }

    @RequestMapping(value = "/{id}/resources", method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public ResourceResource createTeamResource( @PathVariable final String id, @RequestBody Resource resource ) {
        Team team = teamService.find(id);
        Resource teamResource = resourceService.find(resource.getId());

        team.addResource(teamResource);
        teamService.save(team);

        return teamResourceResourceAssembler.toResource(team, teamResource);
    }

    @RequestMapping(value = "/{teamId}/resources/{resourceId}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public ResourceResource getTeamResource( @PathVariable final String teamId, @PathVariable final String resourceId ) {
        Team team = teamService.find(teamId);
        Resource teamResource = team.getResource(resourceId);

        return teamResourceResourceAssembler.toResource(team, teamResource);
    }

    @RequestMapping(value = "/{teamId}/resources/{resourceId}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public ResourceResource deleteTeamResource( @PathVariable final String teamId, @PathVariable final String resourceId ) {
        Team team = teamService.find(teamId);
        Resource teamResource = team.getResource(resourceId);
        
        teamService.removeResource(teamId, resourceId);

        return teamResourceResourceAssembler.toResource(team, teamResource);
    }
}
