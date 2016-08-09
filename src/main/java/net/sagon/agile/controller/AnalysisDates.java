package net.sagon.agile.controller;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

public class AnalysisDates {
    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate start;

    @DateTimeFormat(iso = ISO.DATE)
    private LocalDate end;

    public AnalysisDates() {
    }

    public AnalysisDates(LocalDate start, LocalDate end) {
        this.start = start;
        this.end = end;
    }

    public LocalDate getStart() {
        return start;
    }

    public void setStart(LocalDate start) {
        this.start = start;
    }

    public LocalDate getEnd() {
        return end;
    }

    public void setEnd(LocalDate end) {
        this.end = end;
    }

}
