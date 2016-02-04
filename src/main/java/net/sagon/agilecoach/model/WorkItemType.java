package net.sagon.agilecoach.model;

import net.sagon.agilecoach.AgileCoachException;

public enum WorkItemType {
    STORY(Story.class), 
    BUG(Bug.class);

    private Class<? extends WorkItem> clazz;

    WorkItemType(Class<? extends WorkItem> clazz) {
        this.clazz = clazz;
    }
    
    public WorkItem getWorkItem() {
        try {
            return clazz.newInstance();
        }
        catch(IllegalAccessException|InstantiationException e) {
            throw new AgileCoachException(e);
        }
    }
}
