<?php

function load_view($view_dir, $data = array()){
    extract($data);
    include FOCUSSIGHT_ROOT_PATH . '/views/' . $view_dir;
}

function load_module($name, $data = array()){

}

function getHeader($var_arrays = array()){
    extract($var_arrays);
    include FOCUSSIGHT_ROOT_PATH . '/module/header.php';
}

