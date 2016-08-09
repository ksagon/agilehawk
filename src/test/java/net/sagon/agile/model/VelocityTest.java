package net.sagon.agile.model;

import static org.junit.Assert.*;

import static org.hamcrest.number.IsCloseTo.closeTo;

import java.time.LocalDate;

import org.junit.Test;

import net.sagon.agile.model.Period;
import net.sagon.agile.model.Velocity;

public class VelocityTest {
    @Test
    public void oneStoryPerDay() throws Exception {
        assertVelocity(1);
    }

    @Test
    public void oneStoryPerWeek() throws Exception {
        assertVelocity(7);
    }

    @Test
    public void oneStoryPerBiWeek() throws Exception {
        assertVelocity(14);
    }
    
    @Test
    public void oneStoryPerMonth() throws Exception {
        assertVelocity(30);
    }
    
    private void assertVelocity(int daysInPeriod) {
        LocalDate start = LocalDate.parse("2016-02-15");
        LocalDate end = start.plusDays(daysInPeriod - 1);

        Velocity velocity = new Velocity(start, end, 1);

        assertThat(velocity.getVelocity(Period.DAY), closeTo(1.0/daysInPeriod, 0.001));
        assertThat(velocity.getVelocity(Period.WEEK), closeTo(7.0/daysInPeriod, 0.001));
        assertThat(velocity.getVelocity(Period.BIWEEK), closeTo(14.0/daysInPeriod, 0.001));
        assertThat(velocity.getVelocity(Period.MONTH), closeTo(30.0/daysInPeriod, 0.001));
    }    
}
