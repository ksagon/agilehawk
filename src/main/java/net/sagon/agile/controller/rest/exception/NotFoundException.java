package net.sagon.agile.controller.rest.exception;

public class NotFoundException extends RestException {

	private static final long serialVersionUID = 6107705317282902208L;

	public NotFoundException() {
		super("Not Found");
	}
	
	public NotFoundException(String message) {
		super(message);
	}
}
