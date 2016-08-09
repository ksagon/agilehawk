package net.sagon.agile.model;

import org.springframework.data.annotation.TypeAlias;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="story")
@TypeAlias("story")
public class Story extends Issue {
    private static final long serialVersionUID = -5098470181293180858L;

    public Story() {
        super("ST-1", "Story");
    }

    public Story(String id, String name, String title) {
        super(id, name, title);
    }

    @Override
    public IssueType getType() {
        return IssueType.STORY;
    }

}
