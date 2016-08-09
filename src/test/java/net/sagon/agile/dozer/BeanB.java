package net.sagon.agile.dozer;

import java.time.LocalDate;

import org.dozer.Mapping;

import net.sagon.agile.model.ReflectionToStringAdapter;

public class BeanB extends ReflectionToStringAdapter {
	private static final long serialVersionUID = -515765050438998829L;

	@Mapping("name")
	private String fullName;

	private int age;

	private LocalDate dob;

	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public LocalDate getDob() {
		return dob;
	}
	public void setDob(LocalDate dob) {
		this.dob = dob;
	}
}
