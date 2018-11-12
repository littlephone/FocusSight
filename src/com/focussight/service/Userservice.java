package com.focussight.service;

import com.focussight.dao.LoginDao; //sql

import java.sql.SQLException;

import com.focussight.bean.Users;  //±í

public class Userservice {
	LoginDao logindao=new LoginDao();
	 LoginDao ld=new LoginDao();
//		public ArrayList selLogin(String name,String pwd) {
//			return ld.selLogin(name, pwd);
//		}
		public Users getNamePwd(String name,String pwd) throws SQLException {
			return ld.getNamePwd(name, pwd);
		}
		

	
}
