package com.focussight.stored;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.focussight.bean.Users;

import oracle.jdbc.internal.OracleTypes;


public class LoginStored {
	SQLToolkit toolkit = new SQLToolkit();
	private Connection conn = toolkit.Connect();
	private PreparedStatement pst = null;
	private ResultSet rs = null;
	public int userID = 0;

	public Users getNamePwd(String name,String pwd) throws SQLException {
		Users lg=new Users();
		Connection conn = toolkit.Connect();
	try {
			String sql = "select * from users where username=? and password=?";
			System.out.println(sql);
			pst = conn.prepareStatement(sql);
            pst.setString(1,name);
            pst.setString(2,pwd);
            System.out.println(name);
            System.out.println(pwd);
			rs=pst.executeQuery();
			
			if(rs.next()) 
			{
				System.out.println("ready");
				int userid = rs.getInt("userid");
				System.out.println(userid);
				lg.setUid(userid);
				String uname = rs.getString("username");
				lg.setUname(uname);
				System.out.println(uname);
				String paw = rs.getString("password");
				lg.setPassword(paw);
				System.out.println(paw);
				System.out.println("The user exists");
			 
			}
	      }
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();}
		finally {
			conn.close();
		}
	
	    return lg;
		
	}
	
	/*public boolean verifyUsername(String username) {
		//Check username
		try {
			String sqlbuilder = "SELECT * FROM users WHERE username= ?";
			PreparedStatement stmt = conn.prepareStatement(sqlbuilder);
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			
			return rs.next()? true: false;
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	} */
	public boolean verifyUsername(String uname) {
		Connection conn = toolkit.Connect();
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL verifyUsername(?,?,?)}");
			cstmt.setString(1, uname);
			cstmt.registerOutParameter(2, OracleTypes.NVARCHAR);
			cstmt.registerOutParameter(3, OracleTypes.NUMBER);
			cstmt.execute();
			String name = cstmt.getString(2);
			userID = cstmt.getInt(3);
			conn.close();
			return (name== null) ?false:true;
			
		}catch(Exception e){}
		return false;
	}
	/*public boolean verifypassword(String username, String passwd) {
		try {
			String stmtbuilder = "SELECT * FROM users WHERE username = ? AND password = ?";
			PreparedStatement pstmt = conn.prepareStatement(stmtbuilder);
			pstmt.setString(1, username);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			
			return rs.next()? true: false;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}*/
	
	public boolean verifypassword(String username, String passwd) {
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL verifyPassword(?,?,?)}");
			cstmt.setString(1, username);
			cstmt.setString(2, passwd);
			cstmt.registerOutParameter(3, OracleTypes.NVARCHAR);
			cstmt.execute();
			String name = cstmt.getString(3);
			return (name== null) ?false:true;
			
		}catch(Exception e){}
		return false;
	}
    
}
