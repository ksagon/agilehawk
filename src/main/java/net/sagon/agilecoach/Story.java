package net.sagon.agilecoach;

public class Story extends WorkItem {
    private static final long serialVersionUID = -5098470181293180858L;

    public Story() {
        super("ST-1", "Story");
    }

    @Override
    public String getType() {
        return "Story";
    }

}
