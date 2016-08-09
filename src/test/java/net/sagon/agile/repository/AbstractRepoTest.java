package net.sagon.agile.repository;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.data.repository.PagingAndSortingRepository;

import net.sagon.agile.AbstractSpringTest;

public abstract class AbstractRepoTest<T, S extends Serializable> extends AbstractSpringTest {
    @Before
    public void before() {
        givenEmptyRepo();
    }

    @After
    public void after() {
        givenEmptyRepo();
    }

    @Test
    public void canLoadRepo() {
        Iterable<T> models  = new ArrayList<T>();
        whenLoading(10);

        models = getRepo().findAll();
        assertThat(models.spliterator().getExactSizeIfKnown(), is(10L));
    }

    protected void whenLoading(int count) {
        for( int i = 0; i < count; i++ ) {
            T model = getModel(i);
            getRepo().save(model);
        }
    }

    protected void givenEmptyRepo() {
        getRepo().deleteAll();
    }
    
    protected abstract PagingAndSortingRepository<T, S> getRepo();
    protected abstract T getModel(int i);
}
