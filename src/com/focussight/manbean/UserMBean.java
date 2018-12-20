package com.focussight.manbean;

import java.util.*;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import com.focussight.stored.*;

@ManagedBean (name="usermbean")
@RequestScoped

public class UserMBean {
	public int userid;
	public String username;
	private String password;
	private String gender;
	private String email;
	private String phone;
	private int age;
	private String profession;
	private Map<String, Object> usermap;
	private List<Map<String, Object>> joinedproject;
	
	public UpdateStored upstored= new UpdateStored();
	public ProjectStored pstored = new ProjectStored();

	
	public Map<String, Object> getUsermap() {
		return usermap;
	}
	public void setUsermap(Map<String, Object> map) {
		this.usermap = map;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	
	public void ShowUserByUid(int i)   //this i is important
	{
		setUsermap(upstored.getUsersByuid(i));
		System.out.println("phone"+phone);
	}
	
	public String UpdateUserInfoByUid()
	{
		System.out.println("phone"+phone);
		System.out.println("myid"+userid);
		upstored.UpdateUserByuid(userid, gender, profession, age, email, phone);
		System.out.println("UpdateUserInfoByUid");
		return "index.jsf";
	}
	public List<Map<String, Object>> getJoinedproject() {
		UserStored ustored = new UserStored(userid);
		joinedproject = ustored.getUserJoinedProject(ustored.user.getUid());		
		return joinedproject;
	}
	public void setJoinedproject(List<Map<String, Object>> joinedproject) {
		this.joinedproject = joinedproject;
	}
	
}
