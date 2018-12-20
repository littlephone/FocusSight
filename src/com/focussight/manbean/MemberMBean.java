package com.focussight.manbean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import com.focussight.stored.*;

import java.io.IOException;
import java.util.*;

@ManagedBean (name="membermbean")
@RequestScoped
public class MemberMBean {
	private int userid;
	private int projectid;
	private boolean userMember;
	private boolean projectleader;
	private List<Map<String, Object>> unconfirmeduser;
	private List<String> memberList;
	
	//For calling back when approving/rejecting/blocking
	private String confirmUser;
	private String rejectUser;
	private String blockUser;

	public MemberStored mstored = new MemberStored(projectid);
	public ProjectStored pstored = new ProjectStored(projectid);
	
	public String getRejectUser() {
		pstored.ApplicationTreatment(4, userid, projectid);
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			extContext.redirect("projectstatus.jsf?pid="+projectid+"&message=success");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return rejectUser;
	}
	public void setRejectUser(String rejectUser) {
		this.rejectUser = rejectUser;
	}
	public String getBlockUser() {
		pstored.ApplicationTreatment(3, userid, projectid);
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			extContext.redirect("projectstatus.jsf?pid="+projectid+"&message=success");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return blockUser;
	}
	public void setBlockUser(String blockUser) {
		this.blockUser = blockUser;
	}
	public String getConfirmUser() {
		pstored.ApplicationTreatment(2, userid, projectid);
		
		FacesContext context = FacesContext.getCurrentInstance();
		ExternalContext extContext = context.getExternalContext();
		try {
			extContext.redirect("projectstatus.jsf?pid="+projectid+"&message=success");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return confirmUser;
	}
	public void setConfirmUser(String confirmUser) {
		this.confirmUser = confirmUser;
	}
	
	public List<Map<String, Object>> getUnconfirmeduser() {
		unconfirmeduser = pstored.getUnconfirmedUser(projectid);
		return unconfirmeduser;
	}
	public void setUnconfirmeduser(List<Map<String, Object>> unconfirmeduser) {
		this.unconfirmeduser = unconfirmeduser;
	}
	
	
	public List<String> getMemberList() {
		memberList = mstored.getMemberList(projectid);
		return memberList;
	}
	public void setMemberList(List<String> memberList) {
		this.memberList = memberList;
	}
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		System.out.println(userid+"ewfwergwergwergergjerughreughrngnt");
		this.userid = userid;
	}
	public int getProjectid() {
		return projectid;
	}
	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}
	public boolean isUserMember() {
		userMember = mstored.isProjectMember(userid);
		return userMember;
	}
	public void setUserMember(boolean userMember) {
		this.userMember = userMember;
	}
	public boolean isProjectleader() {
		projectleader = pstored.isProjectOwner(userid, projectid);
		System.out.print("fewfwefeewfwffefewfeww"+projectleader);
		return projectleader;
	}
	public void setProjectleader(boolean projectleader) {
		this.projectleader = projectleader;
	}
}
