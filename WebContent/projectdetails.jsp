<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page import="java.sql.*,
								  java.util.*, 
								 com.focussight.stored.*, 
								 javax.faces.context.*" %>

<!DOCTYPE html>
<html>
<style>
body{
	margin:0;
}
.introwrapper{
	border-radius: 18px;
	border: 1px solid grey;
	width: 98%;
	min-height: 400px;
	margin: 0 auto;
	margin-top: 50px;
	overflow-x:hidden;
}
.introinnerwrapper{
	width:100%;
	height:100%;
}
.coloredwrapper{
	background-color: #00c5ff;
	padding:100px;
}
.projecttitle{
	font-size:28px;
}
.join{
	border: 1px solid #00c5ff;
	color: #00c5ff;
}
.grey{
	border: 1px solid grey;
	color: grey;
}
.green{
	border: 1px solid green;
	color:green;
}
.orange{
	border: 1px solid orange;
	color:orange;
}
.join, .statusbtn{
	display:block;
	text-decoration :none;
	padding: 20px;
}
.cancelbtn{
	display:none;
}
.joinforq{
	display:none;
}
</style>
<head>
<meta charset="UTF-8">
<%
	if(request.getParameter("id") == null || session.getAttribute("userid") == null){
		HttpSession session22 = request.getSession();
		response.sendRedirect("index.jsf");
		return;
	}
	int userid = (int)session.getAttribute("userid");
	int projectID = Integer.parseInt(request.getParameter("id"));
	
	pageContext.setAttribute("userid", userid);
	pageContext.setAttribute("projectid", projectID);
%>
<c:set target="${projectmbean}" property="pid" value="${projectid}"/>
<c:set target="${membermbean}" property="projectid" value="${projectid}"/>
<c:set target="${membermbean}" property="userid" value="${userid}"/>
<c:set value="${membermbean.status}" var="status"/>

<c:set value="${projectmbean.projectdetails}" var="map"/>

<title>Join project ${map.pname} - Labstry FocusSight</title>
</head>
<body>
<f:view>
<%@include file="header.jsp"%>
<div class="introwrapper">
	<div class="introinnerwrapper">
		<div class="coloredwrapper">
			<div class="projecttitle">${map.pname}</div>
			Introduction: ${map.pintro}
		</div>
		<div class="buttonprovider">
		<c:if test="${status == -1}">
			<a id="joinbtn" class="join" href="joinproject.jsf?action=request&id=${userid}&project=${map.pid}">Join</a>
		</c:if>
		<c:if test="${status == 0}">
			<div class="statusbtn grey">Waiting for approval.</div>
			<a class="statusbtn grey cancelbtn2 cancelaction" 
				href="joinproject.jsf?action=cancel&id=${userid}&project=${map.pid}">
				Cancel application</a>
		</c:if>
		<c:if test="${status == 1}">
			<a class="statusbtn green" href="project/viewproject.jsf?id=${map.pid}">Enter project page</a>
		</c:if>
		<c:if test="${status == 2}">
			<a id="joinbtn" class="statusbtn orange" href="joinproject.jsf?action=request&id=${userid}&project=${map.pid}">Re-apply</a>
		</c:if>
		<c:if test="${status == 3}">
			<div class="statusbtn grey">Sorry. Your application was blocked.</div>
		</c:if>
		</div>
	</div>
	<a id="joinbtn" class="join joinforq" href="joinproject.jsf?action=request&id=${userid}&project=${map.pid}">Join</a>
	<a class="statusbtn grey cancelbtn cancelaction" 
		href="joinproject.jsf?action=cancel&id=${userid}&project=${map.pid}">
				Cancel application</a>
</div>
</f:view>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$('#joinbtn').on('click', function(e){
	e.preventDefault();
	$('.buttonprovider').html('<div class="statusbtn grey">Sending...</div>');
	var post_url = $(this).attr('href');
	$.ajax({
		type : 'POST',
		url: post_url,
		success: function(data){
			$('.buttonprovider').html('<div class="statusbtn grey">Request sent. Waiting for approval.</div>');
			$('.joinforq').css({'display' : 'none'})
			$('.cancelbtn').css({'display' : 'block'});
		}
	});
});
$('.cancelaction').on('click', function(e){
	e.preventDefault();
	$('.buttonprovider').html('<div class="statusbtn grey">Processing...</div>');
	var post_url = $(this).attr('href');
	$.ajax({
		type : 'POST',
		url: post_url,
		success: function(data){
			$('.buttonprovider').html('<div class="statusbtn grey">Application Cancelled.</div>');
			$('.cancelbtn').css({'display': 'none'});
			$('.joinforq').css({'display' : 'block'});
			
		}
	});
});
</script>
</html>