<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.focussight.dao.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<style>
.cardwrapper{
	width: 500px;
	min-height: 400px;
	border: 2px solid grey;
	border-radius: 20px;
	margin: auto;
	overflow:hidden;
}
.cardtitle{
	font-size: 30px;
	font-family: Arial, Tahoma;
	padding-top: 120px;
	background-color: orange;
	padding-left: 10px;
}
.cardsubtitle{
	font-size: 15px;
}

.formrow{
	padding-left: 10px;
}
</style>

<meta charset="UTF-8">
<title>Register -  Labstry</title>
</head>
<body>
<div class="cardwrapper">
	<div class="cardtitle">
		<div class="greetings">Welcome</div>
		<div class="cardsubtitle">Let us know you...</div>
	</div>
	<form method="POST" action="Register">
		<div class="formrow"> Username: <input type="text" class="greetuser" name="username"/></div>
		<div class="formrow"> Password: <input type="password" name="password"/></div>
		<div class="formrow"> Gender:
			<input type="radio" name="gender" value="M">Male
			<input type="radio" name="gender" value="F">Female
		</div>
		
		<div class="formrow"> Profession: <input type="text" name="profession"/></div>
		<div class="formrow"> Age: 
			<select name="age">
				<%
					for(int i=12; i<= 99; i++){
						out.println("<option value=\""+ i +"\">"+ i + "</option>");
					}
				%>
			</select>
		
		</div>
		<div class="formrow"> Email: <input type="email" name="email"/></div>
		<div class="formrow"> Phone: <input type="text" name="phone"/></div>
		
		<input type="submit" value="Submit"/>
	</form>
</div>
</body>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$('.greetuser').on("keyup", function(e){
	var content = $('.greetuser').val();
	if(content != ""){
		$('.greetings').text("Welcome, " + content);
	}else{
		$('.greetings').text("Welcome");
	}
});
</script>
</html>