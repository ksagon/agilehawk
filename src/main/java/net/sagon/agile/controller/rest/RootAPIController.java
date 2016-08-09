package net.sagon.agile.controller.rest;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.ResourceSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootAPIController {

    @RequestMapping(value = "/api", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public ResourceSupport getRoot() {
        ResourceSupport root = new ResourceSupport();
        root.add(selfLink());
        root.add(teamsLink());
        root.add(resourcesLink());

        return root;
    }

    private Link selfLink() {
        try {
            return linkTo(RootAPIController.class, RootAPIController.class.getMethod("getRoot"), new Object[] {}).withSelfRel();
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }

    private Link teamsLink() {
        try {
            return linkTo(TeamAPIController.class, TeamAPIController.class.getMethod("getTeams", Pageable.class, PagedResourcesAssembler.class), new Object[] {}).withRel("teams");
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }

    private Link resourcesLink() {
        try {
            return linkTo(ResourceAPIController.class, ResourceAPIController.class.getMethod("getResources", Pageable.class, PagedResourcesAssembler.class), new Object[] {}).withRel("resources");
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    }
}
