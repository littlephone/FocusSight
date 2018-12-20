package com.focussight.stored;

import com.focussight.bean.*;

import oracle.jdbc.*;
import java.sql.*;
import java.util.*;

public class MemberStored {

	//Initialise Member Bean
	Member member = new Member();
	public int pid;
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	
	public MemberStored(int pid, int mid) {
		//Set project number
		this.pid = pid;
		//Initialise specific information on specific user in given project number
		String stmt = "SELECT * FROM member WHERE pid = ? AND mid = ? AND status = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, mid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setPid(rs.getInt("pid"));
				member.setMid(rs.getInt("mid"));
				member.setStatus(rs.getInt("status"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public MemberStored(int pid) {
		this.pid = pid;
	}
	public boolean isProjectMember(int uid) {
		System.out.print("OUT");
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL ISUSERTEAMMEMBER(?,?,?)}");
			cstmt.setInt(1, pid);
			cstmt.setInt(2, uid);
			cstmt.registerOutParameter(3, OracleTypes.NUMBER);
			cstmt.execute();
			int isMember = cstmt.getInt(3);
			System.out.print("HERER"+isMember);
			return (isMember == 0)? false: true;

		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}	
	public List<String> getMemberList(int pid) {
		String stmt = "SELECT u.username AS username FROM member m, users u WHERE pid = ? AND m.mid = u.userid AND status = 1";
		List<String> mem_list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setInt(1, pid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				mem_list.add(rs.getString("username"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return mem_list;
	}
}
