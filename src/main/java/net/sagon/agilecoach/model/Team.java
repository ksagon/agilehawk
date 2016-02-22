package net.sagon.agilecoach.model;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

public class Team {

    private Set<Resource> resources = new HashSet<Resource>();
	private LocalDate start;
	private LocalDate end;

    public Team() {
    }
    
    public Team(List<Story> stories, List<Bug> bugs) {
    	stories.forEach(story -> this.addStory(story));
    	bugs.forEach(bug -> this.addBug(bug));
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

	public Set<Resource> getResources() {
        return resources;
    }

    public void addResource(Resource resource) {
        resources.add(resource);
    }

	public void addStory(Story story) {
		Resource r = findOrAddResource(story);
		r.addStory(story);
	}

	public void addBug(Bug bug) {
		Resource r = findOrAddResource(bug);
		r.addBug(bug);
	}

	public double getPeriodStoryVelocity(LocalDate start, LocalDate end) {
		if( start == null || end == null ) {
			return 0.0;
		}

		return resources.stream().collect(Collectors.averagingDouble( resource -> resource.getWeeklyStoryVelocity(start, end) ));
    }

	public double getPeriodStoryVelocity() {
        return getPeriodStoryVelocity(start, end);
	}

	private Resource findOrAddResource(Issue issue) {
		Resource r = issue.getResolvedBy();

		Optional<Resource> optional = resources.stream().filter(resource -> resource.getName().equalsIgnoreCase(issue.getResolvedBy().getName())).findFirst();
		if( optional.isPresent() ) {
			r = optional.get();
		}
		else {
			resources.add(r);
		}

		return r;
	}

}
