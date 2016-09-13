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

import net.sagon.agile.controller.rest.exception.NotFoundException;
import net.sagon.agile.dto.ResourceResource;
import net.sagon.agile.dto.StoryResource;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;
import net.sagon.agile.service.ResourceService;
import net.sagon.agile.service.StoryService;

@RestController
@RequestMapping("/api/resources")
public class ResourceAPIController implements ModelAPIController<ResourceResource, Resource> {
	@Autowired
	private Mapper mapper; 

    @Autowired
    private StoryService storyService;

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private StoryResourceAssembler storyResourceAssembler;

    @Autowired
    private ResourceResourceAssembler resourceResourceAssembler;

    @RequestMapping(method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public PagedResources<ResourceResource> get(@PageableDefault(page=0, size=5) Pageable pageable, PagedResourcesAssembler<Resource> assembler ) {
        Page<Resource> resourcePage = resourceService.findAll(pageable);

        return assembler.toResource(resourcePage, resourceResourceAssembler);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public ResourceResource get( @PathVariable final String id ) {
        Resource resource = resourceService.find(id);
        
        if( resource == null ) {
        	throw new NotFoundException();
        }

        return resourceResourceAssembler.toResource(resource);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, produces = {"application/json"})
    @ResponseBody
    public ResourceResource update( @PathVariable final String id, @Valid @RequestBody Resource resource ) {
        Resource resourceToUpdate = resourceService.find(id);

        if( resourceToUpdate == null ) {
        	throw new NotFoundException();
        }

        mapper.map(resource, resourceToUpdate);

        resourceService.save(resourceToUpdate);

        return resourceResourceAssembler.toResource(resourceToUpdate);
    }

    @RequestMapping(method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public ResourceResource create( @Valid @RequestBody Resource resource ) {
        resourceService.save(resource);

        return resourceResourceAssembler.toResource(resource);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public ResourceResource delete( @PathVariable final String id ) {
        Resource resourceToUpdate = resourceService.find(id);

        resourceService.delete(id);

        return resourceResourceAssembler.toResource(resourceToUpdate);
    }


    @RequestMapping(value = "/{id}/stories", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public List<StoryResource> getStories( @PathVariable final String id ) {
        Resource resource = resourceService.find(id);

        List<Story> stories = storyService.findByResolvedBy(resource);
        
        return storyResourceAssembler.toResources(stories);
    }
}
