<?php
include './init.php';

$dbname = "cloud1";
$dbuser = "root";
$dbpass = "32167";

function execInBackground($cmd) {
    if (substr(php_uname(), 0, 7) == "Windows"){
        pclose(popen("start /B ". $cmd, "r")); 
    }
    else {
        exec($cmd . " > /dev/null &");  
    }
}

$cmd1 = "echo \"CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* to 'enterprise'@'localhost'\" | mysql -u $dbuser -p$dbpass";
system($cmd1, $retval);
$cmd2 = "mysql -u $dbuser -p$dbpass $dbname < ../database/backups/cleanenterprise.sql";
execInBackground($cmd2);
?>