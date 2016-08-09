package net.sagon.agile.model;

import java.time.LocalDateTime;

import org.springframework.data.mongodb.core.mapping.DBRef;

public abstract class Issue extends Model {
    private static final long serialVersionUID = -913600440903864934L;

    private String title;
    private String epic;
    private String status = "Open";
    private LocalDateTime resolutionDate;
    
    @DBRef
    private Resource resolvedBy;

    private LocalDateTime createdDate;
    
    @DBRef
    private Resource createdBy;

    private double openDays;
    private double devDays;
    private double qaDays;

    public Issue(String id, String name, String title) {
        super(id, name);
        this.title = title;
    }

    public Issue(String name, String title) {
        super(name);
        this.title = title;
    }

    public abstract IssueType getType();
    
    public String getTitle() {
        return title;
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

    public void setResolutionDate(LocalDateTime resolutionDate) {
        this.resolutionDate = resolutionDate;
    }
    
    public LocalDateTime getResolutionDate() {
        return resolutionDate;
    }

    public void setResolvedBy(Resource resolvedBy) {
        this.resolvedBy = resolvedBy;
    }

    public Resource getResolvedBy() {
        return resolvedBy;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public LocalDateTime getCreatedDate() {
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

    public double getQADays() {
        return qaDays;
    }
}