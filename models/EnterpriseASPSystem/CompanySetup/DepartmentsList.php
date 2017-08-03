<?php
/*
  Name of Page: DepartmentsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/DepartmentsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/03/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "departments";
    public $dashboardTitle ="Departments";
    public $breadCrumbTitle ="Departments";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $gridFields = [
        "DepartmentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "DepartmentName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DepartmentDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DepartmentPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DepartmentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "DepartmentName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentWebAddress" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "DepartmentID" => "Department ID",
        "DepartmentName" => "Department Name",
        "DepartmentDescription" => "Department Description",
        "DepartmentPhone" => "Department Phone",
        "DepartmentAddress1" => "Department Address 1",
        "DepartmentAddress2" => "Department Address 2",
        "DepartmentCity" => "Department City",
        "DepartmentState" => "Department State",
        "DepartmentZip" => "Department Zip",
        "DepartmentCountry" => "Department Country",
        "DepartmentFax" => "Department Fax",
        "DepartmentEmail" => "Department Email",
        "DepartmentWebAddress" => "Department Web Address",
        "DepartmentNotes" => "Department Notes"
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
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
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
