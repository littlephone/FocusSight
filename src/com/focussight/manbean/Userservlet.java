package com.focussight.manbean;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import com.focussight.bean.Users;
import com.focussight.stored.*;

@WebServlet("/Userservlet")
public class Userservlet extends HttpServlet {
    LoginStored ld=new LoginStored();
   	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 request.setCharacterEncoding("UTF-8");
	 //��ȡ����
	 String uname=request.getParameter("username");
	 System.out.println(uname);
	 String upwd=request.getParameter("password");
	 if(uname.equals("")||upwd.equals("")) {
		 JOptionPane.showMessageDialog(null, "�û��������벻��Ϊ�գ���");
		 request.getRequestDispatcher("login.jsp").forward(request, response);
	 }else {
	 //�������ݸ�LoginDao�е�getNamePwd()����
    Users ln = null;
	try {
		ln = ld.getNamePwd(uname, upwd);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	   
	   //�ж��Ƿ��ѯ�ɹ�
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



	


