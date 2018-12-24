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
	pageContext.setAttribute("year", availyears);
	pageContext.setAttribute("month", months);
	pageContext.setAttribute("curr_month", curr_month);
	pageContext.setAttribute("curr_day", curr_day);
	pageContext.setAttribute("day", days);
	pageContext.setAttribute("hour", hours);
	pageContext.setAttribute("minute", minutes);
	
	System.out.println(pid);
%>
<c:set target="${projectmbean}" property="pid" value="${pid}"/>
<c:set value="${projectmbean.projectdetails}" var="projectmap"/>
<c:set target="${taskmbean}" property="pid" value="${projectmap.pid}"/>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<f:view>
<h:form>
	<h:inputText value="#{taskmbean.pid}"></h:inputText>
	<h:inputText value="#{taskmbean.ttitle}"></h:inputText>
	<h:inputText value="#{taskmbean.end_date}">
		<f:convertDateTime pattern="yyyy/MM/dd HH:mm"/>
	</h:inputText>
	<h:inputText value="#{taskmbean.tcontent}"></h:inputText>
	<h:commandButton id="submit" type="submit" value="Submit" action="#{taskmbean.addingTasks}"/>
</h:form>
</f:view>
</body>
</html>