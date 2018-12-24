package com.focussight.stored;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import oracle.jdbc.*;

public class TaskStored {

	public int tid;
	public int pid;
	public String ttitle;
	public String tcontent;
	public float status = 0;
	public java.util.Date end_date;
	public Calendar cal = Calendar.getInstance();
	
	public TaskStored() {
		//Do Nothing
	}
	public TaskStored(int tid, int pid) {
		this.tid = tid;
		this.pid = pid;
	}
	public void setCalendarByDateTime() {
		cal.setTime(end_date);
	}
	public void addTask() {
		setCalendarByDateTime();
		java.sql.Timestamp tstamp = new java.sql.Timestamp(cal.getTimeInMillis());
		try {
			SQLToolkit toolkit = new SQLToolkit();
			Connection conn = toolkit.Connect();
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 2);
			cstmt.setInt(2, 0);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, 0);
			cstmt.setTimestamp(5, tstamp);
			cstmt.setString(6, ttitle);
			cstmt.setString(7, tcontent);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			conn.close();
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=task");
		}catch(IOException e) {
			e.printStackTrace();
		}
		
	}
	public List<Map<String, Object>> getTaskList() {
		List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
		try {
			SQLToolkit toolkit = new SQLToolkit();
			Connection conn = toolkit.Connect();
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 1);
			cstmt.setInt(2, 0);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, 0);
			cstmt.registerOutParameter(5, OracleTypes.TIMESTAMP);
			cstmt.setString(6, null);
			cstmt.setString(7, null);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet) cstmt.getObject(8);
			//System.out.println("I am 1-2"+ pid);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("tid", rs.getInt("tid"));
				map.put("tname", rs.getString("ttitle"));
				map.put("tcontent", rs.getString("tcontent"));
				//System.out.println("i am content:"+tcontent);
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
	public Map<String, Object> getTaskByTidPid() {
		Map<String, Object> map = new HashMap<String, Object>();
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 3);
			cstmt.setInt(2, tid);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, 0);
			cstmt.registerOutParameter(5, OracleTypes.TIMESTAMP);
			cstmt.setString(6, null);
			cstmt.setString(7, null);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet) cstmt.getObject(8);
			while(rs.next()) {
				map.put("tid", rs.getInt("tid"));
				map.put("ttitle", rs.getString("ttitle"));
				map.put("tcontent", rs.getString("tcontent"));
				//Treating with datetime
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(rs.getTimestamp("end_date"));
				
				map.put("end_date",	calendar);
				map.put("status", rs.getFloat("status"));
			}
		}catch(SQLException sqle) {
			
		}
		
		return map;
	}
	public void updateTask() {
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		setCalendarByDateTime();
		java.sql.Timestamp tstamp = new java.sql.Timestamp(cal.getTimeInMillis());
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XTASK(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 4);
			cstmt.setInt(2, tid);
			cstmt.setInt(3, pid);
			cstmt.setFloat(4, status);
			cstmt.setTimestamp(5, tstamp);
			cstmt.setString(6, ttitle);
			cstmt.setString(7, tcontent);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=task");
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
}
