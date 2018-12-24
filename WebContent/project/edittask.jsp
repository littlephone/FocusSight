<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@page import="com.focussight.stored.*, 
				java.util.*"  %>
<!DOCTYPE html>
<%
	int pid = 0;
	if(request.getParameter("pid") != null)
		pid = Integer.parseInt(request.getParameter("pid"));
	int userid = (int)session.getAttribute("userid");
	int tid = Integer.parseInt(request.getParameter("tid"));
	
	List<Integer> availyears = new ArrayList<Integer>();
	List<Integer> months = new ArrayList<Integer>();
	List<Integer> days = new ArrayList<Integer>();
	List<Integer> hours = new ArrayList<Integer>();
	List<Integer> minutes = new ArrayList<Integer>();
	
	int year = Calendar.getInstance().get(Calendar.YEAR);
	int curr_month = Calendar.getInstance().get(Calendar.MONTH);
	int curr_day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
	
	for(int i = year; i<= 2099; i++) availyears.add(i);
	for(int i = 1; i<= 12; i++) months.add(i);
	for(int i = 1; i<= 31; i++) days.add(i);
	for(int i=0; i<= 23; i++) hours.add(i);
	for(int i=0; i<= 59; i++) minutes.add(i);
	
	//Set page context
	pageContext.setAttribute("pid", pid);
	pageContext.setAttribute("tid", tid);
	pageContext.setAttribute("year", availyears);
	pageContext.setAttribute("month", months);
	pageContext.setAttribute("curr_month", curr_month);
	pageContext.setAttribute("curr_day", curr_day);
	pageContext.setAttribute("day", days);
	pageContext.setAttribute("hour", hours);
	pageContext.setAttribute("minute", minutes);
%>

<c:set target="${projectmbean}" property="pid" value="${pid}"/>
<c:set value="${projectmbean.projectdetails}" var="projectmap"/>
<c:set target="${taskmbean}" property="pid" value="${projectmap.pid}"/>
<c:set target="${taskmbean}" property="tid" value="${tid}"/>

<c:set value="${taskmbean.taskbytid}" var="taskmap"/>

<%-- Resetting the values into taskmbean --%>
<c:set target="${taskmbean}" property="ttitle" value="${taskmap.ttitle}"/>
<c:set target="${taskmbean}" property="tcontent" value="${taskmap.tcontent}"/>

<%-- 
<c:set target="${taskmbean}" property="year" value="${taskmap.year}"/>
<c:set target="${taskmbean}" property="month" value="${taskmap.month}"/>
<c:set target="${taskmbean}" property="day" value="${taskmap.day}"/>
<c:set target="${taskmbean}" property="hour" value="${taskmap.hour}"/>
<c:set target="${taskmbean}" property="minute" value="${taskmap.minute}"/>
--%>


<html>
<c:out value="${taskmap['year']}"/>
<link rel="stylesheet" type="text/css" href="projectsettings.css"/>
<head>
<style>
.hidden{
	display:none;
}
.formwrapperstyle, .taskpreview{
	border: 1px solid grey;
	border-radius: 18px;
	padding: 20px;
}
.inputblank{
	border-radius: 21px;
	border: 1px solid orange;
	font-size: 18px;
	font-weight:bold;
	padding-left: 10px;
	width: 400px;
}
.colouredtext{
	width:98%;
	margin-top: 10px;
	min-height: 400px;
	margin:0 auto;
	border: 1px solid #00c5ff;
	border-radius: 18px;
	padding: 10px;
}
.hiddentext{
	display:none;
}
/* We are describing a card here*/
.cardasanchor{
	display:block;
	text-decoration: none;
	color:black;
	width: 98%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	min-height: 100px;
	border-radius: 18px;
	min-height: 100px;
	overflow:hidden;
}
.cardanchorcontent{
	padding:10px;
}
.noticentry{
	clear:both;
	display:block;
	padding:10px;
}
.ptitle{
	font-size: 18px;
	font-weight:bold;
}
.deadline, .deadlinedetails{
	display:inline-block;
}
</style>
<meta charset="UTF-8">


<title>Add task to ${projectmap.pname} - Labstry FocusSight</title>
</head>
<body>
<f:view>
<c:import url="header.jsp"/>
<div class="project_details_wrapper">
	<div class="details_inner_wrapper">
		<div class="project_name"><b>Add task to ${projectmap.pname}</b></div>
	</div>
