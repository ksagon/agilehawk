package net.sagon.agile.controller.rest;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import javax.validation.Valid;

import net.sagon.agile.AbstractSpringTest;
import net.sagon.agile.controller.ResourceController;
import net.sagon.agile.dto.ResourceResource;
import net.sagon.agile.model.Resource;
import net.sagon.agile.service.ResourceService;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

public class ResourceAPIControllerTest extends AbstractSpringTest {

    @Autowired
    private WebApplicationContext wac;

    @Autowired
    private ResourceService resourceService;
    
    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
    }

    @Test
    public void canCreateResourceAPIController() {
        ResourceAPIController resourceApiController = new ResourceAPIController();
        assertNotNull(resourceApiController);
    }

    @Test
    public void getResource() throws Exception {
    	this.mockMvc.perform(get("/api/resources").accept(MediaType.parseMediaType(MediaType.APPLICATION_JSON_UTF8_VALUE)))
    		.andExpect(status().isOk());
    }
    
    @Test
    public void getResourceById() throws Exception {
    	this.mockMvc.perform(get("/api/resources/abcd").accept(MediaType.parseMediaType(MediaType.APPLICATION_JSON_UTF8_VALUE)))
    		.andExpect(status().is4xxClientError());
    }
    
//	    public PagedResources<ResourceResource> get(@PageableDefault(page=0, size=5) Pageable pageable, PagedResourcesAssembler<Resource> assembler )
//	        Page<Resource> resourcePage = resourceService.findAll(pageable);
//	
//	        return assembler.toResource(resourcePage, resourceResourceAssembler);
//    }
//
//    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = {"application/json"})
//    @ResponseBody
//    public ResourceResource get( @PathVariable final String id ) {
//        Resource resource = resourceService.find(id);
//
//        return resourceResourceAssembler.toResource(resource);
//    }
//    
//    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, produces = {"application/json"})
//    @ResponseBody
//    public ResourceResource update( @PathVariable final String id, @Valid @RequestBody Resource resource ) {
//        Resource resourceToUpdate = resourceService.find(id);
//
//        mapper.map(resource, resourceToUpdate);
//
//        resourceService.save(resourceToUpdate);
//
//        return resourceResourceAssembler.toResource(resourceToUpdate);
//    }
//
//    @RequestMapping(method = RequestMethod.POST, produces = {"application/json"})
//    @ResponseBody
//    public ResourceResource create( @Valid @RequestBody Resource resource ) {
//        resourceService.save(resource);
//
//        return resourceResourceAssembler.toResource(resource);
//    }
//
//    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = {"application/json"})
//    @ResponseBody
//    public ResourceResource delete( @PathVariable final String id ) {

}
