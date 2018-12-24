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

<c:set target="${membermbean}"  property="projectid" value="${projectid}"></c:set>

<head>
<meta charset="UTF-8">
<title>All Task</title>
</head>
<body>
<f:view>
<c:set value="${membermbean.memberlist}" var="map"/>
<c:forEach items="${map}"  var="mapline">
	组员名称：${mapline.name}&nbsp;&nbsp;
	特长：${mapline.profession}&nbsp;&nbsp;
	性别：${mapline.gender}&nbsp;
	<a href="deletefuc.jsf?pid=${projectid}&mid=${mapline.mid}">删除</a>
	<br/>
</c:forEach>

</f:view>
</body>
</html>