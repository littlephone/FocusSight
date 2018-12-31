<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.focussight.stored.* , java.util.*" %>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

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
	boolean status = false;
	if("request".equals(request.getParameter("action")))
		 status = stored.joinProject(projectid, userid);
	
	else if("cancel".equals(request.getParameter("action"))){
		status = stored.removeMember(projectid, userid);
	}
	pageContext.setAttribute("status", status);
%>

<body>
${status}
</body>
</html>