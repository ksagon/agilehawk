package net.sagon.agilecoach.model;


public class Model extends ReflectionToStringAdapter {
    private static final long serialVersionUID = 1402559319987770774L;

    private long id  = -1;
    private String name = "";

    public Model() {
    }
    
    public Model(long id, String name) {
    	this.id = id;
        this.name = name;
    }

    public Model(String name) {
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean hasId() {
        return id != -1;
    }

    @Override
    public boolean equals(Object obj) {
        return obj != null && this.id == ((Model)obj).id && this.id != -1;
    }

    @Override
    public int hashCode() {
        if (hasId()) {
            return (getClass().getName() + getId()).hashCode();
        }

        return (getClass().getName() + System.identityHashCode(this)).hashCode();
    }
}
