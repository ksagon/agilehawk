package net.sagon.agile.model;

import org.springframework.data.annotation.TypeAlias;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="bug")
@TypeAlias("bug")
public class Bug extends Issue {
    private static final long serialVersionUID = -2593211761819583243L;

    public Bug() {
        super("BUG-1", "Bug");
    }

    public Bug(String id, String name, String title) {
        super(id, name, title);
    }

    @Override
    public IssueType getType() {
        return IssueType.BUG;
    }

}
