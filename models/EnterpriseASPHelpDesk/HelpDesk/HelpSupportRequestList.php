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
   
  Last Modified: 07/08/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "helpsupportrequest";
    public $dashboardTitle ="Help Support Requests";
    public $breadCrumbTitle ="Help Support Requests";
    public $idField ="CaseID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "CaseID"];
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
                "inputType" => "text",
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

    public function getMain($id){
        return $this->getDetailGridFields($id, "Main");
    }

    public function insertItemRemote(){
        parent::insertItemRemote($_POST);
        $mail = new PHPMailer();

        // Settings
        $mail->IsSMTP();
        $mail->CharSet = 'UTF-8';

        $mail->Host       = "box789.bluehost.com"; // SMTP server example
        $mail->SMTPDebug  = 0;                     // enables SMTP debug information (for testing)
        $mail->SMTPAuth   = true;                  // enable SMTP authentication
        $mail->Port       = 465;                    // set the SMTP port for the GMAIL server
        $mail->Username   = "support@stfb.com"; // SMTP account username example
        $mail->Password   = "STFB!xticket1024";        // SMTP account password example

        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = '$values["SupportQuestion"]';
        $mail->Body    = '$values["SupportDescription"]';
        $mail->AltBody = '$values["SupportDescription"]';
        $mail->setFrom('support@stfb.com', 'Support');
        $mail->addAddress($values["CustomerEmail"], '');    
        $mail->send();
    }
}
?>
