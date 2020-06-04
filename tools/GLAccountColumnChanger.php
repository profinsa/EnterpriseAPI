<?php
//$GLOBALS["configName"] = "Admin";
$GLOBALS["DBDONTCACHE"] = true;
$dbname = "stfbenterprise";
$dbuser = "root";
//$dbpass = "32167";
$dbpass = "mysqlroot";

include './init.php';

$columnIgnoreList = [];

$tableIgnoreList = [
   // "companies",
    "audittrail",
    "audittraishistory",
    "currencytypes",
    "currencytypeshistory",
    "errorlog",
    "ledgerchartofaccountsprioryears",
   // "ledgerstoredchartofaccounts",
    "inventoryledger"
];

$tablesColumns = [];
//echo json_encode($tables, JSON_PRETTY_PRINT);

foreach($tables as $tableName){
    $desc = DB::select("describe $tableName", array());
    $keys = 0;
    foreach($desc as $column)
        if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
            $keys++;
    if($keys == 3 && !in_array($tableName, $tableIgnoreList))
        $tablesColumns[$tableName] = $desc;
    else
        echo "Ignoring table $tableName\n";
}

$fields = [];
//echo json_encode($tablesColumns["orderheader"], JSON_PRETTY_PRINT);

foreach($tablesColumns as $name=>$desc){
    foreach($desc as $columnDesc){
        if(preg_match('/GL.*Account[$\d]*/', $columnDesc->Field) && preg_match('/varchar/', $columnDesc->Type)){
            $columnDesc->tableName = $name;
            if(!in_array($columnDesc->Field, $columnIgnoreList))
                $fields[$name . '@' . $columnDesc->Field] = $columnDesc;
            // else
            //  echo "Ignoring column {$columnDesc->Field}\n";
            //$fields[] = $columnDesc;
        }
    }
}

file_put_contents("fields.json", json_encode($fields, JSON_PRETTY_PRINT));

$sqlQueries = [];
foreach($fields as $name=>$desc){
    $sqlQueries[] = "SET SQL_MODE='ALLOW_INVALID_DATES'; alter table {$desc->tableName} MODIFY COLUMN {$desc->Field} NVARCHAR(255);";
    //$sqlQueries[] = "alter table {$desc->tableName} MODIFY COLUMN {$desc->Field} NVARCHAR(255);";
}

//echo $sqlQueries;

foreach($sqlQueries as $query){
    $mysqlcmd = substr(php_uname(), 0, 7) == "Windows" ? "\"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql.exe\" \"--defaults-file=C:\Program Files\MySQL\MySQL Server 5.5\my.ini\" -u$dbuser -p$dbpass" : "mysql -u $dbuser -p$dbpass";
    $mysqlcmd1 = substr(php_uname(), 0, 7) == "Windows" ? "\"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql.exe --defaults-file=C:\Program Files\MySQL\MySQL Server 5.5\my.ini -u$dbuser -p$dbpass" : "\"mysql -u $dbuser -p$dbpass";

    $cmd1 = substr(php_uname(), 0, 7) == "Windows" ? "echo $query | $mysqlcmd $dbname -f" : "echo \"$query\" | $mysqlcmd $dbname -f";
    echo $cmd1 . "\n";
    exec($cmd1, $retval);
}
?>