package com.focussight.manbean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.*;
import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.util.*;
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
	private List<Map<String, Object>> noticemap;
	private Map<String, Object> map;
	
	public Map<String, Object> getMap() {
		NoticeStored nstored = new NoticeStored(pid, uid, nid);
		map = nstored.getNoticeInformation();
		pid = (int)map.get("pid");
		nid = (int)map.get("nid");
		ncontent = (String)map.get("ncontent");
		ntitle = (String) map.get("ntitle");
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	public List<Map<String, Object>> getNoticemap() {
		System.out.print("vrgregergergregergergerger:"+uid);
		NoticeStored nstored = new NoticeStored(pid, uid);
		noticemap = nstored.getAllNotice();
		System.out.println("flag2");
		return noticemap;
	}
	public void setNoticemap(List<Map<String, Object>> noticemap) {
		this.noticemap = noticemap;
	}
	public Date getNdate() {
		return ndate;
	}
	public void setNdate(Date ndate) {
		this.ndate = ndate;
	}
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
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=notice");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return "index";
	}
	public List<Map<String, Object>> showNotice() {
		NoticeStored nstored = new NoticeStored(pid, uid);
		noticemap = nstored.getAllNotice();
		System.out.println("flag");
		return noticemap;
	}
	public String EditNotice() {
		NoticeStored nstored = new NoticeStored(pid, uid, nid);
		 nstored.UpdateContent(ntitle, ncontent);
		 FacesContext context = FacesContext.getCurrentInstance();
		 ExternalContext extContext = context.getExternalContext();
		 try {
			System.out.print("redirecting...edrrrrdrd");
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=notice");
		 }catch(IOException e) {
				e.printStackTrace();
		}
		return null;
	}
	public void deleteNotice() {
		NoticeStored nstored = new NoticeStored(pid, uid, nid);
		nstored.deleteNotice();
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			System.out.print("redirecting...edrrrrdrd");
			extContext.redirect("projectsettings.jsf?pid="+pid+"&type=notice");
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
}
