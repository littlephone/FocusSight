package com.focussight.manbean;

import javax.faces.bean.*;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.util.*;
import com.focussight.stored.*;

@ManagedBean (name="projectmbean")
@RequestScoped

public class ProjectMBean {
	private int pid;
	private String pname;
	private String intro;
	public int manager_id;
	private String requirements;
	private float progress;
	private String pintro ;
	private String psnapshot = "haha";
	private String leader;
	private int status;
	
	public ProjectStored ps = new ProjectStored();
	
	public String getLeader() {
		leader = ps.getManagerUsername();
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	private List<Map<String, Object>> projectmap;
	private Map<String,Object> projectdetails;
	private ProjectStored projectstored= new ProjectStored();
	
	public Map<String, Object> getProjectdetails() {
		//Injection method to check project details, then return
		try {
			projectdetails = ps.getProjectByPid(pid);
		}catch(Exception e) {}
		return projectdetails;
	}
	
	
	
	public void selectProjectbyName(String pname)  throws SQLException{
		System.out.println("my name is:"+pname);
		setProjectmap(ps.selectProjectbyName(pname));
	}
	
	
	public void setProjectdetails(Map<String, Object> projectdetails) {
		
		this.projectdetails = projectdetails;
	}
	
	public List<Map<String, Object>> getProjectmap() {
		//Injection method to check project details, then return
		try {
			projectdetails = ps.getProjectByPid(pid);
		}catch(Exception e) {}
		
		return projectmap;
	}
	public void setProjectmap(List<Map<String, Object>> projectmap) {
		this.projectmap = projectmap;
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
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public int getManager_id() {
		return manager_id;
	}
	public void setManager_id(int manager_id) {
		this.manager_id = manager_id;
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
	public  String createProject() {
		FacesContext fc = FacesContext.getCurrentInstance();
		HttpSession hs = (HttpSession) fc.getExternalContext().getSession(true);
		setManager_id((int)hs.getAttribute("userid"));
		System.out.println("I am createProject");
		System.out.println("pname"+pname);
		System.out.println("mid"+manager_id);	
		System.out.println("pintro"+pintro);
		System.out.println("requirements"+requirements);
		System.out.println("psnapshot"+psnapshot);				
		projectstored.createProject(pname, manager_id, requirements, pintro, psnapshot);	
		return "index.jsp";
	}
	
	public void showProjects()  throws SQLException{
		setProjectmap(ps.getAllProjects());
	}
	public String AlterProjectBySettings() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pid", pid);
		map.put("pname", pname);
		map.put("pintro", pintro);
		return (ps.alterProjectProp(map) == true) ?
				"projectsettings.jsf?pid=5&type=general&result=success&faces-redirect=true":
				"projectsettings.jsf?pid=5&type=general&result=failure&faces-redirect=true";
	}
	public int getStatus() {
		
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
