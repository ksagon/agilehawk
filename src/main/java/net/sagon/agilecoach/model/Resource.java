package net.sagon.agilecoach.model;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class Resource extends Model {
    private static final long serialVersionUID = 2058920244215021480L;

    private double salary = 150000;
    private double weeklyHours = 40;

    private List<Story> stories = new ArrayList<Story>();
    private List<Bug> bugs = new ArrayList<Bug>();

	private static final double SECONDS_IN_A_WEEK = 7.0 * 24.0 * 60.0 * 60.0;

    public Resource() {
        super("Bob Johnson");
    }

    public Resource(long id, String name) {
        super(id, name);
    }

    public Resource(String name) {
        super(name);
    }

    public Resource(long id, String name, double salary) {
        super(id, name);
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

	public List<Bug> getBugs() {
		return bugs;
	}

	public void addBug(Bug bug) {
		bugs.add(bug);
	}

    public double getWeeklyStoryVelocity(ZonedDateTime start, ZonedDateTime end) {
        return calculatePeriodVelocity(stories.stream()
        		.filter(story -> 
        			story.getResolutionDate() != null
        			&& story.getResolutionDate().isAfter(start)
        			&& story.getResolutionDate().isBefore(end))
    			.count(), start, end);
    }

	public double getWeeklyBugVelocity(ZonedDateTime start, ZonedDateTime end) {
        return calculatePeriodVelocity(bugs.size(), start, end);
	}

	private double calculatePeriodVelocity(double itemCount, ZonedDateTime start, ZonedDateTime end) {
        double millisInPeriod = end.toEpochSecond() - start.toEpochSecond();
        double velocityFactor = millisInPeriod / SECONDS_IN_A_WEEK;

        return itemCount / velocityFactor;
	}
}
