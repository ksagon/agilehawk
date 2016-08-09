package net.sagon.agile.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.annotation.Transient;
import org.springframework.data.annotation.TypeAlias;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;

import net.sagon.agile.DateUtil;
import net.sagon.agile.model.validator.LocalDateStartEnd;

@Document(collection="team")
@TypeAlias("team")
@LocalDateStartEnd
public class Team extends Model {
    private static final long serialVersionUID = -2172216712974358170L;
    private static final Logger LOG = LoggerFactory.getLogger(Team.class);

    @DBRef
    private Set<Resource> resources = new HashSet<Resource>();

    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    @NotNull
    private LocalDate start;

    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    @NotNull
    private LocalDate end;

    public Team() {
    }

    public Team(String id, String name) {
        super(id, name);
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
    
    public void removeResource(String resourceId) {
        resources.removeIf(r -> r != null && r.hasId() && r.getId().equals(resourceId) );
    }
    
    public Resource getResource(String resourceId) {
        return resources.stream().filter(r -> r != null && r.hasId() && r.getId().equals(resourceId) ).findFirst().get();
    }

	public void addStory(Story story) {
		Resource r = findOrAddResource(story);
		if( r != null ) {
		    r.addStory(story);
		}
	}

	public void addBug(Bug bug) {
		Resource r = findOrAddResource(bug);
		if( r != null ) {
		    r.addBug(bug);
		}
	}

    public Set<Resource> getPeriodResources(LocalDate start, LocalDate end) {
        Set<Resource> periodResources = resources.stream()
                .filter(r -> r != null && r.hasDeliveryInPeriod(start, end))
            .collect(Collectors.toSet());

        periodResources.forEach(r -> {
            r.setStart(DateUtil.max(start, r.getStart())); 
            r.setEnd(DateUtil.min(end, r.getEnd()));
        });

        return periodResources;
    }

    public List<Story> getPeriodStories(LocalDate start, LocalDate end) {
        List<Story> periodStories = new ArrayList<>();

        resources.stream().forEach(r -> {
            periodStories.addAll(r.getPeriodStories(DateUtil.max(start, r.getStart()), DateUtil.min(end, r.getEnd()))); 
        });

        return periodStories;
    }

	public double getPeriodStoryVelocity(Period period, LocalDate start, LocalDate end) {
		if( start == null || end == null ) {
			return 0.0;
		}

		Velocity v = new Velocity(start, end, getPeriodStories(start, end));

		return v.getVelocity(period);
    }

	private Resource findOrAddResource(Issue issue) {
		Resource r = issue.getResolvedBy();

		if( r != null ) {
    		Optional<Resource> optional = resources.stream().filter(resource -> StringUtils.isNotEmpty(resource.getId()) && resource.getId().equalsIgnoreCase(issue.getResolvedBy().getId())).findFirst();
    		if( optional.isPresent() ) {
    			r = optional.get();
    		}
    		else {
    			resources.add(r);
    		}
		}

		return r;
	}

}
