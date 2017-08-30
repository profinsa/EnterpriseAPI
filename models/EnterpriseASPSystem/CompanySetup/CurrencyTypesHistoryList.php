<?php

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "currencytypes";
    public $dashboardTitle ="Currencies";
    public $breadCrumbTitle ="Currencies";
    public $idField ="CurrencyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CurrencyID"];
    public $modes = ["view"];
    public $editCategories = [
        "Main" => [
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true"
            ],
            "CurrencyType" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrenycySymbol" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CurrencyID" => "Currency ID",
        "CurrencyType" => "Currency Type",
        "CurrencyExchangeRate" => "Exchange Rate",
        "CurrencyIDDateTime" => "Date",
        "CurrenycySymbol" => "Currency Symbol"
    ];

    public $detailPages = [
        "Main" => [
            "keyFields" => ["CurrencyID"],
            "viewPath" => "",
            "newKeyField" => "CurrencyID",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            "hideRowActions" => "true",
            "editDisabled" => "true",
            "gridFields" => [
                "CurrencyExchangeRate" => [
                    "dbType" => "float",
                    "inputType" => "text",
                    "defaultType" => "",
                ],
                "CurrencyIDDateTime" => [
                    "dbType" => "datetime",
                    "format" => "{0:d}",
                    "inputType" => "datetime",
                    "defaultType" => "",
                ]        
            ]
        ]
    ];
    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","CurrencyID"];
	public $embeddedgridFields = [
        // "CurrencyExchangeRate" => [
        //     "dbType" => "float",
        //     "inputType" => "text",
        //     "defaultType" => "",
        // ],
        // "CurrencyIDDateTime" => [
        //     "dbType" => "datetime",
        //     "format" => "{0:d}",
        //     "inputType" => "datetime",
        //     "defaultType" => "",
        // ]
    ];
    
    
    //getting rows for grid
    public function getMain($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->embeddedgridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailIdFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND CurrencyID='" . $id . "'";

        
        $result = DB::select("SELECT * from currencytypeshistory " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);

        return $result;
    }
}
?>
