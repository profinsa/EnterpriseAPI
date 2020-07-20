<?php
include '../init.php';


$tables = DB::getTables();
$types = [
    "varchar(36)" => "string",
    "varchar(120)" => "string",
    "mediumtext" => "string",
    "varchar(50)" => "string",
    "varchar(255)" => "string",
    "varchar(80)" => "string",
    "varchar(30)" => "string",
    "varchar(10)" => "string",
    "varchar(20)" => "string",
    "varchar(3)" => "string",
    "varchar(60)" => "string",
    "varchar(15)" => "string",
    "varchar(250)" => "string",
    "varchar(64)" => "string",
    "varchar(128)" => "string",
    "varchar(256)" => "string",
    "varchar(1)" => "string",
    "char(10)" => "string",
    "varchar(999)" => "string",
    "varchar(12)" => "string",
    "varchar(5)" => "string",
    "char(1)" => "string",
    "varchar(100)" => "string",
    "varchar(200)" => "string",
    "varchar(2)" => "string",
    "text" => "string",
    "varchar(40)" => "string",
    "varchar(4)" => "string",
    "varchar(26)" => "string",
    "char(36)" => "string",
    "varchar(500)" => "string",
    "varchar(11)" => "string",
    "longtext" => "string",
    "char(30)" => "string",

    "timestamp" => "string",
    "datetime" => "string",

    "tinyint unsigned" => "int",
    "tinyint(1)" => "int",
    "smallint" => "int",
    "bigint" => "int",
    "int" => "int",
    
    "decimal(18,0)" => "float",
    "decimal(24,0)" => "float",
    "float" => "float",
    "decimal(19,4)" => "float",
    "double" => "float",
];

foreach($tables as $name=>$columns)
    echo system("php fromMysqlToJson/worker.php $name");

?>

