<?php
    // for snoopy client
    @define('HTTP_USER_AGENT', 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0', true);
    @define('HTTP_TIME_OUT', 30, true);         // seconds
    @define('HTTP_USE_GZIP', true, true);
    $httpIP = null;                             // Use all IPs (set to a string for specific IP)

    @define('RPC_TIME_OUT', 5, true);           // seconds

    @define('LOG_RPC_CALLS', false, true);
    @define('LOG_RPC_FAULTS', true, true);

    // for php
    @define('PHP_USE_GZIP', false, true);
    @define('PHP_GZIP_LEVEL', 2, true);

    $schedule_rand = 10;                        // rand for schedulers start, +0..X seconds

    $do_diagnostic = true;
    $log_file = '/tmp/errors.log';              // path to log file (comment or leave blank to disable logging)

    $saveUploadedTorrents = true;               // Save uploaded torrents to profile/torrents directory or not
    $overwriteUploadedTorrents = false;         // Overwrite existing uploaded torrents in profile/torrents directory or make unique name

    $topDirectory = '/downloads/';              // Upper available directory. Absolute path with trail slash.
    $forbidUserSettings = false;

    $scgi_port = 5000;
    $scgi_host = "127.0.0.1";

    $XMLRPCMountPoint = "/RPC2";

    $pathToExternals = array(
        "php"   => '/usr/bin/php',
        "curl"  => '/usr/bin/curl',
        "gzip"  => '/bin/gzip',
        "id"    => '/usr/bin/id',
        "stat"  => '/usr/bin/stat',
    );

    $localhosts = array(
        "127.0.0.1",
        "localhost",
    );

    $profilePath = '../share';                  // Path to user profiles
    $profileMask = 0777;                        // Mask for files and directory creation in user profiles.
                                                // Both Webserver and rtorrent users must have read-write access to it.
                                                // For example, if Webserver and rtorrent users are in the same group then the value may be 0770.

    $tempDirectory = null;                      // Temp directory. Absolute path with trail slash. If null, then autodetect will be used.

    $canUseXSendFile = false;                   // If true then use X-Sendfile feature if it exist

    $locale = "UTF8";
