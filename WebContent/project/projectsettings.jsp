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
	boolean projectOwner = projectdao.isProjectOwner(userid, projectID);
	
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
<link rel="stylesheet" type="text/css" href="projectsettings.css"/>
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
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=notice">Notice</a>
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=task">Tasks</a>
			<a class="item" href="projectsettings.jsf?pid=${projectid}&type=status">Project Status</a>
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
			<%-- The code here is displayed when user choose 'options' tab --%>
			<div class="noticetitle">Project Options</div>
			<div>Options, within your reach.</div><br/>
			
		</c:if>
		
		
		<c:if test="${page == 'notice'}">
			<%-- The code here is displayed when user choose 'notice' tab --%>
			<div class="noticetitle">Edit Notice</div>
			<div>Its easy to contact your team members.</div><br/>
			<div class="links block">
				<a href="addnotice.jsf?pid=${projectid}">Add notice</a>
				<a href="shownotice.jsf?pid=${projectid}&mode=delete">Delete Notice</a>
			</div>
			<c:set target="${noticembean}" property="pid" value="${projectid}"></c:set>
			<c:set target="${noticembean}" property="uid" value="${userid}"></c:set>
			<c:set value="${noticembean.noticemap}" var="map"/>
			<div class="block">
			<c:forEach items="${map}"  var="mapline">
				<a class="cardasanchor" href="editnotice.jsf?pid=${projectid}&nid=${mapline.nid}">
					<div class="cardanchorcontent">
						<div class="noticentry">${mapline.ntitle}</div>
						<div class="noticentry">${mapline.ndate}</div>
						<div class="noticentry">${mapline.ncontent}</div>
					</div>
				</a>	
			</c:forEach>
			</div>
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