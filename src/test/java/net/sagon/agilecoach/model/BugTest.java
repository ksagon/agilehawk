package net.sagon.agilecoach.model;

import static org.junit.Assert.*;
import net.sagon.agilecoach.model.Bug;
import net.sagon.agilecoach.model.WorkItemType;

import org.hamcrest.CoreMatchers;
import org.junit.Test;

public class BugTest {

    private Bug bug = new Bug();

    @Test
    public void canCreateBug() {
        assertNotNull(bug);
        assertDefaults();
    }
    
    private void assertDefaults() {
        assertThat("Default Bug Has Title 'Bug'", bug.getTitle(), CoreMatchers.is("Bug"));
        assertThat("Default Bug Has Id 'BUG-1'", bug.getName(), CoreMatchers.is("BUG-1"));
        assertThat("Default Bug Has Status 'Open'", bug.getStatus(), CoreMatchers.is("Open"));
        assertThat("Default Bug Has Type 'Bug'", bug.getType(), CoreMatchers.is(WorkItemType.BUG));
    }

}
