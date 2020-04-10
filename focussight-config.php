<?php

defined('FOCUSSIGHT_PATH') || define('FOCUSSIGHT_PATH', dirname($_SERVER['SCRIPT_FILENAME']));
defined('FOCUSSIGHT_ROOT_PATH') || define('FOCUSSIGHT_ROOT_PATH', dirname(__FILE__));
defined('DIR') || define('DIR', dirname(__DIR__));
defined('API_PATH') || define('API_PATH', FOCUSSIGHT_ROOT_PATH . '/api');
defined('BASE_URL') || define('BASE_URL', str_replace($_SERVER['DOCUMENT_ROOT'], '', FOCUSSIGHT_PATH));
defined('BASE_ROOT_URL') || define('BASE_ROOT_URL', str_replace(DIR, '', FOCUSSIGHT_ROOT_PATH));
defined('BASE_ROOT_API_URL') || define('BASE_ROOT_API_URL', BASE_ROOT_URL . '/api');


defined('LANGUAGE') || define('LANGUAGE', 'en');
defined('DATABASE') || define('DATABASE', 'focussight');
defined('DB_SERVER') || define('DB_SERVER',  '127.0.0.1');
defined('DB_USERNAME') || define('DB_USERNAME',  'playground');
defined('DB_PASSWORD') || define('DB_PASSWORD',  'plyg2043');


