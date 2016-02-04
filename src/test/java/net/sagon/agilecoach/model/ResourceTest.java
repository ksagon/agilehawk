package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.number.IsCloseTo.*;
import static org.junit.Assert.*;

import java.text.SimpleDateFormat;

import net.sagon.agilecoach.model.Resource;
import net.sagon.agilecoach.model.Story;

import org.junit.Test;

public class ResourceTest {

    private Resource resource;

    @Test
    public void newResourceHas40HoursAnd75CostBasis() throws Exception {
        givenDefaultResource();
        thenAssertDefaults();
    }

    @Test
    public void oneHundredKJohnDoeHas50CostBasis() throws Exception {
        given100kSeniorDeveloperJohnDoe();

        thenAssert100kJohnDoe();
    }

    @Test
    public void canGetResourceStories() throws Exception {
        givenDefaultResource();
        assertNotNull(resource.getStories());
    }
    
    @Test
    public void canAddResourceStory() throws Exception {
        givenDefaultResource();
        whenAddingStories(1);
        thenStoryCountIs(1);
    }
    
    @Test
    public void whenStoryCountIs1InA1WeekPeriod_thenWeeklyStoryVelocityIs1() throws Exception {
        givenDefaultResource();
        whenAddingStories(1);
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
        whenAddingStories(1);
        assertPeriodStoryVelocity("2016-02-01", "2016-02-15", 0.5);
    }

    private void assertPeriodStoryVelocity(String start, String end, double expectedVelocity) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        assertThat(resource.getWeeklyStoryVelocity(sdf.parse(start) , sdf.parse(end)), closeTo(expectedVelocity, 0.001));
    }

    private void thenStoryCountIs(int count) {
        assertThat(resource.getStories().size(), is(count));
    }

    private void whenAddingStories(int count) {
        for( int i = 0; i < count; i++ ) {
            resource.addStory(new Story());
        }
    }

    private void givenDefaultResource() {
        resource = new Resource();
    }

    private void given100kSeniorDeveloperJohnDoe() {
        resource = new Resource("John Doe", 100000.0);
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
