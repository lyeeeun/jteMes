package kr.co.itcall.jte.spring.config.exception;

public class BusinessException extends RuntimeException{
	private static final long serialVersionUID = 1L;
	
	public String code;
	
	public BusinessException(Exception cause) {
        super(cause) ;
    }

    public BusinessException(String message) {
        super(message) ;
    }
    
    public BusinessException(String code,String message) {
        super(message) ;
        this.code = code;
    }

    public BusinessException(String message, Throwable cause) {
        super(message, cause) ;
    }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
