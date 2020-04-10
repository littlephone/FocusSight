<?php
include_once dirname(__FILE__) . '/../focussight-config.php';
session_start();

if(isset($_SESSION['username'])){

}
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Labstry FocusSight</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@4.4.1/dist/css/bootstrap.min.css"/>

    <?php if(!empty($opt_in_css)){
        foreach($opt_in_css as $link){ ?>
            <link rel="stylesheet" href="<?=$link ?>">
        <?php }
    } ?>
    <link rel="stylesheet" href="<?php echo BASE_ROOT_URL . '/css/header.css'?>"/>
    <link rel="stylesheet" href="<?php echo BASE_ROOT_URL . '/css/main.css'?>"/>

    <script src="https://unpkg.com/jquery@3.4.1/dist/jquery.min.js"></script>
    <script src="https://unpkg.com/bootstrap@4.4.1/dist/js/bootstrap.min.js"></script>

    <?php if(!empty($opt_in_script)){
        foreach($opt_in_script as $script){ ?>
            <script src="<?= $script;  ?>"></script>
    <?php }
    } ?>

</head>
<body>
<main>
    <nav>
        <section class="hamburger-header py-2">
            <a href="#nav" data-toggle="collapse" class="d-inline-block btn header-dropdown-btn align-middle"
               role="button" aria-expanded="false" aria-controls="menu-collapse">
                <div class="burger-icon">
                    <span class="icon-dash icon-dash-1"></span>
                    <span class="icon-dash icon-dash-2"></span>
                </div>
            </a>
            <h1 class="h5 d-inline-block mb-0 align-middle color-so-focus-orange">FocusSight</h1>
        </section>
        <div class="toggle collapse position-absolute w-100" id="nav" style="z-index: 100">
            <div class="bg-so-focus-orange row">
                <div class="link-row w-100">
                    <a class="text-light px-5 py-3 d-inline-block project-link col-12 col-md-6 col-lg-3" href="/forum/index.php">Labstry Forum</a>
                    <a class="text-light px-5 py-3 d-inline-block project-link col-12 col-md-6 col-lg-3" href="">My Projects</a>
                    <a class="text-light px-5 py-3 d-inline-block project-link col-12 col-md-6 col-lg-3" href="">Logout</a>
                </div>

            </div>
        </div>

    </nav>
</main>


<script>
    $('#nav').on('hidden.bs.collapse', function(e){
        $('.burger-icon').removeClass('burger-icon-active');
    });
    $('#nav').on('hide.bs.collapse', function(e){
        $('.link-row').removeClass('active');
    });

    $('#nav').on('shown.bs.collapse', function(e){
        $('.burger-icon').addClass('burger-icon-active');
        $('.link-row').addClass('active');
    })

</script>