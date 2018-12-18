<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@ page import="com.focussight.stored.* , java.util.*" %>
<!DOCTYPE html>
<%
	int projectID = Integer.parseInt(request.getParameter("id"));

	//Set current userid and username if exists
	Integer userid = 0;
	String username = null;
	int curruid = 0;
	if(session.getAttribute("id") != null){
		userid = (Integer)session.getAttribute("userid");
		username = (String)session.getAttribute("username");
		curruid = userid;
	}

	MemberStored memberdao = new MemberStored(projectID);
	ProjectStored projectdao = new ProjectStored(projectID);
	
	String project_name = projectdao.project.getPname();
	String project_leader = projectdao.getManagerUsername();
	String screenshot_path = projectdao.project.getPsnapshot();
	
	List<String> project_mem_list = memberdao.getMemberList();
	
	//Check whether the current user is the owner (leader)
	boolean isOwner = projectdao.isProjectOwner(curruid);
	
	//set PageContext
	pageContext.setAttribute("userid", userid);
	pageContext.setAttribute("projectid", projectID);
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("screenshot", screenshot_path);
%>
<c:set target="${membermbean}" property="userid" value="${userid}"></c:set>
<c:set target="${membermbean}" property="projectid" value="${projectid}"></c:set>
<c:set target="${projectmbean}" property="pid" value="${projectid}"></c:set>

<%-- Is time for us to get the project map --%> 
<c:set value="${projectmbean.projectdetails}" var="map"/>

<html>
<style>
a{
	text-decoration: none;
}

body{
	margin: 0;
}
.project_details_wrapper{
	border-radius: 20px;
	background-color: #00c5ff;
	min-height: 100px; 
	position: relative;
}
.project_name{
	font-size: 18px;
}
.details_inner_wrapper{
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	padding-left: 25px;
}
.leader, .member{
	display: inline-block;
}
.leader{
	font-weight: bold;
}
.nolog{
	width:100%;
	text-align:center;
	height: 500px;
	margin-top: 10px;
	line-height: 500px;
	border: 1px solid grey;
	border-radius: 20px;
}
.horizontal_wrapper{
	position:relative;
	width: 98%;
	margin-top: 10px;
	margin: 0 auto;
}
.horizontal_wrapper div{
	display:inline-block;
	vertical-align: top;
}
.vertical_menu{
	display: block;
	border: 1px solid grey;
	border-radius: 20px;
	width: 300px;
}
.image_place{
	width: 100%;
	height: 150px;
	line-height: 150px;
	text-align: center;
}
.item{
	display:block;
	padding: 10px;
}
.noticeboard{
	width: 70%;
	min-height:400px;
	border: 1px solid grey;
	border-radius: 18px;
}
.noticetitle{
	width:100%;
	text-align: center;
	font-size: 24px;
}
</style>
<head>
<meta charset="UTF-8">
<title>${map.pname} - Labstry FocusSight EE</title>
</head>
<body>
<%@include file="../header.jsp"%>

<div class="project_details_wrapper">
	<div class="details_inner_wrapper">
		<div class="project_name">${map.pname}</div>
		<div class="leader">${projectmbean.leader}(leader)</div>
		<c:forEach items="${membermbean.memberList}" var="member">
			<div class="member">, ${member}</div>
		</c:forEach>
	</div>
</div>
<c:if test="${username == null}" var="notloggedin">
	<div class="nolog">You must <a href="../login.jsf">login</a> to participate in this project</div>
</c:if>
<c:if test="${(membermbean.userMember == true or membermbean.projectleader == true) and not notloggedin}">
<div class="horizontal_wrapper"> 
	<div class="wrapper">
		<div class="vertical_menu">
			<div class="image_place">
			<c:if test="${screenshot == null}" var="noscreenshot">
				No screenshot
			</c:if>
			<c:if test="${not noscreenshot}">
				<img src="${map.psnapshot}" class="snapshotimage"/>
			</c:if>
			</div>
			<div class="seperator"></div>
			<c:if test="${membermbean.projectleader == true}">
			<a class="item" href="projectsettings.jsf?pid=${projectid}">Project Settings</a>
			<a class="item">Manage Members</a>	
			<a class="item" href="projectstatus.jsf?pid=${projectid}">Project Status</a>
			</c:if>
			<a class="item">Project Requirements</a>
			<a class="item">Meeting Room</a>
			<a class="item">Upload</a>
			<a class="item">Resource</a>
		</div>
	</div>
	<div class="noticeboard">
		<div class="noticetitle">Notice</div>
	</div>
</div>
</c:if>
</body>
</html>