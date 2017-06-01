<?php

/*
Name of Page: InventoryWorkOrderHeaderHistoryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderHistoryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryWorkOrderHeaderHistoryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderHistoryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderHistoryList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "workorderheaderhistory";
    public $dashboardTitle ="WorkOrderHeaderHistory";
    public $breadCrumbTitle ="WorkOrderHeaderHistory";
    public $idField ="WorkOrderNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderNumber"];
    public $gridFields = [
        "WorkOrderNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "disabledEdit" => "true"
        ],
        "WorkOrderType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "WorkOrderDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "WorkOrderStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "WorkOrderManager" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "WorkOrderCompleted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "WorkOrderCompletedDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "WorkOrderReference" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "WorkOrderTotalCost" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "WorkOrderReference" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderReferenceDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderRequestedBy" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees"
            ],
            "WorkOrderAssignedTo" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees"
            ],
            "WorkOrderApprovedBy" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees"
            ],
            "WorkOrderApprovedByDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderForCompanyID" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getCompanies"
            ],
            "WorkOrderForDivisionID" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getDivisions"
            ],
            "WorkOrderForDepartmentID" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getDepartments"
            ],
            "WorkOrderReason" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderDescription" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderStatus" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWorkOrderStatus",
                "defaultValue" => ""
            ],
            "WorkOrderPriority" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWorkOrderPriority",
                "defaultValue" => ""
            ],
            "WorkOrderInProgress" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWorkOrderProgress",
                "defaultValue" => ""
            ],
            "WorkOrderProgressNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ], 
            "WorkOrderTotalCost" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ]
       ],
        "Memos" => [
            "WorkOrderMemo1" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo2" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo3" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo4" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo5" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo6" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo7" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo8" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderMemo9" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Signature" => [
            "Signature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "...fields" => [
            "WorkOrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "WorkOrderType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WorkOrderDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderStartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderExpectedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderCompleted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WorkOrderCompletedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderCancelDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "WorkOrderManager" => [
                "dbType" => "varchar(36)",
                "defaultValue" => "",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees"
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    public $columnNames = [
        "WorkOrderNumber" => "Order Number",
        "WorkOrderType" => "Type",
        "WorkOrderDate" => "Date",
        "WorkOrderStartDate" => "Start Date",
        "WorkOrderManager" => "Manager",
        "WorkOrderCompletedDate" => "Completed Date",
        "WorkOrderReference" => "Reference",
        "WorkOrderTotalCost" => "Total Cost",
        "WorkOrderExpectedDate" => "Work Order Expected Date",
        "WorkOrderCompleted" => "Completed",
        "WorkOrderCancelDate" => "Work Order Cancel Date",
        "WorkOrderReferenceDate" => "Work Order Reference Date",
        "WorkOrderRequestedBy" => "Work Order Requested By",
        "WorkOrderAssignedTo" => "Work Order Assigned To",
        "WorkOrderApprovedBy" => "Work Order Approved By",
        "WorkOrderApprovedByDate" => "Work Order Approved By Date",
        "WorkOrderForCompanyID" => "Work Order For Company ID",
        "WorkOrderForDivisionID" => "Work Order For Division ID",
        "WorkOrderForDepartmentID" => "Work Order For Department ID",
        "WorkOrderReason" => "Work Order Reason",
        "WorkOrderDescription" => "Work Order Description",
        "WorkOrderStatus" => "Work Order Status",
        "WorkOrderPriority" => "Work Order Priority",
        "WorkOrderInProgress" => "Work Order In Progress",
        "WorkOrderProgressNotes" => "Work Order Progress Notes",
        "WorkOrderMemo1" => "Memo 1",
        "WorkOrderMemo2" => "Memo 2",
        "WorkOrderMemo3" => "Memo 3",
        "WorkOrderMemo4" => "Memo 4",
        "WorkOrderMemo5" => "Memo 5",
        "WorkOrderMemo6" => "Memo 6",
        "WorkOrderMemo7" => "Memo 7",
        "WorkOrderMemo8" => "Memo 8",
        "WorkOrderMemo9" => "Memo 9",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorSignaturePassword" => "Supervisor Signature Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerSignaturePassword" => "Manager Signature Password",
        "Memorize" => "Memorize",
		"WorkOrderLineNumber" => "Line Number",
		"WorkOrderBOMNumber" => "BOM Number",
		"WorkOrderBOMQuantity" => "BOM Qty"
    ];

    public $headTableOne = [
        "Order Number" => "WorkOrderNumber",
        "Order Type" => "WorkOrderType",
        "Date" => "WorkOrderDate",
        "Start Date" => "WorkOrderStartDate",
        "Expected Date" => "WorkOrderExpectedDate"
    ];

    public $headTableTwo = [
        "Manager" => "WorkOrderManager",
        "Completed Date" => "WorkOrderCompletedDate",
        "Cancel Date" => "WorkOrderCancelDate",
        "Completed" => "WorkOrderCompleted"
    ];

    public $detailTable = [
        "viewPath" => "MRP/WorkOrders/ViewWorkOrdersDetail",
        "newKeyField" => "WorkOrderNumber",
        "keyFields" => ["WorkOrderNumber", "WorkOrderLineNumber"]
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Memorized" => "Memorize"
        ],
        "flags" => [],
        "totalFields" => []
    ];
    
    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderNumber", "WorkOrderLineNumber"];
	public $embeddedgridFields = [
		"WorkOrderLineNumber" => [
			"dbType" => "int(11)",
			"inputType" => "text"
		],
		"WorkOrderBOMNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"WorkOrderBOMQuantity" => [
			"dbType" => "int(11)",
			"inputType" => "text"
		],
        "WorkOrderStartDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "WorkOrderExpectedDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "WorkOrderCompleted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "WorkOrderCompletedDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "WorkOrderTotalCost" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
	];
    
    //getting rows for grid
    public function getDetail($id){
        $user = $_SESSION["user"];
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

        $keyFields .= " AND WorkOrderNumber='" . $id . "'";

        
        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $fields) . " from workorderdetailhistory " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = $_SESSION["user"];
        $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderNumber", "WorkOrderLineNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $GLOBALS["DB"]::delete("DELETE from workorderdetailhistory " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>
