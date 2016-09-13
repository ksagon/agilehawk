package net.sagon.agile.controller.rest;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.hateoas.mvc.ResourceAssemblerSupport;
import org.springframework.stereotype.Component;

import net.sagon.agile.dto.ResourceResource;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;

@Component
public class TeamResourceResourceAssembler extends ResourceAssemblerSupport<Resource, ResourceResource> {

    public TeamResourceResourceAssembler() {
        super(Resource.class, ResourceResource.class);
    }

    @Override
    public List<ResourceResource> toResources(Iterable<? extends Resource> resources) {
    	throw new IllegalArgumentException("Team is required for the TeamResource Assembler");
    }

    @Override
    public ResourceResource toResource(Resource resource) {
    	throw new IllegalArgumentException("Team is required for the TeamResource Assembler");
    }


    public List<ResourceResource> toResources(Team team, Iterable<? extends Resource> resources) {
        List<ResourceResource> resourceResources = new ArrayList<ResourceResource>();
        for(Resource resource : resources) {
        	resourceResources.add(toResource(team, resource));
        }

        return resourceResources;
    }

    public ResourceResource toResource(Team team, Resource resource) {
        try {
            return new ResourceResource(resource, linkTo(TeamAPIController.class, TeamAPIController.class.getMethod("getTeamResource", String.class, String.class), team.getId(), resource.getId()).withSelfRel());
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }
}
