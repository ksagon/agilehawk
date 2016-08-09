package net.sagon.agile.model.validator;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Constraint(validatedBy = { LocalDateStartEndValidator.class })
@Target(TYPE)
@Retention(RUNTIME)
public @interface LocalDateStartEnd {
    String message() default "{error.startEnd}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};

    String startField() default "start";
    String endField() default "end";
}
