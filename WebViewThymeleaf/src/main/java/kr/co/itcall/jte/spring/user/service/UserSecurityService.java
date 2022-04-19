package kr.co.itcall.jte.spring.user.service;

public interface UserSecurityService {

	public String findLoggedInUsername();

	public void autologin(String username, String password);

}