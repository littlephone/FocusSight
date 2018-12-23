<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@ page import="com.focussight.stored.* , java.util.*, java.net.*" %>
<!DOCTYPE html>
<%
	int projectID = Integer.parseInt(request.getParameter("id"));

	//Set current userid and username if exists
	Integer userid = 0;
	String username = null;
	int curruid = 0;
	//This part has a few bugs... Let's leave this alone
	if(session.getAttribute("userid") != null){
		userid = (Integer)session.getAttribute("userid");
		username = (String)session.getAttribute("username");
		curruid = userid;
	}

	MemberStored memberdao = new MemberStored(projectID);
	ProjectStored projectdao = new ProjectStored(projectID);
	
	String project_name = projectdao.project.getPname();
	String project_leader = projectdao.getManagerUsername();
	String screenshot_path = projectdao.project.getPsnapshot();
	
	List<String> project_mem_list = memberdao.getMemberList(projectID);
	
	//Check whether the current user is the owner (leader) or team member
	boolean isOwner = projectdao.isProjectOwner(curruid, projectID);
	boolean isMember = false;
	if(userid !=0) isMember = memberdao.isProjectMember(userid);

	String path = (String) request.getAttribute("javax.servlet.forward.request_uri");
	
	//set PageContext
	pageContext.setAttribute("userid", userid);
	pageContext.setAttribute("projectid", projectID);
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("screenshot", screenshot_path);
	pageContext.setAttribute("isowner", isOwner);
	pageContext.setAttribute("ismember", isMember);
	pageContext.setAttribute("path", path);
%>
<c:set target="${membermbean}" property="userid" value="${userid}"></c:set>
<c:set target="${membermbean}" property="projectid" value="${projectid}"></c:set>
<c:set target="${projectmbean}" property="pid" value="${projectid}"></c:set>
<c:set target="${noticembean}"    property="pid" value="${projectid}"></c:set>
<c:set target="${noticembean}"    property="uid" value="${userid}"></c:set>

<%-- Is time for us to get the project map --%> 
<c:set value="${projectmbean.projectdetails}" var="map"/>
<c:set value="${noticembean.noticemap}" var="noticemaplist"/>

<html>
<link rel="stylesheet" type="text/css" href="viewproject.css"/>
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
	<div class="nolog">You must <a href="../login.jsf?from=${path}?id=${projectid}">login</a> to participate in this project</div>
</c:if>
<c:if test="${(ismember == true or isowner == true) and not notloggedin}" var="member">
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
			<c:if test="${isowner == true}">
			<a class="item" href="projectsettings.jsf?pid=${projectid}">Project Settings</a>
			<a class="item">Manage Members</a>	
			<a class="item" href="projectstatus.jsf?pid=${projectid}">Project Status</a>
			</c:if>
			<a class="item">Project Requirements</a>
			<a class="item">Meeting Room</a>
			<a class="item" href="showtask.jsf?pid=${projectid}">Task</a>
			<a class="item">Resource</a>
		</div>
	</div>
	<div class="noticeboard">
		<div class="noticetitle">Notice</div>
		<div>
			<c:forEach items="${noticemaplist}" var="nmap">
				<div class="cardasanchor">
					<div class="cardanchorcontent">
						<div class="noticelinetitle">${nmap.ntitle}</div>
						<div class="noticelinetitle">${nmap.ndate}</div>
						<div class="noticelinetitle">${nmap.ncontent}</div>
					</div>
				</div>	
			</c:forEach>
		</div>
	</div>
</div>
</c:if>
<c:if test="${not member}">
	<div class="nolog">You must <a href="../joinproject.jsf?id=${projectid}">join the project</a> to participate in this project</div>

</c:if>
</body>
</html>