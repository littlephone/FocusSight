package com.focussight.manbean;

import javax.faces.bean.*;

@ManagedBean(name="login")
@SessionScoped

public class LoginMBean {
	private String username;
	private String password;
	
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
		
	}
	
	public String getUIContent() {
		return null;
	}

}
