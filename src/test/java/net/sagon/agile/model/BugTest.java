package net.sagon.agile.model;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.junit.Test;

import net.sagon.agile.model.Bug;
import net.sagon.agile.model.IssueType;

public class BugTest {

    private Bug bug = new Bug();

    @Test
    public void canCreateBug() {
        assertNotNull(bug);
        assertDefaults();
    }
    
    private void assertDefaults() {
        assertThat("Default Bug Has Title 'Bug'", bug.getTitle(), is("Bug"));
        assertThat("Default Bug Has Id 'BUG-1'", bug.getName(), is("BUG-1"));
        assertThat("Default Bug Has Status 'Open'", bug.getStatus(), is("Open"));
        assertThat("Default Bug Has Type 'Bug'", bug.getType(), is(IssueType.BUG));
    }

}
