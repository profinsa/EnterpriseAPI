<?php
/*
  Name of Page: AccessPermissionsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AccessPermissionsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/AccessPermissionsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AccessPermissionsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AccessPermissionsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/21/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "accesspermissions";
    public $dashboardTitle ="Access Permissions";
    public $breadCrumbTitle ="Access Permissions";
    public $idField ="EmployeeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
    public $gridFields = [
        "EmployeeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "SecurityLevel" => [
            "dbType" => "smallint(6)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SecurityLevel" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MachineName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "IPAddress" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RestrictMultipleLogins" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RestrictSecurityIP" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "DefaultPageToDisplay" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DefaultDashboard" => [
                "dbType" => "varchar(120)",
                "inputType" => "dropdown",
                "dataProvider" => "getDashboards",
                "defaultValue" => ""
            ],
        ],
        "Orders" => [
            "OEView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OEAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OEEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OEDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OEReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveOrders" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Receivables" => [
            "ARView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ARAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AREdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ARDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ARReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveReceipt" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveContract" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveCustomer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveRMA" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Purchase" => [
            "POView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "POAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "POEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PODelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovePurchase" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "POReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Payables" => [
            "APView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APChecks" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveVendor" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveAPChedks" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovePayment" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveReturns" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Ledger" => [
            "GLView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLFinancials" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLMonthEnd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLYearEnd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Inventory" => [
            "WHAdjust" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHTransfer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHPick" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHPack" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHShip" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHReceive" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHPrint" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WODelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOForecast" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveAdjustment" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveTransfer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveItems" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Employee" => [
            "EMView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EMAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EMEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EMDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EMReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveEmployees" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Payroll" => [
            "PRView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PRAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PREdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PRDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PRReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PRChecks" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovePayroll" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "MainTabs" => [
            "MTARView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTAPView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTGLView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTInventoryView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTMRPView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTFundView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTCRMView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTPayrollView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTSystemView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MTReportsView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]            
        ],
        "ReportTabs" => [
            "RTFinancialView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTARView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTAPView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTGLView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTInventoryView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTCRMView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTPayrollView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Admin" => [
            "ADView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ADSecurity" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ADSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "APSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ARSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EMSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OESetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "POSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PRSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WHSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WOSetup" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AuditReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeAdd" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeEdit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeDelete" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChallangeReports" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApproveLowMargins" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RTSystemView" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    public $columnNames = [
        "EmployeeID" => "Employee ID",
        "SecurityLevel" => "Security Level",
        "DefaultPageToDisplay" => "Default Page To Display",
        "MachineName" => "Machine Name",
        "RestrictMultipleLogins" => "Restrict Multiple Logins",
        "IPAddress" => "IP Address",
        "RestrictSecurityIP" => "Restrict Security IP",
        "OEView" => "OE View",
        "OEAdd" => "OE Add",
        "OEEdit" => "OE Edit",
        "OEDelete" => "OE Delete",
        "OEReports" => "OE Reports",
        "OESetup" => "OE Setup",
        "ARView" => "AR View",
        "ARAdd" => "AR Add",
        "AREdit" => "AR Edit",
        "ARDelete" => "AR Delete",
        "ARReports" => "AR Reports",
        "ARSetup" => "AR Setup",
        "POView" => "PO View",
        "POAdd" => "PO Add",
        "POEdit" => "PO Edit",
        "PODelete" => "PO Delete",
        "POReports" => "PO Reports",
        "POSetup" => "PO Setup",
        "APView" => "AP View",
        "APAdd" => "AP Add",
        "APEdit" => "AP Edit",
        "APDelete" => "AP Delete",
        "APChecks" => "AP Checks",
        "APReports" => "AP Reports",
        "APSetup" => "AP Setup",
        "GLView" => "GL View",
        "GLAdd" => "GL Add",
        "GLEdit" => "GL Edit",
        "GLDelete" => "GL Delete",
        "GLReports" => "GL Reports",
        "GLFinancials" => "GL Financials",
        "GLMonthEnd" => "GL Month End",
        "GLYearEnd" => "GL Year End",
        "GLSetup" => "GL Setup",
        "EMView" => "EM View",
        "EMAdd" => "EM Add",
        "EMEdit" => "EM Edit",
        "EMDelete" => "EM Delete",
        "EMReports" => "EM Reports",
        "EMSetup" => "EM Setup",
        "PRView" => "PR View",
        "PRAdd" => "PR Add",
        "PREdit" => "PR Edit",
        "PRDelete" => "PR Delete",
        "PRChecks" => "PR Checks",
        "PRReports" => "PR Reports",
        "PRSetup" => "PR Setup",
        "WHPick" => "WH Pick",
        "WHPack" => "WH Pack",
        "WHShip" => "WH Ship",
        "WHPrint" => "WH Print",
        "WHReceive" => "WH Receive",
        "WHTransfer" => "WH Transfer",
        "WHAdjust" => "WH Adjust",
        "WHSetup" => "WH Setup",
        "WOView" => "WO View",
        "WOAdd" => "WO Add",
        "WOEdit" => "WO Edit",
        "WODelete" => "WO Delete",
        "WOReports" => "WO Reports",
        "WOForecast" => "WO Forecast",
        "WOSetup" => "WO Setup",
        "ADView" => "AD View",
        "ADSetup" => "AD Setup",
        "ADSecurity" => "AD Security",
        "ChallangeView" => "Challange View",
        "ChallangeAdd" => "Challange Add",
        "ChallangeEdit" => "Challange Edit",
        "ChallangeDelete" => "Challange Delete",
        "ChallangeReports" => "Challange Reports",
        "ChallangeSetup" => "Challange Setup",
        "AuditView" => "Audit View",
        "AuditAdd" => "Audit Add",
        "AuditEdit" => "Audit Edit",
        "AuditDelete" => "Audit Delete",
        "AuditReports" => "Audit Reports",
        "AuditSetup" => "Audit Setup",
        "ApproveCustomer" => "Approve Customer",
        "ApproveVendor" => "Approve Vendor",
        "ApprovePayment" => "Approve Payment",
        "ApprovePurchase" => "Approve Purchase",
        "ApproveTransfer" => "Approve Transfer",
        "ApproveAdjustment" => "Approve Adjustment",
        "ApproveReceipt" => "Approve Receipt",
        "ApprovePayroll" => "Approve Payroll",
        "ApproveAPChedks" => "Approve APChedks",
        "ApproveEmployees" => "Approve Employees",
        "ApproveItems" => "Approve Items",
        "ApproveLowMargins" => "Approve Low Margins",
        "ApproveOrders" => "Approve Orders",
        "ApproveContract" => "Approve Contract",
        "ApproveReturns" => "Approve Returns",
        "ApproveRMA" => "Approve RMA",
        "MTARView" => "MT AR View",
        "MTAPView" => "MT AP View",
        "MTGLView" => "MT GL View",
        "MTInventoryView" => "MT Inventory View",
        "MTMRPView" => "MT MRP View",
        "MTFundView" => "MT Fund View",
        "MTCRMView" => "MT CRM View",
        "MTPayrollView" => "MT Payroll View",
        "MTSystemView" => "MT System View",
        "MTReportsView" => "MT Reports View",
        "RTFinancialView" => "RT Financial View",
        "RTARView" => "RT AR View",
        "RTAPView" => "RT AP View",
        "RTGLView" => "RT GL View",
        "RTInventoryView" => "RT Inventory View",
        "RTCRMView" => "RT CRM View",
        "RTPayrollView" => "RT Payroll View",
        "RTSystemView" => "RT System View"
    ];
    //getting list of dashboards list
    public function getDashboards(){
        $user = Session::get("user");
        $res = [
            "Accounting" => [
                "title" => "Accounting",
                "value" => "Accounting"
            ],
            "Accounts Payable" => [
                "title" => "Accounts Payable",
                "value" => "Accounts Payable"
            ],
            "Accounts Receivable" => [
                "title" => "Accounts Receivable",
                "value" => "Accounts Receivable"
            ],
            "Inventory" => [
                "title" => "Inventory",
                "value" => "Inventory"
            ],
            "Human Resources" => [
                "title" => "Human Resources",
                "value" => "Human Resources"
            ],
            "Manufacturing" => [
                "title" => "Manufacturing",
                "value" => "Manufacturing"
            ]
        ];

        return $res;
    }
}
?>
