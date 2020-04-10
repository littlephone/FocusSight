<?php

/*
	file: myproject.php
	date: 2019/5/14
	author: Chow Raynold
*/
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();
require @$_SERVER['DOCUMENT_ROOT'].'/focussight/connect.php';
require @$_SERVER['DOCUMENT_ROOT'].'/focussight/classes/Project.php';


if(!@$_SESSION['id'])
	header("Location: /login.php");

$userid = @$_SESSION['id'];
//Let's party
$project = new Project($pdoconnect);
$myprojectlist = $project->getUserProject($userid);

?>

<html>
<Title>All projects - Labstry FocusSight</Title>
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
<link rel="stylesheet" href="module/general.css"/>
<link rel="stylesheet" type="text/css" href="/module/dynamicmenu.css"/>

<body>
<?php include @$_SERVER['DOCUMENT_ROOT']."/focussight/module/header.php"; ?>

<a href="createproject.php">I would like to create a project and recruit members</a>

<div style="font-size: 15px">All Projects</div>


<?php 
foreach ($myprojectlist as $projectid){
	$project->getProjectByPid($projectid);

?>

<?php
	echo $project->pname."<br/>";
}
?>
</body>

</html>