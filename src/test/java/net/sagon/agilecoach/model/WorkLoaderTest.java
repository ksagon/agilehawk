package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.StringReader;

import net.sagon.agilecoach.model.WorkLoader;

import org.junit.Test;

public class WorkLoaderTest {

    @Test
    public void canInstantiate() {
        WorkLoader storyLoader = new WorkLoader();
        assertThat(storyLoader, notNullValue());
    }

    @Test
    public void canLoadWorkFromStream() throws Exception {
        WorkLoader loader = new WorkLoader();

        StringReader work = new StringReader("ST-1,EP-1,STORY,Resolved,2016-02-03T10:58:37.000-0600,John Doe,2015-09-16T14:39:39.000-0500,Megan Manager,6.03,12.83,0.06");
        loader.load(work);
        work.close();

        assertThat(loader.getStories().size(), is(1));
    }
    
    @Test
    public void canLoadFromFileStream() throws Exception {
        WorkLoader loader = new WorkLoader();
        
        BufferedReader work = new BufferedReader(new FileReader(ClassLoader.getSystemResource("work.csv").getFile()));
        loader.load(work);
        work.close();
        
        assertThat(loader.getStories().size(), is(3));
        assertThat(loader.getBugs().size(), is(6));
    }
}
