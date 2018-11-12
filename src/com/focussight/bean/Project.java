package com.focussight.bean;

import com.focussight.dao.*;
import java.sql.*;

public class Project {
	private int pid;
	private String pname;
	private int manage_id;
	private String requirements;
	private float progress;
	private String pintro;
	private String psnapshot;
	
	public Project(int pid) {
		String stmt = "SELECT * FROM project WHERE pid=?";
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
			pstmt.setInt(1, pid);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			//Setting values 
			this.pid = pid;
			pname = rs.getString("pname");
			manage_id = rs.getInt("manage_id");
			requirements = rs.getString("requirements");
			progress = rs.getFloat("progress");
			pintro = rs.getString("pintro");
			psnapshot =rs.getString("psnapshot");
			conn.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Project() {
		//do nothing
	}
	
	public void createProject(String pname, int manage_id, String requirements,
			float progress, String pintro, String psnapshot) {
		
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		String stmt = "INSERT INTO project (pname, manage_id, requirements, progress, pintro, psnapshot)"
				+ "VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(stmt);
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getManage_id() {
		return manage_id;
	}
	public void setManage_id(int manage_id) {
		this.manage_id = manage_id;
	}
	public String getRequirements() {
		return requirements;
	}
	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	public float getProgress() {
		return progress;
	}
	public void setProgress(float progress) {
		this.progress = progress;
	}
	public String getPintro() {
		return pintro;
	}
	public void setPintro(String pintro) {
		this.pintro = pintro;
	}
	public String getPsnapshot() {
		return psnapshot;
	}
	public void setPsnapshot(String psnapshot) {
		this.psnapshot = psnapshot;
	}
	
}
