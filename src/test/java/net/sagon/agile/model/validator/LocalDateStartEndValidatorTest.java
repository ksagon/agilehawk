package net.sagon.agile.model.validator;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.lang.annotation.Annotation;
import java.time.LocalDate;

import javax.validation.Payload;

import static org.hamcrest.Matchers.*;

import org.apache.commons.lang3.StringUtils;
import org.junit.Before;
import org.junit.Test;

import net.sagon.agile.model.validator.LocalDateStartEnd;
import net.sagon.agile.model.validator.LocalDateStartEndValidator;

public class LocalDateStartEndValidatorTest {
    LocalDate start = LocalDate.parse("2016-02-15");
    LocalDate end = LocalDate.parse("2016-02-16");
    private LocalDateStartEndValidator validator = new LocalDateStartEndValidator();

    @Before
    public void before() {
        validator.initialize(new LocalDateStartEnd() {
            public String startField() {return "start";}
            public String endField() {return "end";}
            
            public Class<? extends Annotation> annotationType() {return null;}
            public Class<? extends Payload>[] payload() {return null;}
            public String message() {return null;}
            public Class<?>[] groups() {return null;}
        });
    }

    @Test
    public void canInitialize() {
        assertNotNull(validator);
    }

    @Test
    public void startBeforeEnd() throws Exception {
        assertThat(validator.isValid(givenStartEndValidated("2016-02-15", "2016-02-16"), null), is(true));
    }

    @Test
    public void endBeforeStart() throws Exception {
        assertThat(validator.isValid(givenStartEndValidated("2016-02-16", "2016-02-15"), null), is(false));
    }

    @Test
    public void startEqualsEnd() throws Exception {
        assertThat(validator.isValid(givenStartEndValidated("2016-02-15", "2016-02-15"), null), is(true));
    }

    @Test
    public void noEndDate() throws Exception {
        assertThat(validator.isValid(givenStartEndValidated("2016-02-15", null), null), is(true));
    }

    @Test
    public void noStartDate() throws Exception {
        assertThat(validator.isValid(givenStartEndValidated(null, "2016-02-15"), null), is(false));
    }

    private LocalStartEndValidated givenStartEndValidated(String s, String e) {
        start = null;
        if( StringUtils.isNotEmpty(s) ) {
            start = LocalDate.parse(s);
        }

        end = null;
        if( StringUtils.isNotEmpty(e) ) {
            end = LocalDate.parse(e);
        }

        return new LocalStartEndValidated(start, end);
    }
}
