<?php
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
"DefaultPageToDisplay" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"MachineName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RestrictMultipleLogins" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"IPAddress" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RestrictSecurityIP" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"SecurityLevel" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"OEView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OEAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OEEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OEDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OEReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OESetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ARView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ARAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AREdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ARDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ARReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ARSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"POView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"POAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"POEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PODelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"POReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"POSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APChecks" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"APSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFinancials" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLMonthEnd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLYearEnd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EMSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PREdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRChecks" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PRSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHPick" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHPack" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHShip" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHPrint" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHReceive" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHTransfer" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHAdjust" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WHSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WODelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOForecast" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"WOSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ADView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ADSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ADSecurity" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditAdd" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditEdit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditDelete" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditReports" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveCustomer" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveVendor" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePayment" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePurchase" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveTransfer" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveAdjustment" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveReceipt" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePayroll" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveAPChedks" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveEmployees" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveItems" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveLowMargins" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveOrders" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveContract" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveReturns" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApproveRMA" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTARView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTAPView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTGLView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTInventoryView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTMRPView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTFundView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTCRMView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTPayrollView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTSystemView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MTReportsView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTFinancialView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTARView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTAPView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTGLView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTInventoryView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTCRMView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTPayrollView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RTSystemView" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"SecurityLevel" => "Security Level",
"DefaultPageToDisplay" => "DefaultPageToDisplay",
"MachineName" => "MachineName",
"RestrictMultipleLogins" => "RestrictMultipleLogins",
"IPAddress" => "IPAddress",
"RestrictSecurityIP" => "RestrictSecurityIP",
"OEView" => "OEView",
"OEAdd" => "OEAdd",
"OEEdit" => "OEEdit",
"OEDelete" => "OEDelete",
"OEReports" => "OEReports",
"OESetup" => "OESetup",
"ARView" => "ARView",
"ARAdd" => "ARAdd",
"AREdit" => "AREdit",
"ARDelete" => "ARDelete",
"ARReports" => "ARReports",
"ARSetup" => "ARSetup",
"POView" => "POView",
"POAdd" => "POAdd",
"POEdit" => "POEdit",
"PODelete" => "PODelete",
"POReports" => "POReports",
"POSetup" => "POSetup",
"APView" => "APView",
"APAdd" => "APAdd",
"APEdit" => "APEdit",
"APDelete" => "APDelete",
"APChecks" => "APChecks",
"APReports" => "APReports",
"APSetup" => "APSetup",
"GLView" => "GLView",
"GLAdd" => "GLAdd",
"GLEdit" => "GLEdit",
"GLDelete" => "GLDelete",
"GLReports" => "GLReports",
"GLFinancials" => "GLFinancials",
"GLMonthEnd" => "GLMonthEnd",
"GLYearEnd" => "GLYearEnd",
"GLSetup" => "GLSetup",
"EMView" => "EMView",
"EMAdd" => "EMAdd",
"EMEdit" => "EMEdit",
"EMDelete" => "EMDelete",
"EMReports" => "EMReports",
"EMSetup" => "EMSetup",
"PRView" => "PRView",
"PRAdd" => "PRAdd",
"PREdit" => "PREdit",
"PRDelete" => "PRDelete",
"PRChecks" => "PRChecks",
"PRReports" => "PRReports",
"PRSetup" => "PRSetup",
"WHPick" => "WHPick",
"WHPack" => "WHPack",
"WHShip" => "WHShip",
"WHPrint" => "WHPrint",
"WHReceive" => "WHReceive",
"WHTransfer" => "WHTransfer",
"WHAdjust" => "WHAdjust",
"WHSetup" => "WHSetup",
"WOView" => "WOView",
"WOAdd" => "WOAdd",
"WOEdit" => "WOEdit",
"WODelete" => "WODelete",
"WOReports" => "WOReports",
"WOForecast" => "WOForecast",
"WOSetup" => "WOSetup",
"ADView" => "ADView",
"ADSetup" => "ADSetup",
"ADSecurity" => "ADSecurity",
"ChallangeView" => "ChallangeView",
"ChallangeAdd" => "ChallangeAdd",
"ChallangeEdit" => "ChallangeEdit",
"ChallangeDelete" => "ChallangeDelete",
"ChallangeReports" => "ChallangeReports",
"ChallangeSetup" => "ChallangeSetup",
"AuditView" => "AuditView",
"AuditAdd" => "AuditAdd",
"AuditEdit" => "AuditEdit",
"AuditDelete" => "AuditDelete",
"AuditReports" => "AuditReports",
"AuditSetup" => "AuditSetup",
"ApproveCustomer" => "ApproveCustomer",
"ApproveVendor" => "ApproveVendor",
"ApprovePayment" => "ApprovePayment",
"ApprovePurchase" => "ApprovePurchase",
"ApproveTransfer" => "ApproveTransfer",
"ApproveAdjustment" => "ApproveAdjustment",
"ApproveReceipt" => "ApproveReceipt",
"ApprovePayroll" => "ApprovePayroll",
"ApproveAPChedks" => "ApproveAPChedks",
"ApproveEmployees" => "ApproveEmployees",
"ApproveItems" => "ApproveItems",
"ApproveLowMargins" => "ApproveLowMargins",
"ApproveOrders" => "ApproveOrders",
"ApproveContract" => "ApproveContract",
"ApproveReturns" => "ApproveReturns",
"ApproveRMA" => "ApproveRMA",
"MTARView" => "MTARView",
"MTAPView" => "MTAPView",
"MTGLView" => "MTGLView",
"MTInventoryView" => "MTInventoryView",
"MTMRPView" => "MTMRPView",
"MTFundView" => "MTFundView",
"MTCRMView" => "MTCRMView",
"MTPayrollView" => "MTPayrollView",
"MTSystemView" => "MTSystemView",
"MTReportsView" => "MTReportsView",
"RTFinancialView" => "RTFinancialView",
"RTARView" => "RTARView",
"RTAPView" => "RTAPView",
"RTGLView" => "RTGLView",
"RTInventoryView" => "RTInventoryView",
"RTCRMView" => "RTCRMView",
"RTPayrollView" => "RTPayrollView",
"RTSystemView" => "RTSystemView"];
}?>
