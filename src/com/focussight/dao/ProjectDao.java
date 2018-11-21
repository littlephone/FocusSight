package com.focussight.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.focussight.bean.*;

public class ProjectDao {
	//Create a java bean
	public Project project = new Project();
	public SQLToolkit toolkit = new SQLToolkit();
	public Users user = new Users();
	Connection conn = toolkit.Connect();
	
	public ProjectDao(int pid) {
		
		//One time initisation when querying database
		String stmt = "SELECT * FROM project WHERE pid=?";

		
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setInt(1, pid);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			//Setting values 
			project.setPid(pid);
			project.setPname(rs.getString("pname"));
			project.setManage_id(rs.getInt("manager_id"));
			project.setRequirements(rs.getString("requirements"));
			project.setProgress(rs.getFloat("progress"));
			project.setPintro(rs.getString("pintro"));
			project.setPsnapshot(rs.getString("psnapshot"));
			
			conn.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String getManagerUsername() {
		int manager_id = project.getManage_id();
		UserDao manage_user = new UserDao(manager_id);
		return manage_user.user.getUname();
	}
	

	public void createProject(String pname, int manage_id, String requirements,
			float progress, String pintro, String psnapshot) {
		
		String stmt = "INSERT INTO project (pname, manage_id, requirements, progress, pintro, psnapshot)"
				+ "VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			//pstmt.setString()
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean isProjectOwner(int userid) {
		//Check whether the current user is the project owner (leader)
		int manager_id = project.getManage_id();		
		return (userid == manager_id) ? true: false;
		
	}
}
