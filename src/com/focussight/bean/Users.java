package com.focussight.bean;

import java.sql.*;
import com.focussight.dao.SQLToolkit;
import java.util.*;
import java.sql.Date;

public class Users {
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
	
	public Users(int uid) {
		//Constructor: to check details by userid
		String usersql = "SELECT * FROM users WHERE userid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(usersql);
			pstmt.setInt(1, uid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				isUserExists = true;
				//Set all the properties
				userid = rs.getInt("userid");
				username = rs.getString("username");
				password = rs.getString("password");
				gender = rs.getString("gender");
				profession = rs.getString("profession");
				age = rs.getInt("age");
				email = rs.getString("email");
				regdate = rs.getDate("reg_date");
				phone = rs.getString("phone");	
			}else {
				isUserExists = false;
			}
			
		}catch(SQLException e) {
			
		}
		
	}
	
	public Users(String uname) {
		//Initialise via username
		String usersql = "SELECT * FROM users WHERE username = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, uname);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				isUserExists = true;	
				//Set all the properties
				userid = rs.getInt("userid");
				username = rs.getString("username");
				password = rs.getString("password");
				gender = rs.getString("gender");
				profession = rs.getString("profession");
				age = rs.getInt("age");
				email = rs.getString("email");
				regdate = rs.getDate("reg_date");
				phone = rs.getString("phone");
			}else {
				isUserExists = false;
			}
		}catch(SQLException e) {
			
		}
		
		
	}
	public Users() {
		//do nothing
	}
	
	public void createUser(String username, String password, String gender, String profession,
			int age, String email, String phone) {
		String stmt = "INSERT INTO users (username, password, profession, age, email, reg_date, phone)"
				+ " VALUES (?,?,?,?,?,?,?)";
		try{
			Date date = new Date(System.currentTimeMillis());
			
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, profession);
			pstmt.setInt(   4, age);
			pstmt.setString(5, email);
			pstmt.setDate(6, date);
			pstmt.setString(7, phone);
			
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
	public boolean passwordVerify(String entrypassword) {
		return (Objects.equals(password, entrypassword))? true : false;
	}
}
