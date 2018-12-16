<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.focussight.stored.*"  %>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>

<%
	int projectID = Integer.parseInt(request.getParameter("pid"));

	String settingspage = "general";
	int userid = 0;
	
	if((String) request.getParameter("type") != null){
		settingspage = (String) request.getParameter("type");
	}
	
	if(session.getAttribute("userid") != null)
		userid = (Integer)session.getAttribute("userid");
	
	ProjectStored projectdao = new ProjectStored(projectID);
	boolean projectOwner = projectdao.isProjectOwner(userid);
	
	//Set pageContext
	pageContext.setAttribute("projectOwner", projectOwner);
	pageContext.setAttribute("userid", userid);
	pageContext.setAttribute("projectid", projectID);
	pageContext.setAttribute("page", settingspage);
%>
<c:if test="${projectOwner == false or userid == 0}">
	  <%--Filters illegal user--%>
      <c:redirect url = "../index.jsf"/>
</c:if>
<html>
<style>
body{
	margin:0;
}
.project_details_wrapper{
	border-radius: 20px;
	background-color: #00c5ff;
	min-height: 100px; 
	position: relative;
}
.details_inner_wrapper{
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	padding-left: 25px;
}
.project_name{
	font-size: 18px;
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
.text-input{
	width: 500px;
	height:40px;
	font-size: 24px;
	border:none;
	padding-left: 10px;
	/* Override border */
	border: 2px solid #00c5ff;
	border-radius: 24px;
}
.pidhidden, .text-area{
	display:none;
}
.colorededit{
	border: 1px solid orange;
	border-radius: 18px;
	min-height: 300px;
	width: 98%;
	margin: 0 auto;
	padding: 10px;
}
</style>
<head>
<meta charset="UTF-8">
<c:set target="${projectmbean}" property="pid" value="${projectid}"/>

<%-- Is time for us to get the project map --%> 
<c:set value="${projectmbean.projectdetails}" var="map"/>

<title>Preferences of ${map.pname}</title>
</head>
<body>
<f:view>
<c:import url="header.jsp"/>
<div class="project_details_wrapper">
	<div class="details_inner_wrapper">
		<div class="project_name"><b>Preferences of ${map.pname} (pid: ${map.pid})</b></div>
	</div>
</div>
<div class="horizontal_wrapper"> 
	<div class="wrapper">
		<div class="vertical_menu">
			<a class="item" href="viewproject.jsf?id=${projectid}">&lt; Back</a>
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=general">General Settings</a>
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=options">Project Options</a>	
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=progress">Progress</a>
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=task">Tasks</a>
			<a class="item" href="delete.jsf?pid=${projectid}">Delete Project</a>
		</div>
	</div>
	<div class="noticeboard">
		<c:if test="${page == 'general'}">
			<%-- The code here is displayed when user choose 'general' tab --%>
			<div class="noticetitle">General Settings</div>
			<div>It doesn't matter if you change your mind.</div><br/>
			<div class="item">
				<c:set target="${projectmbean}" property="pid" value="${projectid}"/>
				<c:set value="${projectmbean.projectdetails}" var="map"/>
				<%-- Setting previous values --%>
				<c:set target="${projectmbean}" property="pname" value="${map.pname}"/>
				<c:set target="${projectmbean}" property="pintro" value="${map.pintro}"/>
				<h:form>
					<%-- Display it to user --%>
					<h:inputText styleClass="pidhidden" value="#{projectmbean.pid}"></h:inputText>
					Project Name: <h:inputText styleClass="text-input" value="#{projectmbean.pname}"></h:inputText><br/>
					Project Intro: <br/>
					<div class="colorededit" contenteditable="true">
					
					</div>
					<h:inputTextarea value="#{projectmbean.pintro}" styleClass="text-area"></h:inputTextarea><br/>
					<h:commandButton type="submit" value="Enter" action="#{projectmbean.AlterProjectBySettings}"/>
				</h:form>
			</div>
		</c:if>
		<c:if test="${page == 'options'}">
			<%-- The code here is displayed when user choose 'general' tab --%>
			<div class="noticetitle">Project Options</div>
			<div>Options, within your reach.</div><br/>
			
		</c:if>
		
	</div>
</div>
</f:view>
</body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$('.colorededit').text($('.text-area').text());
$(".colorededit").on('DOMSubtreeModified', function() {
    $('.text-area').text($('.colorededit').text());
});
</script>
</html>