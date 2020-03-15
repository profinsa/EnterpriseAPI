<?php
/*
  Name of Page: HelpSupportRequestList
   
  Method: Model for grid screen. It provides data from database and default values, column names and categories
   
  Date created: 06/08/2019 Nikita Zaharov
   
  Use: this model used by views/gridView
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by grid controller
  used as model by views/gridView
   
  Calls:
  MySql Database
   
  Last Modified: 12/03/2020
  Last Modified by: Nikita Zaharov
*/

require_once "./models/gridDataSource.php";
require "./models/EnterpriseASPAR/Customers/CustomerInformationList.php";

class gridData extends gridDataSource{
    public $tableName = "helpsupportrequest";
    public $dashboardTitle ="Help Support Requests";
    public $breadCrumbTitle ="Help Support Requests";
    //    public $gridConditions = "EmailConfirmed = 1 AND IFNULL(SupportStatus, '') <> 'Resolved'";
    public $idField ="CaseID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "CaseID"];
    public $publicAccess = [
        "procedure" => ["confirm", "test", "mailtest"]
    ];
    public $gridFields = [
        "CaseId" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerId" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportManager" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportAssigned" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "SupportAssignedTo" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportRequestMethod" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataSource" => "getHelpStatuses",
            "defaultValue" => ""
        ],
        "SupportDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "SupportQuestion" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
    ];

    public $editCategories = [
        "Main" => [
            "CaseId" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "disabledEdit" => true,
                "disabledNew" => true,
                "defaultValue" => "-1",
                "dirtyAutoincrement" => "true"
            ],
            "CustomerId" => [
                "dbType" => "varchar(36)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "defaultValue" => ""
            ],
            "ContactId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProductId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportManager" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getEmployees",
                "defaultValue" => ""
            ],
            "SupportAssigned" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SupportAssignedTo" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getEmployees",
                "defaultValue" => ""
            ],
            "SupportRequestMethod" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportStatus" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getHelpStatuses",
                "defaultValue" => ""
            ],
            "SupportPriority" => [
                "dbType" => "tinyint(3) unsigned",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportVersion" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SupportQuestion" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportKeywords" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportDescription" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportScreenShotURL" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportScreenShot" => [
                "dbType" => "varchar(255)",
                "inputType" => "imageFile",
                "defaultValue" => ""
            ],
            "SupportResolution" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportResolutionDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SupportTimeSpentFixing" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SuportNotesPrivate" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportApproved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SupportApprovedBy" => [
                "dbType" => "varchar(26)",
                "inputType" => "dropdown",
                "dataProvider" => "getEmployees",
                "defaultValue" => ""
            ],
            "UniqID" => [
                "dbType" => "varchar(50)",
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CaseId" => "Case Id",
        "CustomerId" => "Customer Id",
        "ContactId" => "Contact Id",
        "ProductId" => "Product Id",
        "SupportManager" => "Support Manager",
        "SupportAssigned" => "Support Assigned",
        "SupportAssignedTo" => "Support Assigned To",
        "SupportRequestMethod" => "Support Request Method",
        "SupportStatus" => "Support Status",
        "SupportPriority" => "Support Priority",
        "SupportType" => "Support Type",
        "SupportVersion" => "Support Version",
        "SupportDate" => "Support Date",
        "SupportQuestion" => "Support Question",
        "SupportKeywords" => "Support Keywords",
        "SupportDescription" => "Support Description",
        "SupportScreenShotURL" => "Support ScreenShot URL",
        "SupportResolution" => "Support Resolution",
        "SupportResolutionDate" => "Support Resolution Date",
        "SupportTimeSpentFixing" => "Support Time Spent Fixing",
        "SuportNotesPrivate" => "Suport Notes Private",
        "SupportApproved" => "Support Approved",
        "SupportApprovedBy" => "Support Approved By",
        "Subject" => "Subject",
        "Created" => "Created",
        "Message" => "Message",
        "ScreenShotURL" => "ScreenShot URL",
        "CaseIDDetail" => "Case ID Detail"
    ];

    public $detailPages = [
        "Main" => [
            "tableName" => "helpsupportrequestdetail",
            //"hideFields" => "true",
            //"disableNew" => "true",
            //"deleteDisabled" => "true",
            //"editDisabled" => "true",
            "viewPath" => "CRMHelpDesk/HelpDesk/SupportRequestDetail",
            "newKeyField" => "CaseId",
            "keyFields" => ["CaseId"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","CaseId"],
            "gridFields" => [
                "Subject" => [
                    "dbType" => "varchar(80)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "Created" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime",
                    "defaultValue" => "now"
                ],
                "Message" => [
                    "dbType" => "varchar(999)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "ScreenShotURL" => [
                    "dbType" => "varchar(120)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ]
            ]
        ]
    ];

    public function getPage($id){
        $user = Session::get("user");
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "total"){
            $this->gridConditions = "EmailConfirmed=1";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "resolved"){
            $this->gridConditions = "IFNULL(SupportStatus, 0) = 'Resolved'";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "newmonth"){
            $this->gridConditions .= "and SupportDate >= NOW() - INTERVAL 30 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "newyear"){
            $this->gridConditions .= "and SupportDate >= NOW() - INTERVAL 365 DAY";
            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }

    public function getMain($id){
        return $this->getDetailGridFields($id, "Main");
    }

    public function Resolve(){
        $ts = date("Y-m-d H:i:s");
        if($_POST["SupportStatus"] != "Resolved")
            DB::update("update helpsupportrequest set SupportStatus='Resolved', SupportResolutionDate='$ts'");
        else
            DB::update("update helpsupportrequest set SupportStatus='In Review'");            
    }
    
    public function confirm(){
        DB::update("update helpsupportrequest set EmailConfirmed=1 WHERE uniqid=?", [$_GET["uniqid"]]);
        echo "Your request is confirmed";
    }
    
    public function mailtest(){
        $config = config();
        echo "ok";
        //        session_write_close(); //close the session
        //fastcgi_finish_request(); //this returns 200 to the user, and processing continues
        $mailer = new mailer();
        $uid = uniqid();
        $mailer->send([
            "subject" => "test",
            "body" => "<html><body>To confirm your support request please click <a href=\"{$config["confirmationHost"]}/EnterpriseX/index.php?page=grid&action=CRMHelpDesk/HelpDesk/ViewSupportRequests&mode=view&category=Main&uniqid=$uid&procedure=confirm\">here</a></body></html>",
            "email" => "ix@2du.ru"
        ]);
    }
    
    public function insertRequestWithCustomer(){
        $user = Session::get("user");
        $config = config();

        $customersDS = new CustomerInformationList();
        $customer = [];
        foreach($customersDS->editCategories as $key=>$value)
            $customer = array_merge($customer, $customersDS->getNewItem($_POST["id"], $key));
        $customer["CustomerID"] = $_POST["CustomerID"];
        $customer["CustomerName"] = $_POST["CustomerName"];
        $customer["CustomerFirstName"] = $_POST["CustomerFirstName"];
        $customer["CustomerLastName"] = $_POST["CustomerLastName"];
        $customer["CustomerEmail"] = $_POST["CustomerEmail"];
        if(count(DB::select("select CustomerID from customerinformation where CompanyID=? AND DivisionID=? AND DepartmentID=? AND CustomerID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $customer["CustomerID"]])) == 0)
            $customersDS->insertItemLocal($customer);
        
        echo json_encode($customer, JSON_PRETTY_PRINT);

        $helpRequest = [];
        foreach($this->editCategories as $key=>$value)
            $helpRequest = array_merge($helpRequest, $this->getNewItem($_POST["id"], $key));
        $helpRequest["CustomerId"] = $_POST["CustomerID"];
        $helpRequest["ProductId"] = $_POST["ProductId"];
        $uid = $helpRequest["UniqID"] = uniqid();
        $helpRequest["SupportQuestion"] = $_POST["SupportQuestion"];
        $helpRequest["SupportDescription"] = $_POST["SupportDescription"];
        $helpRequest["SupportScreenShot"] = $_POST["SupportScreenShot"];
        $helpRequest["EmailConfirmed"] = 0;

        $item = $this->insertItemLocal($helpRequest);
        echo json_encode($helpRequest, JSON_PRETTY_PRINT);

        //session_write_close(); //close the session
        //fastcgi_finish_request(); //this returns 200 to the user, and processing continues
        $mailer = new mailer();
        $mailer->send([
            "subject" => "The confirmation message",
            "body" => "<html><body>Your request has been accepted.<br/>To confirm your support request please click <a href=\"{$config["confirmationHost"]}/EnterpriseX/index.php?config=STFBEnterprise&page=grid&action=CRMHelpDesk/HelpDesk/ViewSupportRequests&mode=view&category=Main&uniqid=$uid&procedure=confirm\">here</a></body></html>",
            "email" => $_POST["CustomerEmail"]
        ]);
        
        
        $mailer1 = new mailer();
        $mailer1->send([
            "subject" => $_POST["SupportQuestion"],
            "body" => "<html><body>Help Request from {$_POST["CustomerEmail"]}: <br/> Title: {$_POST["SupportQuestion"]} <br/> Message: {$_POST["SupportDescription"]}</body></html>",
            "email" => $config["mailSales"]
        ]);
    }
    
    public function test(){
        echo "test";
    }
}
?>
