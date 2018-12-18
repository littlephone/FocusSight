package com.focussight.stored;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.focussight.bean.*;

import oracle.jdbc.OracleTypes;


public class NoticeStored {
	public int pid;
	public int uid;
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	public NoticeStored(int pid, int uid) {
		this.pid = pid;
		this.uid = uid;
	}
	public void addNotice(String ntitle, String ncontent) {
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XNOTICE(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 1);
			cstmt.registerOutParameter(2, OracleTypes.NUMBER);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, uid);
			cstmt.setString(5, ntitle);
			cstmt.setString(6, ncontent);
			cstmt.registerOutParameter(7, OracleTypes.TIMESTAMP);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			System.out.println("ADD NOTICE SUCCESS");
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Map<String, Object> getAllNotice(){
		
	}
}
