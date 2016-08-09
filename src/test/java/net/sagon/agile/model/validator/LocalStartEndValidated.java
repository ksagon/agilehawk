package net.sagon.agile.model.validator;

import java.time.LocalDate;

import net.sagon.agile.model.validator.LocalDateStartEnd;

@LocalDateStartEnd
public class LocalStartEndValidated {
    private LocalDate start;
    private LocalDate end;

    public LocalStartEndValidated(LocalDate start, LocalDate end) {
        this.start = start;
        this.end = end;
    }

    public LocalDate getStart() {
        return start;
    }

    public LocalDate getEnd() {
        return end;
    }

    public void setStart(LocalDate start) {
        this.start = start;
    }

    public void setEnd(LocalDate end) {
        this.end = end;
    }
}
