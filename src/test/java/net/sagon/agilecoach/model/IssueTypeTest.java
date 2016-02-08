package net.sagon.agilecoach.model;

import static org.junit.Assert.*;
import net.sagon.agilecoach.model.Bug;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.Issue;
import net.sagon.agilecoach.model.IssueType;

import org.junit.Test;

public class IssueTypeTest {

    @Test
    public void canGetStoryFromFactory() throws Exception {
        Issue issue = IssueType.STORY.getWorkItem();

        assertTrue("Expected instance of Story", issue instanceof Story);
    }

    @Test
    public void canGetBugFromFactory() throws Exception {
        Issue issue = IssueType.BUG.getWorkItem();

        assertTrue("Expected instance of Bug", issue instanceof Bug);
    }
}
