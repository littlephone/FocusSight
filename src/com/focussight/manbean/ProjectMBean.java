package com.focussight.manbean;

import javax.faces.bean.*;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import com.focussight.stored.*;

@ManagedBean (name="projectmbean")
@RequestScoped

public class ProjectMBean {
	private int pid;
	private String pname;
	private String intro;
	private int manager_id;
	private String requirements;
	private float progress;
	private String pintro ;
	private String psnapshot = "haha";
	
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
	public String createProject() {
		FacesContext fc = FacesContext.getCurrentInstance();
		HttpSession hs = (HttpSession)fc.getExternalContext().getSession(true);
		setManager_id((int)hs.getAttribute("userid"));
		
		ProjectStored ps = new ProjectStored();
		int result = ps.createProject(pname, manager_id, requirements, pintro, psnapshot);
		
		setPid(result);
		System.out.print("good:" + getPid());
		String str = "viewproject.jsf?id="+ getPid();
		System.out.println("4r2r2r23r2r23");
		return str;
	}
}
