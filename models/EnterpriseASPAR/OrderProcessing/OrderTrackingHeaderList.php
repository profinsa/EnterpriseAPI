<?php
/*
  Name of Page: OrderTrackingHeaderList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderTrackingHeaderList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/OrderTrackingHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderTrackingHeaderList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderTrackingHeaderList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/16/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class OrderTrackingHeaderList extends gridDataSource{
    public $tableName = "ordertrackingheader";
    public $dashboardTitle ="OrderTrackingHeader";
    public $breadCrumbTitle ="OrderTrackingHeader";
    public $idField ="OrderNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
    public $gridFields = [
        "OrderNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "OrderDescription" => [
            "dbType" => "varchar(80)",
            "inputType" => "text"
        ],
        "SpecialInstructions" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
        "SpecialNeeds" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
        "EnteredBy" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "Approved" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "OrderDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "OrderLongDescription" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SpecialInstructions" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SpecialNeeds" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EnteredBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "ApprovedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ]
        ],
        "Tracking Detail" => [
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "OrderNumber" => "Order Number",
        "OrderDescription" => "Order Description",
        "SpecialInstructions" => "Special Instructions",
        "SpecialNeeds" => "Special Needs",
        "EnteredBy" => "Entered By",
        "OrderLongDescription" => "Order Long Description",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "CommentNumber" => "Comment Number",
        "CommentDate" => "Comment Date",
        "Comment" => "Comment"
    ];
    
    public $detailPages = [
        "Tracking Detail" => [
            "hideFields" => "true",
            "viewPath" => "AccountsReceivable/OrderProcessing/OrderTrackingDetail",
            "newKeyField" => "OrderNumber",
            "keyFields" => ["OrderNumber", "CommentNumber"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","OrderNumber", "CommentNumber"],
            "gridFields" => [
                "OrderNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "CommentNumber" => [
                    "dbType" => "decimal(18,0)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "CommentDate" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime",
                    "defaultValue" => "now"
                ],
                "Comment" => [
                    "dbType" => "varchar(255)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "Approved" => [
                    "dbType" => "tinyint(1)",
                    "inputType" => "checkbox",
                    "defaultValue" => "0"
                ]
            ]
        ]
    ];
    //getting rows for grid
    public function getTrackingDetail($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Tracking Detail"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Tracking Detail"]["detailIdFields"] as $key){
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

        $keyFields .= " AND OrderNumber='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from ordertrackingdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function deleteTrackingDetail(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber", "CommentNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from ordertrackingdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>
