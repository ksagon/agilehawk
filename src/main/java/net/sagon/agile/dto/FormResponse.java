package net.sagon.agile.dto;

import org.springframework.validation.Errors;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class FormResponse {
    public enum ResponseStatus {
        SUCCESS, FAIL
    }

    private Object response;

    @JsonIgnore
    private Errors errors;

    public FormResponse() {
    }

    public FormResponse(final Errors errors) {
        this.errors = errors;
    }

    public FormResponse(final Object response, final Errors errors) {
        this(errors);
        this.response = response;
    }

    public ResponseStatus getStatus() {
        return (errors != null && errors.hasErrors()) ? ResponseStatus.FAIL : ResponseStatus.SUCCESS;
    }

    public Object getResponse() {
        if (errors != null && errors.hasErrors()) {
            return errors.getAllErrors();
        }
        return this.response;
    }

    @JsonIgnore
    public boolean isSuccessful() {
        return errors == null || !errors.hasErrors();
    }

    @JsonIgnore
    public boolean isNotSuccessful() {
        return (errors != null && errors.hasErrors());
    }

}
