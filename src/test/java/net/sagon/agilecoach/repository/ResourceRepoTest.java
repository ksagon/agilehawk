package net.sagon.agilecoach.repository;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import net.sagon.agilecoach.AbstractSpringTest;
import net.sagon.agilecoach.model.Resource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class ResourceRepoTest extends AbstractSpringTest {

    @Autowired
    private ResourceRepo repo;

    @Test
    public void canLoadResourceRepo() {
        List<Resource> resources  = new ArrayList<Resource>();
        givenEmptyRepo();
        whenLoadingResources(10);

        resources = repo.findAll();
        assertThat(resources.size(), is(10));
    }

    private void whenLoadingResources(int resourceCount) {
        for( int i = 0; i < resourceCount; i++ ) {
            Resource r = new Resource(Integer.toString(i), "Resource " + i);
            System.out.println("Saving " + r);
            repo.save(r);
        }
    }

    private void givenEmptyRepo() {
        repo.deleteAll();
    }

}
