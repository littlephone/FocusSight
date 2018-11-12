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

	public Project() {
		//do nothing
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
