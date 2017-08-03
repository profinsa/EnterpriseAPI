<?php
/*
  Name of Page: DivisionsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/DivisionsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/03/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "divisions";
    public $dashboardTitle ="Divisions";
    public $breadCrumbTitle ="Divisions";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $gridFields = [
        "DivisionID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "DivisionName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DivisionDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DivisionPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DivisionID" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => "true",
                "inputType" => "text"
            ],
            "DivisionName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionWebAddress" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "DivisionID" => "Division ID",
        "DivisionName" => "Division Name",
        "DivisionDescription" => "Division Description",
        "DivisionPhone" => "Division Phone",
        "DivisionAddress1" => "Division Address 1",
        "DivisionAddress2" => "Division Address 2",
        "DivisionCity" => "Division City",
        "DivisionState" => "Division State",
        "DivisionZip" => "Division Zip",
        "DivisionCountry" => "Division Country",
        "DivisionFax" => "Division Fax",
        "DivisionEmail" => "Division Email",
        "DivisionWebAddress" => "Division Web Address",
        "DivisionNotes" => "Division Notes"
    ];
    
    //getting rows for grid
    public function getPage($number){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->gridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        if(property_exists($this, "gridConditions")){
            if($keyFields != "")
                $keyFields .= " AND " . $this->gridConditions;
            else
                $keyFields = $this->gridConditions;
        }
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
