package net.sagon.agilecoach;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.number.IsCloseTo.closeTo;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;

import java.text.ParseException;
import java.text.SimpleDateFormat;

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

    private void assertPeriodStoryVelocity(String start, String end, double expectedVelocity) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            assertThat(resource.getWeeklyStoryVelocity(sdf.parse(start) , sdf.parse(end)), closeTo(expectedVelocity, 0.001));
        }
        catch (ParseException e) {
            fail("Unable to parse start / end dates");
        }
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
        resource = new Resource("John", "Doe", 100000.0);
    }
    
    private void thenAssertDefaults() {
        assertThat(resource.getFirstName(), is("Bob"));
        assertThat(resource.getLastName(), is("Johnson"));
        assertThat(resource.getWeeklyHours(), is(40.0));
        assertThat(resource.getCostBasis(), is(75.0));
    }
    
    private void thenAssert100kJohnDoe() {
        assertThat("John Doe Resource First Name", resource.getFirstName(), is("John"));
        assertThat("John Doe Resource Last Name", resource.getLastName(), is("Doe"));
        assertThat("100k Resource Costs 50 Per Week", resource.getCostBasis(), is(50.0));
    }
    
}
