package net.sagon.agile.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.hateoas.Link;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import net.sagon.agile.model.Team;
import net.sagon.agile.model.serializer.AgileLocalDateSerializer;

public class TeamResource extends ModelResource<Team> {
    private LocalDate start;
    private LocalDate end;

    public TeamResource(Team team, Link link) {
        super(team);
        
        this.end = team.getEnd();
        this.start = team.getStart();

        add(link);
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
    public Team asModel() {
    	Team t = new Team();
    	populateModel(t);

    	return t;
    }
}
