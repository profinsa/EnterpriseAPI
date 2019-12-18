<?php
$categories["CommonTasks"] =[
    [
        "id" => "AccountsReceivable/OrderProcessing/ViewOrders",
        "full" => $translation->translateLabel('Create New Order'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsReceivable/OrderProcessing/ViewOrders"),
        "short" => "Vi"
    ],
    [
        "id" => "AccountsReceivable/OrderProcessing/ViewOrders",
        "full" => $translation->translateLabel('Create New Invoice'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsReceivable/OrderProcessing/ViewInvoices"),
        "short" => "Vi"
    ],
    [
        "id" => "AccountsPayable/PurchaseScreens/ViewPurchases",
        "full" => $translation->translateLabel('Create New Purchase'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsPayable/PurchaseScreens/ViewPurchases"),
        "short" => "Vi"
    ],
    [
        "id" => "AccountsPayable/VoucherProcessing/ViewVouchers",
        "full" => $translation->translateLabel('Create New Payment'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsPayable/VoucherProcessing/ViewVouchers"),
        "short" => "Vi"
    ],
    [
        "id" => "CRMHelpDesk/CRM/ViewLeads",
        "full" => $translation->translateLabel('Create New Lead'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("CRMHelpDesk/CRM/ViewLeads"),
        "short" => "Vi"
    ],
    [
        "id" => "AccountsReceivable/Customers/ViewCustomers",
        "type" => "absoluteLink",
        "full" => $translation->translateLabel('Create New Customer'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsReceivable/Customers/ViewCustomers"),
        "short" => "Vi"
    ],
    [
        "id" => "AccountsPayable/Vendors/ViewVendors",
        "full" => $translation->translateLabel('Create New Vendor'),
        "type" => "absoluteLink",
        "href"=> $linksMaker->makeGridItemNewPartial("AccountsPayable/Vendors/ViewVendors"),
        "short" => "Vi"
    ],
];
?>