package net.sagon.agile.service;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import net.sagon.agile.AbstractSpringTest;
import net.sagon.agile.model.Resource;
import net.sagon.agile.repository.ResourceRepo;
import net.sagon.agile.service.ResourceService;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class ResourceServiceTest extends AbstractSpringTest {

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private ResourceRepo repo;

    @Before
    public void before() {
        repo.deleteAll();
    }

    @After
    public void after() {
        repo.deleteAll();
    }

    @Test
    public void canSaveResource() {
        Resource resource = new Resource("Kevin Sagon", "Kevin Sagon", 100000);

        resourceService.save(resource);

        Resource result = resourceService.find("Kevin Sagon");

        assertThat(result, is(resource));
        
        resourceService.delete("Kevin Sagon");
    }

    @Test
    public void canLoadAllResources() throws Exception {
        List<Resource> resources = new ArrayList<Resource>();

        resources.add(new Resource("Alpha", "Alpha"));
        resources.add(new Resource("Omega", "Omega"));

        resourceService.save(resources);

        List<Resource> foundResources = resourceService.findAll();

        assertThat(foundResources.size(), is(2));

        resourceService.delete("Alpha");
        resourceService.delete("Omega");
    }

    @Test
    public void canDelete() throws Exception {
        Resource resource = new Resource("deletedOne", "deletedOne");
        resourceService.save(resource);
        assertNotNull(resourceService.find("deletedOne"));

        resourceService.delete("deletedOne");
        assertNull(resourceService.find("deletedOne"));
    }

}
