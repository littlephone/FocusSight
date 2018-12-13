package com.focussight.stored;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

import com.focussight.bean.Users;

import oracle.jdbc.internal.OracleTypes;
public class UpdateStored {
	public SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	ResultSet rs = null;
	Users users=new Users();
	
	public Map<String, Object> getUsersByuid(int uid)  {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
		
			System.out.println("!!!!!!!"+uid);
	 		CallableStatement cs = conn.prepareCall("{CALL showUsers(?,?)}");
			cs.setInt(1, uid);
			cs.registerOutParameter(2, OracleTypes.CURSOR);
			cs.execute();
			
			rs = (ResultSet) cs.getObject(2);
			rs.next();				
			map.put("userid", rs.getInt("userid"));
			map.put("username", rs.getString("username"));
			map.put("profession", rs.getString("profession"));
			map.put("gender", rs.getString("gender"));
			map.put("age", rs.getInt("age"));
			map.put("email", rs.getString("email"));
			map.put("phone", rs.getString("phone"));
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!here");
			
		}catch(Exception e) {}
		return map;
	}
	
	public void UpdateUserByuid(int uid,String gender, String profession,int age,String email,String phone) 
	{
		try {
			
			System.out.println("!!!!!!!"+uid);
			System.out.println("!!!!phone:"+phone);
	 		CallableStatement cs = conn.prepareCall("{CALL updateusersinfo(?,?,?,?,?,?)}");
			cs.setInt(1, uid);
		    cs.setString(2, gender);
		    cs.setString(3, profession);
		    cs.setInt(4, age);
		    cs.setString(5, email);
		    cs.setString(6, phone);
			cs.execute();				
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!here");
			
		}catch(Exception e) {}
	
	}
	
}
