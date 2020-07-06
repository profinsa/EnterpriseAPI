<?php
/*
 Dumping tables descriptions and data types to json files for MS SQL server database
 */
include './init.php';

file_put_contents("database/sqlsrv/tablesDescription.json", json_encode(DB::getTables(), JSON_PRETTY_PRINT));
$tablesDescription = json_decode(file_get_contents("database/sqlsrv/tablesDescription.json"));
$types = [];
foreach($tablesDescription as $name=>$desc){
    foreach($desc as $fieldDesc)
        if(!in_array($fieldDesc->Type, $types))
            $types[] = $fieldDesc->Type;
}
file_put_contents("database/sqlsrv/types.json", json_encode($types, JSON_PRETTY_PRINT));
?>

