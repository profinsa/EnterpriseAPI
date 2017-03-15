<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderheader";
public $gridFields =["WorkOrderNumber","WorkOrderType","WorkOrderDate","WorkOrderStartDate","WorkOrderManager","WorkOrderCompletedDate","WorkOrderReference","WorkOrderTotalCost"];
public $dashboardTitle ="WorkOrderHeader";
public $breadCrumbTitle ="WorkOrderHeader";
public $idField ="WorkOrderNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderNumber"];
public $editCategories = [
"Main" => [

"WorkOrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderType" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderStartDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderExpectedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderCompleted" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderCompletedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderCancelDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderReference" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderReferenceDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderRequestedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderManager" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderAssignedTo" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderApprovedByDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"WorkOrderForCompanyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderForDivisionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderForDepartmentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderPriority" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderInProgress" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderProgressNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderTotalCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo4" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo5" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo6" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo7" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo8" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderMemo9" => [
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
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
