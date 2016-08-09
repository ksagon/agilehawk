package net.sagon.agile.model;

import static org.junit.Assert.*;

import org.junit.Test;

import net.sagon.agile.model.Bug;
import net.sagon.agile.model.Issue;
import net.sagon.agile.model.IssueType;
import net.sagon.agile.model.Story;

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
