package net.sagon.agile.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Collection;

import net.sagon.agile.DateUtil;

public class Velocity {
    private LocalDateTime start;
    private LocalDateTime end;
    private double issueCount;

    public Velocity(LocalDate start, LocalDate end, long issueCount) {
        this.start = start.atStartOfDay();
        this.end = end.atTime(23, 59, 59);
        this.issueCount = issueCount;
    }

    public Velocity(LocalDate start, LocalDate end, Collection<? extends Issue> issues) {
        this(start, end, countIssues(start, end, issues));
    }

    private static long countIssues(LocalDate start, LocalDate end, Collection<? extends Issue> issues) {
        return issues.stream()
                .filter(story -> story.getResolutionDate() != null && DateUtil.isBetween(story.getResolutionDate(), start, end))
                .count();
    }

    public double getVelocity(Period period) {
        double secondsBetweenStartAndEnd = ChronoUnit.SECONDS.between(start, end);
        double periods =  secondsBetweenStartAndEnd / period.inSeconds();

        return issueCount / periods;
    }
}
