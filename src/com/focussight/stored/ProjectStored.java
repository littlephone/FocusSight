package com.focussight.stored;

import java.sql.*;
import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.focussight.bean.*;

import oracle.jdbc.internal.OracleTypes;

public class ProjectStored {
	//Create a java bean
	public Project project = new Project();
	public SQLToolkit toolkit = new SQLToolkit();
	public Users user = new Users();
	Connection conn = toolkit.Connect();
	ResultSet rs = null;
	
	public ProjectStored(int pid) {
		selectProjectPropByID(pid);	
	}
	public ProjectStored() {
		//DO NOTHING
		//Query First, then stores
		
	}
	
	public ArrayList<Integer> getUserOwnedProjectID(int uid){
		String sql = "SELECT * FROM project WHERE manage_id="+ uid + ";";
		ArrayList<Integer> projectID = new ArrayList<Integer>();
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				projectID.add(rs.getInt("pid"));
			}
		}catch(SQLException e) {
			
		}
		
		return projectID;
	}
	public void selectProjectPropByID(int pid) {
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
		UserStored manage_user = new UserStored(manager_id);
		return manage_user.user.getUname();
	}
	

	public int createProject(String pname, int manager_id, String requirements,
			 String pintro, String psnapshot) {
		try {
			CallableStatement cs = conn.prepareCall("{CALL createProject(?,?,?,?,?,?)}");
			cs.setString(1, pname);
			cs.setInt(2, manager_id);
			cs.setString(3	, requirements);
			cs.setString(4, pintro);
			cs.setString(5, psnapshot);
			cs.registerOutParameter(6, OracleTypes.NUMBER);
			cs.execute();
			int pid = cs.getInt(6);
			System.out.print("werwewetwefwetwe4ewtewtewt:"+ pid);
			return pid;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public boolean isProjectOwner(int userid) {
		//Check whether the current user is the project owner (leader)
		int manager_id = project.getManage_id();		
		return (userid == manager_id) ? true: false;
		
	}
	public void CallStmt() {
		try{
			CallableStatement cstmt = conn.prepareCall("{call ProjectCheck}");
			cstmt.execute();
			System.out.println("Running here");
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Error occured");
		}
	}
	
	public List<Map<String, Object>> getProjectProp(int uid) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			CallableStatement cstmt = conn.prepareCall("{CALL showProject(?,?)}");
			cstmt.setInt(1,uid);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.execute();
			rs = (ResultSet) cstmt.getObject(2);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("pid", rs.getInt("pid"));
				map.put("pname", rs.getString("pname"));
				map.put("manager_id", rs.getString("manager_id"));
				map.put("requirements", rs.getString("requirements"));
				map.put("progress", rs.getFloat("progress"));
				map.put("pintro", rs.getString("pintro"));
				map.put("psnapshot", rs.getString("psnapshot"));
				list.add(map);
			}
			
		}catch(SQLException e) {}
		return list;
	}
}
