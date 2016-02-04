package net.sagon.agilecoach;

import static org.junit.Assert.*;

import org.hamcrest.CoreMatchers;
import org.junit.Test;

public class StoryTest {

    private WorkItem story;

    @Test
    public void canCreateStory() {
        givenDefaultInitializedStory();

        thenAssertDefaults();
    }
    
    private void givenDefaultInitializedStory() {
        story = new Story();
        story.setId(1);
    }

    private void thenAssertDefaults() {
        assertThat("Default Story Has Title 'Story'", story.getTitle(), CoreMatchers.is("Story"));
        assertThat("Default Story Has Id 'ST-1'", story.getName(), CoreMatchers.is("ST-1"));
        assertThat("Default Story Has Status 'Open'", story.getStatus(), CoreMatchers.is("Open"));
        assertThat("Default Story Has Type 'Story'", story.getType(), CoreMatchers.is("Story"));
        assertNotNull(story.getOwner());
        assertThat("Default Story Has Owner Default Owner With No Id", story.getOwner().hasId(), CoreMatchers.is(false));
    }

}
