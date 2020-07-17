<?php
include '../init.php';

$name = $argv[1];
echo "dumping $name\n";
$dump = DB::select("select * from $name");
file_put_contents("mysqldump/$name.json", json_encode($dump, JSON_PRETTY_PRINT));
?>