</div>
<h:form styleClass="formwrapperstyle">
	<h:inputText styleClass="hidden" value="#{taskmbean.pid}"></h:inputText>
	<h:inputText styleClass="hidden" value="#{taskmbean.tid}"></h:inputText>
	<h:inputText styleClass="inputblank field" value="#{taskmbean.ttitle}"></h:inputText><br/>
	Task deadline: 
	<select name="year" class="year field">
		<c:forEach items="${year}" var="yearline">
			<c:if test="${yearline == taskmap.year}" var="current_year">
				<option value="${yearline}" selected>${yearline}</option>
			</c:if>
			<c:if test="${not current_year}">
				<option value="${yearline}">${yearline}</option>
			</c:if>
		</c:forEach>
	</select>/
	<select name="month" class="month field">
		<c:forEach items="${month}" var="monthline">
			<c:if test="${monthline == taskmap.month}" var="current_month">
				<option value="${monthline}" selected>${monthline}</option>
			</c:if>
			<c:if test="${not current_month}">
				<option value="${monthline}">${monthline}</option>
			</c:if>
		</c:forEach>
	</select>/
	<select name="day" class="day field">
		<c:forEach items="${day}" var="dayline">
			<c:if test="${dayline == taskmap.day}" var="current_day">
				<option value="${dayline}" selected>${dayline}</option>
			</c:if>
			<c:if test="${not current_day}">
				<option value="${dayline}">${dayline}</option>
			</c:if>
		</c:forEach>
	</select>
	&emsp; &emsp;
	<select name="hour" class="hour field">
		<c:forEach items="${hour}" var="hourline">
			<c:if test="${hourline < 10}" var="lessthan10">
				<option value="0${hourline}">0${hourline}</option>
			</c:if>
			<c:if test="${not lessthan10}">
				<option value="${hourline}">${hourline}</option>
			</c:if>
		</c:forEach>
	</select>:
	<select name="minute" class="minute field">
		<c:forEach items="${minute}" var="minline">
			<c:if test="${minline < 10}" var="lessthan101">
				<option value="0${minline}">0${minline}</option>
			</c:if>
			<c:if test="${not lessthan101}">
				<option value="${minline}">${minline}</option>
			</c:if>
		</c:forEach>
	</select>
	<h:inputText styleClass="date hidden field" value="#{taskmbean.end_date}">
		<f:convertDateTime pattern="yyyy/MM/dd HH:mm"/>
	</h:inputText>
	<div class="colouredtext" contenteditable="true">
	</div>
	<h:inputTextarea styleClass="field hiddentext" value="#{taskmbean.tcontent}"></h:inputTextarea>
	<h:commandButton id="submit" type="submit" value="Submit" action="#{taskmbean.updateContent}"/>
</h:form>
</f:view>
<div class="taskpreview">
Task Preview
<a class="cardasanchor">
		<div class="cardanchorcontent">
			<div class="noticentry ptitle ntitle"></div>
			<div class="noticentry deadline">Deadline: <div class="deadlinedetails"></div></div>
			<div class="noticentry pcontent">${taskmapline.tcontent}</div>
		</div>
</a>	
</div>

</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>

setDate();
setPreview();
getContent();


function setPreview(){
	if($('.inputblank').val() == ''){
		$('.ptitle').text("<<Untitled>>");
	}else{
		$('.ptitle').text($('.inputblank').val());
	}
	$('.deadlinedetails').text($('.date').val());
	$('.pcontent').html($('.hiddentext').html());
}
function getContent(){
	$('.colouredtext').html($('.hiddentext').html());
}

function updateDropBox(){
	//Add all selection back first
	for(i=0; i<=31; i++) $(".day option[value='"+i+"']").remove();
	for(i=1; i<=31; i++) $(".day").append("<option value='" +i+ "'>"+i+"</option>");
	
	var selected = $('.month').children("option:selected").val();

	if(selected == '4' ||  selected == '6' || selected == '9' || selected == '11')
		$(".day option[value='31']").remove();
	else if(selected == '2'){
		var chosenyear = $('.year').children("option:selected").val();
		var startdate = 0;
		if(chosenyear % 4 == 0)
			startdate = 30;
		else
			startdate = 29;
		alert(startdate);
		for(i = startdate; i<=31; i++){
				$(".day option[value='"+i+"']").remove();
		}
	}
}
function setDate(){
	var hour = 0;
	var min = 0;
	if($('.hour').val() == "") hour = 0;
	else hour = $('.hour').val();
	
	
	if($('.minute').val() == "") min = 0;
	else min = $('.minute').val();
	
	var date = $('.year').children("option:selected").val() + "/" +
			$('.month').children("option:selected").val() + "/" +
			$('.day').children("option:selected").val() + " " +
			hour + ":" + min;
	
	$('.date').val(date);
}

$('.month').on('change', function(e){
	updateDropBox();
});
$('.year').on('change', function(e) {
	updateDropBox();
});
$('.field').on('change', function(e){
	setDate();
	setPreview();
});
$('.field').on('keyup', function(e){
	setPreview();
});

$('.colouredtext').on('DOMSubtreeModified', function(e){
	$('.hiddentext').html($('.colouredtext').html());
	setPreview();
})

</script>
</html>