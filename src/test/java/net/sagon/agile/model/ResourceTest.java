package net.sagon.agile.model;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.time.Clock;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

import org.junit.Test;

import net.sagon.agile.model.Bug;
import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;

public class ResourceTest {

    private Resource resource;

    @Test
    public void newResourceHas40HoursAnd75CostBasis() throws Exception {
        givenDefaultResource("2016-01-01", "2016-01-30");
        thenAssertDefaults();
    }

    @Test
	public void canSetStartAndEndDatesOnResource() throws Exception {
        givenDefaultResource("2016-01-01", "2016-01-30");
        
        assertThat(resource.getStart(), is(LocalDate.parse("2016-01-01")));
		assertThat(resource.getEnd(), is(LocalDate.parse("2016-01-30")));
	}

    @Test
    public void oneHundredKJohnDoeHas50CostBasis() throws Exception {
        given100kSeniorDeveloperJohnDoe();

        thenAssert100kJohnDoe();
    }

    @Test
    public void canAddResourceStory() throws Exception {
        givenDefaultResource("2016-02-01", "2016-02-08");
        whenAddingStoriesBetween(1, "2016-02-01", "2016-02-08");
        thenStoryCountIs(1);
    }

    @Test
    public void canAddResourceBug() throws Exception {
        givenDefaultResource("2016-02-01", "2016-02-14");
        whenAddingBugsBetween(1, "2016-02-01", "2016-02-14");
        thenBugCountIs(1);
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

    private LocalDateTime generateResolutionDateInRange(String start, String end) {
    	LocalDateTime s = LocalDateTime.parse(start+"T00:00:00");
    	LocalDateTime e = LocalDateTime.parse(end+"T23:59:59");

    	Duration d = Duration.between(s, e);
    	long randomSeconds = (new Random(Clock.systemUTC().millis())).longs(0, d.getSeconds()).iterator().next();

    	return s.plusSeconds(randomSeconds);
	}

    private void thenBugCountIs(int count) {
        assertThat(resource.getBugs().size(), is(count));
    }

    private void whenAddingBugsBetween(int count, String start, String end) {
        for( int i = 0; i < count; i++ ) {
            Bug b = new Bug();
            b.setName(String.format("B-%s", i));
            b.setId(Integer.toString(i));
            b.setResolutionDate(generateResolutionDateInRange(start, end));
            resource.addBug(b);
        }
    }

    private void givenDefaultResource(String start, String end) {
        resource = new Resource();
        resource.setStart(LocalDate.parse(start));
        resource.setEnd(LocalDate.parse(end));
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
