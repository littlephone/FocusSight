<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.focussight.stored.* , java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submitting joining request...</title>
</head>

<%
	if(request.getParameter("id") == null || request.getParameter("project") == null)
		return;
	

	int userid = Integer.parseInt(request.getParameter("id"));
	int projectid  = Integer.parseInt(request.getParameter("project"));
	
	//Now we got userid and requested project ID, let's call join project
	ProjectStored stored = new ProjectStored();
	boolean isProjectJoinRequested = stored.joinProject(projectid, userid);

%>

<body>
Successful application!
<br/>  
<a href="index.jsf">Index</a>
</body>
</html>