package com.focussight.bean;

import java.sql.*;
//import javax.faces.bean.*;
import com.focussight.stored.*;
import java.util.*;
import javax.faces.bean.*;
import java.sql.Date;

@ManagedBean(name = "users")
@RequestScoped

public class Users {
	private String hello = "Hello World";
	private int userid;
	private String username;
	private String password;
	private String gender;
	private String profession;
	private int age;
	private String email;
	private Date regdate;
	private String phone;
	
	//Toolkit;
	public SQLToolkit toolkit = new SQLToolkit();
	public Connection conn = toolkit.Connect();
	
	public boolean isUserExists = false;
	
	
	public Users() {
		//do nothing
	}
	
	public void createUser(String username, String password, String gender, String profession,
			int age, String email, String phone) {
		String stmt = "INSERT INTO users (username, password, gender, profession, age, email, reg_date, phone)"
				+ " VALUES (?,?,?,?,?,?,?,?)";
		try{
			Date date = new Date(System.currentTimeMillis());
			
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, gender);
			pstmt.setString(4, profession);
			pstmt.setInt(   5, age);
			pstmt.setString(6, email);
			pstmt.setDate(7, date);
			pstmt.setString(8, phone);
			
			pstmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getUid() {
		return userid;
	}
	public void setUid(int uid) {
		this.userid = uid;
	}
	public String getUname() {
		return username;
	}
	public void setUname(String uname) {
		this.username = uname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public boolean isUserExists() {
		return this.isUserExists;
	}

	public String getHello() {
		return hello;
	}

	public void setHello(String hello) {
		this.hello = hello;
	}
}
