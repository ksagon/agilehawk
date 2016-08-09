package net.sagon.agile.model.validator;

import java.time.LocalDate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.apache.commons.beanutils.PropertyUtils;

public class LocalDateStartEndValidator implements ConstraintValidator<LocalDateStartEnd, Object> {
    private String startDateFieldName;
    private String endDateFieldName;

    @Override
    public void initialize(final LocalDateStartEnd constraintAnnotation) {
        startDateFieldName = constraintAnnotation.startField();
        endDateFieldName = constraintAnnotation.endField();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext paramConstraintValidatorContext) {
        try
        {
            final LocalDate startDate = (LocalDate) PropertyUtils.getProperty(value, startDateFieldName);
            final LocalDate endDate = (LocalDate) PropertyUtils.getProperty(value, endDateFieldName);

            return startIsBeforeOrEqualsEnd(startDate, endDate);
        }
        catch (final Exception ignore)
        {
            return false;
        }
    }

    private boolean startIsBeforeOrEqualsEnd(LocalDate startDate, LocalDate endDate) {
        return startDate != null && (endDate == null || startDate.isBefore(endDate) || startDate.equals(endDate));
    }
}
