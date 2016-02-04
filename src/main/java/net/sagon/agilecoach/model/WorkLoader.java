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

public class WorkLoader {
    private List<Story> stories = new ArrayList<Story>();
    private List<Bug> bugs = new ArrayList<Bug>();

    public List<Story> getStories() {
        return stories;
    }

    public List<Bug> getBugs() {
        return bugs;
    }

    public void load(Reader work) throws IOException {
        CSVFormat.DEFAULT.withHeader(WorkColumn.asColumnList()).parse(work).forEach(new WorkLoaderRecordConsumer(this));
    }

    public void add(WorkItem workItem) {
        switch( workItem.getType() ) {
            case STORY:
                stories.add((Story)workItem);
                break;
            
            case BUG:
                bugs.add((Bug)workItem);
                break;
        }
    }

    class WorkLoaderRecordConsumer implements Consumer<CSVRecord> {
        private WorkLoader loader;

        public WorkLoaderRecordConsumer(WorkLoader loader) {
            this.loader = loader;
        }

        @Override
        public void accept(CSVRecord record) {
            WorkItemType type = WorkItemType.valueOf(record.get(WorkColumn.TYPE.toString()).toUpperCase());
            WorkItem workItem = type.getWorkItem();

            workItem.setName(record.get(WorkColumn.NAME.toString()));
            workItem.setEpic(record.get(WorkColumn.EPIC.toString()));
            workItem.setStatus(record.get(WorkColumn.STATUS.toString()));
            workItem.setResolutionDate(toDate(record.get(WorkColumn.RESOLUTION_DATE.toString())));
            workItem.setResolvedBy(new Resource(record.get(WorkColumn.RESOLVED_BY.toString())));
            workItem.setCreatedDate(toDate(record.get(WorkColumn.CREATED_DATE.toString())));
            workItem.setCreatedBy(new Resource(record.get(WorkColumn.CREATED_BY.toString())));
            workItem.setOpenDays(Double.parseDouble(record.get(WorkColumn.OPEN_DAYS.toString())));
            workItem.setDevDays(Double.parseDouble(record.get(WorkColumn.DEV_DAYS.toString())));
            workItem.setQADays(Double.parseDouble(record.get(WorkColumn.QA_DAYS.toString())));

            loader.add(workItem);
        }

        private ZonedDateTime toDate(String d) {
            return ZonedDateTime.parse(d, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"));
        }

    }

    enum WorkColumn {
        NAME,EPIC,TYPE,STATUS,RESOLUTION_DATE,RESOLVED_BY,CREATED_DATE,CREATED_BY,OPEN_DAYS,DEV_DAYS,QA_DAYS;

        public static String[] asColumnList() {
            String[] columnList = new String[values().length];
            for( int i = 0; i < values().length; i++ ) {
                columnList[i] = values()[i].toString();
            }
            
            return columnList;
        }
    }
}
