package com.focussight;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.focussight.dao.SQLToolkit;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

    public boolean checkUsername(Connection conn, String username) {
    	String sql = "SELECT * FROM users WHERE username = ?";
    	ResultSet rs = null;
    	boolean isUsernameValid = false;
    	
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, username);
    		rs = pstmt.executeQuery();
    		if(rs.next()) isUsernameValid = true;
    	}catch(SQLException sqle) {
    		
    	}
    	return isUsernameValid;
    }
    
    public boolean checkPassword(Connection conn, String username, String passwd) {
    	String sql = "SELECT * FROM users WHERE username= ? AND password = ?";
    	ResultSet rs = null;
    	boolean isPasswordValid = false;
    	
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, username);
    		pstmt.setString(2, passwd);
    		rs = pstmt.executeQuery();
    		if(rs.next()) isPasswordValid = true;
    	}catch(SQLException sqle) {
    		sqle.printStackTrace();
    	}
    	return isPasswordValid;
    }
    
    public int getID(Connection conn, String username) {
    	String stmt = "SELECT userid FROM users WHERE username = ?";
    	int id = 0;
    	ResultSet rs = null;
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(stmt);
    		pstmt.setString(1, username);
    		rs = pstmt.executeQuery();
    		rs.next();
    		
    		id = rs.getInt("userid");
    	}catch(SQLException sqle) {
    		sqle.printStackTrace();
    	}
    	return id;
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SQLToolkit toolkit = new SQLToolkit();
		HttpSession session = request.getSession();
		
		Connection conn= toolkit.Connect();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		processLogin(request, response, conn, session, username, password);
		
	}

	public void processLogin(HttpServletRequest request, HttpServletResponse response, Connection conn, HttpSession session,  String username, String passwd)
	throws ServletException, IOException{
		
		boolean usernamestat = checkUsername(conn, username);
		boolean passwdstat = checkPassword(conn, username,passwd);
		RequestDispatcher rd;
		
		if(usernamestat && passwdstat){
			//Then the username is correct
			System.out.println("The user exists"); 
			
			int userid = getID(conn, username);
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
