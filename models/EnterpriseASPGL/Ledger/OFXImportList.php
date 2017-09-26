<?php
/*
  Name of Page: OFXImport model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: Nikita Zaharov, 09.26.2017

  Use: this model used by gridView for:
  - as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods has own parameters

  Output parameters:
  - dictionaries as public properties
  - methods has own output

  Called from:
  created and used for ajax requests by Grid controller
  used as model by gridView

  Calls:
  sql

  Last Modified: 09.26.2017
  Last Modified by: Nikita Zaharov
*/

require __DIR__ . "/../../gridDataSource.php";
use \OfxParser\Parser as ofxparser;

class gridData extends gridDataSource{
    public $dashboardTitle ="OFX & QFX Importing";
    public $breadCrumbTitle ="OFX & QFX Importing";
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionTypeID" => "Type"
    ];

    public function uploadOFX(){
        $user = Session::get("user");
        $ofxParser = new ofxparser();
        $ofxpath = __DIR__ .  "/../../../uploads/uploaded.ofx";

        if (move_uploaded_file($_FILES['ofx']['tmp_name'], $ofxpath)) {
            $ofx = $ofxParser->loadFromFile($ofxpath);

            $accounts = [];
            $transactions = [];
            $transactionTypes = [];
            foreach($ofx->bankAccounts as $bankAccount){
                //            echo json_encode($startDate = $bankAccount->statement->startDate);
                // echo json_encode($endDate = $bankAccount->statement->endDate);

                // Get the statement transactions for the account
                $accounts[] = [
                    "number" => $bankAccount->accountNumber,
                    "type" => $bankAccount->accountType
                ];
                foreach($bankAccount->statement->transactions as $transaction){
                    $currentTransaction = $transactions[] = [
                        "TransactionType" => $transaction->type,
                        "TransactionDate" => $transaction->date,
                        "TransactionAmount" => $transaction->amount,
                        "Notes" => $transaction->name,
                        "BankDocumentNumber" => $transaction->uniqueId                        
                    ];
                    if(!in_array($transaction->type, $transactionTypes))
                        $transansationTypes[] = $transaction->type;

                    $insert_fields = "";
                    $insert_values = "";
                    $alreadyUsed = [];
                    $ret = [];
                    foreach($currentTransaction as $name=>$value){
                        if($name == "TransactionDate")
                            $value = date_format($value, "Y-m-d H:i:s");

                        if($insert_fields == ""){
                            $insert_fields = $name;
                            $insert_values = "'$value'";
                        }else{
                            $insert_fields .= "," . $name;
                            $insert_values .= ",'$value'";
                        }
                    }

                    $insert_fields .= ", CompanyID, DivisionID, DepartmentID, BankTransactionID";
                    $this->tableName = "banktransactions";
                    $bankTransactionID = $this->dirtyAutoincrementColumn("banktransactions", "BankTransactionID");
                    $insert_values .= ", '{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '$bankTransactionID'";
                    if(!count(DB::select("select BankTransactionID from banktransactions WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND BankTransactionID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $bankTransactionID))))
                        //echo "INSERT INTO banktransactions(" . $insert_fields . ") values(" . $insert_values .")\n";
                    $result = DB::insert("INSERT INTO banktransactions(" . $insert_fields . ") values(" . $insert_values .")");
                }
            }
            
            //            echo json_encode($accounts, JSON_PRETTY_PRINT);
            //echo json_encode($transactions, JSON_PRETTY_PRINT);
            //echo json_encode($transactionTypes, JSON_PRETTY_PRINT);
        } else {
            echo "file uploading attack!\n";
        }

        echo "ok";
    }
    
    public function Memorize(){
        $user = Session::get("user");
        $keyValues = explode("__", $_POST["id"]);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        DB::update("UPDATE " . $this->tableName . " set Memorize='" . ($_POST["Memorize"] == '1' ? '0' : '1') . "' WHERE ". $keyFields);
        echo "ok";
    }
}
?>
