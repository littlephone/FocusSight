package com.focussight.stored;

import com.focussight.bean.*;
import java.sql.*;
import java.util.Objects;


public class UserStored {
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	public Users user = new Users();
	
	public UserStored(String username) {
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		
		String usersql = "SELECT * FROM users WHERE username = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				user.isUserExists = true;	
				//Set all the properties
				user.setUid(rs.getInt("userid"));
				user.setUname(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setProfession(rs.getString("profession"));
				user.setAge(rs.getInt("age"));
				user.setEmail(rs.getString("email"));
				user.setRegdate(rs.getDate("reg_date"));
				user.setPhone(rs.getString("phone"));
				
			}else {
				user.isUserExists = false;
			}
		}catch(SQLException e) {
			
		}
	}
	public UserStored(int userid) {	
		String usersql = "SELECT * FROM users WHERE userid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(usersql);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				user.isUserExists = true;	
				//Set all the properties
				user.setUid(rs.getInt("userid"));
				user.setUname(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setProfession(rs.getString("profession"));
				user.setAge(rs.getInt("age"));
				user.setEmail(rs.getString("email"));
				user.setRegdate(rs.getDate("reg_date"));
				user.setPhone(rs.getString("phone"));
				
			}else {
				user.isUserExists = false;
			}
		}catch(SQLException e) {
			
		}
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
	public boolean checkUser() {
		return user.isUserExists();
	}
	
	public boolean passwordVerify(String entrypassword) {
		return (Objects.equals(user.getPassword(), entrypassword))? true : false;
	}
	
}
