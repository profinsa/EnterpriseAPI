<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"IPAddress" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RestrictSecurityIP" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"SecurityLevel" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
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
"OESetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
"ARSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
"POReports" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"POSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
"APSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
],
"GLSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
"EMSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
"PRChecks" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PRReports" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PRSetup" => [
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
"WHPrint" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"WHReceive" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"WHTransfer" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"WHAdjust" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"WHSetup" => [
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
"WOSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ADView" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ADSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ADSecurity" => [
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
"ChallangeSetup" => [
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
"AuditSetup" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveCustomer" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveVendor" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovePayment" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovePurchase" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveTransfer" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveAdjustment" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveReceipt" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovePayroll" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveAPChedks" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveEmployees" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveItems" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveLowMargins" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveOrders" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveContract" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveReturns" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApproveRMA" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
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
],
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
],
"RTSystemView" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
