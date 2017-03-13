<?php 
 $menuCategories["AccountsReceivable"] = [
"type" => "submenu",
"id" => "AccountsReceivable",
"full" => $translation->translateLabel('Accounts Receivable'),
"short" => "Ac",
"data" => [

    [
    "type" => "submenu",
    "id" => "OrderProcessing",
    "full" => $translation->translateLabel('Order Processing'),
    "short" => "Or",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewOrders",
        "full" => $translation->translateLabel('View Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/PickPackOrders",
        "full" => $translation->translateLabel('Pick & Pack Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsReceivable/ShipOrders",
        "full" => $translation->translateLabel('Ship Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsReceivable/InvoiceShippedOrders",
        "full" => $translation->translateLabel('Invoice Shipped Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ViewInvoices",
        "full" => $translation->translateLabel('View Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "OrderScreens",
    "full" => $translation->translateLabel('Order Screens'),
    "short" => "Or",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewOrders",
        "full" => $translation->translateLabel('View Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewClosedOrders",
        "full" => $translation->translateLabel('View Closed Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewOrdersHistory",
        "full" => $translation->translateLabel('View Orders History'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewOrdersonHold",
        "full" => $translation->translateLabel('View Orders on Hold'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewOrdersTracking",
        "full" => $translation->translateLabel('View Orders Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewBackorders",
        "full" => $translation->translateLabel('View Backorders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/PickPackOrders",
        "full" => $translation->translateLabel('Pick & Pack Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsReceivable/ShipOrders",
        "full" => $translation->translateLabel('Ship Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsReceivable/InvoiceShippedOrders",
        "full" => $translation->translateLabel('Invoice Shipped Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ViewInvoices",
        "full" => $translation->translateLabel('View Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewClosedInvoices",
        "full" => $translation->translateLabel('View Closed Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewInvoicesHistory",
        "full" => $translation->translateLabel('View Invoices History'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewInvoicesTracking",
        "full" => $translation->translateLabel('View Invoices Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/StoreInvoices",
        "full" => $translation->translateLabel('Store Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/ViewQuotes",
        "full" => $translation->translateLabel('View Quotes'),
        "href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewQuotesTracking",
        "full" => $translation->translateLabel('View Quotes Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/QuoteTrackingHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ServiceProcessing",
    "full" => $translation->translateLabel('Service Processing'),
    "short" => "Se",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewServiceOrders",
        "full" => $translation->translateLabel('View Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/FulfillServiceOrders",
        "full" => $translation->translateLabel('Fulfill Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
        "short" => "Fu"
        ],
        [
        "id" => "AccountsReceivable/PerformServiceOrders",
        "full" => $translation->translateLabel('Perform Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
        "short" => "Pe"
        ],
        [
        "id" => "AccountsReceivable/InvoiceServiceOrders",
        "full" => $translation->translateLabel('Invoice Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ViewServiceInvoices",
        "full" => $translation->translateLabel('View Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ServiceScreens",
    "full" => $translation->translateLabel('Service Screens'),
    "short" => "Se",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewServiceOrders",
        "full" => $translation->translateLabel('View Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ServiceOrdersonHold",
        "full" => $translation->translateLabel('Service Orders on Hold'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList",
        "short" => "Se"
        ],
        [
        "id" => "AccountsReceivable/ClosedServiceOrders",
        "full" => $translation->translateLabel('Closed Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList",
        "short" => "Cl"
        ],
        [
        "id" => "AccountsReceivable/ServiceOrderHistory",
        "full" => $translation->translateLabel('Service Order History'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHistoryList",
        "short" => "Se"
        ],
        [
        "id" => "AccountsReceivable/StoreServiceOrders",
        "full" => $translation->translateLabel('Store Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/FulfillServiceOrders",
        "full" => $translation->translateLabel('Fulfill Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
        "short" => "Fu"
        ],
        [
        "id" => "AccountsReceivable/PerformServiceOrders",
        "full" => $translation->translateLabel('Perform Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
        "short" => "Pe"
        ],
        [
        "id" => "AccountsReceivable/InvoiceServiceOrders",
        "full" => $translation->translateLabel('Invoice Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ViewServiceInvoices",
        "full" => $translation->translateLabel('View Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ClosedServiceInvoices",
        "full" => $translation->translateLabel('Closed Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList",
        "short" => "Cl"
        ],
        [
        "id" => "AccountsReceivable/ServiceInvoiceHistory",
        "full" => $translation->translateLabel('Service Invoice History'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList",
        "short" => "Se"
        ],
        [
        "id" => "AccountsReceivable/StoreServiceInvoices",
        "full" => $translation->translateLabel('Store Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderStoreList",
        "short" => "St"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ProjectsJobs",
    "full" => $translation->translateLabel('Projects & Jobs'),
    "short" => "Pr",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewProjects",
        "full" => $translation->translateLabel('View Projects'),
        "href"=> "EnterpriseASPAR/Projects/ProjectsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ProjectTypes",
        "full" => $translation->translateLabel('Project Types'),
        "href"=> "EnterpriseASPAR/Projects/ProjectTypesList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "CreditMemos",
    "full" => $translation->translateLabel('Credit Memos'),
    "short" => "Cr",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewCreditMemos",
        "full" => $translation->translateLabel('View Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewClosedCreditMemos",
        "full" => $translation->translateLabel('View Closed Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCreditMemoHistory",
        "full" => $translation->translateLabel('View Credit Memo History'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/StoreCreditMemos",
        "full" => $translation->translateLabel('Store Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/IssuePaymentsforCreditMemos",
        "full" => $translation->translateLabel('Issue Payments for Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList",
        "short" => "Is"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "RMAProcessing",
    "full" => $translation->translateLabel('RMA Processing'),
    "short" => "RM",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewRMA",
        "full" => $translation->translateLabel('View RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ApproveRMA",
        "full" => $translation->translateLabel('Approve RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsReceivable/ReceiveRMA",
        "full" => $translation->translateLabel('Receive RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsReceivable/ReceivedRMAs",
        "full" => $translation->translateLabel('Received RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "RMAScreens",
    "full" => $translation->translateLabel('RMA Screens'),
    "short" => "RM",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewRMA",
        "full" => $translation->translateLabel('View RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewClosedRMAs",
        "full" => $translation->translateLabel('View Closed RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewRMAHistory",
        "full" => $translation->translateLabel('View RMA History'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/StoreRMAs",
        "full" => $translation->translateLabel('Store RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/ApproveRMA",
        "full" => $translation->translateLabel('Approve RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsReceivable/ReceiveRMA",
        "full" => $translation->translateLabel('Receive RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsReceivable/ReceivedRMAs",
        "full" => $translation->translateLabel('Received RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "CashReceiptsProcessing",
    "full" => $translation->translateLabel('Cash Receipts Processing'),
    "short" => "Ca",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewCashReceipts",
        "full" => $translation->translateLabel('View Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ProcessCashReceipts",
        "full" => $translation->translateLabel('Process Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "CashReceiptsScreens",
    "full" => $translation->translateLabel('Cash Receipts Screens'),
    "short" => "Ca",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewCashReceipts",
        "full" => $translation->translateLabel('View Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewClosedCashReceipts",
        "full" => $translation->translateLabel('View Closed Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCashReceiptsHistory",
        "full" => $translation->translateLabel('View Cash Receipts History'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/StoreCashReceipts",
        "full" => $translation->translateLabel('Store Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/ProcessCashReceipts",
        "full" => $translation->translateLabel('Process Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Customers",
    "full" => $translation->translateLabel('Customers'),
    "short" => "Cu",
    "data" => [

        [
        "id" => "AccountsReceivable/ViewCustomers",
        "full" => $translation->translateLabel('View Customers'),
        "href"=> "EnterpriseASPAR/Customers/CustomerInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCustomerFinancials",
        "full" => $translation->translateLabel('View Customer Financials'),
        "href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewShipToLocations",
        "full" => $translation->translateLabel('View Ship To Locations'),
        "href"=> "EnterpriseASPAR/Customers/CustomerShipToLocationsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewShipForLocations",
        "full" => $translation->translateLabel('View Ship For Locations'),
        "href"=> "EnterpriseASPAR/Customers/CustomerShipForLocationsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCreditReferences",
        "full" => $translation->translateLabel('View Credit References'),
        "href"=> "EnterpriseASPAR/Customers/CustomerCreditReferencesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCustomerContacts",
        "full" => $translation->translateLabel('View Customer Contacts'),
        "href"=> "EnterpriseASPAR/Customers/CustomerContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewContactLog",
        "full" => $translation->translateLabel('View Contact Log'),
        "href"=> "EnterpriseASPAR/Customers/CustomerContactLogList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewComments",
        "full" => $translation->translateLabel('View Comments'),
        "href"=> "EnterpriseASPAR/Customers/CustomerCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCommentTypes",
        "full" => $translation->translateLabel('View Comment Types'),
        "href"=> "EnterpriseASPAR/Customers/CommentTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewAccountStatus",
        "full" => $translation->translateLabel('View Account Status'),
        "href"=> "EnterpriseASPAR/Customers/CustomerAccountStatusesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewItemXref",
        "full" => $translation->translateLabel('View Item Xref'),
        "href"=> "EnterpriseASPAR/Customers/CustomerItemCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewPriceXref",
        "full" => $translation->translateLabel('View Price Xref'),
        "href"=> "EnterpriseASPAR/Customers/CustomerPriceCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCustomerReferences",
        "full" => $translation->translateLabel('View Customer References'),
        "href"=> "EnterpriseASPAR/Customers/CustomerReferencesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCustomerSatisfactions",
        "full" => $translation->translateLabel('View Customer Satisfactions'),
        "href"=> "EnterpriseASPAR/Customers/CustomerSatisfactionList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ViewCustomerTypes",
        "full" => $translation->translateLabel('View Customer Types'),
        "href"=> "EnterpriseASPAR/Customers/CustomerTypesList",
        "short" => "Vi"
        ]
    ]
    ]
]
];
$menuCategories["AccountsPayable"] = [
"type" => "submenu",
"id" => "AccountsPayable",
"full" => $translation->translateLabel('Accounts Payable'),
"short" => "Ac",
"data" => [

    [
    "type" => "submenu",
    "id" => "PurchaseProcessing",
    "full" => $translation->translateLabel('Purchase Processing'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/ViewPurchases",
        "full" => $translation->translateLabel('View Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ApprovePurchases",
        "full" => $translation->translateLabel('Approve Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/ReceivePurchases",
        "full" => $translation->translateLabel('Receive Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsPayable/ViewReceivedPurchases",
        "full" => $translation->translateLabel('View Received Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PurchaseScreens",
    "full" => $translation->translateLabel('Purchase Screens'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/ViewPurchases",
        "full" => $translation->translateLabel('View Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewClosedPurchases",
        "full" => $translation->translateLabel('View Closed Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPurchasesHistory",
        "full" => $translation->translateLabel('View Purchases History'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/StorePurchases",
        "full" => $translation->translateLabel('Store Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsPayable/ApprovePurchases",
        "full" => $translation->translateLabel('Approve Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/ReceivePurchases",
        "full" => $translation->translateLabel('Receive Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsPayable/ViewReceivedPurchases",
        "full" => $translation->translateLabel('View Received Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PurchaseContracts",
    "full" => $translation->translateLabel('Purchase Contracts'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/ViewPurchasesTracking",
        "full" => $translation->translateLabel('View Purchases Tracking'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPurchaseContracts",
        "full" => $translation->translateLabel('View Purchase Contracts'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPurchaseContractsHistory",
        "full" => $translation->translateLabel('View Purchase Contracts History'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPurchaseContractLedger",
        "full" => $translation->translateLabel('View Purchase Contract Ledger'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPurchaseContractLedgerHistory",
        "full" => $translation->translateLabel('View Purchase Contract Ledger History'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerHistoryList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "VoucherProcessing",
    "full" => $translation->translateLabel('Voucher Processing '),
    "short" => "Vo",
    "data" => [

        [
        "id" => "AccountsPayable/ViewVouchers",
        "full" => $translation->translateLabel('View Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ApproveVouchers",
        "full" => $translation->translateLabel('Approve Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/IssueVouchers",
        "full" => $translation->translateLabel('Issue Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/IssueCreditMemosforVouchers",
        "full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/ThreeWayMatching",
        "full" => $translation->translateLabel('Three Way Matching'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsMatching",
        "short" => "Th"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "VoucherScreens",
    "full" => $translation->translateLabel('Voucher Screens '),
    "short" => "Vo",
    "data" => [

        [
        "id" => "AccountsPayable/ViewVouchers",
        "full" => $translation->translateLabel('View Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoidVouchers",
        "full" => $translation->translateLabel('Void Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidList",
        "short" => "Vo"
        ],
        [
        "id" => "AccountsPayable/ViewVoidedVouchersHistory",
        "full" => $translation->translateLabel('View Voided Vouchers History'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewClosedVouchers",
        "full" => $translation->translateLabel('View Closed Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewVocuhersHistory",
        "full" => $translation->translateLabel('View Vocuhers History'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/StoreVocuhers",
        "full" => $translation->translateLabel('Store Vocuhers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsPayable/ApproveVouchers",
        "full" => $translation->translateLabel('Approve Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/IssuePaymentsforVouchers",
        "full" => $translation->translateLabel('Issue Payments for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/IssueCreditMemosforVouchers",
        "full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
        "short" => "Is"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "DebitMemos",
    "full" => $translation->translateLabel('Debit Memos'),
    "short" => "De",
    "data" => [

        [
        "id" => "AccountsPayable/ViewDebitMemos",
        "full" => $translation->translateLabel('View Debit Memos'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewClosedDebitMemo",
        "full" => $translation->translateLabel('View Closed Debit Memo'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewStoreDebitMemo",
        "full" => $translation->translateLabel('View Store Debit Memo'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderStoreList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewDebitMemoHistory",
        "full" => $translation->translateLabel('View Debit Memo History'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ApplyDebitMemostoPayments",
        "full" => $translation->translateLabel('Apply Debit Memos to Payments'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList",
        "short" => "Ap"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ReturntoVendorProcessing",
    "full" => $translation->translateLabel('Return to Vendor Processing'),
    "short" => "Re",
    "data" => [

        [
        "id" => "AccountsPayable/ViewReturns",
        "full" => $translation->translateLabel('View Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PickPackReturns",
        "full" => $translation->translateLabel('Pick & Pack Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsPayable/ShipReturns",
        "full" => $translation->translateLabel('Ship Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsPayable/InvoiceShippedReturns",
        "full" => $translation->translateLabel('Invoice Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsPayable/ViewReturnInvoices",
        "full" => $translation->translateLabel('View Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewReturnCashReceipts",
        "full" => $translation->translateLabel('View Return Cash Receipts'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ProcessReturnsCashReceipt",
        "full" => $translation->translateLabel('Process Returns Cash Receipt'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ReturntoVendorScreens",
    "full" => $translation->translateLabel('Return to Vendor Screens'),
    "short" => "Re",
    "data" => [

        [
        "id" => "AccountsPayable/ViewReturns",
        "full" => $translation->translateLabel('View Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewClosedReturns",
        "full" => $translation->translateLabel('View Closed Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewReturnHistory",
        "full" => $translation->translateLabel('View Return History'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewShippedReturns",
        "full" => $translation->translateLabel('View Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewStoreReturns",
        "full" => $translation->translateLabel('View Store Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderStoreList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PickPackReturns",
        "full" => $translation->translateLabel('Pick & Pack Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsPayable/ShipReturns",
        "full" => $translation->translateLabel('Ship Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsPayable/InvoiceShippedReturns",
        "full" => $translation->translateLabel('Invoice Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsPayable/ViewReturnInvoices",
        "full" => $translation->translateLabel('View Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewStoreReturnInvoices",
        "full" => $translation->translateLabel('View Store Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderStoreList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewReturnCashReceipts",
        "full" => $translation->translateLabel('View Return Cash Receipts'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ProcessReturnsCashReceipt",
        "full" => $translation->translateLabel('Process Returns Cash Receipt'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Vendors",
    "full" => $translation->translateLabel('Vendors'),
    "short" => "Ve",
    "data" => [

        [
        "id" => "AccountsPayable/ViewVendors",
        "full" => $translation->translateLabel('View Vendors'),
        "href"=> "EnterpriseASPAP/Vendors/VendorInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewVendorFinancials",
        "full" => $translation->translateLabel('View Vendor Financials'),
        "href"=> "EnterpriseASPAP/Vendors/VendorFinancialsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewContacts",
        "full" => $translation->translateLabel('View Contacts'),
        "href"=> "EnterpriseASPAP/Vendors/VendorContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewComments",
        "full" => $translation->translateLabel('View Comments'),
        "href"=> "EnterpriseASPAP/Vendors/VendorCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewAccountStatus",
        "full" => $translation->translateLabel('View Account Status'),
        "href"=> "EnterpriseASPAP/Vendors/VendorAccountStatusesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewAccountTypes",
        "full" => $translation->translateLabel('View Account Types'),
        "href"=> "EnterpriseASPAP/Vendors/VendorTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewItemXref",
        "full" => $translation->translateLabel('View Item Xref'),
        "href"=> "EnterpriseASPAP/Vendors/VendorItemCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ViewPriceXref",
        "full" => $translation->translateLabel('View Price Xref'),
        "href"=> "EnterpriseASPAP/Vendors/VendorPriceCrossReferenceList",
        "short" => "Vi"
        ]
    ]
    ]
]
];
$menuCategories["GeneralLedger"] = [
"type" => "submenu",
"id" => "GeneralLedger",
"full" => $translation->translateLabel('General Ledger'),
"short" => "Ge",
"data" => [

    [
    "type" => "submenu",
    "id" => "Ledger",
    "full" => $translation->translateLabel('Ledger'),
    "short" => "Le",
    "data" => [

        [
        "id" => "GeneralLedger/ViewChartofAccounts",
        "full" => $translation->translateLabel('View Chart of Accounts'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewLedgerAccountGroup",
        "full" => $translation->translateLabel('View Ledger Account Group'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerAccountGroupList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewGLTransactions",
        "full" => $translation->translateLabel('View GL Transactions'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewClosedGLTransactions",
        "full" => $translation->translateLabel('View Closed GL Transactions'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewGLTransactionsHistory",
        "full" => $translation->translateLabel('View GL Transactions History'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/StoreGLTransactions",
        "full" => $translation->translateLabel('Store GL Transactions'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsStoreList",
        "short" => "St"
        ],
        [
        "id" => "GeneralLedger/ViewBudgets",
        "full" => $translation->translateLabel('View Budgets'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsBudgetsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewPriorFiscalYear",
        "full" => $translation->translateLabel('View Prior Fiscal Year'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsPriorYearsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/LedgerTreeviewSample1",
        "full" => $translation->translateLabel('Ledger Treeview Sample1'),
        "href"=> "EnterpriseASPGL/Ledger/GLCOATreeView",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerTreeviewSample2",
        "full" => $translation->translateLabel('Ledger Treeview Sample2'),
        "href"=> "EnterpriseASPGL/Ledger/GLCOATreeViewSample2",
        "short" => "Le"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Banking",
    "full" => $translation->translateLabel('Banking'),
    "short" => "Ba",
    "data" => [

        [
        "id" => "GeneralLedger/ViewBankAccounts",
        "full" => $translation->translateLabel('View Bank Accounts'),
        "href"=> "EnterpriseASPGL/Banking/BankAccountsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewBankAccountsContacts",
        "full" => $translation->translateLabel('View Bank Accounts Contacts'),
        "href"=> "EnterpriseASPGL/Banking/BankAccountsContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ViewBankTransactions",
        "full" => $translation->translateLabel('View Bank Transactions'),
        "href"=> "EnterpriseASPGL/Banking/BankTransactionsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/ReconcileBankAccounts",
        "full" => $translation->translateLabel('Reconcile Bank Accounts'),
        "href"=> "EnterpriseASPGL/Banking/BankReconciliationList",
        "short" => "Re"
        ],
        [
        "id" => "GeneralLedger/ViewBankReconciliations",
        "full" => $translation->translateLabel('View Bank Reconciliations'),
        "href"=> "EnterpriseASPGL/Banking/BankReconciliationSummaryList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "FixedAssets",
    "full" => $translation->translateLabel('Fixed Assets'),
    "short" => "Fi",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "LedgerSetup",
    "full" => $translation->translateLabel('Ledger Setup'),
    "short" => "Le",
    "data" => [

        [
        "id" => "GeneralLedger/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "GeneralLedger/ClosePeriod",
        "full" => $translation->translateLabel('Close Period'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "GeneralLedger/CloseYear",
        "full" => $translation->translateLabel('Close Year'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "GeneralLedger/LedgerTransactionTypes",
        "full" => $translation->translateLabel('Ledger Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerBalanceTypes",
        "full" => $translation->translateLabel('Ledger Balance Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerAccountTypes",
        "full" => $translation->translateLabel('Ledger Account Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/BankTransactionTypes",
        "full" => $translation->translateLabel('Bank Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
        "short" => "Ba"
        ],
        [
        "id" => "GeneralLedger/AssetType",
        "full" => $translation->translateLabel('Asset Type'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
        "short" => "As"
        ],
        [
        "id" => "GeneralLedger/AssetStatus",
        "full" => $translation->translateLabel('Asset Status'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
        "short" => "As"
        ],
        [
        "id" => "GeneralLedger/DepreciationMethods",
        "full" => $translation->translateLabel('Depreciation Methods'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
        "short" => "De"
        ]
    ]
    ]
]
];
$menuCategories["Inventory"] = [
"type" => "submenu",
"id" => "Inventory",
"full" => $translation->translateLabel('Inventory'),
"short" => "In",
"data" => [

    [
    "type" => "submenu",
    "id" => "ItemsStock",
    "full" => $translation->translateLabel('Items & Stock '),
    "short" => "It",
    "data" => [

        [
        "id" => "Inventory/ViewInventoryOnHand",
        "full" => $translation->translateLabel('View Inventory On-Hand'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryByWarehouseList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewInventoryItems",
        "full" => $translation->translateLabel('View Inventory Items'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryItemsList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewItemCategories",
        "full" => $translation->translateLabel('View Item Categories'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryCategoriesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewItemFamilies",
        "full" => $translation->translateLabel('View Item Families'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryFamiliesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewItemTypes",
        "full" => $translation->translateLabel('View Item Types'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryItemTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewSerialNumbers",
        "full" => $translation->translateLabel('View Serial Numbers'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventorySerialNumbersList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewPricingCodes",
        "full" => $translation->translateLabel('View Pricing Codes'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingCodeList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ViewPricingMethods",
        "full" => $translation->translateLabel('View Pricing Methods'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingMethodsList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "InventoryAdjustments",
    "full" => $translation->translateLabel('Inventory Adjustments '),
    "short" => "In",
    "data" => [

        [
        "id" => "Inventory/ViewAdjustments",
        "full" => $translation->translateLabel('View Adjustments'),
        "href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentsList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/InventoryAdjustmentTypes",
        "full" => $translation->translateLabel('Inventory Adjustment Types'),
        "href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentTypesList",
        "short" => "In"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "InventoryTransfers",
    "full" => $translation->translateLabel('Inventory Transfers'),
    "short" => "In",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "WarehouseTransits",
    "full" => $translation->translateLabel('Warehouse Transits'),
    "short" => "Wa",
    "data" => [

        [
        "id" => "Inventory/WarehouseTransits",
        "full" => $translation->translateLabel('Warehouse Transits'),
        "href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderList",
        "short" => "Wa"
        ],
        [
        "id" => "Inventory/WarehouseTransitsHistory",
        "full" => $translation->translateLabel('Warehouse Transits History'),
        "href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderHistoryList",
        "short" => "Wa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ShoppingCartSetup",
    "full" => $translation->translateLabel('Shopping Cart Setup'),
    "short" => "Sh",
    "data" => [

        [
        "id" => "Inventory/CartItemsSetup",
        "full" => $translation->translateLabel('Cart Items Setup'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCartDetail",
        "short" => "Ca"
        ],
        [
        "id" => "Inventory/CategoriesLanguages",
        "full" => $translation->translateLabel('Categories Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
        "short" => "Ca"
        ],
        [
        "id" => "Inventory/FamiliesLanguages",
        "full" => $translation->translateLabel('Families Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
        "short" => "Fa"
        ],
        [
        "id" => "Inventory/ItemsLanguages",
        "full" => $translation->translateLabel('Items Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsCrossSell",
        "full" => $translation->translateLabel('Items Cross Sell'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsNoticifations",
        "full" => $translation->translateLabel('Items Noticifations'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsRelations",
        "full" => $translation->translateLabel('Items Relations'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsReviews",
        "full" => $translation->translateLabel('Items Reviews'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsSubsitiutions",
        "full" => $translation->translateLabel('Items Subsitiutions'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ItemsWishList",
        "full" => $translation->translateLabel('Items Wish List'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
        "short" => "It"
        ]
    ]
    ]
]
];
$menuCategories["MRP"] = [
"type" => "submenu",
"id" => "MRP",
"full" => $translation->translateLabel('MRP'),
"short" => "MR",
"data" => [

    [
    "type" => "submenu",
    "id" => "BillofMaterials",
    "full" => $translation->translateLabel('Bill of Materials'),
    "short" => "Bi",
    "data" => [

        [
        "id" => "MRP/ViewBillOfMaterials",
        "full" => $translation->translateLabel('View Bill Of Materials'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/ViewBuildInstructions",
        "full" => $translation->translateLabel('View Build Instructions'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesInstructionsList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/CreateInventory",
        "full" => $translation->translateLabel('Create Inventory'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryCreateAssembly",
        "short" => "Cr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "WorkOrders",
    "full" => $translation->translateLabel('Work Orders'),
    "short" => "Wo",
    "data" => [

        [
        "id" => "MRP/ViewWorkOrders",
        "full" => $translation->translateLabel('View Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/ViewClosedWorkOrders",
        "full" => $translation->translateLabel('View Closed Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/ViewWorkOrdersHistory",
        "full" => $translation->translateLabel('View Work Orders History'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/StoreWorkOrders",
        "full" => $translation->translateLabel('Store Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderStoreList",
        "short" => "St"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "MRPSetup",
    "full" => $translation->translateLabel('MRP Setup'),
    "short" => "MR",
    "data" => [

        [
        "id" => "MRP/InProgressTypes",
        "full" => $translation->translateLabel('In Progress Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderInProgressList",
        "short" => "In"
        ],
        [
        "id" => "MRP/PriorityTypes",
        "full" => $translation->translateLabel('Priority Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderPriorityList",
        "short" => "Pr"
        ],
        [
        "id" => "MRP/WorkOrderStatuses",
        "full" => $translation->translateLabel('Work Order Statuses'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderStatusList",
        "short" => "Wo"
        ],
        [
        "id" => "MRP/WorkOrderTypes",
        "full" => $translation->translateLabel('Work Order Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderTypesList",
        "short" => "Wo"
        ]
    ]
    ]
]
];
$menuCategories["FundAccounting"] = [
"type" => "submenu",
"id" => "FundAccounting",
"full" => $translation->translateLabel('Fund Accounting'),
"short" => "Fu",
"data" => [

    [
    "type" => "submenu",
    "id" => "ViewJointPayments",
    "full" => $translation->translateLabel('View Joint Payments'),
    "short" => "Vi",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "ApproveJointPayments",
    "full" => $translation->translateLabel('Approve Joint Payments'),
    "short" => "Ap",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "IssueJointPayments",
    "full" => $translation->translateLabel('Issue Joint Payments'),
    "short" => "Is",
    "data" => [
    ]
    ]
]
];
$menuCategories["CRM&HelpDesk"] = [
"type" => "submenu",
"id" => "CRMHelpDesk",
"full" => $translation->translateLabel('CRM & Help Desk'),
"short" => "CR",
"data" => [

    [
    "type" => "submenu",
    "id" => "CRM",
    "full" => $translation->translateLabel('CRM'),
    "short" => "CR",
    "data" => [

        [
        "id" => "CRMHelpDesk/ViewLeads",
        "full" => $translation->translateLabel('View Leads'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewLeadContacts",
        "full" => $translation->translateLabel('View Lead Contacts'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewLeadComments",
        "full" => $translation->translateLabel('View Lead Comments'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewLeadSatisfactions",
        "full" => $translation->translateLabel('View Lead Satisfactions'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadSatisfactionList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewLeadTypes",
        "full" => $translation->translateLabel('View Lead Types'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadTypeList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "HelpDesk",
    "full" => $translation->translateLabel('Help Desk'),
    "short" => "He",
    "data" => [

        [
        "id" => "CRMHelpDesk/ViewNewsItems",
        "full" => $translation->translateLabel('View News Items'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpNewsBoardList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewReleaseDates",
        "full" => $translation->translateLabel('View Release Dates'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpReleaseDatesList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewHeadings",
        "full" => $translation->translateLabel('View Headings'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageHeadingList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewTopics",
        "full" => $translation->translateLabel('View Topics'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageTopicList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewProblemReports",
        "full" => $translation->translateLabel('View Problem Reports'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemReportList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewSupportRequests",
        "full" => $translation->translateLabel('View Support Requests'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewResources",
        "full" => $translation->translateLabel('View Resources'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourcesList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewPriorities",
        "full" => $translation->translateLabel('View Priorities'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpPriorityList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewProblemTypes",
        "full" => $translation->translateLabel('View Problem Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewRequestMethods",
        "full" => $translation->translateLabel('View Request Methods'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpRequestMethodList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewResourceTypes",
        "full" => $translation->translateLabel('View Resource Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourceTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewSeverities",
        "full" => $translation->translateLabel('View Severities'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSeverityList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewStatuses",
        "full" => $translation->translateLabel('View Statuses'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpStatusList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/ViewSupportTypes",
        "full" => $translation->translateLabel('View Support Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
        "short" => "Vi"
        ]
    ]
    ]
]
];
$menuCategories["Payroll"] = [
"type" => "submenu",
"id" => "Payroll",
"full" => $translation->translateLabel('Payroll'),
"short" => "Pa",
"data" => [

    [
    "type" => "submenu",
    "id" => "EmployeeManagement",
    "full" => $translation->translateLabel('Employee Management'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/ViewEmployees",
        "full" => $translation->translateLabel('View Employees'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSecurity",
        "full" => $translation->translateLabel('Employee Security'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeLoginHistory",
        "full" => $translation->translateLabel('Employee Login History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
        "short" => "Em"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "EmployeeExpenses",
    "full" => $translation->translateLabel('Employee Expenses'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/ExpenseReports",
        "full" => $translation->translateLabel('Expense Reports'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/ExpenseReportsHistory",
        "full" => $translation->translateLabel('Expense Reports History'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderHistoryList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/ExpenseReportItems",
        "full" => $translation->translateLabel('Expense Report Items'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportItemsList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/ExpenseReportReasons",
        "full" => $translation->translateLabel('Expense Report Reasons'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportReasonsList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/ExpenseReportTypes",
        "full" => $translation->translateLabel('Expense Report Types'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportTypesList",
        "short" => "Ex"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "EmployeeSetup",
    "full" => $translation->translateLabel('Employee Setup'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/ViewEmployees",
        "full" => $translation->translateLabel('View Employees'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeTypes",
        "full" => $translation->translateLabel('Employee Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeePayType",
        "full" => $translation->translateLabel('Employee Pay Type'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeePayFrequency",
        "full" => $translation->translateLabel('Employee Pay Frequency'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayFrequencyList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeStatus",
        "full" => $translation->translateLabel('Employee Status'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeDepartment",
        "full" => $translation->translateLabel('Employee Department'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeDepartmentList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/ViewTaskList",
        "full" => $translation->translateLabel('View Task List'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewTaskPriorities",
        "full" => $translation->translateLabel('View Task Priorities'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskPriorityList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewTaskTypes",
        "full" => $translation->translateLabel('View Task Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeStatusTypes",
        "full" => $translation->translateLabel('Employee Status Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/ViewEmployeeAccruals",
        "full" => $translation->translateLabel('View Employee Accruals'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewAccrualFrequencies",
        "full" => $translation->translateLabel('View Accrual Frequencies'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualFrequencyList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewAccrualTypes",
        "full" => $translation->translateLabel('View Accrual Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewPayrollEmails",
        "full" => $translation->translateLabel('View Payroll Emails'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmailMessagesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewPayrollInstantMessages",
        "full" => $translation->translateLabel('View Payroll Instant Messages'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollInstantMessagesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeeEmails",
        "full" => $translation->translateLabel('View Employee Emails'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeEmailMessageList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeeInstantMessages",
        "full" => $translation->translateLabel('View Employee Instant Messages'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeInstantMessageList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeesCalendar",
        "full" => $translation->translateLabel('View Employees Calendar'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCalendarList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeesCurrentlyOn",
        "full" => $translation->translateLabel('View Employees Currently On'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCurrentlyOnList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeesEvents",
        "full" => $translation->translateLabel('View Employees Events'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventsList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeesEventTypes",
        "full" => $translation->translateLabel('View Employees Event Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/ViewEmployeesTimesheets",
        "full" => $translation->translateLabel('View Employees Timesheets'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesTimesheetHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PayrollProcessing",
    "full" => $translation->translateLabel('Payroll Processing'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayEmployees",
        "full" => $translation->translateLabel('Pay Employees'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollPayEmployees",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollRegister",
        "full" => $translation->translateLabel('Payroll Register'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollRegisterList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollChecks",
        "full" => $translation->translateLabel('Payroll Checks'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollChecksList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollCheckTypes",
        "full" => $translation->translateLabel('Payroll Check Types'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollCheckTypeList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PayrollTaxes",
    "full" => $translation->translateLabel('Payroll Taxes'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayrollItemsMaster",
        "full" => $translation->translateLabel('Payroll Items Master'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollItemsMasterList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollFedTax",
        "full" => $translation->translateLabel('Payroll Fed Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollFedTaxTables",
        "full" => $translation->translateLabel('Payroll Fed Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollStateTax",
        "full" => $translation->translateLabel('Payroll State Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollStateTaxTables",
        "full" => $translation->translateLabel('Payroll State Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollCountyTax",
        "full" => $translation->translateLabel('Payroll County Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollCountyTaxTables",
        "full" => $translation->translateLabel('Payroll County Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollCityTax",
        "full" => $translation->translateLabel('Payroll City Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollCityTaxTables",
        "full" => $translation->translateLabel('Payroll City Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxTablesList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PayrollSetup",
    "full" => $translation->translateLabel('Payroll Setup'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayrollSetup",
        "full" => $translation->translateLabel('Payroll Setup'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollSetupList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollItems",
        "full" => $translation->translateLabel('Payroll Items'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemsList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollItemTypes",
        "full" => $translation->translateLabel('Payroll Item Types'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemTypesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollItemBasis",
        "full" => $translation->translateLabel('Payroll Item Basis'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemBasisList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/W2Details",
        "full" => $translation->translateLabel('W2 Details'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW2DetailList",
        "short" => "W2"
        ],
        [
        "id" => "Payroll/W3Details",
        "full" => $translation->translateLabel('W3 Details'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW3DetailList",
        "short" => "W3"
        ]
    ]
    ]
]
];
$menuCategories["SystemSetup"] = [
"type" => "submenu",
"id" => "SystemSetup",
"full" => $translation->translateLabel('System Setup'),
"short" => "Sy",
"data" => [

    [
    "type" => "submenu",
    "id" => "CompanySetup",
    "full" => $translation->translateLabel('Company Setup'),
    "short" => "Co",
    "data" => [

        [
        "id" => "SystemSetup/CompanySetup",
        "full" => $translation->translateLabel('Company Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanyDisplayLanguages",
        "full" => $translation->translateLabel('Company Display Languages'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesDisplayLangList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/SystemWideMessage",
        "full" => $translation->translateLabel('System Wide Message'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesSystemWideMessageDetail",
        "short" => "Sy"
        ],
        [
        "id" => "SystemSetup/CompanyWorkflowByEmployees",
        "full" => $translation->translateLabel('Company Workflow By Employees'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkflowByEmployeesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanyWorkflowTypes",
        "full" => $translation->translateLabel('Company Workflow Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkFlowTypesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/DivisionSetup",
        "full" => $translation->translateLabel('Division Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/DivisionsList",
        "short" => "Di"
        ],
        [
        "id" => "SystemSetup/DepartmentSetup",
        "full" => $translation->translateLabel('Department Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/DepartmentsList",
        "short" => "De"
        ],
        [
        "id" => "SystemSetup/CompanyIDNumbers",
        "full" => $translation->translateLabel('Company ID Numbers'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesNextNumbersList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CreditCardTypes",
        "full" => $translation->translateLabel('Credit Card Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CreditCardTypesList",
        "short" => "Cr"
        ],
        [
        "id" => "SystemSetup/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "SystemSetup/TaxItems",
        "full" => $translation->translateLabel('Tax Items'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxesList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/TaxGroupDetails",
        "full" => $translation->translateLabel('Tax Group Details'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupDetailList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/TaxGroups",
        "full" => $translation->translateLabel('Tax Groups'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupsList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/Terms",
        "full" => $translation->translateLabel('Terms'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TermsList",
        "short" => "Te"
        ],
        [
        "id" => "SystemSetup/POSSetup",
        "full" => $translation->translateLabel('POS Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/POSSetupDetail",
        "short" => "PO"
        ],
        [
        "id" => "SystemSetup/ShipmentMethods",
        "full" => $translation->translateLabel('Shipment Methods'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ShipmentMethodsList",
        "short" => "Sh"
        ],
        [
        "id" => "SystemSetup/Warehouses",
        "full" => $translation->translateLabel('Warehouses'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehousesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/WarehouseBins",
        "full" => $translation->translateLabel('Warehouse Bins'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinsList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/WarehouseBinTypes",
        "full" => $translation->translateLabel('Warehouse Bin Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinTypesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/WarehouseBinZones",
        "full" => $translation->translateLabel('Warehouse Bin Zones'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinZonesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/WarehouseContacts",
        "full" => $translation->translateLabel('Warehouse Contacts'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehousesContactsList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/ContactIndustries",
        "full" => $translation->translateLabel('Contact Industries'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactIndustryList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/ContactRegions",
        "full" => $translation->translateLabel('Contact Regions'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactRegionsList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/ContactSources",
        "full" => $translation->translateLabel('Contact Sources'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactSourceList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/ContactTypes",
        "full" => $translation->translateLabel('Contact Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactTypeList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/TranslationTable",
        "full" => $translation->translateLabel('Translation Table'),
        "href"=> "EnterpriseASPSystem/CompanySetup/Translation",
        "short" => "Tr"
        ],
        [
        "id" => "SystemSetup/TimeUnits",
        "full" => $translation->translateLabel('Time Units'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TimeUnitsList",
        "short" => "Ti"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SecuritySetup",
    "full" => $translation->translateLabel('Security Setup'),
    "short" => "Se",
    "data" => [

        [
        "id" => "SystemSetup/SecuritySetup",
        "full" => $translation->translateLabel('Security Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
        "short" => "Se"
        ],
        [
        "id" => "SystemSetup/UnlockRecords",
        "full" => $translation->translateLabel('Unlock Records'),
        "href"=> "EnterpriseASPSystem/CompanySetup/Unlock",
        "short" => "Un"
        ],
        [
        "id" => "SystemSetup/SystemErrorLog",
        "full" => $translation->translateLabel('System Error Log'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ErrorLogList",
        "short" => "Sy"
        ],
        [
        "id" => "SystemSetup/AuditDescription",
        "full" => $translation->translateLabel('Audit Description'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTablesDescriptionList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/AuditTrail",
        "full" => $translation->translateLabel('Audit Trail'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/AuditTrailHistory",
        "full" => $translation->translateLabel('Audit Trail History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailHistoryList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/AuditLogin",
        "full" => $translation->translateLabel('Audit Login'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/AuditLoginHistory",
        "full" => $translation->translateLabel('Audit Login History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
        "short" => "Au"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "LedgerSetup",
    "full" => $translation->translateLabel('Ledger Setup'),
    "short" => "Le",
    "data" => [

        [
        "id" => "SystemSetup/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "SystemSetup/ClosePeriod",
        "full" => $translation->translateLabel('Close Period'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "SystemSetup/CloseYear",
        "full" => $translation->translateLabel('Close Year'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "SystemSetup/LedgerTransactionTypes",
        "full" => $translation->translateLabel('Ledger Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/LedgerBalanceTypes",
        "full" => $translation->translateLabel('Ledger Balance Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/LedgerAccountTypes",
        "full" => $translation->translateLabel('Ledger Account Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/BankTransactionTypes",
        "full" => $translation->translateLabel('Bank Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
        "short" => "Ba"
        ],
        [
        "id" => "SystemSetup/AssetType",
        "full" => $translation->translateLabel('Asset Type'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
        "short" => "As"
        ],
        [
        "id" => "SystemSetup/AssetStatus",
        "full" => $translation->translateLabel('Asset Status'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
        "short" => "As"
        ],
        [
        "id" => "SystemSetup/DepreciationMethods",
        "full" => $translation->translateLabel('Depreciation Methods'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
        "short" => "De"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivableSetup",
    "full" => $translation->translateLabel('Accounts Receivable Setup'),
    "short" => "Ac",
    "data" => [

        [
        "id" => "SystemSetup/ARTransactionTypes",
        "full" => $translation->translateLabel('AR Transaction Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ARTransactionTypesList",
        "short" => "AR"
        ],
        [
        "id" => "SystemSetup/ContractTypes",
        "full" => $translation->translateLabel('Contract Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ContractTypesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/OrderTypes",
        "full" => $translation->translateLabel('Order Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/OrderTypesList",
        "short" => "Or"
        ],
        [
        "id" => "SystemSetup/ReceiptTypes",
        "full" => $translation->translateLabel('Receipt Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptTypesList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/ReceiptClasses",
        "full" => $translation->translateLabel('Receipt Classes'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptClassList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/ReceiptMethods",
        "full" => $translation->translateLabel('Receipt Methods'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptMethodsList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/SalesGroups",
        "full" => $translation->translateLabel('Sales Groups'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/SalesGroupList",
        "short" => "Sa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayableSetup",
    "full" => $translation->translateLabel('Accounts Payable Setup'),
    "short" => "Ac",
    "data" => [

        [
        "id" => "SystemSetup/APTransactionTypes",
        "full" => $translation->translateLabel('AP Transaction Types'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/APTransactionTypesList",
        "short" => "AP"
        ],
        [
        "id" => "SystemSetup/PaymentClasses",
        "full" => $translation->translateLabel('Payment Classes'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentClassesList",
        "short" => "Pa"
        ],
        [
        "id" => "SystemSetup/PaymentTypes",
        "full" => $translation->translateLabel('Payment Types'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentTypesList",
        "short" => "Pa"
        ],
        [
        "id" => "SystemSetup/PaymentMethods",
        "full" => $translation->translateLabel('Payment Methods'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentMethodsList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "EDISetup",
    "full" => $translation->translateLabel('EDI Setup '),
    "short" => "ED",
    "data" => [

        [
        "id" => "SystemSetup/EDISetup",
        "full" => $translation->translateLabel('EDI Setup'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDISetupList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDIDocumentTypes",
        "full" => $translation->translateLabel('EDI Document Types'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIDocumentTypesList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDIDocumentDirections",
        "full" => $translation->translateLabel('EDI Document Directions'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIDirectionList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDIExceptions",
        "full" => $translation->translateLabel('EDI Exceptions'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionsList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDIExceptionTypes",
        "full" => $translation->translateLabel('EDI Exception Types'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionTypesList",
        "short" => "ED"
        ]
    ]
    ]
]
];
$menuCategories["Reports"] = [
"type" => "submenu",
"id" => "Reports",
"full" => $translation->translateLabel('Reports'),
"short" => "Re",
"data" => [

    [
    "type" => "submenu",
    "id" => "Financials",
    "full" => $translation->translateLabel('Financials'),
    "short" => "Fi",
    "data" => [

        [
        "id" => "Reports/ExcelWorksheets",
        "full" => $translation->translateLabel('Excel Worksheets'),
        "href"=> "reports/Worksheets/Worksheet",
        "short" => "Ex"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivableReports",
    "full" => $translation->translateLabel('Accounts Receivable Reports'),
    "short" => "Ac",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayableReports",
    "full" => $translation->translateLabel('Accounts Payable Reports'),
    "short" => "Ac",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "LedgerReports",
    "full" => $translation->translateLabel('Ledger Reports'),
    "short" => "Le",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "InventoryReports",
    "full" => $translation->translateLabel('Inventory Reports'),
    "short" => "In",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "CRMReports",
    "full" => $translation->translateLabel('CRM Reports'),
    "short" => "CR",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "PayrollReports",
    "full" => $translation->translateLabel('Payroll Reports'),
    "short" => "Pa",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SetupReports",
    "full" => $translation->translateLabel('Setup Reports'),
    "short" => "Se",
    "data" => [
    ]
    ]
]
];
?>