package net.sagon.agile.model;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.data.annotation.Id;


public class Model extends ReflectionToStringAdapter {
    private static final long serialVersionUID = 1402559319987770774L;

    @Id
    private String id;
    
    @NotBlank
    private String name = "";

    public Model() {
    }

    public Model(String id, String name) {
        setId(id);
        this.name = name;
    }

    public Model(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        if( StringUtils.isNotBlank(id) ) {
            this.id = id;
        }
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean hasId() {
        return StringUtils.isNotEmpty(id);
    }

    @Override
    public boolean equals(Object obj) {
        return obj != null && obj instanceof Model && hasId() && this.id.equals(((Model)obj).id);
    }

    @Override
    public int hashCode() {
        if (hasId()) {
            return (getClass().getName() + getId()).hashCode();
        }

        return (getClass().getName() + System.identityHashCode(this)).hashCode();
    }
}
