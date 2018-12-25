<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@page import="java.util.*, 
 								com.focussight.manbean.*" %>
<%

//Check if the session is exists
if(!session.isNew()){
	String username = (String)session.getAttribute("username");
	int id = (Integer)session.getAttribute("id");
}else{
	String username = null;
	int id = 0;
}

	ProjectMBean mbean = new ProjectMBean();
	 mbean.showProjects();
	 List<Map<String, Object>> list = mbean.getProjectmap();
	 pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>


<style>
body{
	margin: 0;
}
.fakesubheader{
    display:none;
    min-height:100px;
    line-height: 100px;
    border-radius: 18px;
}
  .searchbarwrapper{
    width:500px;
    margin: 0 auto;
    white-space:nowrap;
  }
  #close{
    display: inline-block;
  }
  .searchbox{
	display:inline-block;
	width:350px;
  }
  
@keyframes dropsubmenu{
	0%{top: -5000px; opacity: 0}
	90%{top:-4px; opacity: 0.3}
	100%{top:0px; opacity: 1}
}
#searchkey{
	border:none;
	/*Override the border */
	border-bottom: 2px solid white;
	font-size:18px;
}
.searchbox, #close{
	vertical-align: middle;
	position:relative;
	animation: dropsubmenu 1s ease;
}
.topmenu{
	width: 100%;
	height: 100px;
	background-color: #00c5ff;
	border-radius: 18px;
}
@keyframes dropdownsearchmenu{
	0%{height: 0px;}
	90%{height: 395px};
	100%{height: 400px}
}
.searchresultprovider{
	width:100%;
	position:absolute;
	top:150px;
	display: none; 
	animation: : dropdownsearchmenu 1s ease;
	padding-left: 50px;
	
}
.topmenu a{
	text-decoration:none;
	color:white;
	width: 200px;
	margin-left: 100px;
	margin-right: 100px;
	margin-bottom:10px;
}
.icon{
	width: 70px;
	height:70px;
}
.littleicon{
	width: 40px;
	height: 40px;
}
.link{
	display:inline-block;
}
 /* Modulise Search Bar Style */
 .searchbarwrapper{
    width:500px;
    margin: 0 auto;
    white-space:nowrap;
    overflow:scroll;
  }
  #close{
    display: inline-block;
  }
  .searchbox{
	display:inline-block;
	width:350px;
  }
.card{
	display: block;
	border-radius: 18px;
	background-color: grey;
	color: white;
	width: 400px;
	min-height:50px;
	padding: 20px;
	text-decoration: none;
	margin-top: 10px;
}
</style>
<meta charset="UTF-8">
<title>FocusSight EE - Labstry</title>
</head>
<body>
<%@include file="header.jsp"%>
<f:view>


<%
if(uname != null){
%>
<div class="topmenu">
	<a href="project/myproject.jsf" class="link">My project</a>
	<a href="manage.jsf" class="link">My information</a>
	<a href="#" class="search link">
			<img src="https://www.labstry.com/menu/images/Search.png" class="icon"/><br/>
			Search
	</a>
</div>
<%} %>
<div class="fakesubheader" style="background-color:#00c5ff;">
<div class="searchbarwrapper">
    <form method="POST" action="minsearch.jsf" class='searchform' onclick="return false;">
        <div class="search searchinline" id="close">
  <img src="https://www.labstry.com/menu/images/cross.png" class="buttonimg littleicon"/>
  </div>
        <input type="text" name="searchname" class="searchbox" id="searchkey" placeholder="搜尋帖子" />
            <a class="imagediv" id="sending" href="#">
            <img src="https://www.labstry.com/menu/images/Search.png" class="buttonimg littleicon" />
        </a>
    </form>
</div>
</div>
<div class="searchresultprovider">

</div>
<h1>Your project, your team, starts here...</h1>
<form action="search.jsf" method="post">
Search: <input  type="text" name="searchname" value=""/>
<input type="submit" />
</form>

<div>
Projects:
<c:forEach items="${list}" var="map">
	<a href="projectdetails.jsf?id=${map.pid}">${map.pname} <br/>
		
	</a>
</c:forEach>
</div>
</f:view>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$('.fakesubheader').css('display') == 'none';
$('.searchresultprovider').css('display') == 'none';
$('.search').click(function(){
	if($('.fakesubheader').css('display') == 'none'){
		$('.fakesubheader').css({'display':'block','z-index':'1000',
			'height': '100px'
		});
		$('.searchresultprovider').css({'z-index': '1000'});
		$('.button').css({'display':'none', 'z-index': '-3'});
		$('.topmenu').css({'display':'none','z-index':'1'});
		var headercolor = $('.topmenu').css('background-color');
		$('.fakesubheader').css({'background-color': headercolor});
		$('#searchkey').css({'background-color': headercolor});

		$('.searchresultprovider').css({'background-color': headercolor,
		 	'opacity': '0.9'});
		$('.searchresultprovider').css({'display':'block',
		});

	}else{
		$('.fakesubheader').css({'display' : 'none',
			'height': '0px','z-index':'10'});
		$('.topmenu').css({'display':'inline-block'});
		$('.button').css({'display':'inline-block','z-index': '900' });
		$('.searchresultprovider').css({'display':'none',
		});
		// But in a thorough test, it passes all of our test through Android Samsung browser and Chrome on Android,
  		// we just let magic happens again :D
	    /* 
  		if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)){
     		$('.submenu').css({
      			'overflow': 'scroll'
    		})
     		$('.button').css({
      			'display': 'none'
     		})
  		} */
	}
});

var headerheight = parseInt($('.fakesubheader').css('height'));
var windowheight = parseInt($(window).height());

$('.searchresultprovider').css({'min-height': windowheight - headerheight});

//The content below is ALL ABOUT AJAX
$('#searchkey').keyup(function(e){
	e.preventDefault();
	var forming = $('.searchform');
	$.ajax({
		type: 'GET',
		url: forming.attr('action'),
		data: forming.serialize(),
		success: function (data){
			$('.searchresultprovider').html(data);
		},
		error: function(){
			alert("Error");
		}
	});
});
</script>
</html>