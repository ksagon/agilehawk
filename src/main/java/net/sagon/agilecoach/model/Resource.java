package net.sagon.agilecoach.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Resource extends Model {
    private static final long serialVersionUID = 2058920244215021480L;

    private double salary = 150000;
    private double weeklyHours = 40;

    private List<Story> stories = new ArrayList<Story>();

    public Resource() {
        super("Bob Johnson");
    }

    public Resource(String name) {
        super(name);
    }

    public Resource(String name, double salary) {
        super(name);
        this.salary = salary;
    }

    public double getWeeklyHours() {
        return weeklyHours;
    }

    public double getCostBasis() {
        return salary / (weeklyHours * 50);
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
