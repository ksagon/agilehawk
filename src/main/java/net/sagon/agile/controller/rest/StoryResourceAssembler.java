package net.sagon.agile.controller.rest;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.hateoas.mvc.ResourceAssemblerSupport;
import org.springframework.stereotype.Component;

import net.sagon.agile.dto.StoryResource;
import net.sagon.agile.model.Story;

@Component
public class StoryResourceAssembler extends ResourceAssemblerSupport<Story, StoryResource> {

    public StoryResourceAssembler() {
        super(Story.class, StoryResource.class);
    }

    @Override
    public List<StoryResource> toResources(Iterable<? extends Story> stories) {
        List<StoryResource> resources = new ArrayList<StoryResource>();
        for(Story story : stories) {
            resources.add(toResource(story));
        }
        return resources;
    }

    @Override
    public StoryResource toResource(Story story) {
        try {
        	StoryResource storyResource = new StoryResource(story, linkTo(StoryAPIController.class, StoryAPIController.class.getMethod("get", String.class), story.getId()).withSelfRel());

        	return storyResource;

        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }
}
