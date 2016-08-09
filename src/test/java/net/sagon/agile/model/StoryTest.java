package net.sagon.agile.model;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.number.IsCloseTo.closeTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import org.junit.Test;

import net.sagon.agile.model.Issue;
import net.sagon.agile.model.IssueType;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;

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
        assertThat(story.getResolutionDate(), is(LocalDateTime.parse("2016-02-04T00:00:00.000", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS"))));
        assertThat(story.getResolvedBy(), is(givenResource(100)));
        assertThat(story.getCreatedDate(), is(LocalDateTime.parse("2016-02-01T00:00:00.000", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS"))));
        assertThat(story.getCreatedBy(), is(givenResource(101)));
        assertThat(story.getOpenDays(), closeTo(1.34, 0.001));
        assertThat(story.getDevDays(), closeTo(5.3, 0.001));
        assertThat(story.getQADays(), closeTo(3.45, 0.001));
        assertEquals("Story[title=Story,epic=EP-1,status=Open,resolutionDate=2016-02-04T00:00,resolvedBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],bugs=[],start=<null>,end=<null>,id=100,name=Bob Johnson],createdDate=2016-02-01T00:00,createdBy=Resource[salary=150000.0,weeklyHours=40.0,stories=[],bugs=[],start=<null>,end=<null>,id=101,name=Bob Johnson],openDays=1.34,devDays=5.3,qaDays=3.45,id=ST-1,name=ST-1]", story.toString());
	}

    private void givenInitializedStory() {
        story = new Story();

        story.setEpic("EP-1");
        story.setId("ST-1");
        story.setStatus("Open");
        story.setResolutionDate(LocalDateTime.parse("2016-02-04T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
        story.setResolvedBy(givenResource(100));
        story.setCreatedDate(LocalDateTime.parse("2016-02-01T00:00:00.000-0600", DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")));
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
