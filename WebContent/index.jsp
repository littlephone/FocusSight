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
@keyframes roundedcorners{
	0%{border-radius: 18px 18px 18px 18px}
	90%{border-radius: 18px 18px 2px 2px}
	100%{border-radius: 18px 18px 0px 0px}
}
.fakesubheader{
    display:none;
    min-height:100px;
    line-height: 100px;
    animation: roundedcorners 1s ease;
    border-radius: 18px 18px 0px 0px
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
	margin-left: 50px;
}
.searchhint{
	display: block;	
	text-align : center;
}
.leftfloat{
	display:inline;
}
.floatblock{
	display:inline-block;
	height: 100px;
	width:400px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	border-radius: 18px;
	line-height: 100px;
	text-decoration:none;
	padding: 10px;
	color:black;
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
        <input type="text" name="searchname" class="searchbox" id="searchkey" placeholder="Search Project..." />
            <a class="imagediv" id="sending" href="#">
            <img src="https://www.labstry.com/menu/images/Search.png" class="buttonimg littleicon" />
        </a>
    </form>
</div>
</div>
<div class="searchresultprovider">
	<div class="searchinnerwrapper">
		<div class="searchhint">Start searching by typing keywords...</div>
	</div>
</div>
<img style="width:100%;border-radius:18px;overflow:hidden" src="image/glass-table.jpg"/>
<div class="rounded leftfloat">
<div>Recommended Projects:</div>
<c:forEach items="${list}" var="map">
	<a class="floatblock" href="projectdetails.jsf?id=${map.pid}">${map.pname}</a>
</c:forEach>
</div>
</f:view>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$('.fakesubheader').css('display') == 'none';
$('.searchresultprovider').css('display') == 'none';
$('.search').click(function(){
	if($('.fakesubheader').css('display') == 'none'){
		$('.fakesubheader').css({'display':'block','z-index':'1000',
			'height': '100px'
		});
	    $('.fakesubheader').animate({
	    	borderRadius: '18px 18px 0px 0px'}
	    	, 5000   
	    );
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
		
		//Special: setting corners gradually
	}else{
	    $('.fakesubheader').animate({
	    	borderRadius: '18px 18px 18px 18px'}
	       	, 5000   
	    );
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
$('.searchhint').css({
	'line-height': windowheight - headerheight+'px'
});

$('.searchresultprovider').css({'min-height': windowheight - headerheight});

//The content below is ALL ABOUT AJAX
$('#searchkey').keyup(function(e){
	e.preventDefault();
	if ($('#searchkey').val() != ""){
		$('.searchhint').css({
			'display' : 'none'
		})
		var forming = $('.searchform');
		$.ajax({
			type: 'GET',
			url: forming.attr('action'),
			data: forming.serialize(),
			success: function (data){
				$('.searchinnerwrapper').html(data);
			},
			error: function(){
				alert("Error");
			}
		});
	}else{
		//Clear all the contents
		$('.searchinnerwrapper').html("<div class='searchhint'>Start searching by typing keywords...</div>");
		$('.searchhint').css({
			'display': 'block',	
			'line-height' : (windowheight - headerheight) + 'px',
			'text-align' : 'center'
		})
	}
});
</script>
</html>