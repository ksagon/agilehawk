package net.sagon.agilecoach;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.apache.commons.lang3.ArrayUtils;
import org.junit.Test;

public class ReflectionToStringAdapterTest {

    @Test
    public void toStringWithoutExcludes() {
        ToStringWithoutExcludes s = new ToStringWithoutExcludes("FOO");
        assertThat(s.toString(), is("ReflectionToStringAdapterTest.ToStringWithoutExcludes[foo=FOO]"));
    }

    @Test
    public void toStringWithExcludes() {
        ToStringWithExcludes s = new ToStringWithExcludes("FOO", "BAR");
        assertThat(s.toString(), is("ReflectionToStringAdapterTest.ToStringWithExcludes[foo=FOO]"));
    }

    class ToStringWithoutExcludes extends ReflectionToStringAdapter {
        private static final long serialVersionUID = 5510669504791394562L;

        String foo;

        public ToStringWithoutExcludes(String foo) {
            this.foo = foo;
        }
    }

    class ToStringWithExcludes extends ReflectionToStringAdapter {
        private static final long serialVersionUID = 5884873736899843934L;

        String foo;
        String bar;

        public ToStringWithExcludes(String foo, String bar) {
            this.foo = foo;
            this.bar = bar;
        }

        @Override
        protected String[] excludeFieldsFromToString() {
            return ArrayUtils.addAll(new String[] {"bar"}, super.excludeFieldsFromToString());
        }
    }
}
