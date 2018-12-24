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
	private float status;
	private java.util.Date create_date;
	private java.util.Date end_date;
	
	private int year;
	private int month;
	private int day;
	private int hour;
	private int minute;
	
	private List<Map<String, Object>> taskmap;
	private List<Map<String, Object>> tasklist ;
	private Map<String, Object> taskbytid;
	
	public List<Map<String, Object>> getTaskmap() {
		return taskmap;
	}
	public void setTaskmap(List<Map<String, Object>> taskmap) {
		this.taskmap = taskmap;
	}

	public List<Map<String, Object>> getTasklist() {
		TaskStored tstored = new TaskStored();
		tstored.pid=pid;
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
	
	public String updateContent() {
		TaskStored tstored = new TaskStored();
		tstored.pid = pid;
		tstored.tid = tid;
		tstored.status = status;
		tstored.ttitle = ttitle;
		tstored.tcontent = tcontent;
		tstored.end_date = end_date;
		tstored.updateTask();
		return null;
	}
	
	public List<Map<String, Object>> showTask() {
		TaskStored tstored = new TaskStored();
		System.out.println("i am pid "+ pid);
		tstored.pid = pid;
		taskmap = tstored.getTaskList();
		System.out.println("flag");
		return taskmap;
	}
	public Map<String, Object> getTaskbytid() {
		TaskStored tstored = new TaskStored();
		tstored.tid = tid;
		tstored.pid = pid;
		taskbytid = tstored.getTaskByTidPid();
		
		Calendar cal = (Calendar) taskbytid.get("end_date");
		
		taskbytid.put("endyear", cal.get(Calendar.YEAR));
		taskbytid.put("endmonth", cal.get(Calendar.MONTH) + 1);
		taskbytid.put("endday", cal.get(Calendar.DAY_OF_MONTH));
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH) + 1;
		day = cal.get(Calendar.DAY_OF_MONTH);
		hour = cal.get(Calendar.HOUR_OF_DAY);
		minute = cal.get(Calendar.MINUTE);
		
		return taskbytid;
	}
	public void setTaskbytid(Map<String, Object> taskbytid) {
		this.taskbytid = taskbytid;
	}
	
	//This part is for setting and getting date
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public int getMinute() {
		return minute;
	}
	public void setMinute(int minute) {
		this.minute = minute;
	}
	public float getStatus() {
		return status;
	}
	public void setStatus(float status) {
		this.status = status;
	}
}
