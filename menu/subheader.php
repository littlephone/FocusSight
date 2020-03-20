<link rel="stylesheet" href="css/uikit.css" />
<script src="js/uikit.js"></script>
<script src="js/uikit-icons.js"></script>
<style>
.submenu{
}
.button{
  position:absolute;
  background-color: rgba(75, 210, 176 , 0.8);
  z-index:900;
}
.left{
  left:0;
  border-radius:0px 0px 0px 15px;
}
.right{
  right:0;
  border-radius:0px 0px 15px 0px;
}
.bgwrapper{
  overflow: hidden;
}
.dummy-child{
  height:100%;
}
.dummy-child, .icon{
  display:inline-block;
  vertical-align: middle;
}
a{
  text-decoration: none;
}
</style>


<?php
//require_once("ranking.php");
/* If the class is search, DO NOT PUT A REAL <a ON THEM, 
/* In other words, put '#' on href of search <a>
/*
/*
 */
//These are forum related

if($viewpage == "profile"){
  echo "<div class='submenu' style='overflow:hidden;background-color: #ACACAC; clear:both; width: 100%; height: 100px;'>";
  echo  "<h3 class='useraction'><a class='submenuitem' href='/account.php'>帳戶設定</a></h3>";
  echo  "<h3 class='useraction'><a class='submenuitem' href='/account/members.php'>找朋友</a></h3>";
  echo  "<h3 class='useraction'><a class='submenuitem' href='#'>我的帖子</a></h3>";
  echo   "</div>";
}

if($viewpage == "index"){
  //echo "<div style='white-space:nowrap'>";
  /*
  echo "\n\t<div class='' style='display:inline-block;height:100px'>";
  echo "\n\t\t<";
  echo "\n\t</div>";
  */
 echo "<div class='bgwrapper' style='white-space:nowrap;background-color: #00c5ff; width:100%;border-radius:0px 0px 15px 15px'>";
  //left button
  echo "\n\t<a href='#' class='button left' style='display:inline-block;height:100px;'>";
  echo "<div class='dummy-child'></div>";
  echo "\n\t\t\t<img src='../menu/images/left.png' class='icon' style='height:30px;width:30px;'/>";
  echo "\n\t</a>";

  echo "<div class='submenu' style='overflow:hidden; display:inline-block; white-space:nowrap; height: 100px;vertical-align:'>";
  if(@$_SESSION['username']){
  	echo  "<div class='useraction'> 
       <a class='submenuitem' href='createproject.php'>
      \n\t<img src='menu/icon/add.png' class='icon' />
      \n\t<div style='text-align:center'>Create Project</div>
      </a></div>";


    echo  "<div class='useraction'> 
       <a class='submenuitem' href='myproject.php'>
      \n\t<img src='/menu/images/catagory.png' class='icon' />
      \n\t<div style='text-align:center'>My Project</div>
      </a></div>";
  }
   echo  "<div class='useraction search'>
            <a class='submenuitem' href='#'>
            <img src='../menu/images/Search.png' class='icon' />
            <div style='text-align:center'>搜尋&ensp;Search</div>
           </a>
        </div>";
  
  
    echo  "<div class='useraction'> 
       <a class='submenuitem' href='forumlist.php'>
      \n\t<img src='../menu/images/discussion.png' class='icon' />
      \n\t<div style='text-align:center'>板塊&ensp;Thread</div>
      </a></div>";
  
 echo  "<div class='useraction'> 
       <a class='submenuitem' href='index.php'>
      \n\t<img src='../menu/images/msg.png' class='icon' />
      \n\t<div style='text-align:center'>訊息(即將推出)&ensp;Messages</div>
      </a></div>";
  echo   "</div>";
  //Right button
  echo "\n\t<a href='#' class='button right' style='display:inline-block;height:100px;vertical-align:top;float:right;'>";
  echo "<div class='dummy-child'></div>";
  echo "\n\t\t<img src='../menu/images/right.png' class='icon' style='height:30px;width:30px;'/>";
  echo "\n\t</div>";
  echo "</a>";
  //echo "</div>";
}
?>
<script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
<script>
checkSize();
checkScrollPosition(0);

  $(window).on("resize", function(e){
    checkSize();
  });
  // These device could not be simply controlled by button, thus a fallback is applied
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
  //Check if scroll button is required in the window
  function checkSize(){
    var barlen = $('.submenu').width() + 75;
    var windowlen = window.innerWidth;
    if(barlen <= windowlen){
      $('.button').css({'display': 'none'});
    }
    else $('.button').css({'display': 'inline-block'});
  }

//Its a bit ugly. But do the right job
function checkScrollPosition(scrollDisp){
	  //reset scroll button to default
	  $('.button').css({'background-color': 'rgba(75,210,176, 0.8)'});
    var windowsize = window.innerWidth;

    //Judge the scroll direction
    //If the Displacement is postive, then it's to the right;
    if(scrollDisp > 0){
	    var ScrollPos = $('.bgwrapper').scrollLeft() + scrollDisp + windowsize;
    }
    else{
      var ScrollPos = $('.bgwrapper').scrollLeft() + scrollDisp;
    }
	  var barlen = $('.submenu').width()+75;
    //alert(ScrollPos + ";" + barlen);
	  //Make button disable when it is at the either end
	  if(ScrollPos <= 0){
	  	$('.left').css({'background-color': 'rgba(255,255,255, 0.3)'});
	  }
	  if(ScrollPos >= barlen){
	  	$('.right').css({'background-color': 'rgba(255,255,255, 0.3)'});
	  }
  }
</script>
<script>
  //Dealing with left and right click of the button
  $('.left').click(function(e){
        var leftPos = $('.bgwrapper').scrollLeft();
    $('.bgwrapper').animate({
      scrollLeft: leftPos - 200
	}, "slow");
	checkScrollPosition(-200);
  });
  $('.right').click(function(e){
    var rightPos = $('.bgwrapper').scrollLeft();
    $('.bgwrapper').animate({
      scrollLeft: rightPos + 200
    }, "slow");
    checkScrollPosition(200);
  });
</script>
