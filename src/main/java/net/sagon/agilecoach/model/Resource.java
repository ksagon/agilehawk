package net.sagon.agilecoach.model;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="resource")
public class Resource extends Model {
    private static final long serialVersionUID = 2058920244215021480L;

    private double salary = 150000;
    private double weeklyHours = 40;

    private List<Story> stories = new ArrayList<Story>();
    private List<Bug> bugs = new ArrayList<Bug>();

	private LocalDate start;

	private LocalDate end;

	private static final double SECONDS_IN_A_WEEK = 7.0 * 24.0 * 60.0 * 60.0;

    public Resource() {
        super("Bob Johnson");
    }

    public Resource(String id, String name) {
        super(id, name);
    }

    public Resource(String name) {
        super(name);
    }

    public Resource(String id, String name, double salary) {
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

    public double getWeeklyStoryVelocity(LocalDate start, LocalDate end) {
        return calculatePeriodVelocity(stories.stream()
        		.filter(story -> 
        			story.getResolutionDate() != null
        			&& (story.getResolutionDate().isAfter(start.atStartOfDay(ZoneId.systemDefault())) || story.getResolutionDate().isEqual(start.atStartOfDay(ZoneId.systemDefault())))
        			&& (story.getResolutionDate().isBefore(end.atStartOfDay(ZoneId.systemDefault())) || story.getResolutionDate().isEqual(end.atStartOfDay(ZoneId.systemDefault()))))
    			.count(), start.atStartOfDay(ZoneId.systemDefault()), end.atStartOfDay(ZoneId.systemDefault()));
    }

	public double getWeeklyBugVelocity(ZonedDateTime start, ZonedDateTime end) {
        return calculatePeriodVelocity(bugs.size(), start, end);
	}

	private double calculatePeriodVelocity(double itemCount, ZonedDateTime start, ZonedDateTime end) {
        double millisInPeriod = end.toEpochSecond() - start.toEpochSecond();
        double velocityFactor = millisInPeriod / SECONDS_IN_A_WEEK;

        return itemCount / velocityFactor;
	}

	public LocalDate getStartDate() {
		return start;
	}

	public LocalDate getEndDate() {
		return end;
	}

	public void setStartDate(LocalDate start) {
		this.start = start;
	}

	public void setEndDate(LocalDate end) {
		this.end = end;
	}
}
