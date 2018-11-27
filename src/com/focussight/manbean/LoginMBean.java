package com.focussight.manbean;

import javax.faces.bean.*;
import javax.swing.JOptionPane;

@ManagedBean (name="loginmbean")
@SessionScoped

public class LoginMBean {
	private String username;
	private String password;
	private String hello="hello1";
	private String message;
	
	public LoginMBean() {
		//Do nothing
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void verifyData() {
		System.out.println("hello world");
	}
	
	public String getUIContent() {
		return null;
	}

	public String getHello() {
		return hello;
	}

	public void setHello(String hello) {
		this.hello = hello;
	}

}
