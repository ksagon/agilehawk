package net.sagon.agile.repository;

import org.springframework.beans.factory.annotation.Autowired;

import net.sagon.agile.model.Resource;

public class ResourceRepoTest extends AbstractRepoTest<Resource, String> {
    @Autowired
    private ResourceRepo repo;

    @Override
    protected ModelRepo<Resource> getRepo() {
        return repo;
    }

    @Override
    protected Resource getModel(int i) {
        return new Resource(Integer.toString(i), "Resource " + i);
    }
}
