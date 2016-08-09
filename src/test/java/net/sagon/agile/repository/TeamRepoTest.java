package net.sagon.agile.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.PagingAndSortingRepository;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Team;

public class TeamRepoTest extends AbstractRepoTest<Team, String> {

    @Autowired
    private TeamRepo repo;

    @Override
    protected PagingAndSortingRepository<Team, String> getRepo() {
        return repo;
    }

    @Override
    protected Team getModel(int i) {
        Team t = new Team(Integer.toString(i), "Team Alpha " + i);
        
        for( int j = 0; j < 10; j++ ) {
            Resource r = new Resource(i + "::" + j, "Bob Marley, " + i + "::" + j);
            t.addResource(r);
        }
        
        return t;
    }
}
