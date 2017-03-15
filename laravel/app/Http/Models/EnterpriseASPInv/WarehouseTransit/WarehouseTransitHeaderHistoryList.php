<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousetransitheaderhistory";
public $gridFields =["TransitID","TransitEnteredDate","TransitETAlDate","TransitShipVia","TransitShipDate","TransitBillOfLadingNumber","TransitTrailerPrefix","TransitShippingInstructions","TransitReceivedDate","TransitRequestedBy","ApprovedBy","ApprovedDate","EnteredBy","TransitHeaderMemo1","TransitHeaderMemo2","TransitHeaderMemo3","TransitHeaderMemo4","TransitHeaderMemo5","TransitHeaderMemo6","TransitHeaderMemo7","TransitHeaderMemo8","TransitHeaderMemo9","TransitHeaderMemo10","Signature","SignaturePassword","SupervisorSignature","SupervisorSignaturePassword","ManagerSignature","ManagerSignaturePassword"];
public $dashboardTitle ="WarehouseTransitHeaderHistory";
public $breadCrumbTitle ="WarehouseTransitHeaderHistory";
public $idField ="TransitID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransitID"];
public $editCategories = [
"Main" => [

"TransitID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitEnteredDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitETAlDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitShipVia" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitShipped" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitShipDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitTrackingNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitBillOfLadingNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitTralierNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitTrailerPrefix" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitShippingInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitReceived" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitReceivedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"TransitRequestedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo4" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo5" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo6" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo7" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo8" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo9" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransitHeaderMemo10" => [
"inputType" => "text",
"defaultValue" => ""
],
"Memorized" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
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
