package kr.co.itcall.jte.spring.config.exception;

public class BadRequestException extends RuntimeException{
	private static final long serialVersionUID = 1L;
	
	public BadRequestException(Exception cause) {
        super(cause) ;
    }

    public BadRequestException(String message) {
        super(message) ;
    }

    public BadRequestException(String message, Throwable cause) {
        super(message, cause) ;
    }
}
