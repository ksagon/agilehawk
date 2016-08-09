package net.sagon.agile;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DateUtil {

    public static boolean isBetween(LocalDateTime check, LocalDate start, LocalDate end) {
        if( check == null || start == null ) {
            return false;
        }

        return (check.isAfter(start.atStartOfDay()) || check.isEqual(start.atStartOfDay())) && (end == null || check.isBefore(end.atTime(23, 59, 59)) || check.isEqual(end.atTime(23, 59, 59)));
    }
    
    public static LocalDate min(LocalDate d1, LocalDate d2) {
        if( d1 == null ) return d2;
        if( d2 == null ) return d1;

        if( d1.isBefore(d2) ) return d1;
        else return d2;
    }

    public static LocalDate max(LocalDate d1, LocalDate d2) {
        if( d1 == null ) return d2;
        if( d2 == null ) return d1;

        if( d1.isBefore(d2) ) return d2;
        else return d1;
    }
}
