package com.focussight.manbean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.*;

import java.io.IOException;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import com.focussight.stored.*;

@ManagedBean (name="noticembean")
@SessionScoped
public class NoticeMBean {
	private int pid;
	private int uid;

	private int nid;
	private String ntitle;
	private String ncontent;
	private Date ndate;
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getNid() {
		return nid;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public String AddNotice() {
		NoticeStored nstored = new NoticeStored(pid, uid);
		System.out.println(pid);
		nstored.addNotice(ntitle, ncontent);
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			System.out.print("redirecting...");
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=notice");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return "index";
	}
	public String EditNotice() {
		return null;
	}
	
}
