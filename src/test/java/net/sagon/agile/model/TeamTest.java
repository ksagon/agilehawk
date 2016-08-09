package net.sagon.agile.model;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.*;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.junit.Test;

import net.sagon.agile.model.Bug;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;
import net.sagon.agile.model.Team;

public class TeamTest {
    private Team team;

    @Test
	public void canSetTeamStartAndEnd() throws Exception {
        givenTeamWithResources(0, 0, "2016-02-04", "2016-02-11");

        assertThat(team.getStart(), is(LocalDate.parse("2016-02-04")));
    	assertThat(team.getEnd(), is(LocalDate.parse("2016-02-11")));
	}

    @Test
    public void canAddResourcesToTeam() throws Exception {
        givenTeamWithResources(2, 0, "2016-02-04", "2016-02-11");

        assertThat(team.getResources().size(), is(2));
    }

    @Test
	public void canInitializeTeamFromEmptyStoriesAndBugs() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	assertThat(team.getResources().size(), is(0));
	}

    @Test
	public void whenAddingAStoryToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

        Story s1 = new Story();
        s1.setResolvedBy(new Resource("r1", "Bob Marley"));
    	team.addStory(s1);

		assertThat(team.getResources().size(), is(1));
	}

    @Test
	public void whenAdding2StoriesWithTheSameResourceToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

        Story s1 = new Story();
        s1.setResolvedBy(new Resource("r1", "Bob Marley"));
        team.addStory(s1);

        Story s2 = new Story();
        s2.setResolvedBy(new Resource("r1", "Bob Marley"));
        team.addStory(s2);

		assertThat(team.getResources().size(), is(1));
	}

    @Test
	public void whenAdding2StoriesWithDifferentResourcesToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

    	Story s1 = new Story();
    	s1.setResolvedBy(new Resource("r1", "Bob Marley"));
    	team.addStory(s1);

    	Story s2 = new Story();
    	s2.setResolvedBy(new Resource("r2", "Jacob Marley"));
    	team.addStory(s2);

		assertThat(team.getResources().size(), is(2));
	}

    @Test
	public void whenAddingABugToATeam_thenResourcesAreInitialized() throws Exception {
    	givenTeamWithNoStoriesOrBugs();

        Bug b = new Bug("BG-100", "BG-100", "BG-100");
        b.setResolvedBy(new Resource("Bob Marley 0", "Bob Marley 0"));
    	team.addBug(b);

		assertThat(team.getResources().size(), is(1));
	}
    
    @Test
    public void canGetTheSubsetOfStoriesDeliveredInDefinedTimeWindow() throws Exception {
        givenTeamWithResources(4, 2, "2016-02-01", "2016-02-15");
        
        Story s = new Story("ST-100", "ST-100", "ST-100");
        s.setResolutionDate(LocalDate.parse("2016-02-28").atStartOfDay());
        s.setResolvedBy(new Resource("Bob Marley 0", "Bob Marley 0"));
        team.addStory(s);
        
        team.setStart(LocalDate.parse("2016-02-27"));
        team.setEnd(LocalDate.parse("2016-02-29"));

        assertThat(team.getPeriodStories(team.getStart(), team.getEnd()).size(), is(1));
    }
    
    @Test
    public void canGetTheSubsetOfResourcesDeliveredInDefinedTimeWindow() throws Exception {
        givenTeamWithResources(4, 2, "2016-02-01", "2016-02-15");

        Story s = new Story("ST-100", "ST-100", "ST-100");
        s.setResolutionDate(LocalDate.parse("2016-02-28").atStartOfDay());
        s.setResolvedBy(new Resource("Bob Marley 100", "Bob Marley 100"));
        team.addStory(s);
        
        team.setStart(LocalDate.parse("2016-02-27"));
        team.setEnd(LocalDate.parse("2016-02-29"));

        assertThat(team.getPeriodResources(team.getStart(), team.getEnd()).size(), is(1));
    }

    private void givenTeamWithNoStoriesOrBugs() {
		List<Story> stories = new ArrayList<Story>();
    	List<Bug> bugs = new ArrayList<Bug>();

		team = new Team(stories, bugs);
	}

    private void givenTeamWithResources(int resourceCount, int storiesPerResource, String start, String end) {
        team = new Team();
        
        if( StringUtils.isNotEmpty(start) ) {
        	team.setStart(LocalDate.parse(start));
        }
        
        if( StringUtils.isNotEmpty(end) ) {
        	team.setEnd(LocalDate.parse(end));
        }

        for( int i = 0; i < resourceCount; i++ ) {
            Resource r = new Resource();
            r.setId("Bob Marley " + i);
            r.setName("Bob Marley " + i);
            team.addResource(r);

            for( int j = 0; j < storiesPerResource; j++ ) {
            	int storyId = (i*storiesPerResource)+j;
            	Story s = new Story();
            	s.setName(String.format("ST-%s", storyId));
            	s.setId(Integer.toString(storyId));
            	s.setResolutionDate(generateResolutionDateInRange(start, end));
            	s.setResolvedBy(r);

            	team.addStory(s);
            }
        }
    }

    private LocalDateTime generateResolutionDateInRange(String start, String end) {
    	if( StringUtils.isEmpty(start) ) {
    		start = "2016-02-01";
    	}

    	if( StringUtils.isEmpty(end) ) {
    		end = "2016-02-08";
    	}

    	LocalDateTime s = LocalDateTime.parse(start+"T00:00:00");
    	LocalDateTime e = LocalDateTime.parse(end+"T00:00:00");

    	Period p = Period.between(s.toLocalDate(), e.toLocalDate());
    	int randomDays = (new Random(Clock.systemUTC().millis())).ints(0, p.getDays()).iterator().next();

    	return s.plusDays(randomDays);
	}
}
