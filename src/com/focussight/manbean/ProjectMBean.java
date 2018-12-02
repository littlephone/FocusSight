package com.focussight.manbean;

import javax.faces.bean.*;
import java.util.*;
import com.focussight.stored.*;

@ManagedBean(name ="projectmbean")
@RequestScoped
public class ProjectMBean {
	//Class used to retrieve project related info
	
	ProjectStored project = new ProjectStored();
	private int projectID;
	private String projectName;
	private String projectIntro;
	private String projectRequirements;
	private String projectProgress;
	
	public String getProjectRequirements() {
		return projectRequirements;
	}

	public void setProjectRequirements(String projectRequirements) {
		this.projectRequirements = projectRequirements;
	}

	public String getProjectProgress() {
		return projectProgress;
	}

	public void setProjectProgress(String projectProgress) {
		this.projectProgress = projectProgress;
	}

	public ProjectMBean(int projectID) {
		this.projectID = projectID;
	}
	
	public int getProjectID() {
		return projectID;
	}
	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectIntro() {
		return projectIntro;
	}
	public void setProjectIntro(String projectIntro) {
		this.projectIntro = projectIntro;
	}
	
	public List<Map> projectContentFiller(int userid) {
		ProjectStored pstored = new ProjectStored();
		return pstored.getProjectProp(userid);
		
	}
	
	public void createProject() {
	}
	
}
