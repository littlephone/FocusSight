<?php
ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL);

include_once dirname(__FILE__) . '/focussight-config.php';
include_once FOCUSSIGHT_ROOT_PATH . '/focussight-functions.php';

load_view('conference-room/conference-room-client.php');