<?php

/*
Name of Page: WarehouseTransitHeaderHistoryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WarehouseTransitHeaderList\WarehouseTransitHeaderHistoryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehouseTransitHeaderHistoryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WarehouseTransitHeaderList\WarehouseTransitHeaderHistoryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WarehouseTransitHeaderList\WarehouseTransitHeaderHistoryList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
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
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"TransitETAlDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"TransitShipVia" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransitShipDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
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
    "format" => "{0:d}",
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
    "format" => "{0:d}",
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
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"TransitShipped" => "Transit Shipped",
"TransitTrackingNumber" => "Transit Tracking Number",
"TransitTralierNumber" => "Transit Tralier Number",
"TransitReceived" => "Transit Received",
"Memorized" => "Memorized",
"Approved" => "Approved"];
}?>
