<?php
$GLOBALS["configName"] = "common_sqlsrv";

include '../init.php';

$mysqldump = opendir("mysqldump");
$tables = [];
while (false !== ($entry = readdir($mysqldump))) {
    if($entry != ".." && $entry != "."){
        $name = preg_replace('/\.json/', "", $entry);
        //     $tables[$entry
        $tables[] = $name;
    }
}
closedir($mysqldump);

//echo json_encode($tables, JSON_PRETTY_PRINT);
$queriesCounter = 0;
foreach($tables as $name)
    system("php fromJsonToSQLSrv/worker.php $name");

echo "Queries: $queriesCounter\n";
?>
