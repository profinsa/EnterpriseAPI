<?php
$GLOBALS["configName"] = "common_sqlsrv";

include '../init.php';

$tables = json_decode(file_get_contents("../database/sqlsrv/tablesDescription.json"));

$dump = [];
foreach($tables as $name=>$columns){
    echo "processing table: $name";
    $dump[$name] = DB::select("select TOP(1) * from $name");
    //    foreach($columns as $desc)
    //  if(!in_array($desc->Type, $types))
    //      $types[] = $desc->Type;
}

echo json_encode($dump, JSON_PRETTY_PRINT);
?>

