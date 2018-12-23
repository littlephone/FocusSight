<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>

<%
		int projectID = Integer.parseInt(request.getParameter("pid"));
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
		
%>

<c:set target="${taskmbean}"  property="pid" value="${projectid}"></c:set>

<head>
<meta charset="UTF-8">
<title>All Task</title>
</head>
<body>
<f:view>
<c:set value="${taskmbean.tasklist}" var="map"/>
<c:forEach items="${map}"  var="mapline">
	${mapline.tid}
	${mapline.tname}
	${mapline.tcontent}
	<a href="fileupload.jsf?pid=${projectid}&tid=${mapline.tid}">upload</a>
	<br/>
</c:forEach>

</f:view>
</body>
</html>