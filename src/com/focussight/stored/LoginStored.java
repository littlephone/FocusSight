package com.focussight.stored;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.focussight.bean.Users;


public class LoginStored {
	private Connection conn = null;
	private PreparedStatement pst = null;
	private ResultSet rs = null;

	public Users getNamePwd(String name,String pwd) throws SQLException {
		Users lg=new Users();
		
	try {
		SQLToolkit toolkit = new SQLToolkit();	
		conn = toolkit.Connect();
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
	

  
    
}
