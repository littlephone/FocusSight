package com.focussight.stored;

import com.focussight.bean.*;

import oracle.jdbc.OracleTypes;

import java.sql.*;
import java.util.*;


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
	
	public List<Map<String, Object>> getUserJoinedProject(int uid){
		List<Map<String, Object>> userjoinedlist = new ArrayList<Map<String, Object>>();
		try{
			CallableStatement cstmt = conn.prepareCall("{CALL XMEMBER(?,?,?,?,?)}");
			cstmt.setInt(1, 5);
			cstmt.setInt(2, 0);
			cstmt.setInt(3, uid);
			cstmt.setInt(4, 0);
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet)cstmt.getObject(5);
			if(!rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("pid", 0);
				map.put("pname", "No projects found.");
				map.put("pintro", "Please join a project");
				userjoinedlist.add(map);
			}else {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("pid", rs.getInt("pid"));
				map.put("pname", rs.getString("pname"));
				map.put("pintro", rs.getString("pintro"));
				
				userjoinedlist.add(map);
			}
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("pid", rs.getInt("pid"));
				map.put("pname", rs.getString("pname"));
				map.put("pintro", rs.getString("pintro"));
				
				userjoinedlist.add(map);
			}
		}
		catch(SQLException sqle) {
			sqle.printStackTrace();
		}
		return userjoinedlist; 
	}
}
