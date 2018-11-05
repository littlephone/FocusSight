<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.focussight.SQLToolkit" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login to EE -  Labstry</title>
</head>
<body>
<div>
Login to FocusSight EE
</div>
<% 
//Get Parameters from page
 String username = request.getParameter("username");
 String password = request.getParameter("password");
 String mode = request.getParameter("mode");
 
 if(mode == null || !mode.equals("verify")){
%>
<form method="POST" action="login.jsp?mode=verify">
Username: <input type="text" name="username"/><br/>
Password: <input type="password" name="password"/><br/>
<input type="submit" value="Submit"/>
</form>
<%
}else{
	SQLToolkit toolkit = new SQLToolkit();
	Connection conn= toolkit.Connect();
	//bind parameters to check whether username exists
	String stmt = "SELECT userid FROM users WHERE username = ? AND password = ?";
	try{
		PreparedStatement pstmt = conn.prepareStatement(stmt);
		pstmt.setString(1, username);	
		pstmt.setString(2, password);
		
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			//The username exists and the password is correct
			int userid = rs.getInt("userid");
			
			out.println("The user exists"); 
			session.setAttribute("username", username);
			session.setAttribute("id", userid);
			
			//The session is created: out.println(session.getAttribute("username"));
			conn.close();
			response.sendRedirect("index.jsp");
			
		}else{
			out.println("Username not exists or password incorrect");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
</body>
</html>