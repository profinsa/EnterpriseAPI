<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousetransitheaderhistory";
public $dashboardTitle ="WarehouseTransitHeaderHistory";
public $breadCrumbTitle ="WarehouseTransitHeaderHistory";
public $idField ="TransitID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransitID"];
public $gridFields = [

"TransitID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitEnteredDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"TransitETAlDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"TransitShipVia" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitShipDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"TransitBillOfLadingNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitTrailerPrefix" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitShippingInstructions" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"TransitReceivedDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"TransitRequestedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ApprovedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ApprovedDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitHeaderMemo1" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo2" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo3" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo4" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo5" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo6" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo7" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo8" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo9" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransitHeaderMemo10" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"Signature" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SignaturePassword" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SupervisorSignature" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SupervisorSignaturePassword" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ManagerSignature" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ManagerSignaturePassword" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TransitID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitEnteredDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitETAlDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitShipVia" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitShipped" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitShipDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitTrackingNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitBillOfLadingNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitTralierNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitTrailerPrefix" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitShippingInstructions" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitReceived" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitReceivedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitRequestedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo6" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo7" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo8" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo9" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo10" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Memorized" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
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
]];
public $columnNames = [

"TransitID" => "Transit ID",
"TransitEnteredDate" => "Entered Date",
"TransitETAlDate" => "ETAl Date",
"TransitShipVia" => "Ship Via",
"TransitShipDate" => "Ship Date",
"TransitBillOfLadingNumber" => "Bill Of Lading Number",
"TransitTrailerPrefix" => "Trailer Prefix",
"TransitShippingInstructions" => "Shipping Instructions",
"TransitReceivedDate" => "Received Date",
"TransitRequestedBy" => "Requested By",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"EnteredBy" => "Entered By",
"TransitHeaderMemo1" => "Memo 1",
"TransitHeaderMemo2" => "Memo 2",
"TransitHeaderMemo3" => "Memo 3",
"TransitHeaderMemo4" => "Memo 4",
"TransitHeaderMemo5" => "Memo 5",
"TransitHeaderMemo6" => "Memo 6",
"TransitHeaderMemo7" => "Memo 7",
"TransitHeaderMemo8" => "Memo 8",
"TransitHeaderMemo9" => "Memo 9",
"TransitHeaderMemo10" => "Memo 10",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorSignaturePassword" => "Supervisor Signature Password",
"ManagerSignature" => "Manager Signature",
"ManagerSignaturePassword" => "Manager Signature Password",
"TransitShipped" => "TransitShipped",
"TransitTrackingNumber" => "TransitTrackingNumber",
"TransitTralierNumber" => "TransitTralierNumber",
"TransitReceived" => "TransitReceived",
"Memorized" => "Memorized",
"Approved" => "Approved"];
}?>
