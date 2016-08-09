package net.sagon.agile.model;

import net.sagon.agile.AgileCoachException;

public enum IssueType {
    STORY(Story.class), 
    BUG(Bug.class);

    private Class<? extends Issue> clazz;

    IssueType(Class<? extends Issue> clazz) {
        this.clazz = clazz;
    }
    
    public Issue getWorkItem() {
        try {
            return clazz.newInstance();
        }
        catch(IllegalAccessException|InstantiationException e) {
            throw new AgileCoachException(e);
        }
    }
}
