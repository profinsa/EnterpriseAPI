<?php
$GLOBALS["configName"] = "Admin";
$GLOBALS["DBDONTCACHE"] = true;

include './init.php';

$dbuser = "root";
$dbpass = "32167";

$mysqlcmd = substr(php_uname(), 0, 7) == "Windows" ? "\"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql.exe\" \"--defaults-file=C:\Program Files\MySQL\MySQL Server 5.5\my.ini\" \"-u$dbuser\" \"-p$dbpass\"" : "mysql -u $dbuser -p$dbpass";


function generateRandomString($length = 10) {
    return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
}

function execInBackground($cmd) {
    if (substr(php_uname(), 0, 7) == "Windows"){
        pclose(popen("start /B ". $cmd, "r")); 
    }
    else {
        exec($cmd . " > /dev/null &");  
    }
}

while(1){
    sleep(2);
    $installations = DB::SELECT("SELECT * FROM appinstallations WHERE Clean=1");
    if(count($installations) < 3){
        $dbname = "db" . generateRandomString(20);
    
        $cmd1 = "echo \"CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON $dbname.* to 'enterprise'@'localhost'\" | $mysqlcmd";
        system($cmd1, $retval);
        //$cmd2 = "$mysqlcmd $dbname < ../database/updates/update_2019_08_30.sql";
        $cmd2 = "$mysqlcmd $dbname < ../database/backups/cleanenterprise.sql";
        execInBackground($cmd2);
        DB::INSERT("INSERT INTO appinstallations (CustomerID, ConfigName, InstallationName, InstallationDate, ExpirationDate, Active, Clean) values('DEFAULT', ?, ?, now(), now(), 0, 1)", [$dbname, $dbname]);
    }
}
?>