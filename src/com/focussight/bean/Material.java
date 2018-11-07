package com.focussight.bean;

import java.sql.Date;

public class Material {
	private int pid;
	private int maid;
	private int upload_id;
	private String path;
	private Date upload_date;
	private String mstatus;
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getMaid() {
		return maid;
	}
	public void setMaid(int maid) {
		this.maid = maid;
	}
	public int getUpload_id() {
		return upload_id;
	}
	public void setUpload_id(int upload_id) {
		this.upload_id = upload_id;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getUpload_date() {
		return upload_date;
	}
	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}
	public String getMstatus() {
		return mstatus;
	}
	public void setMstatus(String mstatus) {
		this.mstatus = mstatus;
	}
}
