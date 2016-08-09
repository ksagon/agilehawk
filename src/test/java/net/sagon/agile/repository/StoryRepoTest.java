package net.sagon.agile.repository;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import net.sagon.agile.model.Resource;
import net.sagon.agile.model.Story;

public class StoryRepoTest extends AbstractRepoTest<Story, String> {

    @Autowired
    private StoryRepo repo;
    
    private List<Story> results;

    @Override
    protected Story getModel(int i) {
        Story s = new Story(Integer.toString(i), "Story " + i, "Story " + i);
        s.setResolvedBy(givenResolvedBy("Kevin Sagon"));
        return s;
    }
    
    private Resource givenResolvedBy(String name) {
        return new Resource(name, name);
    }

    @Override
    protected ModelRepo<Story> getRepo() {
        return repo;
    }
    
    @Test
    public void canLoadByResolvedBy() throws Exception {
        givenSomeStoriesWithResources(10);
        whenFindingByResolvedBy("Kevin Sagon");
        then10StoriesAreFound();
    }

    private void givenSomeStoriesWithResources(int i) {
        whenLoading(10);
    }

    private void whenFindingByResolvedBy(String name) {
        results = repo.findByResolvedBy(new Resource(name, name));
    }

    private void then10StoriesAreFound() {
        assertThat(results.size(), is(10));
    }
}
