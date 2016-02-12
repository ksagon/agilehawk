package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.number.IsCloseTo.*;
import static org.junit.Assert.*;

import java.time.Clock;
import java.time.Period;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import net.sagon.agilecoach.model.Resource;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.Team;

import org.junit.Test;

public class TeamTest {
    private Team team;

    @Test
    public void canAddResourcesToTeam() throws Exception {
        givenTeamWithResources(2, 0, "2016-02-04", "2016-02-11");
        assertThat(team.getResources().size(), is(2));
    }

    @Test
    public void aTeamOfSize0Has0Velocity() throws Exception {
        givenTeamWithResources(0, 0, "2016-02-04", "2016-02-11");
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 0.0);
    }

    @Test
    public void when1ResourceCompletes1StoryIn1Week_thenTeamVelocityIs1() throws Exception {
        givenTeamWithResources(1, 1, "2016-02-04", "2016-02-11");
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 1.0);
    }

    @Test
    public void when2ResourceComplete2StoryIn2Weeks_thenTeamVelocityIsPoint5() throws Exception {
        givenTeamWithResources(2, 1, "2016-02-04", "2016-02-18");
        assertPeriodStoryVelocity("2016-02-04", "2016-02-18", 0.5);
    }

    @Test
    public void when4ResourceComplete8StoryIn1Weeks_thenTeamVelocityIs2() throws Exception {
        givenTeamWithResources(4, 2, "2016-02-04", "2016-02-11");
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 2.0);
    }

    @Test
    public void when2ResourcesComplete2StoriesIn1Week_thenTeamVelocityIs1() throws Exception {
        givenTeamWithResources(2, 1, "2016-02-04", "2016-02-11");
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 1.0);
    }

    @Test
	public void canInitializeTeamFromEmptyStoriesAndBugs() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	assertThat(team.getResources().size(), is(0));
	}

    @Test
	public void whenAddingAStoryToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	team.addStory(new Story());

		assertThat(team.getResources().size(), is(1));
	}

    @Test
	public void whenAdding2StoriesWithTheSameResourceToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	team.addStory(new Story());
    	team.addStory(new Story());

		assertThat(team.getResources().size(), is(1));
	}

    @Test
	public void whenAdding2StoriesWithDifferentResourcesToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	Story s1 = new Story();
    	s1.setResolvedBy(new Resource("Bob Marley"));
    	team.addStory(s1);

    	Story s2 = new Story();
    	s2.setResolvedBy(new Resource("Jacob Marley"));
    	team.addStory(new Story());

		assertThat(team.getResources().size(), is(2));
	}

    @Test
	public void whenAddingABugToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	team.addBug(new Bug());

		assertThat(team.getResources().size(), is(1));
	}

    private void givenTeamWithNoStoriesOrBugs() {
		List<Story> stories = new ArrayList<Story>();
    	List<Bug> bugs = new ArrayList<Bug>();

		team = new Team(stories, bugs);
	}

    private void givenTeamWithResources(int resourceCount, int storiesPerResource, String start, String end) {
        team = new Team();

        for( int i = 0; i < resourceCount; i++ ) {
            Resource r = new Resource();
            r.setId(i);
            for( int j = 0; j < storiesPerResource; j++ ) {
            	long storyId = (i*storiesPerResource)+j;
            	Story s = new Story();
            	s.setName(String.format("ST-%s", storyId));
            	s.setId(storyId);
            	s.setResolutionDate(generateResolutionDateInRange(start, end));
                r.addStory(s);
            }

            team.addResource(r);
        }
    }

    private ZonedDateTime generateResolutionDateInRange(String start, String end) {
    	ZonedDateTime s = ZonedDateTime.parse(start+"T00:00:00-06:00");
    	ZonedDateTime e = ZonedDateTime.parse(end+"T00:00:00-06:00");

    	Period p = Period.between(s.toLocalDate(), e.toLocalDate());
    	int randomDays = (new Random(Clock.systemUTC().millis())).ints(0, p.getDays()).iterator().next();

    	return s.plusDays(randomDays);
	}
    
    private void assertPeriodStoryVelocity(String start, String end, double expectedVelocity) throws Exception {
        assertThat(team.getPeriodStoryVelocity(ZonedDateTime.parse(start+"T00:00:00-06:00") , ZonedDateTime.parse(end+"T00:00:00-06:00")), closeTo(expectedVelocity, 0.001));
    }
}
