package net.sagon.agilecoach.model;

import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

public class Team {

    private Set<Resource> resources = new HashSet<Resource>();

    public Team() {
    }
    
    public Team(List<Story> stories, List<Bug> bugs) {
    	stories.forEach(story -> this.addStory(story));
    	bugs.forEach(bug -> this.addBug(bug));
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

	public double getPeriodStoryVelocity(ZonedDateTime start, ZonedDateTime end) {
        return resources.stream().collect(Collectors.averagingDouble( resource -> resource.getWeeklyStoryVelocity(start, end) ));
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
