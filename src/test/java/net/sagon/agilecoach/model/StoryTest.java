package net.sagon.agilecoach.model;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import net.sagon.agilecoach.model.Resource;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.WorkItem;
import net.sagon.agilecoach.model.WorkItemType;

import org.junit.Test;

public class StoryTest {

    private WorkItem story;

    @Test
    public void canCreateStory() {
        givenDefaultInitializedStory();

        thenAssertDefaults();
    }
    
    @Test
    public void anInitializedStoryHasTheExpectedToString() throws Exception {
        givenInitializedStory();

        assertThat(story.toString(), is("Story[title=Story,owner=Resource[salary=150000.0,weeklyHours=40.0,stories=[],id=-1,name=Bob Johnson],epic=EP-1,status=Open,resolutionDate=2016-02-04T00:00-06:00,resolvedBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],id=-1,name=Bob Johnson],createdDate=2016-02-01T00:00-06:00,createdBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],id=-1,name=Bob Johnson],openDays=1.34,devDays=5.3,qaDays=3.45,id=-1,name=ST-1]"));
    }
    
    private void givenInitializedStory() {
        story = new Story();

        story.setEpic("EP-1");
        story.setStatus("Open");
        story.setResolutionDate(ZonedDateTime.parse("2016-02-04T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
        story.setResolvedBy(new Resource());
        story.setCreatedDate(ZonedDateTime.parse("2016-02-01T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
        story.setCreatedBy(new Resource());
        story.setOpenDays(1.34);
        story.setDevDays(5.3);
        story.setQADays(3.45);
    }

    private void givenDefaultInitializedStory() {
        story = new Story();
        story.setId(1);
    }

    private void thenAssertDefaults() {
        assertThat("Default Story Has Title 'Story'", story.getTitle(), is("Story"));
        assertThat("Default Story Has Id 'ST-1'", story.getName(), is("ST-1"));
        assertThat("Default Story Has Status 'Open'", story.getStatus(), is("Open"));
        assertThat("Default Story Has Type 'Story'", story.getType(), is(WorkItemType.STORY));
        assertNotNull(story.getOwner());
        assertThat("Default Story Has Owner Default Owner With No Id", story.getOwner().hasId(), is(false));
    }

}
