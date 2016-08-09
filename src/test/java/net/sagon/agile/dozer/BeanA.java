package net.sagon.agile.dozer;

import java.time.LocalDate;

import net.sagon.agile.model.ReflectionToStringAdapter;

public class BeanA extends ReflectionToStringAdapter {
	private static final long serialVersionUID = -515765050438998829L;

	private String name;
	private int age;
	private LocalDate dob;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
