package net.sagon.agile.controller.rest;

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
import net.sagon.agile.model.Resource;
import net.sagon.agile.service.ResourceService;

@RestController
@RequestMapping("/api/resources")
public class ResourceAPIController {
	@Autowired
	private Mapper mapper;

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private ResourceResourceAssembler resourceResourceAssembler;

    @RequestMapping(method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public PagedResources<ResourceResource> getResources(@PageableDefault(page=0, size=5) Pageable pageable, PagedResourcesAssembler<Resource> assembler ) {
        Page<Resource> resourcePage = resourceService.findAll(pageable);

        return assembler.toResource(resourcePage, resourceResourceAssembler);
    }

    @RequestMapping(value = "/{resourceId}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public ResourceResource getResource( @PathVariable final String resourceId ) {
        Resource resource = resourceService.find(resourceId);

        return resourceResourceAssembler.toResource(resource);
    }
    
    @RequestMapping(value = "/{resourceId}", method = RequestMethod.PUT, produces = {"application/json"})
    @ResponseBody
    public ResourceResource updateResource( @PathVariable final String resourceId, @Valid @RequestBody Resource resource ) {
        Resource resourceToUpdate = resourceService.find(resourceId);

        mapper.map(resource, resourceToUpdate);
//        resourceToUpdate.setEnd(resource.getEnd());
//        resourceToUpdate.setName(resource.getName());
//        resourceToUpdate.setSalary(resource.getSalary());
//        resourceToUpdate.setStart(resource.getStart());
//        resourceToUpdate.setWeeklyHours(resource.getWeeklyHours());

        resourceService.save(resourceToUpdate);

        return resourceResourceAssembler.toResource(resourceToUpdate);
    }

    @RequestMapping(method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public ResourceResource createResource( @Valid @RequestBody Resource resource ) {
        resourceService.save(resource);

        return resourceResourceAssembler.toResource(resource);
    }

    @RequestMapping(value = "/{resourceId}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public ResourceResource deleteResource( @PathVariable final String resourceId ) {
        Resource resourceToUpdate = resourceService.find(resourceId);
        
        resourceService.delete(resourceId);

        return resourceResourceAssembler.toResource(resourceToUpdate);
    }

}
