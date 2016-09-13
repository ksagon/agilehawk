package net.sagon.agile.dto;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

import java.time.LocalDateTime;

import org.apache.commons.lang3.NotImplementedException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.hateoas.Link;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import net.sagon.agile.controller.rest.ResourceAPIController;
import net.sagon.agile.model.Issue;
import net.sagon.agile.model.serializer.AgileLocalDateTimeSerializer;

public abstract class IssueResource<I extends Issue> extends ModelResource<I> {
	private String title;
    private String epic;
    private String status = "Open";
    private LocalDateTime resolutionDate;
    private ResourceResource resolvedBy;
    private LocalDateTime createdDate;
    private ResourceResource createdBy;
    private double openDays;
    private double devDays;
    private double qaDays;

    public IssueResource(I issue, Link link) {
        super(issue);

        this.title = issue.getTitle();
        this.epic = issue.getEpic();
        this.status = issue.getStatus();
        this.resolutionDate = issue.getResolutionDate();
        this.createdDate = issue.getCreatedDate();
        this.openDays = issue.getOpenDays();
        this.devDays = issue.getDevDays();
        this.qaDays = issue.getQADays();

        try {
        	if( issue.getResolvedBy() != null ) {
        		this.resolvedBy = new ResourceResource(issue.getResolvedBy(), linkTo(ResourceAPIController.class, ResourceAPIController.class.getMethod("get", String.class), issue.getResolvedBy().getId()).withSelfRel());
        	}
        	
        	if( issue.getCreatedBy() != null ) {
        		this.createdBy = new ResourceResource(issue.getCreatedBy(), linkTo(ResourceAPIController.class, ResourceAPIController.class.getMethod("get", String.class), issue.getCreatedBy().getId()).withSelfRel());
        	}
        }
        catch(NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
    	
        add(link);
    }
    
    public String getTitle() {
		return title;
	}

	public String getEpic() {
		return epic;
	}

	public String getStatus() {
		return status;
	}

    @DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonSerialize(using = AgileLocalDateTimeSerializer.class)
	public LocalDateTime getResolutionDate() {
		return resolutionDate;
	}

	public ResourceResource getResolvedBy() {
		return resolvedBy;
	}

    @DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonSerialize(using = AgileLocalDateTimeSerializer.class)
	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public ResourceResource getCreatedBy() {
		return createdBy;
	}

	public double getOpenDays() {
		return openDays;
	}

	public double getDevDays() {
		return devDays;
	}

	public double getQaDays() {
		return qaDays;
	}
    
    protected void populateIssue(I i) {
    	super.populateModel(i);
    	
        i.setTitle(this.title);
        i.setEpic(this.epic);
        i.setStatus(this.status);
        i.setResolutionDate(this.resolutionDate);
        i.setCreatedDate(this.createdDate);
        i.setOpenDays(this.openDays);
        i.setDevDays(this.devDays);
        i.setQADays(this.qaDays);
        i.setResolvedBy(this.resolvedBy.asModel());
        i.setCreatedBy(this.createdBy.asModel());

    }
}
