package net.sagon.agile.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

import org.springframework.data.annotation.Transient;
import org.springframework.data.annotation.TypeAlias;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;

import net.sagon.agile.DateUtil;
import net.sagon.agile.model.validator.LocalDateStartEnd;

@Document(collection="resource")
@TypeAlias("resource")
@LocalDateStartEnd()
public class Resource extends Model {
    private static final long serialVersionUID = 2058920244215021480L;

    @Min(1000)
    @Max(10000000)
    private double salary = 150000;

    @Min(10)
    @Max(80)
    private double weeklyHours = 40;

    @Transient
    private List<Story> stories = new ArrayList<Story>();

    @Transient
    private List<Bug> bugs = new ArrayList<Bug>();

    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
	private LocalDate start;

    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate end;

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

    public void setWeeklyHours(double weeklyHours) {
        this.weeklyHours = weeklyHours;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public double getCostBasis() {
        return salary / (weeklyHours * 50);
    }

    public int getStoryCount() {
        return stories.size();
    }

    public List<Story> getStories() {
        return stories;
    }

    public void addStory(Story story) {
        stories.add(story);
    }

    public void addStories(Collection<Story> stories) {
        this.stories.addAll(stories);
    }

    public List<Bug> getBugs() {
		return bugs;
	}

	public void addBug(Bug bug) {
		bugs.add(bug);
	}

	public LocalDate getStart() {
		return start;
	}

	public LocalDate getEnd() {
		return end;
	}

	public void setStart(LocalDate start) {
		this.start = start;
	}

	public void setEnd(LocalDate end) {
		this.end = end;
	}

    public boolean hasDeliveryInPeriod(LocalDate start, LocalDate end) {
        Optional<Story> opt = stories.stream().filter(s -> DateUtil.isBetween(s.getResolutionDate(), start, end) ).findFirst();

        return opt.isPresent();
    }

    public List<Story> getPeriodStories(LocalDate start, LocalDate end) {
        List<Story> periodStories = stories.stream()
                .filter(story -> DateUtil.isBetween(story.getResolutionDate(), start, end))
                .collect(Collectors.toList());

        return periodStories;
    }

    public List<Bug> getPeriodBugs(LocalDate start, LocalDate end) {
        List<Bug> periodBugs = bugs.stream()
                .filter(bug -> DateUtil.isBetween(bug.getResolutionDate(), start, end))
                .collect(Collectors.toList());

        return periodBugs;
    }
}
