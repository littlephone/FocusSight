<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>

<html>

<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!--- 確保頁面與手機相容-->
<head>
	<title>註冊LabStry帳戶 </title>
    <link rel="stylesheet" href="menu/dynamicmenu.css"/>
<style type="text/css">
	input{
		float:right;
	}
	#regtable{
	        width:300px;
	        margin: 0 auto;
	}
	#regtag{
	        border: 2px solid #00c5ff;
	        background-color: white;
	        border-radius: 4px;
	}
	.table{                 /*使用CSS定義表單TABLE */
	display:table;
	width: 95%;
}

    .table-cell{            /* 定義一欄/格*/
	display:table-cell;
}
    .table-row{              /*定義一行*/
	display:table-row;
	height: 60px;
}

/*Stying input blanks */
.blank{
	border:none;
	border-bottom: 2px solid grey;
	display: inline-block;
	height:25px;
	width: 100%;
	font-size: 16px;
	outline: none;
	margin-bottom: 0;
	transition: border-bottom 0.1s ease;
	text-align:right;
}
.blankborder{
	display: block;
	content: '';
	transform: scaleX(0);
	transition: transform 0.5s ease-in-out;
	border-bottom: 2px solid green;
	margin-top: 2px;
}
.blank:focus ~.blankborder{
	transform: scaleX(1);
	}
.blank:focus{
	font-size:18px;
	text-align: left;
	border-bottom:none;
	padding-bottom: 4px;
}
.title{
	text-align: center;
	transition: text-align 0.5s ease;
	display:block;
	padding:50px; 
	width:100%;  
	height:10px;   /* 重要! background-color 如果進入註冊介面前是forum,設為藍色(00c5ff)      */
	background-color: orange;	font-size: 40px;
}

/* Styling optional button*/
.showoptionalblank{
	text-align: center;
	border-radius: 18px;
	border: 1px solid #ACACAC;
	text-decoration: none;
	color: black;
	width: 100%;
	height: 100%;
}
.showoptions{
	pointer-events: auto;
	cursor: pointer;
}
</style>
</head>
<body>
     <!--顯示標題 -->
  <div style="" class="title">註冊Labstry帳戶</div>         <!--顯示頁標題 -->
  <h:form id="regtable" style="min-width: 95%">

	<div class="table">     <!--這是用戶輸入申請資料的表 一行有兩欄分別顯示 要求輸入的數據及輸入元素 -->
		<!-- The <span> tag is for styling the bottom of the input
			 class="blank" contains all styled blank
		 -->
		<div class="table-row">
	     <div class="table-cell">*表示該列選填</div>
	     </div>
	     <div class="table-row">
	     <div class="table-cell">用戶名稱:</br>
	     	<h:inputText value="#{usermbean.username}"></h:inputText>
		 </div>
	     </div>
	     <div class="table-row">	 
		 <div class="table-cell">密碼:</br>
				<h:inputSecret value="#{usermbean.password}"></h:inputSecret>
		 </div>
	     </div>
		    
		 <div class="table-row">
		 <div class="table-cell">確認密碼:</br>
	        <input type="password" class="blank" name="repassword" /><br>
			<span class='blankborder'></span>
	     </div>
	     </div>
			
		 <div class="table-row">
		 <div class="table-cell">Email:</br>
	        <input type="email" class="blank" name="email"><br>
	     	<span class='blankborder'></span>
	     </div>
	     </div>

		 <div class="table-row">
		 <div class="table-cell">密碼提示問題:</br>
		    <input type="text" class="blank" name="password_question"><br>
	     	<span class='blankborder'></span>
		 </div>
		 </div>
		 
	     <div class="table-row">
		 <div class="table-cell">密碼提示答案:</br>
	        <input type="text" class="blank" name="password_question_answer"><br>
	     	<span class='blankborder'></span>
	     </div>
	     </div>
		 
		 <div class="table-row showoptions">
		 	<a class="table-cell showoptionalblank">顯示選填項</a>
		 </div>
		 <div class="table-row optional">
		 <div class="table-cell">*聯絡電話:</br>
	        <input type="text" class="blank" pattern="[0-9]*" name="Phone_number"><br>
	     	<span class='blankborder'></span>
	     </div>
	     </div>
		 
		 <div class="table-row">        <!--用戶輸入資料後,按下註冊按鈕而完成註冊 -->
		 <div class="table-cell"></br><input id="regtag" type="submit" name="submit" value="註冊" style="width:95%; height:60px; margin:0 auto"></div> 
	     </div>
	     </div>
		 
		 <div class="table-row">                                         <!--用戶如果已經擁有帳號, 按這裡的按鈕登入 -->
		 <div class="table-cell">已有帳戶？</div>
	     <div class="table-cell"><a href="login.php">登入</a> </div>
	     </div>
	     </div>
	
	</div>
	
  </h:form>
</body>
<script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
<script>
//Hide optional blank
$('.optional').css({
	'display' : 'none'
});

$('.showoptionalblank').on('click', function(e){
	if($('.optional').css('display') == 'none')
		$('.optional').css({
		'display' : 'block'
		});
	else 
		$('.optional').css({
		'display' : 'none'
		});
});


$(window).scroll(function(e){         //動態更變header
	var $cls = $('.title');
	var titlewidth = parseInt($('#menudiv').css('height'));
	var Fixed = ($cls.css('position') == 'fixed');
	console.log($(this).scrollTop());
	if($(this).scrollTop() > titlewidth && !Fixed){
		$cls.css({'position': 'fixed',
		 'top': '0px',
		 'font-size':'20px',
		 'text-align':'left',
		 'padding':'10px', 
		 'height': titlewidth
		});
	}
	if($(this).scrollTop() < titlewidth && Fixed){
		$cls.css({'position': 'static',
		 'top': '0px',
		 'font-size':'30px',
		 'text-align':'center',
		 'padding': '50px', 
		 'height':'40px'});
	}
});

</script>
</html>
 