package net.sagon.agilecoach;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Resource extends Model {
    private static final long serialVersionUID = 2058920244215021480L;

    private String firstName = "Bob";
    private String lastName = "Johnson";
    private double salary = 150000;
    private double weeklyHours = 40;

    private List<Story> stories = new ArrayList<Story>();

    public Resource() {
    }

    public Resource(String firstName, String lastName, double salary) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.salary = salary;
    }

    public double getWeeklyHours() {
        return weeklyHours;
    }

    public double getCostBasis() {
        return salary / (weeklyHours * 50);
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public List<Story> getStories() {
        return stories;
    }

    public void addStory(Story story) {
        stories.add(story);
    }

    public double getWeeklyStoryVelocity(Date start, Date end) {
        double millisInAWeek = 7.0 * 24.0 * 60.0 * 60.0 * 1000.0;
        double millisInPeriod = end.getTime() - start.getTime();
        double velocityFactor = millisInPeriod / millisInAWeek;

        return stories.size() / velocityFactor;
    }
}
