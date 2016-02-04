package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.number.IsCloseTo.*;
import static org.junit.Assert.*;

import java.text.SimpleDateFormat;

import net.sagon.agilecoach.model.Resource;
import net.sagon.agilecoach.model.Story;
import net.sagon.agilecoach.model.Team;

import org.junit.Test;

public class TeamTest {
    private Team team;

    @Test
    public void canAddResourcesToTeam() throws Exception {
        givenTeamWithResources(2, 0);
        assertThat(team.getResources().size(), is(2));
    }

    @Test
    public void aTeamOfSize0Has0Velocity() throws Exception {
        givenTeamWithResources(0, 0);
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 0.0);
    }

    @Test
    public void when1ResourceCompletes1StoryIn1Week_thenTeamVelocityIs1() throws Exception {
        givenTeamWithResources(1, 1);
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 1.0);
    }

    @Test
    public void when2ResourceComplete2StoryIn2Weeks_thenTeamVelocityIsPoint5() throws Exception {
        givenTeamWithResources(2, 1);
        assertPeriodStoryVelocity("2016-02-04", "2016-02-18", 0.5);
    }

    @Test
    public void when4ResourceComplete8StoryIn1Weeks_thenTeamVelocityIs2() throws Exception {
        givenTeamWithResources(4, 2);
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 2.0);
    }

    @Test
    public void when2ResourcesComplete2StoriesIn1Week_thenTeamVelocityIs1() throws Exception {
        givenTeamWithResources(2, 1);
        assertPeriodStoryVelocity("2016-02-04", "2016-02-11", 1.0);
    }

    private void givenTeamWithResources(int resourceCount, int storiesPerResource) {
        team = new Team();

        for( int i = 0; i < resourceCount; i++ ) {
            Resource r = new Resource();
            for( int j = 0; j < storiesPerResource; j++ ) {
                r.addStory(new Story());
            }

            team.addResource(r);
        }
    }
    
    private void assertPeriodStoryVelocity(String start, String end, double expectedVelocity) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        assertThat(team.getPeriodStoryVelocity(sdf.parse(start) , sdf.parse(end)), closeTo(expectedVelocity, 0.001));
    }
}
