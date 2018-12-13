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
	int userid;
	int projectid;
	if(((userid = Integer.parseInt(request.getParameter("id")))== 0) ||
	   ((projectid = Integer.parseInt(request.getParameter("project"))) ==0) 
		) 
		return;
	//Now we got userid and requested project ID, let's call join project
	ProjectStored stored = new ProjectStored();
	boolean isProjectJoinRequested = stored.joinProject(projectid, userid);
	
%>

<body>
</body>
</html>