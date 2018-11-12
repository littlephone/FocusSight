package com.focussight.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.focussight.bean.Users;
import com.focussight.service.Userservice;

@WebServlet("/Userservlet")
public class Userservlet extends HttpServlet {
    Userservice ld=new Userservice();
   	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 request.setCharacterEncoding("UTF-8");
	 //获取数据
	 String uname=request.getParameter("username");
	 System.out.println(uname);
	 String upwd=request.getParameter("password");
	 if(uname.equals("")||upwd.equals("")) {
		 JOptionPane.showMessageDialog(null, "用户名或密码不能为空！！");
		 request.getRequestDispatcher("login.jsp").forward(request, response);
	 }else {
	 //传递数据给LoginDao中的getNamePwd()方法
    Users ln = null;
	try {
		ln = ld.getNamePwd(uname, upwd);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	   
	   //判断是否查询成功
	    	if(ln==null) {
				request.getRequestDispatcher("field.jsp").forward(request, response);
			}else {
				request.getRequestDispatcher("index.html").forward(request, response);	
	    }
	 }
		
	}
 
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException,IOException 
			{ 
			doGet(request,response); 
			} 
 
}



	


