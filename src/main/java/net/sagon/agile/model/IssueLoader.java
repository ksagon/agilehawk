package net.sagon.agile.model;

import java.io.IOException;
import java.io.Reader;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import net.sagon.agile.AgileStringUtils;
import net.sagon.agile.repository.BugRepo;
import net.sagon.agile.repository.ResourceRepo;
import net.sagon.agile.repository.StoryRepo;

@Component
public class IssueLoader {
    private List<Story> stories = new ArrayList<Story>();
    private List<Bug> bugs = new ArrayList<Bug>();
    private List<Resource> resources = new ArrayList<Resource>();

    @Autowired
    private StoryRepo storyRepo;

    @Autowired
    private BugRepo bugRepo;
    
    @Autowired
    private ResourceRepo resourceRepo;

    public List<Story> getStories() {
        return stories;
    }

    public List<Bug> getBugs() {
        return bugs;
    }

    public void load(Reader issues) throws IOException {
        CSVFormat.DEFAULT.withHeader(IssueColumn.asColumnList()).parse(issues).forEach(new WorkLoaderRecordConsumer(this));
    }

    public void add(Issue issue) {
        switch( issue.getType() ) {
            case STORY:
                stories.add((Story)issue);
                break;

            case BUG:
                bugs.add((Bug)issue);
        }
    }

    public void reset() {
        resources.clear();
        stories.clear();
        bugs.clear();
    }

	public Team getTeam() {
		return new Team(stories, bugs);
	}

    public void loadFromRepo() {
        reset();

        resourceRepo.findAll().forEach( r -> resources.add(r) );
        storyRepo.findAll().forEach( s -> stories.add(s) );
        bugRepo.findAll().forEach( b -> bugs.add(b) );
    }

    public void clearRepo() {
        resourceRepo.deleteAll();
        storyRepo.deleteAll();
        bugRepo.deleteAll();
    }

    public void persist() {
        persistResources();
        persistStories();
        persistBugs();
    }

    private void persistResources() {
        resources.stream().forEach(resource -> resourceRepo.save(resource));
    }

    private void persistStories() {
        stories.stream().forEach(story -> storyRepo.save(story));
    }

    private void persistBugs() {
        bugs.stream().forEach(story -> bugRepo.save(story));
    }

    class WorkLoaderRecordConsumer implements Consumer<CSVRecord> {
        private IssueLoader loader;

        public WorkLoaderRecordConsumer(IssueLoader loader) {
            this.loader = loader;
        }

        @Override
        public void accept(CSVRecord record) {
            IssueType type = IssueType.valueOf(record.get(IssueColumn.TYPE.toString()).toUpperCase());

            Issue issue = type.getWorkItem();

            issue.setId(record.get(IssueColumn.NAME.toString()));
            issue.setName(record.get(IssueColumn.NAME.toString()));
            issue.setEpic(record.get(IssueColumn.EPIC.toString()));
            issue.setStatus(record.get(IssueColumn.STATUS.toString()));
            issue.setResolutionDate(toDate(record.get(IssueColumn.RESOLUTION_DATE.toString())));
            issue.setResolvedBy(findOrAddResource(record.get(IssueColumn.RESOLVED_BY.toString())));
            issue.setCreatedDate(toDate(record.get(IssueColumn.CREATED_DATE.toString())));
            issue.setCreatedBy(findOrAddResource(record.get(IssueColumn.CREATED_BY.toString())));
            issue.setOpenDays(Double.parseDouble(record.get(IssueColumn.OPEN_DAYS.toString())));
            issue.setDevDays(Double.parseDouble(record.get(IssueColumn.DEV_DAYS.toString())));
            issue.setQADays(Double.parseDouble(record.get(IssueColumn.QA_DAYS.toString())));

            loader.add(issue);
        }

        private LocalDateTime toDate(String d) {
            return LocalDateTime.parse(d, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"));
        }

        private Resource findOrAddResource(String resourceName) {
            String hash = AgileStringUtils.hash(resourceName);

            Optional<Resource> optional = resources.stream().filter(resource -> resource.getId().equals(hash)).findFirst();
            if( optional.isPresent() ) {
                return optional.get();
            }
            else {
                Resource r = new Resource(hash, resourceName);
                resources.add(r);
                
                return r;
            }
        }
    }

    enum IssueColumn {
        NAME,
        EPIC,
        TYPE,
        STATUS,
        RESOLUTION_DATE,
        RESOLVED_BY,
        CREATED_DATE,
        CREATED_BY,
        OPEN_DAYS,
        DEV_DAYS,
        QA_DAYS;

        public static String[] asColumnList() {
            String[] columnList = new String[values().length];
            for( int i = 0; i < values().length; i++ ) {
                columnList[i] = values()[i].toString();
            }
            
            return columnList;
        }
    }
}
