package net.sagon.agilecoach.model;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;

import net.sagon.agilecoach.model.IssueLoader;

import org.junit.Test;

public class IssueLoaderTest {

    @Test
    public void canInstantiate() {
        IssueLoader storyLoader = new IssueLoader();
        assertThat(storyLoader, notNullValue());
    }

    @Test
    public void canLoadWorkFromStream() throws Exception {
        IssueLoader loader = initIssueLoader(1, 0);

        assertThat(loader.getStories().size(), is(1));
    }

	@Test
    public void canLoadFromFileStream() throws Exception {
        IssueLoader loader = new IssueLoader();

        try( BufferedReader work = new BufferedReader(new FileReader(ClassLoader.getSystemResource("work.csv").getFile())) ) {
	        loader.load(work);
        }

        assertThat(loader.getStories().size(), is(3));
        assertThat(loader.getBugs().size(), is(6));
    }
	
	@Test
	public void canGetTeamFromWorkLoader() throws Exception {
        IssueLoader loader = initIssueLoader(10, 10);

        assertThat(loader.getTeam(), notNullValue());
	}

	private IssueLoader initIssueLoader(int storyCount, int bugCount) throws IOException {
		IssueLoader loader = new IssueLoader();

		String csvIssues = "";

		for( int i = 0; i < storyCount; i++ ) {
			csvIssues += String.format("ST-%s,EP-1,STORY,Resolved,2016-02-03T10:58:37.000-0600,John Doe,2015-09-16T14:39:39.000-0500,Megan Manager,6.03,12.83,0.06\n", i);
		}

		for( int i = 0; i < bugCount; i++ ) {
			csvIssues += String.format("BUG-%s,,BUG,Resolved,2016-02-03T10:58:37.000-0600,John Doe,2015-09-16T14:39:39.000-0500,Megan Manager,6.03,12.83,0.06\n", i);
		}

		StringReader work = new StringReader(csvIssues);
        loader.load(work);
        work.close();
		return loader;
	}
    
}
