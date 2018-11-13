<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.focussight.dao.* , java.util.*" %>
<!DOCTYPE html>
<%
	int projectID = Integer.parseInt(request.getParameter("id"));
	int curruid = 0;
	Integer userid;
	
	if((userid = (Integer)session.getAttribute("id")) != null){
		curruid = userid;
	}
	MemberDao memberdao = new MemberDao(projectID);
	ProjectDao projectdao = new ProjectDao(projectID);
	
	String project_name = projectdao.project.getPname();
	String project_leader = projectdao.getManagerUsername();
	String screenshot_path = projectdao.project.getPsnapshot();
	
	List<String> project_mem_list = memberdao.getMemberList();
	
	//Check whether the current user is the owner (leader)
	boolean isOwner = projectdao.isProjectOwner(curruid);
%>
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
	display:inline-block;
	width: 98%;
	margin-top: 10px;
	margin: 0 auto;
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
</style>
<head>
<meta charset="UTF-8">
<title><%=project_name %> - Labstry FocusSight EE</title>
</head>
<body>
<%@include file="../header.jsp"%>
<div class="project_details_wrapper">
	<div class="details_inner_wrapper">
		<div class="project_name"><%=project_name %></div>
		<div class="leader"><%=project_leader %>(leader)</div>
		<% for(String project_member : project_mem_list){ %>
			<div class="member">, <%=project_member %></div>
		<%}%>
	</div>
</div>
<%
if(uname == null){
	out.print("<div class=\"nolog\">You must login to participate in this project</div>");
}else{
%>
<div class="horizontal_wrapper">
<div class="wrapper">
		<div class="vertical_menu">
			<div class="image_place">
				<% if(screenshot_path == null) out.print("No screeshot"); %>
			</div>
			<div class="seperator"></div>
			<%
			if(isOwner){
			%>
			<a class="item" href="projectsettings.jsp?pid=<%=projectID %>">Project Settings</a>
			<a class="item">Manage Members</a>		
			<%	
			}
			%>
			<a class="item">Project Requirements</a>
			<a class="item">Meeting Room</a>
			<a class="item">Work </a>
		</div>
	
	</div>
</div>
<%}%>
</body>
</html>