package com.focussight.stored;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import oracle.jdbc.OracleTypes;


public class NoticeStored {
	public int pid;
	public int uid;
	public int nid;
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	
	public NoticeStored(int pid, int uid) {
		this.pid = pid;
		this.uid = uid;
	}
	public NoticeStored(int pid, int uid, int nid) {
		this.pid = pid;
		this.uid = uid;
		this.nid = nid;
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
	
	public List<Map<String, Object>> getAllNotice(){
		List<Map<String, Object>> rtnmaplist = new ArrayList<Map<String, Object>>();
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XNOTICE(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 2);
			cstmt.registerOutParameter(2, OracleTypes.NUMBER);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, uid );
			cstmt.setString(5, "");
			cstmt.setString(6, "");
			cstmt.registerOutParameter(7, OracleTypes.TIMESTAMP);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet) cstmt.getObject(8);
			System.out.print(uid+""+pid);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				int nid = rs.getInt("nid");
				String ntitle = rs.getString("ntitle");
				String ncontent = rs.getString("ncontent");
				Date ndate = rs.getTimestamp("ndate");
				map.put("nid", nid);
				map.put("ntitle", ntitle);
				map.put("ncontent", ncontent);
				map.put("ndate", ndate);
				rtnmaplist.add(map);
			}
			
 		}catch(Exception e) {
			e.printStackTrace();
		}
		return rtnmaplist;
	}
	public Map<String, Object> getNoticeInformation(){
		Map<String, Object> object = new HashMap<String, Object>();
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XNOTICE(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 3);
			cstmt.setInt(2, nid);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, uid );
			cstmt.setString(5, "");
			cstmt.setString(6, "");
			cstmt.registerOutParameter(7, OracleTypes.TIMESTAMP);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
			ResultSet rs = (ResultSet)cstmt.getObject(8);
			rs.next();
			
			//putting it to map
			object.put("ntitle", rs.getString("ntitle"));
			object.put("nid", rs.getInt("nid"));
			object.put("ncontent", rs.getString("ncontent"));
			object.put("pid", rs.getInt("pid"));
			
		}catch(SQLException e) {
			
		}
		return object;
	}
	public void UpdateContent(String ntitle, String ncontent) {
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XNOTICE(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 4);
			cstmt.setInt(2, nid);
			cstmt.setInt(3, pid);
			cstmt.setInt(4, uid );
			cstmt.setString(5, ntitle);
			cstmt.setString(6, ncontent);
			cstmt.registerOutParameter(7, OracleTypes.TIMESTAMP);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
	}catch(SQLException e) {
		}
	}
	public void deleteNotice() {
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL XNOTICE(?,?,?,?,?,?,?,?)}");
			cstmt.setInt(1, 5);
			cstmt.setInt(2, nid);
			cstmt.setInt(3, 0);
			cstmt.setInt(4,  0);
			cstmt.setString(5, "");
			cstmt.setString(6, "");
			cstmt.registerOutParameter(7, OracleTypes.TIMESTAMP);
			cstmt.registerOutParameter(8, OracleTypes.CURSOR);
			cstmt.execute();
	}catch(SQLException e) {
		}
	}
}
