<?php

/*
Name of Page: InventoryWorkOrderHeaderClosedList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderClosedList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryWorkOrderHeaderClosedList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderClosedList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\WorkOrders\InventoryWorkOrderHeaderClosedList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderheader";
public $dashboardTitle ="WorkOrderHeader";
public $breadCrumbTitle ="WorkOrderHeader";
public $idField ="WorkOrderNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderNumber"];
public $gridFields = [

"WorkOrderNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
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

"WorkOrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
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
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderManager" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderAssignedTo" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderApprovedByDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderForCompanyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderForDivisionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderForDepartmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderPriority" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderInProgress" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderProgressNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderTotalCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
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
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"WorkOrderNumber" => "Order Number",
"WorkOrderType" => "WorkOrderType",
"WorkOrderDate" => "Date",
"WorkOrderStartDate" => "Start Date",
"WorkOrderManager" => "Manager",
"WorkOrderCompletedDate" => "Completed Date",
"WorkOrderReference" => "Reference",
"WorkOrderTotalCost" => "Total Cost",
"WorkOrderExpectedDate" => "Work Order Expected Date",
"WorkOrderCompleted" => "Work Order Completed",
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
"WorkOrderMemo1" => "Work Order Memo 1",
"WorkOrderMemo2" => "Work Order Memo 2",
"WorkOrderMemo3" => "Work Order Memo 3",
"WorkOrderMemo4" => "Work Order Memo 4",
"WorkOrderMemo5" => "Work Order Memo 5",
"WorkOrderMemo6" => "Work Order Memo 6",
"WorkOrderMemo7" => "Work Order Memo 7",
"WorkOrderMemo8" => "Work Order Memo 8",
"WorkOrderMemo9" => "Work Order Memo 9",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorSignaturePassword" => "Supervisor Signature Password",
"ManagerSignature" => "Manager Signature",
"ManagerSignaturePassword" => "Manager Signature Password",
"Memorize" => "Memorize"];
}?>
