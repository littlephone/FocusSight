<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page import="com.focussight.stored.* , java.util.*, java.net.*" %>
<!DOCTYPE html>
<html>

<%
		int projectID = Integer.parseInt(request.getParameter("pid"));
        int mid=Integer.parseInt(request.getParameter("mid"));
        out.print(mid);
		//Set current userid and username if exists
		Integer userid = 0;
		String username = null;
		int curruid = 0;
		if(session.getAttribute("userid") != null){
			userid = (Integer)session.getAttribute("userid");
			username = (String)session.getAttribute("username");
			curruid = userid;
		}
		pageContext.setAttribute("userid", userid);
		pageContext.setAttribute("projectid", projectID);
		MemberStored memstored=new MemberStored();
		memstored.pid=projectID;
		memstored.mid=mid;
		memstored.deletemember();
		response.sendRedirect("showmember.jsf?pid="+projectID); 
%>



<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>

</body>
</html>