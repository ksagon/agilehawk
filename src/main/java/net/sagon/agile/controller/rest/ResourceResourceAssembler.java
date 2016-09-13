package net.sagon.agile.controller.rest;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.hateoas.Link;
import org.springframework.hateoas.mvc.ResourceAssemblerSupport;
import org.springframework.stereotype.Component;

import net.sagon.agile.dto.ResourceResource;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;

@Component
public class ResourceResourceAssembler extends ResourceAssemblerSupport<Resource, ResourceResource> {

    public ResourceResourceAssembler() {
        super(Resource.class, ResourceResource.class);
    }

    @Override
    public List<ResourceResource> toResources(Iterable<? extends Resource> resources) {
        List<ResourceResource> resourceresources = new ArrayList<ResourceResource>();
        for(Resource resource : resources) {
            resourceresources.add(toResource(resource));
        }

        return resourceresources;
    }

    @Override
    public ResourceResource toResource(Resource resource) {
        try {
            ResourceResource resourceResource = new ResourceResource(resource, linkTo(ResourceAPIController.class, ResourceAPIController.class.getMethod("get", String.class), resource.getId()).withSelfRel());
            resourceResource.add(resourceStoriesLink(resource));

            return resourceResource;
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }


    private Link resourceStoriesLink(Resource resource) {
        try {
            return linkTo(ResourceAPIController.class, ResourceAPIController.class.getMethod("getStories", String.class), resource.getId()).withRel("stories");
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }
}
