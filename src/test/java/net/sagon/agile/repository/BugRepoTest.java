package net.sagon.agile.repository;

import org.springframework.beans.factory.annotation.Autowired;

import net.sagon.agile.model.Bug;

public class BugRepoTest extends AbstractRepoTest<Bug, String> {

    @Autowired
    private BugRepo repo;

    @Override
    protected ModelRepo<Bug> getRepo() {
        return repo;
    }

    @Override
    protected Bug getModel(int i) {
        return new Bug(Integer.toString(i), "Bug " + i, "Bug " + i);
    }
}
