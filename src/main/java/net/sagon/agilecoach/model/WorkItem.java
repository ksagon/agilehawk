package net.sagon.agilecoach.model;

import java.time.ZonedDateTime;

public abstract class WorkItem extends Model {
    private static final long serialVersionUID = -913600440903864934L;

    private String title;
    private Resource owner = new Resource();
    private String epic;
    private String status = "Open";
    private ZonedDateTime resolutionDate;
    private Resource resolvedBy;
    private ZonedDateTime createdDate;
    private Resource createdBy;
    private double openDays;
    private double devDays;
    private double qaDays;

    public WorkItem(String name, String title) {
        super(name);
        this.title = title;
    }

    public abstract WorkItemType getType();
    
    public String getTitle() {
        return title;
    }

    public Resource getOwner() {
        return owner;
    }

    public void setEpic(String epic) {
        this.epic = epic;
    }
    
    public String getEpic() {
        return epic;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setResolutionDate(ZonedDateTime resolutionDate) {
        this.resolutionDate = resolutionDate;
    }
    
    public ZonedDateTime getResolutionDate() {
        return resolutionDate;
    }

    public void setResolvedBy(Resource resolvedBy) {
        this.resolvedBy = resolvedBy;
    }

    public Resource getResolvedBy() {
        return resolvedBy;
    }

    public void setCreatedDate(ZonedDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public ZonedDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedBy(Resource createdBy) {
        this.createdBy = createdBy;
    }

    public Resource getCreatedBy() {
        return createdBy;
    }

    public void setOpenDays(double openDays) {
        this.openDays = openDays;
    }

    public double getOpenDays() {
        return openDays;
    }

    public void setDevDays(double devDays) {
        this.devDays = devDays;
    }
    
    public double getDevDays() {
        return devDays;
    }

    public void setQADays(double qaDays) {
        this.qaDays = qaDays;
    }

    public double getQaDays() {
        return qaDays;
    }
}