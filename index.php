<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://unpkg.com/swiper@4.3.5/dist/css/swiper.min.css">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@4.1.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/header.css">
    <script src="https://unpkg.com/swiper@4.3.5/dist/js/swiper.min.js"></script>
    <title>Document</title>
</head>
<style>
    .swiper-slide{
        min-height: 500px;
    }
</style>
<body>
<div class="swiper-container container px-0">
    <!-- Additional required wrapper -->
    <div class="swiper-wrapper">
        <!-- Slides -->
        <div class="swiper-slide d-flex flex-column justify-content-center align-items-center"
            style="background: linear-gradient(90deg, rgba(255,169,0,1) 0%, rgba(148,97,74,1) 21%, rgba(75,49,124,1) 70%);">
            <h1 class="text-light py-5">FocusSight</h1>
            <div class="text-light">Introducing FocusSight, an entrance for all dreams and remote collabs.</div>
        </div>
        <div class="swiper-slide">Slide 2</div>
        <div class="swiper-slide">Slide 3</div>
    </div>
    <div class="swiper-pagination"></div>

    <!-- If we need navigation buttons -->
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>

</div>
</body>

<script>
    var mySwiper = new Swiper ('.swiper-container', {
        // Optional parameters
        loop: true,

        // If we need pagination
        pagination: {
            el: '.swiper-pagination',
        },

        // Navigation arrows
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    })
</script>
</html>