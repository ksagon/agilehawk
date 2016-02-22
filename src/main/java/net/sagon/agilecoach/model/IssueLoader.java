package net.sagon.agilecoach.model;

import java.io.IOException;
import java.io.Reader;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

public class IssueLoader {
    private List<Story> stories = new ArrayList<Story>();
    private List<Bug> bugs = new ArrayList<Bug>();

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

	public Team getTeam() {
		return new Team(stories, bugs);
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

            issue.setName(record.get(IssueColumn.NAME.toString()));
            issue.setEpic(record.get(IssueColumn.EPIC.toString()));
            issue.setStatus(record.get(IssueColumn.STATUS.toString()));
            issue.setResolutionDate(toDate(record.get(IssueColumn.RESOLUTION_DATE.toString())));
            issue.setResolvedBy(new Resource(record.get(IssueColumn.RESOLVED_BY.toString())));
            issue.setCreatedDate(toDate(record.get(IssueColumn.CREATED_DATE.toString())));
            issue.setCreatedBy(new Resource(record.get(IssueColumn.CREATED_BY.toString())));
            issue.setOpenDays(Double.parseDouble(record.get(IssueColumn.OPEN_DAYS.toString())));
            issue.setDevDays(Double.parseDouble(record.get(IssueColumn.DEV_DAYS.toString())));
            issue.setQADays(Double.parseDouble(record.get(IssueColumn.QA_DAYS.toString())));

            loader.add(issue);
        }

        private ZonedDateTime toDate(String d) {
            return ZonedDateTime.parse(d, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"));
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
