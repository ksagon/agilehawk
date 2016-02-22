package net.sagon.agilecoach.model;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.number.IsCloseTo.*;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import net.sagon.agilecoach.model.Resource;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.Issue;
import net.sagon.agilecoach.model.IssueType;

import org.junit.Test;

public class StoryTest {

    private Issue story;

    @Test
    public void canCreateStory() {
        givenDefaultInitializedStory();

        thenAssertDefaults();
    }

    @Test
    public void anInitializedStoryHasTheExpectedToString() throws Exception {
        givenInitializedStory();

        assertInitializedValues();
    }

	private void assertInitializedValues() {
        assertThat(story.getEpic(), is("EP-1"));
        assertThat(story.getStatus(), is("Open"));
        assertThat(story.getResolutionDate(), is(ZonedDateTime.parse("2016-02-04T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"))));
        assertThat(story.getResolvedBy(), is(givenResource(100)));
        assertThat(story.getCreatedDate(), is(ZonedDateTime.parse("2016-02-01T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"))));
        assertThat(story.getCreatedBy(), is(givenResource(101)));
        assertThat(story.getOpenDays(), closeTo(1.34, 0.001));
        assertThat(story.getDevDays(), closeTo(5.3, 0.001));
        assertThat(story.getQADays(), closeTo(3.45, 0.001));
        assertEquals("Story[title=Story,epic=EP-1,status=Open,resolutionDate=2016-02-04T00:00-06:00,resolvedBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],bugs=[],start=<null>,end=<null>,id=100,name=Bob Johnson],createdDate=2016-02-01T00:00-06:00,createdBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],bugs=[],start=<null>,end=<null>,id=101,name=Bob Johnson],openDays=1.34,devDays=5.3,qaDays=3.45,id=,name=ST-1]", story.toString());
	}

    private void givenInitializedStory() {
        story = new Story();

        story.setEpic("EP-1");
        story.setStatus("Open");
        story.setResolutionDate(ZonedDateTime.parse("2016-02-04T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
        story.setResolvedBy(givenResource(100));
        story.setCreatedDate(ZonedDateTime.parse("2016-02-01T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
        story.setCreatedBy(givenResource(101));
        story.setOpenDays(1.34);
        story.setDevDays(5.3);
        story.setQADays(3.45);
    }

    private Resource givenResource(int id) {
    	Resource r = new Resource();
    	r.setId(Integer.toString(id));

    	return r;
	}

	private void givenDefaultInitializedStory() {
        story = new Story();
        story.setId("1");
    }

    private void thenAssertDefaults() {
        assertThat("Default Story Has Title 'Story'", story.getTitle(), is("Story"));
        assertThat("Default Story Has Id 'ST-1'", story.getName(), is("ST-1"));
        assertThat("Default Story Has Status 'Open'", story.getStatus(), is("Open"));
        assertThat("Default Story Has Type 'Story'", story.getType(), is(IssueType.STORY));
    }

}
