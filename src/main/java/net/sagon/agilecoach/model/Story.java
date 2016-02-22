package net.sagon.agilecoach.model;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Story extends Issue {
    private static final long serialVersionUID = -5098470181293180858L;

    public Story() {
        super("ST-1", "Story");
    }

    @Override
    public IssueType getType() {
        return IssueType.STORY;
    }

}
