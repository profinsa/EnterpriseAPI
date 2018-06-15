<?php
require 'models/menuIdToHref.php';
$redirectModel = [
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList"
    ];
//       file_put_contents("menuIdToPath.json", json_encode($menuIdToPath, JSON_PRETTY_PRINT));
	     
$tables = [];
foreach($menuIdToPath as $id=>$path){
    $model_path = $path;
    
    $requireModelPath = key_exists($model_path, $redirectModel) ? $redirectModel[$model_path] : $model_path;
    //echo exec("whoami");
    echo exec("php modelstojson_worker.php $requireModelPath $model_path");
}
?>