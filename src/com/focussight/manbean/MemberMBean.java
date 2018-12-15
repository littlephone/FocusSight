package com.focussight.manbean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import com.focussight.stored.*;
import java.util.*;

@ManagedBean (name="membermbean")
@RequestScoped
public class MemberMBean {
	private int userid;
	private int projectid;
	private boolean userMember;
	private boolean projectleader;
	private List<String> memberList;
	
	public MemberStored mstored = new MemberStored(projectid);
	public ProjectStored pstored = new ProjectStored(projectid);
	
	public List<String> getMemberList() {
		memberList = mstored.getMemberList();
		return memberList;
	}
	public void setMemberList(List<String> memberList) {
		this.memberList = memberList;
	}
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
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
		projectleader = pstored.isProjectOwner(userid);
		System.out.print(projectleader);
		return projectleader;
	}
	public void setProjectleader(boolean projectleader) {
		this.projectleader = projectleader;
	}
}
