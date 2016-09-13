package net.sagon.agile.dto;

import org.springframework.hateoas.Link;

import net.sagon.agile.model.Story;

public class StoryResource extends IssueResource<Story> {
    public StoryResource(Story story, Link link) {
        super(story, link);
    }
    
    @Override
    public Story asModel() {
    	Story s = new Story();
    	populateIssue(s);

    	return s;
    }
}
