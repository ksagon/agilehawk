package net.sagon.agile.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.hateoas.Link;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.serializer.AgileLocalDateSerializer;

public class ResourceResource extends ModelResource<Resource> {
    private double salary = 150000;
    private double weeklyHours = 40;
    private LocalDate start;
    private LocalDate end;

    public ResourceResource(Resource resource, Link link) {
        super(resource);
        
        this.salary = resource.getSalary();
        this.weeklyHours = resource.getWeeklyHours();
        this.start = resource.getStart();
        this.end = resource.getEnd();

        add(link);
    }
    
    public double getSalary() {
        return this.salary;
    }
    
    public double getWeeklyHours() {
        return this.weeklyHours;
    }

    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = AgileLocalDateSerializer.class)
    public LocalDate getStart() {
        return this.start;
    }
    
    @DateTimeFormat(iso = ISO.DATE)
    @JsonSerialize(using = AgileLocalDateSerializer.class)
    public LocalDate getEnd() {
        return this.end;
    }
    
    @Override
    public Resource asModel() {
    	Resource r = new Resource();
    	populateModel(r);

    	r.setEnd(end);
    	r.setSalary(salary);
    	r.setStart(start);
    	r.setWeeklyHours(weeklyHours);

    	return r;
    }
}
