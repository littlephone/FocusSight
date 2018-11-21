package com.focussight.manbean;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.focussight.stored.*;
/**
 * Servlet implementation class Login
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	public UserStored userstored;
	public Connection conn;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void setConnection(Connection conn) {
    	this.conn = conn;
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SQLToolkit toolkit = new SQLToolkit();
		HttpSession session = request.getSession();
		
		
		setConnection(toolkit.Connect());
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		processLogin(request, response, session, username, password);
		
	}

	public void processLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session,  String username, String passwd)
	throws ServletException, IOException{
		
		// V: Connection
		
		userstored = new UserStored(username);
		
		boolean usernamestat = userstored.checkUser();
		boolean passwdstat = userstored.passwordVerify(passwd);
		
		
		
		RequestDispatcher rd;
		
		if(usernamestat && passwdstat){
			//Then the username is correct
			System.out.println("The user exists"); 
			
			int userid = userstored.user.getUid();
			
			session.setAttribute("username", username);
			session.setAttribute("id", userid);
			rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
			 
		}
		else if(usernamestat && !passwdstat)
			rd = request.getRequestDispatcher("login.jsp?error=1");
			
		else if(!usernamestat) {
			rd = request.getRequestDispatcher("login.jsp?error=2");
		}
	}
}
