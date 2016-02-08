package net.sagon.agilecoach.model;

public class Bug extends Issue {
    private static final long serialVersionUID = -2593211761819583243L;

    public Bug() {
        super("BUG-1", "Bug");
    }

    @Override
    public IssueType getType() {
        return IssueType.BUG;
    }

}
