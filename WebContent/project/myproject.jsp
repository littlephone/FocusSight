<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.focussight.stored.SQLToolkit" %>
<%@ page import="java.sql.*, com.focussight.manbean.*" %>

<%
	//Before we start, we need to get the current session
	MyProjectMBean pb = new MyProjectMBean();
	

	String username = (String)session.getAttribute("username");
	int uid = (Integer)session.getAttribute("id");
	System.out.println(uid);
	if(username != null){
%>

<!DOCTYPE html>
<html>
<head>
<style>
body{
	margin:0;
}
.title{
	font-size: 20px;
	padding:50px;
}
.contents{
	
}
</style>
<meta charset="UTF-8">
<title>My project</title>
</head>
<body>
<%@include file="../header.jsp"%>
<div class="title">My FocusSight Projects</div>
<a href="newproject.jsp" class="add">Create a new project</a>
<%
	//Query Structure
		SQLToolkit toolkit = new SQLToolkit();
		Connection conn = toolkit.Connect();
		String projectchksql = "SELECT pid, pname, requirements FROM project WHERE manager_id= ? ";
		try{
			PreparedStatement stmt = conn.prepareStatement(projectchksql,
					ResultSet.TYPE_SCROLL_INSENSITIVE , 
			        ResultSet.CONCUR_READ_ONLY);
			
			stmt.setInt(1, uid);
			ResultSet rs = stmt.executeQuery();
			int num_rows = toolkit.countRows(rs);
			if(num_rows == 0){
				out.println("<div class=\"contents\">There is no pending projects</div>");
			}else{
				while(rs.next()){
					int pid = rs.getInt("pid");
					String pname = rs.getString("pname");
					String requirements = rs.getString("requirements");
					//Showing these items repeatedly
					out.println("<div class=\"contents\">");
					out.println("\t <a href=\"viewproject.jsp?id="+ pid + "\" class=\"card\">");
					out.println("\t\t <div class=\"title\">" + pname + "</div>");
					out.println("\t </a>");
					out.println("</div>");
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
</body>

</html>