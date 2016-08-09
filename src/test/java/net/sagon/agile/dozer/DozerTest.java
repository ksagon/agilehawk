package net.sagon.agile.dozer;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.time.LocalDate;

import org.dozer.Mapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import net.sagon.agile.AbstractSpringTest;

public class DozerTest extends AbstractSpringTest {

	@Autowired
	private Mapper mapper;

	@Test
	public void test() {
		BeanA a = new BeanA();
		a.setName("Kevin Sagon");
		a.setDob(LocalDate.parse("1976-02-15"));
		a.setAge(40);

		BeanB b = new BeanB();

		mapper.map(a, b);

		assertThat(a.getAge(), is(b.getAge()));
		assertThat(a.getDob(), is(b.getDob()));
		assertThat(a.getName(), is(b.getFullName()));
	}

}
