<?php

include("connect.php");
include(@$_SERVER["DOCUMENT_ROOT"]."/focussight/classes/SQLiteOpener.php");
include(@$_SERVER["DOCUMENT_ROOT"]."/focussight/classes/Project.php");

$pid = @$_GET['pid'];
$password = @$_GET["password"];


$opener = new SQLiteOpener($password);


?>
