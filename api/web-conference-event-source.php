<?php
session_start();
if (!ctype_alnum(session_id()) || !preg_match('/^(?:[a-z0-9_-]|\.(?!\.))+$/iD', session_id())) {
    die();
}

if (count($_POST)!=0) {
    // simulated onmessage by ajax post
    // Note that browsers that connect with the same
    // session (tabs in the same browser at the same computer)
    // will clash. This does never happen in practice, although when testing
    // on one computer, you have to use two different browsers, in order to
    // get a different result from session_id().
    $filename = '_file_' /* .$room */ .session_id();

    $posted = file_get_contents('php://input');

    // A main lock on conference-room-client.php, because otherwise we can not delete the
    // file after reading its content (further down)
    $mainlock = fopen('conference-room-client.php','r');
    flock($mainlock,LOCK_EX);

    // Add the new message to file
    $file = fopen($filename,'ab');
    if (filesize($filename)!=0) {
        fwrite($file,'_MULTIPLEVENTS_');
    }
    fwrite($file,$posted);
    fclose($file);

    // Unlock main lock
    flock($mainlock,LOCK_UN);
    fclose($mainlock);


} else { // regular eventSource poll which is loaded every few seconds
    header('Content-Type: text/event-stream');
    header('Cache-Control: no-cache'); // recommended

    function startsWith($haystack, $needle) {
        return (substr($haystack, 0, strlen($needle) ) === $needle);
    }

    // Get a list of all files in the folder
    $all = array ();
    $handle = opendir ( '../'.basename ( dirname ( __FILE__ ) ) );
    if ($handle !== false) {
        while ( false !== ($filename = readdir ( $handle )) ) {
            if (startsWith($filename,'_file_' /* .$room */)
                && !(startsWith($filename,'_file_' /*.$room*/ .session_id()))) {
                $all [] .= $filename;
            }
        }
        closedir( $handle );
    }

    // A main lock on this file, because otherwise we can not delete the
    // file after reading its content.
    $mainlock = fopen('web-conference-event-source.php','r');
    flock($mainlock,LOCK_EX);

    // show and empty the first one that is not empty
    for($x = 0; $x < count ( $all ); $x++) {
        $filename=$all[$x];

        // prevent sending empty files
        if (filesize($filename)==0) {
            unlink($filename);
            continue;
        }

        $file = fopen($filename, 'c+b');
        flock($file, LOCK_SH);
        echo 'data: ', fread($file, filesize($filename)),PHP_EOL;
        fclose($file);
        unlink($filename);
        break;
    }

    // Unlock main lock
    flock($mainlock,LOCK_UN);
    fclose($mainlock);

    echo 'retry: 1000',PHP_EOL,PHP_EOL; // shorten the 3 seconds to 1 sec

}