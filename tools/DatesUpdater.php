<?php
$GLOBALS["configName"] = "cleanenterprise";

include './init.php';

$columnIgnoreList = [
    "LockTS",
    "LoginDateTime",
    "EntryDate",
    "EntryTime",
    "SystemDate",
    "CreditCardExpDate",
    "CustomerBornDate",
    "HireDate",
    "Birthday",
    "LastSessionUpdateTime"
];
$tableIgnoreList = [
    "companies",
    "audittrail",
    "audittraishistory",
    "currencytypes",
    "currencytypeshistory",
    "errorlog",
    "ledgerchartofaccountsprioryears",
    "ledgerstoredchartofaccounts",
    "inventoryledger"
];

$minimalDateForIncrease = "1 January 1990";

function add_months($months, DateTime $dateObject) 
{
    $next = new DateTime($dateObject->format('Y-m-d'));
    $next->modify('last day of +'.$months.' month');

    if($dateObject->format('d') > $next->format('d')) {
        return $dateObject->diff($next);
    } else {
        return new DateInterval('P'.$months.'M');
    }
}

function endCycle($d1, $months)
{
    $date = new DateTime($d1);

    // call second function to add the months
    $newDate = $date->add(add_months($months, $date));

    // goes back 1 day from date, remove if you want same day of month
    $newDate->sub(new DateInterval('P1D')); 

    //formats final date to Y-m-d form
    $dateReturned = $newDate->format('Y-m-d h:m:s'); 

    return $dateReturned;
}

$tablesColumns = [];
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
        if($columnDesc->Type == "datetime" || $columnDesc->Type == "timestamp"){
            $columnDesc->tableName = $name;
            if(!in_array($columnDesc->Field, $columnIgnoreList))
                $fields[$columnDesc->Field] = $columnDesc;
            //            else
            //  echo "Ignoring column {$columnDesc->Field}\n";
            //$fields[] = $columnDesc;
        }
    }
}
    
//file_put_contents("fields.json", json_encode($fields, JSON_PRETTY_PRINT));
$queries = [];
foreach($tablesColumns as $name=>$desc){
    $columns = [];
    $keys = [];
    foreach($desc as $columnDesc){
        if(($columnDesc->Type == "datetime" || $columnDesc->Type == "timestamp") &&
           !in_array($columnDesc->Field, $columnIgnoreList))
            $columns[] = $columnDesc->Field;
        if($columnDesc->Key)
            $keys[$columnDesc->Field] = $columnDesc->Key;
    }
    if(count($columns)){
        $result = DB::select("select " . implode(",", array_merge($columns, array_keys($keys))) . " from $name");
        //        echo "update $name set";
        if(count($result)){
            echo "processing $name\n";
            foreach($result as $row){
                $whereString = [];
                foreach($keys as $keyColumn=>$keyType)
                    $whereString[] = "$keyColumn='{$row->$keyColumn}'";
                $whereString = implode(" AND ", $whereString);

                //foreach(
                $values = [];
                foreach($columns as $columnName)
                    if($row->$columnName && strtotime($row->$columnName) > strtotime($minimalDateForIncrease)){
                        $row->$columnName = endCycle($row->$columnName, 1);
                        $values[] = "$columnName='{$row->$columnName}'";
                    }
                if(count($values)){
                    $query = "update $name set " . implode(",", $values) . " WHERE $whereString";
                    echo ($queries[] = $query) . "\n";
                    DB::update($query);
                }
            }
        }else
            echo "table $name is empty\n";
    }

}

echo count($queries);
file_put_contents("queries.sql", implode("\n", $queries));
//echo count($tablesColumns);
//echo count($fields);
//echo json_encode($fields, JSON_PRETTY_PRINT);
?>