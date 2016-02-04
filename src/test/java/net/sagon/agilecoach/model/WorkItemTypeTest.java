package net.sagon.agilecoach.model;

import static org.junit.Assert.*;
import net.sagon.agilecoach.model.Bug;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.WorkItem;
import net.sagon.agilecoach.model.WorkItemType;

import org.junit.Test;

public class WorkItemTypeTest {

    @Test
    public void canGetStoryFromFactory() throws Exception {
        WorkItem workItem = WorkItemType.STORY.getWorkItem();

        assertTrue("Expected instance of Story", workItem instanceof Story);
    }

    @Test
    public void canGetBugFromFactory() throws Exception {
        WorkItem workItem = WorkItemType.BUG.getWorkItem();

        assertTrue("Expected instance of Bug", workItem instanceof Bug);
    }
}
