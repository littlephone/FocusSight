<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page import="java.sql.*, 
				com.focussight.manbean.*, 
				com.focussight.stored.*,
				java.util.*, 
				javax.servlet.jsp.*"
				 %>
<%
	//0, pid, nid
	int pid = Integer.parseInt(request.getParameter("pid"));
	int nid = Integer.parseInt(request.getParameter("nid"));
	NoticeStored nstored = new NoticeStored(0, pid, nid);
	nstored.deleteNotice();
	System.out.println("Notice deleted");
	pageContext.setAttribute("pid", pid);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Redirecting...</title>
</head>
<body>
<c:redirect url="projectsettings.jsf?pid=${pid}&type=notice"/>
</body>
</html>