<?php
$GLOBALS["configName"] = "common_sqlsrv";
include '../init.php';

$name = $argv[1];
echo "loading $name \n";

$records = json_decode(file_get_contents("mysqldump/$name.json"));
$desc = DB::describe($name);
//echo json_encode($desc, JSON_PRETTY_PRINT);
$descColumns = [];
foreach($desc as $column)
    $descColumns[] = $column->Field;
    
foreach($records as $record){
    $columns = [];
    $values = [];
    foreach($record as $column=>$value){
        if(in_array($column, $descColumns)){
            $columns[] = $column;
            $values[] = DB::quote($value);
        }
    }

    if(count($columns)){
        $query = "INSERT INTO $name (" . implode(",", $columns) . ") values(" . implode(",", $values) . ")";
        try{
            DB::statement("SET IDENTITY_INSERT $name ON");
        }catch(Exception $e){
            file_put_contents("fromJsonToSQLSrv/identity_error.log", $e->getMessage() . "\n", FILE_APPEND);            
        }
        try{
            DB::insert($query);
            echo $query . "\n";
        }catch(Exception $e){
            file_put_contents("fromJsonToSQLSrv/error.log", $e->getMessage() . "\n", FILE_APPEND);
            echo $e->getMessage();
        }
    }else
        echo "skipping $name";
    //        DB::insert($query);
    break;
}
?>