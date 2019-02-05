<?php
/*
  Name of Page: Positivr Pay model

  Method: Model for Positivr Pay form. It provides data from database and default values, column names and categories

  Date created: 09/14/2017 Tetarenko Eugene

  Use: this model used by views/gridView for
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by grid controllers
  used as model by views

  Calls:
  MySql Database

  Last Modified: 01/29/2019
  Last Modified by: Nikita Zaharov
*/


require __DIR__ . "/../../gridDataSource.php";

class gridData extends gridDataSource{
    public $dashboardTitle ="Positive Pay";
    public $breadCrumbTitle ="Positive Pay";
    public $tableName = "";
    public $gridConditions = "";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $onlyEdit = true;
    public $gridFields = [
    ];

    public $editCategories = [
        "Main" => [
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getBankAccounts",
                "defaultValue" => ""
            ],
            "StartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "EndDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
        ]
    ];
    public $columnNames = [
        "GLBankAccount" => "Bank Account",
        "StartDate" => "Start Date",
        "EndDate" => "End Date"
    ];

    public function getBankAccounts() {
        $user = Session::get("user");
        $ret = [];

        $result = DB::select("SELECT * from bankaccounts WHERE GLBankAccount Is NOT NULL AND LENGTH(LTRIM(RTrim(BankAccounts.GLBankAccount))) > 0 AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $ret[$value->GLBankAccount] = [
                "title" =>  $value->GLBankAccount . " - " . $value->BankName,
                "value" => $value->GLBankAccount
            ];

        return $ret;
    }

    public function getPositivePayTable() {
        $user = Session::get("user");

        $GLBankAccount = $_POST["GLBankAccount"];
        $StartDate = $_POST["StartDate"];
        $EndDate = $_POST["EndDate"];
        
        $BankAccountNumber = DB::select("SELECT BankAccountNumber from bankaccounts WHERE GLBankAccount='" . $GLBankAccount . "'  AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        // paymentsheader.CheckDate > '" . date("Y-m-d H:i:s", $StartDate) . "' AND paymentsheader.CheckDate < '" . date("Y-m-d H:i:s", $EndDate) . "'
        $result = DB::select("
        SELECT paymentchecks.CheckNumber, paymentsheader.CheckDate, paymentchecks.Amount
        FROM paymentchecks
        LEFT JOIN paymentsheader
        ON paymentsheader.PaymentID=paymentchecks.PaymentID
        WHERE paymentchecks.GLBankAccount='" . $GLBankAccount . "' AND paymentchecks.CompanyID='" . $user["CompanyID"] . "'
        ORDER BY paymentchecks.CheckNumber;");

        $fileContent = "";
        $columns = [
            "Bank Account Number",
            "Check Number",
            "Check Date",
            "Amount"
        ];

        $fileContent = implode(",", $columns) . "\n";

        foreach($result as $row){
            if ((strtotime($row->CheckDate) >= strtotime($StartDate)) && (strtotime($row->CheckDate) <= strtotime($EndDate))) {
                $amount = $row->Amount;
                if (preg_match('/([-+\d]+)\.(\d+)/', $row->Amount, $numberParts)) {
                    $amount = preg_replace('/\B(?=(\d{3})+(?!\d))/', '', $numberParts[1]) . '.' . substr($numberParts[2], 0, 2);
                }

                $fileContent .= $BankAccountNumber[0]->BankAccountNumber . "," . $row->CheckNumber . "," . date("Y-m-d H:i:s", strtotime($row->CheckDate)) . "," . $amount . "," . "\n";
            }
        }
    
        header('Content-Type: application/csv');
        echo $fileContent;
    }
    
    public function getNewItem($id, $type){            
        $values = [];

        foreach($this->idFields as $value)
            $idDefaults[] = "$value='DEFAULT'";

        // $defaultRecord = DB::select("select * from {$this->tableName} WHERE " . implode(" AND ", $idDefaults), array());
        // if(count($defaultRecord))
        //     $defaultRecord = $defaultRecord[0];
        // else
            $defaultRecord = false;
        
        // $result = DB::select("describe " . $this->tableName);
        $result = [];

        foreach($this->editCategories[$type] as $key=>$value) {
            foreach($result as $struct) {
                if ($struct->Field == $key) {
                    if(!key_exists("defaultOverride", $this->editCategories[$type][$key]) &&
                       !key_exists("dirtyAutoincrement", $this->editCategories[$type][$key])){
                        $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;
                        if($defaultRecord && property_exists($defaultRecord, $key) && $defaultRecord->$key != "")
                            $this->editCategories[$type][$key]["defaultValue"] = $defaultRecord->$key;
                    }
                    switch ($struct->Null) {
                        case "NO":
                            $this->editCategories[$type][$key]["required"] = true;
                            break;
                        case "YES":
                            $this->editCategories[$type][$key]["required"] = false;
                            break;
                        default:
                            $this->editCategories[$type][$key]["required"] = false;
                    }
                    break;
                }
            }
        }

        foreach($this->editCategories[$type] as $key=>$value)
            $values[$key] = key_exists($key, $_GET) ? $_GET[$key] : (key_exists("defaultValue", $value) ? $value["defaultValue"] : "");
        
        return $values;
    } 


}
?>
