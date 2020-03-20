<?php

error_reporting(E_ALL); ini_set('display_errors', 1); 
include_once "classes/Project.php";
include_once "connect.php";

$keywords = @$_GET["searchname"];

$project = new Project($pdoconnect);
$stmt = $project->searchProject($keywords);

while($resultset = $stmt->fetch(PDO::FETCH_ASSOC)){

?>

	<a class="card" href="projectdetails.php?id=<?php echo  $resultset["pid"] ?>">
		<?php echo $resultset["pname"] ?> (pid: <?php echo $resultset["pid"]; ?>)
	</a>

<?php
}
?>

