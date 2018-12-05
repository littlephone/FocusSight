package com.focussight.manbean;

import com.focussight.stored.*;
import com.focussight.bean.*;
import java.util.*;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;


@ManagedBean (name="myprojectbean")
@SessionScoped
public class MyProjectMBean {
	public ProjectStored ps = new ProjectStored();
	private int userid;
	public Project project = ps.project;
	public ArrayList<Integer> projectIDList;

	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public void myProjects(int pid) {
		//Get a Project Class with certain pid 
		projectIDList = ps.getUserOwnedProjectID(userid);
		
		ps.selectProjectPropByID(pid);
	}
	
	public void testproject()
	{
		ProjectStored stored=new ProjectStored();
		stored.CallStmt();
	}
}