package net.sagon.agilecoach;

public abstract class WorkItem extends Model {
    private static final long serialVersionUID = -913600440903864934L;

    private String title;
    private String status = "Open";
    private Resource owner = new Resource();

    public WorkItem(String name, String title) {
        super(name);
        this.title = title;
    }

    public abstract String getType();
    
    public String getTitle() {
        return title;
    }

    public String getStatus() {
        return status;
    }

    public Resource getOwner() {
        return owner;
    }

}