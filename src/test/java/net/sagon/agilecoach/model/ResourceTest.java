package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.number.IsCloseTo.closeTo;
import static org.junit.Assert.*;

import java.time.Clock;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZonedDateTime;
import java.util.Random;

import org.junit.Test;

public class ResourceTest {

    private Resource resource;

    @Test
    public void newResourceHas40HoursAnd75CostBasis() throws Exception {
        givenDefaultResource();
        thenAssertDefaults();
    }

    @Test
	public void canSetStartAndEndDatesOnResource() throws Exception {
        givenDefaultResource();
        
        resource.setStartDate(LocalDate.parse("2016-01-01"));
        resource.setEndDate(LocalDate.parse("2016-01-30"));

        assertThat(resource.getStartDate(), is(LocalDate.parse("2016-01-01")));
		assertThat(resource.getEndDate(), is(LocalDate.parse("2016-01-30")));
	}

    @Test
    public void oneHundredKJohnDoeHas50CostBasis() throws Exception {
        given100kSeniorDeveloperJohnDoe();

        thenAssert100kJohnDoe();
    }

    @Test
    public void canAddResourceStory() throws Exception {
        givenDefaultResource();
        whenAddingStoriesBetween(1, "2016-02-01", "2016-02-08");
        thenStoryCountIs(1);
    }
    
    @Test
    public void whenStoryCountIs1InA1WeekPeriod_thenWeeklyStoryVelocityIs1() throws Exception {
        givenDefaultResource();
        whenAddingStoriesBetween(1, "2016-02-01", "2016-02-08");
        assertPeriodStoryVelocity("2016-02-01", "2016-02-08", 1.0);
    }

    @Test
    public void whenNoStoriesAreDelivered_thenWeeklyStoryVelocityIs0() throws Exception {
        givenDefaultResource();
        assertPeriodStoryVelocity("2016-02-01", "2016-02-08", 0.0);
    }

    @Test
    public void whenStoryCountIs1InA2WeekPeriod_thenWeeklyStoryVelocityIsPoint5() throws Exception {
        givenDefaultResource();
        whenAddingStoriesBetween(1, "2016-02-01", "2016-02-15");
        assertPeriodStoryVelocity("2016-02-01", "2016-02-15", 0.5);
    }

    @Test
    public void canAddResourceBug() throws Exception {
        givenDefaultResource();
        whenAddingBugs(1);
        thenBugCountIs(1);
    }

    @Test
    public void whenBugCountIs1InA1WeekPeriod_thenWeeklyBugVelocityIs1() throws Exception {
        givenDefaultResource();
        whenAddingBugs(1);
        assertPeriodBugVelocity("2016-02-01", "2016-02-08", 1.0);
    }

    @Test
    public void whenNoBugsAreDelivered_thenWeeklyBugVelocityIs0() throws Exception {
        givenDefaultResource();
        assertPeriodBugVelocity("2016-02-01", "2016-02-08", 0.0);
    }

    @Test
    public void whenBugCountIs1InA2WeekPeriod_thenWeeklyBugVelocityIsPoint5() throws Exception {
        givenDefaultResource();
        whenAddingBugs(1);
        assertPeriodBugVelocity("2016-02-01", "2016-02-15", 0.5);
    }
    
    @Test
	public void whenStoryCountIs1InA1DayPeriod_thenWeeklyStoryVelocityIs7() throws Exception {
        givenDefaultResource();
        whenAddingStoriesBetween(1, "2016-02-01", "2016-02-02");
        assertPeriodStoryVelocity("2016-02-01", "2016-02-02", 7.0);
	}

    private void assertPeriodStoryVelocity(String start, String end, double expectedVelocity) throws Exception {
        assertThat(resource.getWeeklyStoryVelocity(LocalDate.parse(start) , LocalDate.parse(end)), closeTo(expectedVelocity, 0.001));
    }

    private void thenStoryCountIs(int count) {
        assertThat(resource.getStories().size(), is(count));
    }

    private void whenAddingStoriesBetween(int count, String start, String end) {
        for( int i = 0; i < count; i++ ) {
        	Story s = new Story();
        	s.setName(String.format("ST-%s", i));
        	s.setId(Integer.toString(i));
        	s.setResolutionDate(generateResolutionDateInRange(start, end));
            resource.addStory(s);
        }
    }

    private ZonedDateTime generateResolutionDateInRange(String start, String end) {
    	ZonedDateTime s = ZonedDateTime.parse(start+"T00:00:00-06:00");
    	ZonedDateTime e = ZonedDateTime.parse(end+"T00:00:00-06:00");

    	Period p = Period.between(s.toLocalDate(), e.toLocalDate());
    	int randomDays = (new Random(Clock.systemUTC().millis())).ints(0, p.getDays()).iterator().next();

    	return s.plusDays(randomDays);
	}

	private void assertPeriodBugVelocity(String start, String end, double expectedVelocity) throws Exception {
        assertThat(resource.getWeeklyBugVelocity(ZonedDateTime.parse(start+"T00:00:00-06:00") , ZonedDateTime.parse(end+"T00:00:00-06:00")), closeTo(expectedVelocity, 0.001));
    }

    private void thenBugCountIs(int count) {
        assertThat(resource.getBugs().size(), is(count));
    }

    private void whenAddingBugs(int count) {
        for( int i = 0; i < count; i++ ) {
            resource.addBug(new Bug());
        }
    }

    private void givenDefaultResource() {
        resource = new Resource();
    }

    private void given100kSeniorDeveloperJohnDoe() {
        resource = new Resource("101", "John Doe", 100000.0);
    }
    
    private void thenAssertDefaults() {
        assertThat(resource.getName(), is("Bob Johnson"));
        assertThat(resource.getWeeklyHours(), is(40.0));
        assertThat(resource.getCostBasis(), is(75.0));
    }
    
    private void thenAssert100kJohnDoe() {
        assertThat("John Doe Resource Name", resource.getName(), is("John Doe"));
        assertThat("100k Resource Costs 50 Per Week", resource.getCostBasis(), is(50.0));
    }
    
}
