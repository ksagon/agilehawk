package net.sagon.agilecoach.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Team {

    private List<Resource> resources = new ArrayList<Resource>();

    public List<Resource> getResources() {
        return resources;
    }

    public void addResource(Resource resource) {
        resources .add(resource);
    }

    public double getPeriodStoryVelocity(Date start, Date end) {
        if( resources.size() == 0 ) {
            return 0;
        }

        double totalVelocity = 0.0;
        for( int i = 0; i < resources.size(); i++ ) {
            totalVelocity += resources.get(i).getWeeklyStoryVelocity(start, end);
        }

        return totalVelocity / resources.size();
    }
}
