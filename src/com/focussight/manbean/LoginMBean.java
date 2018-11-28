package com.focussight.manbean;

import javax.faces.bean.*;
import javax.faces.context.FacesContext;
import javax.servlet.http.*;
import javax.swing.JOptionPane;

import com.focussight.stored.LoginStored;

@ManagedBean (name="loginmbean")
@SessionScoped

public class LoginMBean {
	private String username;
	private int userid;
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
	public String proccessLogin() {
		LoginStored loginstored = new LoginStored();
		
		//boolean userverify = loginstored.verifyUsername(username);
		boolean userverify = loginstored.verifyUsername(username);
		System.out.println("here");
		boolean passwdverify = loginstored.verifypassword(username, password);
		
		if(userverify && passwdverify) {
			FacesContext fc = FacesContext.getCurrentInstance();
			HttpSession session = (HttpSession) fc.getExternalContext().getSession(true);
			
			session.setAttribute("userid", loginstored.userID);
			session.setAttribute("username", username);
			return "index.jsp";
		}
		else if(!userverify) {
			return "login.jsf?error=1";
		}
		else return "login.jsf?error=2";
	}

}
