package net.sagon.agile.service.impl;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;
import net.sagon.agile.model.Team;
import net.sagon.agile.repository.ModelRepo;
import net.sagon.agile.repository.StoryRepo;
import net.sagon.agile.repository.TeamRepo;
import net.sagon.agile.service.ResourceService;
import net.sagon.agile.service.TeamService;

@Service
public class TeamServiceImpl extends ModelServiceImpl<Team> implements TeamService {
    private final static Logger LOG = LoggerFactory.getLogger(TeamServiceImpl.class);

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private StoryRepo storyRepo;

    @Autowired
    private TeamRepo repo;

    @Override
    public ModelRepo<Team> getRepo() {
    	return repo;
    }

    @Override
    public Team find(String id) {
        Team team = super.find(id);

        if( team != null ) {
            team.getResources().forEach(r -> {
                List<Story> stories = storyRepo.findByResolvedBy(r);
                r.addStories(stories);
            });
        }

        return team;
    }

    @Override
    public void save(Team team) {
        resourceService.save(Arrays.asList(team.getResources().toArray(new Resource[0])));

        super.save(team);
    }

    @Override
    public void removeResource(String teamId, String resourceId) {
        Team t = repo.findOne(teamId);
        if( t != null ) {
            t.removeResource(resourceId);
            
            repo.save(t);
        }
    }
    
}
