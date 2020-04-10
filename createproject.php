<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
//Redirect unregistered user
if(!@$_SESSION['username']) header("Location: /focussight/conference-room-client.php");


include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/SQLiteOpener.php";
include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/Project.php";
include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/Member.php";
include_once @$_SERVER['DOCUMENT_ROOT']."/focussight/classes/ImageTools.php";
include_once "connect.php";

$project = new Project($pdoconnect);
$member = new Member($pdoconnect);
$imagetool = new ImageTools();

if(@$_GET['action'] == 'create' && @$_POST['pname']){
	$upload_dir = @$_SERVER['DOCUMENT_ROOT'].'/focussight/project/thumbnails/';
	$filedir = $imagetool->uploadPhoto($_FILES, $upload_dir);

	/*
	$file = basename($_FILES['file']['name']);


	$imageType = strtolower(pathinfo($file, PATHINFO_EXTENSION));
	//Generate a unique thumbnail filename
	$targetfile = $upload_dir.md5(uniqid(md5(microtime()), true)).".".$imageType;

	move_uploaded_file($_FILES['file']['tmp_name'], $targetfile);
*/
	//Resize image 
	//ååimagejpeg($targetfile, $targetfile, 90);

	//get attr
	$pname = @$_POST['pname'];
	$managerid = @$_SESSION['id'];
	$requirements = @$_POST['requirements'];
	$progress = 0;
	$pintro = @$_POST['pintro'];
	$psnapshot = $filedir;
	$accept = @$_POST['accept'];
	$rules = @$_POST['rules'];


	$pid = $project->createProject($pname, $managerid, $requirements, $progress, $pintro, $psnapshot, $accept, $rules);

	$project->initProjectSqlite(1, @$_POST['pname']);

}
?>

<html>

<head>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<link rel="stylesheet" type="text/css" href="/menu/dynamicmenu.css"/>
	<Title>Create Project - Labstry Focussight</Title>
</head>
<body>
<style>
body{
	margin: 0;
	
}
.blank, .singleliner{
	resize: none;
	border: none;
	display: block;
	width: 98%;
	margin: 0 auto;
	border-radius: 20px;
	box-shadow: 2px 2px 4px 4px grey;
	box-sizing: border-box;
	font-size: 24px;
	padding-left: 10px;
	margin-bottom: 20px;

}
input{
	height: 100px
}
textarea{
	height: 400px;
	font-family: 'Source Sans Pro', sans-serif;
}
.filepart{
	border: none;
	box-shadow: none;
	font-size: 12px;
}
#preview{
	width:200px;
	height: 100px;
}

.singleliner{
	vertical-align: middle;
	overflow: hidden;
}
.pname{
	width: 100%;
	border:none;
	font-size: 24px;
}
.stylishselector, .visibletoggle{
text-decoration:none;
color:black;
background: linear-gradient(to right, orange 50%, white 50%);
background-size: 200% 100%;
background-position: left bottom;
transition: all .5s ease-out;
border-radius: 4px;
padding-left:10px;
padding-right: 10px;
cursor: pointer;
border: 1px solid orange;
}

.stylishselector:hover, .visibletoggle:hover{
background-position: right bottom;
}

</style>

<?php include_once("module/header.php"); ?>

<h2 style="padding-left: 10px;">Create Project "<span id="projectname"></span>"</h2>

<form method="POST" action="createproject.php?action=create" enctype="multipart/form-data">

<div style="font-size: 16px; margin: 0 auto; width: 98%; padding-left: 10px; padding-bottom: 10px;"> 
	<input name="accept" class="acceptblank" type="hidden" value="1" />
	<span class='visibletoggle' id="accept"> On </span>&ensp;<label>Open for application</label>
</div>

<div class="singleliner" id="descript">
	<img id="preview" src="#" style="vertical-align: middle;" alt="Upload your project thumbnail here..."/> 
	<input type="file" style="display: none" name="file" class="filepart" />
	<span id="uploadbtn" style=" cursor: pointer;font-size: 16px;">Upload</span><br/>
	<label style="font-size: 12px">Please ensure your thumbnail has dimension of 200px x 100px</label>
	<input class="pname" name="pname" placeholder="Project Name" />
</div>

<textarea class="pintro blank" name="pintro" placeholder="Introduction">
</textarea>

<textarea class="requirements blank" name="requirements" placeholder="Requirements...">
</textarea>

<textarea class="rules blank" name="rules" placeholder="Rules for participants.">
</textarea>


<input type="submit" style="font-size: 18px;height: auto" class="blank" name="submit" value="Create"/>

</form>

</body>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
$('.filepart').css({
	'display' : 'none'
});
$('#uploadbtn').on('click', function(){
	$('.filepart').click();
});

$('.pname').on('keyup', function(e){
	$('#projectname').text($('.pname').val());
});
function readURL(input) {

  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {

      $('#preview').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

$('.visibletoggle').on('click', function(e){
	var clickedid = event.target.id;
	var checkid = "."+ clickedid + "blank";

	if($(checkid).val() == 1){
		$('#' + clickedid).text(" Off ");
		$(checkid).val(0);
		$('.visibletoggle').css({
			'background-position' : 'right bottom'
		})
	}
	else{
		$('#' + clickedid).text(" On ");
		$(checkid).val(1);
		$('.visibletoggle').css({
			'background-position' : 'left bottom'
		});
	}

});

$(".visibletoggle").on('mouseover', function(e) {
	var clickedid = event.target.id;
	var checkid = "."+ clickedid + "blank";

	if($(checkid).val() == 1){	
  		$(".visibletoggle").css('background-position',' right bottom');
  	}else{
  		$(".visibletoggle").css('background-position',' left bottom');
  	}
});

$(".visibletoggle").on('mouseleave', function(e) {
	var clickedid = event.target.id;
	var checkid = "."+ clickedid + "blank";

	if($(checkid).val() == 1){	
  		$(".visibletoggle").css('background-position',' left bottom');
  	}else{
  		$(".visibletoggle").css('background-position',' right bottom');
  	}
});

$(".filepart").change(function() {
  readURL(this);
});
</script>
</html>
