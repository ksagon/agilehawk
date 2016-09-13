package net.sagon.agile.controller.rest.exception;

public class RestException extends RuntimeException {
	private static final long serialVersionUID = -59251390535380392L;

	public RestException(String message) {
		super(message);
	}
}
