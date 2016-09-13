package net.sagon.agile.controller.rest.exception;

public class RestError {
	private String message;

	public RestError() {
	}

	public RestError(RestException e) {
		this.message = e.getMessage();
	}
	
	public String getMessage() {
		return message;
	}
}
