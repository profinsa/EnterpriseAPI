<?php
include './init.php';


class wrapper{
    public $tableName;
    public function dirtyAutoincrementColumn($tableName, $columnName, $CompanyID, $DivisionID, $DepartmentID){
        $forDirtyAutoincrement = [
            "orderheader" => [
                //"columns" => "OrderNumber",
                "tables" => ["orderheader", "orderheaderhistory"]
            ],
            "workorderheader" => [
                //"columns" => "OrderNumber",
                "tables" => ["workorderheader", "workorderheaderhistory"]
            ],
            "orderheaderhistory" => [
                //"columns" => "OrderNumber",
                "tables" => ["orderheader", "orderheaderhistory"]
            ],
            "invoiceheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["invoiceheader", "invoiceheaderhistory"]
            ],
            "invoiceheaderhistory" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["invoiceheader", "invoiceheaderhistory"]
            ],
            "receiptsheader" => [
                //"columns" => "ReceipID",
                "tables" => ["receiptsheader", "receiptsheaderhistory"]
            ],
            "purchaseheader" => [
                "tables" => ["purchaseheader", "purchaseheaderhistory"]
            ],
            "purchasecontractheader" => [
                "tables" => ["purchasecontractheader", "purchasecontractheaderhistory"]
            ],
            "paymentsheader" => [
                "tables" => ["paymentsheader", "paymentsheaderhistory"]
            ],
            "ledgertransactions" => [
                "tables" => ["ledgertransactions", "ledgertransactionshistory"]
            ],
            "banktransactions" => [
                "tables" => ["banktransactions"]
            ],
            "ediinvoiceheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["ediinvoiceheader"]
            ],
            "ediorderheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["ediorderheader"]
            ],
            "edipurchaseheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edipurchaseheader"]
            ],
            "edireceiptsheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edireceiptsheader"]
            ],
            "edipaymentsheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edipaymentsheader"]
            ],
        ];

        $tablesForGetNextEntity = [
            "orderheader" => "NextOrderNumber",
            "workorderheader" => "NextWorkOrderNumber",
            "orderheaderhistory" => "NextOrderNumber",
            "invoiceheader" => "NextInvoiceNumber",
            "invoiceheaderhistory" => "NextInvoiceNumber",
            "receiptsheader" => "NextReceiptNumber",
            "purchaseheader" => "NextPurchaseOrderNumber",
            //    "purchasecontractheader" => [ FIXME for now i don't know where take values for commented tables, will using dirtyautoincrement for them
            "paymentsheader" => "NextVoucherNumber",
            "ledgertransactions" => "NextGLTransNumber",
            "banktransactions" => "NextBankTransactionNumber",
            //    "ediinvoiceheader" => [
            //"ediorderheader" => [
            //"edipurchaseheader" => [
            //"edireceiptsheader" => [
            //      "edipaymentsheader" => [
        ];

        $columnMax = 0;
        if(key_exists($this->tableName, $tablesForGetNextEntity)){
            DB::statement("CALL GetNextEntityID2(?, ?, ?, ?, @nextNumber, @ret)", [
            $CompanyID, $DivisionID, $DepartmentID, $tablesForGetNextEntity[$this->tableName]]);
            $columnMax = DB::select("select @nextNumber as nextNumber, @ret")[0]->nextNumber;
        }else{
            if(key_exists($this->tableName, $forDirtyAutoincrement)){
                foreach($forDirtyAutoincrement[$this->tableName]["tables"] as $tableName){
                    //$columnName = $forDirtyAutoincrement[$this->tableName]["column"];
                    $res = DB::select("select $columnName from $tableName");
                    foreach($res as $row)
                        if(is_numeric($row->$columnName) && $row->$columnName > $columnMax)
                            $columnMax = $row->$columnName;
                }
            }
            ++$columnMax;
        }

        return $columnMax;
    }

}

$wrap = new wrapper();
$wrap->tableName = "orderheader";

$tables = [
    "orderheader" => "OrderNumber",
    "workorderheader" => "WorkOrderNumber",
    "orderheaderhistory" => "OrderNumber",
    "invoiceheader" => "InvoiceNumber",
    "invoiceheaderhistory" => "InvoiceNumber",
    "receiptsheader" => "ReceiptID",
    "purchaseheader" => "PurchaseNumber",
    "purchasecontractheader" => "PurchaseContractNumber",
    "paymentsheader" => "PaymentID",
    "ledgertransactions" => "GLTransactionNumber",
    "banktransactions" => "BankTransactionID",
    "ediinvoiceheader" => "InvoiceNumber",
    "ediorderheader" => "OrderNumber",
    "edipurchaseheader" => "PurchaseNumber",
    "edireceiptsheader" => "ReceiptID",
    "edipaymentsheader" => "PaymentID"
];

//listing currecnt common next entity number
/*foreach($tables as $tableName=>$column){
    $wrap->tableName = $tableName;
    echo "$tableName " . $wrap->dirtyAutoincrementColumn($tableName, $column, 'DINOS', 'DEFAULT', 'DEFAULT') . " \n";
    }*/

$departments = DB::select("select CompanyID, DivisionID, DepartmentID from departments");
//print_r($departments);

//deleting all records which have id higher then getted by getnextentity
foreach($departments as $department){
    echo "$department->CompanyID // $department->DivisionID // $department->DepartmentID \n";
    foreach($tables as $tableName=>$column){
        $wrap->tableName = $tableName;
        $value = $wrap->dirtyAutoincrementColumn($tableName, $column, $department->CompanyID, $department->DivisionID, $department->DepartmentID);
        DB::delete("delete from $tableName where CompanyID='$department->CompanyID' and DivisionID='$department->DivisionID' and DepartmentID='$department->DepartmentID' and $column>'$value'");
    }  
}

?>