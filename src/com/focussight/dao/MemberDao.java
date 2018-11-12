package com.focussight.dao;

import com.focussight.bean.*;
import java.sql.*;
import java.util.*;

public class MemberDao {

	//Initialise Member Bean
	Member member = new Member();
	public int pid;
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn = toolkit.Connect();
	
	public MemberDao(int pid, int mid) {
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
	public MemberDao(int pid) {
		this.pid = pid;
	}
	public List<String> getMemberList() {
		String stmt = "SELECT u.username AS username FROM member m, users u WHERE pid = ? AND m.mid = u.userid";
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
