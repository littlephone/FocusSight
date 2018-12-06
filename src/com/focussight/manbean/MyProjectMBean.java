package com.focussight.manbean;

import com.focussight.stored.*;
import com.focussight.bean.*;
import java.util.*;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.*;
import javax.servlet.jsp.*;


@ManagedBean (name="myprojectbean")
@SessionScoped
public class MyProjectMBean {
	public ProjectStored ps = new ProjectStored();
	FacesContext fc = FacesContext.getCurrentInstance();
	HttpSession session = (HttpSession) fc.getExternalContext().getSession(true);
	private int userid = (int) session.getAttribute("userid");
	
	public Project project = ps.project;

	public List<Map<String, Object>> userOwnedProject;

	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public void testproject()
	{
		ProjectStored stored=new ProjectStored();
		stored.CallStmt();
	}
	public List<Map<String, Object>> getUserOwnedProject(){
		userOwnedProject= ps.getProjectProp(userid);
		return userOwnedProject;
	}
}
