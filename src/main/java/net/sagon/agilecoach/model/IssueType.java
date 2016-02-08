package net.sagon.agilecoach.model;

import net.sagon.agilecoach.AgileCoachException;

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
