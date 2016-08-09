package net.sagon.agile.model;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.StandardToStringStyle;

public abstract class ReflectionToStringAdapter implements Serializable {
    private static final long serialVersionUID = 1998119813965007474L;

    public static final StandardToStringStyle REFLECTIVE_TO_STRING_STYLE;
    static {
        REFLECTIVE_TO_STRING_STYLE = new StandardToStringStyle();
        REFLECTIVE_TO_STRING_STYLE.setUseIdentityHashCode(false);
        REFLECTIVE_TO_STRING_STYLE.setUseShortClassName(true);
        REFLECTIVE_TO_STRING_STYLE.setDefaultFullDetail(true);
    }

    @Override
    public String toString() {
        ReflectionToStringBuilder toStringBuilder = new ReflectionToStringBuilder(this, REFLECTIVE_TO_STRING_STYLE);
        toStringBuilder.setExcludeFieldNames(excludeFieldsFromToString());

        return toStringBuilder.toString();
    }

    protected String[] excludeFieldsFromToString() {
        return new String[0];
    }
}
