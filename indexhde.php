<?php

include dirname(__FILE__ ) . '/focussight-config.php';
include FOCUSSIGHT_ROOT_PATH . '/classes/connect.php';
include FOCUSSIGHT_ROOT_PATH . '/focussight-functions.php';

$header = array(
    'opt_in_script' => array(
        '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js',
    ),
    'opt_in_css' => array(
        '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css',
        '//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.min.css'
    )

);

getHeader($header);

?>
<div class="site-wrapper">
    <div class="frontend-hero" style="background-color: #ffb266">
        <div class="embed-responsive embed-responsive-16by9" aria-labelledby="Find your members remotely.">
            <div class="embed-responsive-item" style="background-image: url('<?php echo BASE_URL . '/image/focussight-hero.jpg' ?>'); background-position:  center center; background-size: cover; background-repeat:  no-repeat">
                <div class="h-100 d-flex flex-column justify-content-center container">
                    <h2 class="text-light">Find your members, remotely.</h2>
                    <a href="<?php echo BASE_URL . '/how-it-works.php'?>" class="btn btn-outline-light text-left"
                       style="max-width: 15rem">How does it work ?</a>
                </div>
            </div>
        </div>
    </div>
    <section class="py-3" style="background-color: #ffb266">
        <div class="container">
            <h2 class="h2 text-center text-light">Interested in these projects? </h2>
            <div class="card-template">
                <div class="round-card d-flex align-items-center justify-content-center w-100 bg-light" style="min-height: 150px;">
                    Loading...
                </div>
            </div>
        </div>

    </section>
</div>


<script>
    $('.frontend-hero').slick({
        autoplay: true,
        autoplaySpeed: 2000,
    });
</script>