package net.sagon.agile.service;

import net.sagon.agile.model.Team;

public interface TeamService extends ModelService<Team> {

    void removeResource(String teamId, String resourceId);

}
