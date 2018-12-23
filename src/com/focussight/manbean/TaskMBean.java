package com.focussight.manbean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.*;
import java.util.*;
import com.focussight.stored.*;

@ManagedBean (name="taskmbean")
@RequestScoped
public class TaskMBean {
	private int pid;
	private int tid;
	private String ttitle;
	private String tcontent;
	private java.util.Date create_date;
	private java.util.Date end_date;
	
	private List<Map<String, Object>> tasklist;
	
	public List<Map<String, Object>> getTasklist() {
		TaskStored tstored = new TaskStored(tid, pid);
		tasklist = tstored.getTaskList();
		return tasklist;
	}
	public void setTasklist(List<Map<String, Object>> tasklist) {
		this.tasklist = tasklist;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	public String getTtitle() {
		return ttitle;
	}
	public void setTtitle(String ttitle) {
		this.ttitle = ttitle;
	}
	public String getTcontent() {
		return tcontent;
	}
	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}
	public java.util.Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(java.util.Date create_date) {
		this.create_date = create_date;
	}
	public java.util.Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(java.util.Date end_date) {
		this.end_date = end_date;
	}
	public String addingTasks() {
		TaskStored tstored = new TaskStored();
		System.out.println(pid+ttitle+tcontent+end_date);
		tstored.pid = pid;
		tstored.ttitle = ttitle;
		tstored.tcontent = tcontent;
		tstored.end_date = end_date;
		tstored.addTask();
		return "projectsettings.jsf";
	}
}
