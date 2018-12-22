package com.focussight.stored;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import oracle.jdbc.*;

public class TaskStored {

	public int tid;
	public int pid;
	public String ttitle;
	public String tcontent;
	public Date end_date;
	
	public TaskStored() {
		//Do Nothing
	}
	public TaskStored(int tid, int pid) {
		this.tid = tid;
		this.pid = pid;
	}
	public void addTask() {
		try {
			SQLToolkit toolkit = new SQLToolkit();
			Connection conn = toolkit.Connect();
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 2);
			cstmt.setInt(2, 0);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, 0);
			cstmt.setDate(5, end_date);
			cstmt.setString(6, ttitle);
			cstmt.setString(7, tcontent);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			
			conn.close();
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}
	}
	public List<Map<String, Object>> getTaskList() {
		List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
		try {
			SQLToolkit toolkit = new SQLToolkit();
			Connection conn = toolkit.Connect();
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 1);
			cstmt.setInt(2, tid);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, 0);
			cstmt.registerOutParameter(5, OracleTypes.TIMESTAMP);
			cstmt.setString(6, null);
			cstmt.setString(7, null);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet) cstmt.getObject(5);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("tid", rs.getInt("tid"));
				map.put("tname", rs.getString("ttitle"));
				map.put("tcontent", rs.getString("tcontent"));
				map.put("create_date", rs.getTimestamp("CREATE_DATE"));
				map.put("end_date", rs.getTimestamp("END_DATE"));
				map.put("status", rs.getInt("STATUS"));
				listmap.add(map);
			}
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listmap;
	}
	
}
