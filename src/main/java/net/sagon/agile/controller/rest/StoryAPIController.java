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

import net.sagon.agile.dto.StoryResource;
import net.sagon.agile.model.Story;
import net.sagon.agile.service.StoryService;

@RestController
@RequestMapping("/api/stories")
public class StoryAPIController implements ModelAPIController<StoryResource, Story> {
	@Autowired
	private Mapper mapper;

	@Autowired
    private StoryService storyService;

    @Autowired
    private StoryResourceAssembler storyResourceAssembler;

    @RequestMapping(method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public PagedResources<StoryResource> get(@PageableDefault(page=0, size=5) final Pageable pageable, final PagedResourcesAssembler<Story> assembler ) {
        Page<Story> storyPage = storyService.findAll(pageable);

        return assembler.toResource(storyPage, storyResourceAssembler);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = {"application/json"})
    @ResponseBody
    public StoryResource get( @PathVariable final String id ) {
        Story story = storyService.find(id);

        return storyResourceAssembler.toResource(story);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, produces = {"application/json"})
    @ResponseBody
    public StoryResource update( @PathVariable final String id, @Valid @RequestBody Story story ) {
        Story storyToUpdate = storyService.find(id);
        
        mapper.map(story, storyToUpdate);

        storyService.save(storyToUpdate);

        return storyResourceAssembler.toResource(storyToUpdate);
    }

    @RequestMapping(method = RequestMethod.POST, produces = {"application/json"})
    @ResponseBody
    public StoryResource create( @Valid @RequestBody Story story ) {
        storyService.save(story);

        return storyResourceAssembler.toResource(story);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = {"application/json"})
    @ResponseBody
    public StoryResource delete( @PathVariable final String id ) {
        Story storyToUpdate = storyService.find(id);
        
        storyService.delete(id);

        return storyResourceAssembler.toResource(storyToUpdate);
    }

}
