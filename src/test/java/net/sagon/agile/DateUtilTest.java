package net.sagon.agile;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.is;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.junit.Test;

import net.sagon.agile.DateUtil;

public class DateUtilTest {

    @Test
    public void betweenTwoDates() {
        assertTrue(DateUtil.isBetween(LocalDateTime.parse("2016-02-14T00:00:00"), LocalDate.parse("2016-02-01"), LocalDate.parse("2016-02-15")));
    }

    @Test
    public void falseWhenAfter() throws Exception {
        assertFalse(DateUtil.isBetween(LocalDateTime.parse("2016-02-16T00:00:00"), LocalDate.parse("2016-02-01"), LocalDate.parse("2016-02-15")));
    }
    
    @Test
    public void betweenWhenEqualToStart() throws Exception {
        assertTrue(DateUtil.isBetween(LocalDateTime.parse("2016-02-01T00:00:00"), LocalDate.parse("2016-02-01"), LocalDate.parse("2016-02-15")));
    }
    
    @Test
    public void betweenWhenEqualToEnd() throws Exception {
        assertTrue(DateUtil.isBetween(LocalDateTime.parse("2016-02-15T23:59:59"), LocalDate.parse("2016-02-01"), LocalDate.parse("2016-02-15")));
    }
    
    @Test
    public void min() throws Exception {
        assertThat(DateUtil.min(LocalDate.parse("2016-02-15"), LocalDate.parse("2016-02-16")), is(LocalDate.parse("2016-02-15")));
    }

    @Test
    public void minNull1() throws Exception {
        assertThat(DateUtil.min(null, LocalDate.parse("2016-02-15")), is(LocalDate.parse("2016-02-15")));
    }

    @Test
    public void minNull2() throws Exception {
        assertThat(DateUtil.min(LocalDate.parse("2016-02-15"), null), is(LocalDate.parse("2016-02-15")));
    }
    
    @Test
    public void max() throws Exception {
        assertThat(DateUtil.max(LocalDate.parse("2016-02-15"), LocalDate.parse("2016-02-14")), is(LocalDate.parse("2016-02-15")));
    }

    @Test
    public void maxNull1() throws Exception {
        assertThat(DateUtil.max(null, LocalDate.parse("2016-02-15")), is(LocalDate.parse("2016-02-15")));
    }

    @Test
    public void maxNull2() throws Exception {
        assertThat(DateUtil.max(LocalDate.parse("2016-02-15"), null), is(LocalDate.parse("2016-02-15")));
    }
}
