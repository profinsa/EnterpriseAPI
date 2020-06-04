<?php
include './init.php';

//mssql test
/*        
        "COLUMN_NAME": "LockTS",
        "TYPE_NAME": "datetime",
        "PRECISION": 23,
        "LENGTH": 16,
        "NULLABLE": 1,
        "REMARKS": null,
        "COLUMN_DEF": null,
        "IS_NULLABLE": "YES",
        "SS_DATA_TYPE": 111
    }
]
ix@calculate ~/dev/work/databoom/EnterpriseX $ php dbtest.php 
[
    {
        "Field": "CompanyID",
        "Type": "varchar(36)",
        "Null": "NO",
        "Key": "PRI",
        "Default": null,
        "Extra": ""
        },*/

//echo json_encode(DB::select("exec sp_columns payrollemployees", array()), JSON_PRETTY_PRINT);
//echo json_encode(DB::select("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'PayrollEmployees'", array()), JSON_PRETTY_PRINT);
$results = DB::select("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'PayrollEmployees'", array());
$columns = [];
foreach($results as $column)
    $columns[] = [
        "Field" => $column->COLUMN_NAME,
        "Type" => $column->DATATYPE,
        "Null" => $column->IS_NULLABLE,
        "Default" => $column->COLUMN_DEFAULT
    ];
echo json_encode($columns, JSON_PRETTY_PRINT);
// TABLE_SCHEMA = @SchemaName  AND

//mysql test
//echo json_encode(DB::select("describe payrollemployees", array()), JSON_PRETTY_PRINT);
//echo json_encode(DB::select("SELECT * from payrollemployees", array()));
?>

