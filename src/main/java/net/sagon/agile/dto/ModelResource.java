package net.sagon.agile.dto;

import org.springframework.hateoas.ResourceSupport;

import net.sagon.agile.model.Model;

public abstract class ModelResource<M extends Model> extends ResourceSupport {
    private String id;
    private String name;

    public ModelResource(M model) {
        this.id = model.getId();
        this.name = model.getName();
    }
    
    public String getModelId() {
        return this.id;
    }
    
    public String getName() {
        return this.name;
    }

    public abstract M asModel();
    
    protected void populateModel(M model) {
    	model.setId(this.id);
    	model.setName(this.name);
    }
}
