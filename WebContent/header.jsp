<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.toplink{
	display:inline-block;
	padding-left: 100px;
}
.header{
	background-color: orange;
	border-radius: 0 0 18px 18px;
	height:50px;
	line-height: 50px;
	overflow:scroll;
}
</style>
<div class='header'>
<a class="toplink" href="/FocusSight/index.jsp">FocusSight</a>
<a class="toplink">viewProjectByCatagory()</a>
<a class="toplink">How does it work?</a>
<%
String uname = (String)session.getAttribute("username");
int id = (Integer)session.getAttribute("id");
if(uname != null){
	out.println("<a class=\"toplink\">" + uname + "</a>");
	out.println("<a class=\"toplink\" href=\"LogoutServlet\">Logout</a>");
}else{
%>
<a class="toplink" href="/FocusSight/login.jsp">Login</a>
<a class="toplink">New to here? Register</a>
<%}%>
</div>