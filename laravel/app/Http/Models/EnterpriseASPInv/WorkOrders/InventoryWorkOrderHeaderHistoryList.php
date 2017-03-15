<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderheaderhistory";
public $dashboardTitle ="WorkOrderHeaderHistory";
public $breadCrumbTitle ="WorkOrderHeaderHistory";
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
    "inputType" => "datetime"
],
"WorkOrderStartDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"WorkOrderManager" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderCompletedDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"WorkOrderReference" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderTotalCost" => [
    "dbType" => "decimal(19,4)",
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"WorkOrderExpectedDate" => "WorkOrderExpectedDate",
"WorkOrderCompleted" => "WorkOrderCompleted",
"WorkOrderCancelDate" => "WorkOrderCancelDate",
"WorkOrderReferenceDate" => "WorkOrderReferenceDate",
"WorkOrderRequestedBy" => "WorkOrderRequestedBy",
"WorkOrderAssignedTo" => "WorkOrderAssignedTo",
"WorkOrderApprovedBy" => "WorkOrderApprovedBy",
"WorkOrderApprovedByDate" => "WorkOrderApprovedByDate",
"WorkOrderForCompanyID" => "WorkOrderForCompanyID",
"WorkOrderForDivisionID" => "WorkOrderForDivisionID",
"WorkOrderForDepartmentID" => "WorkOrderForDepartmentID",
"WorkOrderReason" => "WorkOrderReason",
"WorkOrderDescription" => "WorkOrderDescription",
"WorkOrderStatus" => "WorkOrderStatus",
"WorkOrderPriority" => "WorkOrderPriority",
"WorkOrderInProgress" => "WorkOrderInProgress",
"WorkOrderProgressNotes" => "WorkOrderProgressNotes",
"WorkOrderMemo1" => "WorkOrderMemo1",
"WorkOrderMemo2" => "WorkOrderMemo2",
"WorkOrderMemo3" => "WorkOrderMemo3",
"WorkOrderMemo4" => "WorkOrderMemo4",
"WorkOrderMemo5" => "WorkOrderMemo5",
"WorkOrderMemo6" => "WorkOrderMemo6",
"WorkOrderMemo7" => "WorkOrderMemo7",
"WorkOrderMemo8" => "WorkOrderMemo8",
"WorkOrderMemo9" => "WorkOrderMemo9",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorSignaturePassword" => "SupervisorSignaturePassword",
"ManagerSignature" => "ManagerSignature",
"ManagerSignaturePassword" => "ManagerSignaturePassword",
"Memorize" => "Memorize"];
}?>
