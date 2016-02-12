package net.sagon.agilecoach.controller;

import org.springframework.web.multipart.MultipartFile;

public class IssuesHolder {
	private MultipartFile issues;

	public void setIssues(MultipartFile issues) {
		this.issues = issues;
	}

	public MultipartFile getIssues() {
		return issues;
	}
}
