<?php 
$menuCategories["AccountsReceivable"] = [
"type" => "submenu",
"id" => "AccountsReceivable",
"full" => $translation->translateLabel('Accounts Receivable'),
"short" => "Ac",
"data" => [
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/Customers",
    "full" => $translation->translateLabel('Customers'),
    "short" => "Cu",
    "data" => [
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerFinancials",
        "full" => $translation->translateLabel('View Customer Financials'),
        "href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomers",
        "full" => $translation->translateLabel('View Customers'),
        "href"=> "EnterpriseASPAR/Customers/CustomerInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewShipToLocations",
        "full" => $translation->translateLabel('View Ship To Locations'),
        "href"=> "EnterpriseASPAR/Customers/CustomerShipToLocationsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewShipForLocations",
        "full" => $translation->translateLabel('View Ship For Locations'),
        "href"=> "EnterpriseASPAR/Customers/CustomerShipForLocationsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCreditReferences",
        "full" => $translation->translateLabel('View Credit References'),
        "href"=> "EnterpriseASPAR/Customers/CustomerCreditReferencesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerContacts",
        "full" => $translation->translateLabel('View Customer Contacts'),
        "href"=> "EnterpriseASPAR/Customers/CustomerContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewContactLog",
        "full" => $translation->translateLabel('View Contact Log'),
        "href"=> "EnterpriseASPAR/Customers/CustomerContactLogList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewComments",
        "full" => $translation->translateLabel('View Comments'),
        "href"=> "EnterpriseASPAR/Customers/CustomerCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCommentTypes",
        "full" => $translation->translateLabel('View Comment Types'),
        "href"=> "EnterpriseASPAR/Customers/CommentTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewAccountStatus",
        "full" => $translation->translateLabel('View Account Status'),
        "href"=> "EnterpriseASPAR/Customers/CustomerAccountStatusesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewItemXref",
        "full" => $translation->translateLabel('View Item Xref'),
        "href"=> "EnterpriseASPAR/Customers/CustomerItemCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewPriceXref",
        "full" => $translation->translateLabel('View Price Xref'),
        "href"=> "EnterpriseASPAR/Customers/CustomerPriceCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerReferences",
        "full" => $translation->translateLabel('View Customer References'),
        "href"=> "EnterpriseASPAR/Customers/CustomerReferencesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerSatisfactions",
        "full" => $translation->translateLabel('View Customer Satisfactions'),
        "href"=> "EnterpriseASPAR/Customers/CustomerSatisfactionList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerTypes",
        "full" => $translation->translateLabel('View Customer Types'),
        "href"=> "EnterpriseASPAR/Customers/CustomerTypesList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/OrderProcessing",
    "full" => $translation->translateLabel('Order Processing'),
    "short" => "Or",
    "data" => [

        [
        "id" => "AccountsReceivable/OrderProcessing/ViewOrders",
        "full" => $translation->translateLabel('View Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderProcessing/PickPackOrders",
        "full" => $translation->translateLabel('Pick & Pack Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsReceivable/OrderProcessing/ShipOrders",
        "full" => $translation->translateLabel('Ship Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsReceivable/OrderProcessing/InvoiceShippedOrders",
        "full" => $translation->translateLabel('Invoice Shipped Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/OrderProcessing/ViewInvoices",
        "full" => $translation->translateLabel('View Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/OrderScreens",
    "full" => $translation->translateLabel('Order Screens'),
    "short" => "Or",
    "data" => [

        [
        "id" => "AccountsReceivable/OrderScreens/ViewOrders",
        "full" => $translation->translateLabel('View Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewClosedOrders",
        "full" => $translation->translateLabel('View Closed Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewOrdersHistory",
        "full" => $translation->translateLabel('View Orders History'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewOrdersonHold",
        "full" => $translation->translateLabel('View Orders on Hold'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewOrdersTracking",
        "full" => $translation->translateLabel('View Orders Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewBackorders",
        "full" => $translation->translateLabel('View Backorders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/PickPackOrders",
        "full" => $translation->translateLabel('Pick & Pack Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ShipOrders",
        "full" => $translation->translateLabel('Ship Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/InvoiceShippedOrders",
        "full" => $translation->translateLabel('Invoice Shipped Orders'),
        "href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewInvoices",
        "full" => $translation->translateLabel('View Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewClosedInvoices",
        "full" => $translation->translateLabel('View Closed Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewInvoicesHistory",
        "full" => $translation->translateLabel('View Invoices History'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewInvoicesTracking",
        "full" => $translation->translateLabel('View Invoices Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewQuotes",
        "full" => $translation->translateLabel('View Quotes'),
        "href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/OrderScreens/ViewQuotesTracking",
        "full" => $translation->translateLabel('View Quotes Tracking'),
        "href"=> "EnterpriseASPAR/OrderProcessing/QuoteTrackingHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/ServiceProcessing",
    "full" => $translation->translateLabel('Service Processing'),
    "short" => "Se",
    "data" => [

        [
        "id" => "AccountsReceivable/ServiceProcessing/ViewServiceOrders",
        "full" => $translation->translateLabel('View Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ServiceProcessing/FulfillServiceOrders",
        "full" => $translation->translateLabel('Fulfill Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
        "short" => "Fu"
        ],
        [
        "id" => "AccountsReceivable/ServiceProcessing/PerformServiceOrders",
        "full" => $translation->translateLabel('Perform Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
        "short" => "Pe"
        ],
        [
        "id" => "AccountsReceivable/ServiceProcessing/InvoiceServiceOrders",
        "full" => $translation->translateLabel('Invoice Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ServiceProcessing/ViewServiceInvoices",
        "full" => $translation->translateLabel('View Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/ServiceScreens",
    "full" => $translation->translateLabel('Service Screens'),
    "short" => "Se",
    "data" => [

        [
        "id" => "AccountsReceivable/ServiceScreens/ViewServiceOrders",
        "full" => $translation->translateLabel('View Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ServiceOrdersonHold",
        "full" => $translation->translateLabel('Service Orders on Hold'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList",
        "short" => "Se"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ClosedServiceOrders",
        "full" => $translation->translateLabel('Closed Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList",
        "short" => "Cl"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ServiceOrderHistory",
        "full" => $translation->translateLabel('Service Order History'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHistoryList",
        "short" => "Se"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/FulfillServiceOrders",
        "full" => $translation->translateLabel('Fulfill Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
        "short" => "Fu"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/PerformServiceOrders",
        "full" => $translation->translateLabel('Perform Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
        "short" => "Pe"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/InvoiceServiceOrders",
        "full" => $translation->translateLabel('Invoice Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ViewServiceInvoices",
        "full" => $translation->translateLabel('View Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ClosedServiceInvoices",
        "full" => $translation->translateLabel('Closed Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList",
        "short" => "Cl"
        ],
        [
        "id" => "AccountsReceivable/ServiceScreens/ServiceInvoiceHistory",
        "full" => $translation->translateLabel('Service Invoice History'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList",
        "short" => "Se"
        ],
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/ProjectsJobs",
    "full" => $translation->translateLabel('Projects & Jobs'),
    "short" => "Pr",
    "data" => [

        [
        "id" => "AccountsReceivable/ProjectsJobs/ViewProjects",
        "full" => $translation->translateLabel('View Projects'),
        "href"=> "EnterpriseASPAR/Projects/ProjectsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/ProjectsJobs/ProjectTypes",
        "full" => $translation->translateLabel('Project Types'),
        "href"=> "EnterpriseASPAR/Projects/ProjectTypesList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/CreditMemos",
    "full" => $translation->translateLabel('Credit Memos'),
    "short" => "Cr",
    "data" => [

        [
        "id" => "AccountsReceivable/CreditMemos/ViewCreditMemos",
        "full" => $translation->translateLabel('View Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CreditMemos/ViewClosedCreditMemos",
        "full" => $translation->translateLabel('View Closed Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CreditMemos/ViewCreditMemoHistory",
        "full" => $translation->translateLabel('View Credit Memo History'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CreditMemos/IssuePaymentsforCreditMemos",
        "full" => $translation->translateLabel('Issue Payments for Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList",
        "short" => "Is"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/RMAProcessing",
    "full" => $translation->translateLabel('RMA Processing'),
    "short" => "RM",
    "data" => [

        [
        "id" => "AccountsReceivable/RMAProcessing/ViewRMA",
        "full" => $translation->translateLabel('View RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/RMAProcessing/ApproveRMA",
        "full" => $translation->translateLabel('Approve RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsReceivable/RMAProcessing/ReceiveRMA",
        "full" => $translation->translateLabel('Receive RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsReceivable/RMAProcessing/ReceivedRMAs",
        "full" => $translation->translateLabel('Received RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/RMAScreens",
    "full" => $translation->translateLabel('RMA Screens'),
    "short" => "RM",
    "data" => [

        [
        "id" => "AccountsReceivable/RMAScreens/ViewRMA",
        "full" => $translation->translateLabel('View RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/RMAScreens/ViewClosedRMAs",
        "full" => $translation->translateLabel('View Closed RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/RMAScreens/ViewRMAHistory",
        "full" => $translation->translateLabel('View RMA History'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/RMAScreens/ApproveRMA",
        "full" => $translation->translateLabel('Approve RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsReceivable/RMAScreens/ReceiveRMA",
        "full" => $translation->translateLabel('Receive RMA'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsReceivable/RMAScreens/ReceivedRMAs",
        "full" => $translation->translateLabel('Received RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/CashReceiptsProcessing",
    "full" => $translation->translateLabel('Cash Receipts Processing'),
    "short" => "Ca",
    "data" => [

        [
        "id" => "AccountsReceivable/CashReceiptsProcessing/ViewCashReceipts",
        "full" => $translation->translateLabel('View Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CashReceiptsProcessing/ProcessCashReceipts",
        "full" => $translation->translateLabel('Process Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/CashReceiptsScreens",
    "full" => $translation->translateLabel('Cash Receipts Screens'),
    "short" => "Ca",
    "data" => [

        [
        "id" => "AccountsReceivable/CashReceiptsScreens/ViewCashReceipts",
        "full" => $translation->translateLabel('View Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CashReceiptsScreens/ViewClosedCashReceipts",
        "full" => $translation->translateLabel('View Closed Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CashReceiptsScreens/ViewCashReceiptsHistory",
        "full" => $translation->translateLabel('View Cash Receipts History'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/CashReceiptsScreens/ProcessCashReceipts",
        "full" => $translation->translateLabel('Process Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
        "short" => "Pr"
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
    "id" => "AccountsPayable/Vendors",
    "full" => $translation->translateLabel('Vendors'),
    "short" => "Ve",
    "data" => [
        [
        "id" => "AccountsPayable/Vendors/ViewVendorFinancials",
        "full" => $translation->translateLabel('View Vendor Financials'),
        "href"=> "EnterpriseASPAP/Vendors/VendorFinancialsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewVendors",
        "full" => $translation->translateLabel('View Vendors'),
        "href"=> "EnterpriseASPAP/Vendors/VendorInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewContacts",
        "full" => $translation->translateLabel('View Contacts'),
        "href"=> "EnterpriseASPAP/Vendors/VendorContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewComments",
        "full" => $translation->translateLabel('View Comments'),
        "href"=> "EnterpriseASPAP/Vendors/VendorCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewAccountStatus",
        "full" => $translation->translateLabel('View Account Status'),
        "href"=> "EnterpriseASPAP/Vendors/VendorAccountStatusesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewAccountTypes",
        "full" => $translation->translateLabel('View Account Types'),
        "href"=> "EnterpriseASPAP/Vendors/VendorTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewItemXref",
        "full" => $translation->translateLabel('View Item Xref'),
        "href"=> "EnterpriseASPAP/Vendors/VendorItemCrossReferenceList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewPriceXref",
        "full" => $translation->translateLabel('View Price Xref'),
        "href"=> "EnterpriseASPAP/Vendors/VendorPriceCrossReferenceList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/PurchaseProcessing",
    "full" => $translation->translateLabel('Purchase Processing'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/PurchaseProcessing/ViewPurchases",
        "full" => $translation->translateLabel('View Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseProcessing/ApprovePurchases",
        "full" => $translation->translateLabel('Approve Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/PurchaseProcessing/ReceivePurchases",
        "full" => $translation->translateLabel('Receive Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsPayable/PurchaseProcessing/ViewReceivedPurchases",
        "full" => $translation->translateLabel('View Received Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/PurchaseScreens",
    "full" => $translation->translateLabel('Purchase Screens'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/PurchaseScreens/ViewPurchases",
        "full" => $translation->translateLabel('View Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseScreens/ViewClosedPurchases",
        "full" => $translation->translateLabel('View Closed Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseScreens/ViewPurchasesHistory",
        "full" => $translation->translateLabel('View Purchases History'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseScreens/ApprovePurchases",
        "full" => $translation->translateLabel('Approve Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/PurchaseScreens/ReceivePurchases",
        "full" => $translation->translateLabel('Receive Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
        "short" => "Re"
        ],
        [
        "id" => "AccountsPayable/PurchaseScreens/ViewReceivedPurchases",
        "full" => $translation->translateLabel('View Received Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/PurchaseContracts",
    "full" => $translation->translateLabel('Purchase Contracts'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "AccountsPayable/PurchaseContracts/ViewPurchasesTracking",
        "full" => $translation->translateLabel('View Purchases Tracking'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseTrackingHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseContracts/ViewPurchaseContracts",
        "full" => $translation->translateLabel('View Purchase Contracts'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseContracts/ViewPurchaseContractsHistory",
        "full" => $translation->translateLabel('View Purchase Contracts History'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseContracts/ViewPurchaseContractLedger",
        "full" => $translation->translateLabel('View Purchase Contract Ledger'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/PurchaseContracts/ViewPurchaseContractLedgerHistory",
        "full" => $translation->translateLabel('View Purchase Contract Ledger History'),
        "href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerHistoryList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/VoucherProcessing",
    "full" => $translation->translateLabel('Voucher Processing '),
    "short" => "Vo",
    "data" => [

        [
        "id" => "AccountsPayable/VoucherProcessing/ViewVouchers",
        "full" => $translation->translateLabel('View Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoucherProcessing/ApproveVouchers",
        "full" => $translation->translateLabel('Approve Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/VoucherProcessing/IssueVouchers",
        "full" => $translation->translateLabel('Issue Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/VoucherProcessing/IssueCreditMemosforVouchers",
        "full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/VoucherProcessing/ThreeWayMatching",
        "full" => $translation->translateLabel('Three Way Matching'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsMatching",
        "short" => "Th"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/VoucherScreens",
    "full" => $translation->translateLabel('Voucher Screens '),
    "short" => "Vo",
    "data" => [

        [
        "id" => "AccountsPayable/VoucherScreens/ViewVouchers",
        "full" => $translation->translateLabel('View Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/VoidVouchers",
        "full" => $translation->translateLabel('Void Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidList",
        "short" => "Vo"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/ViewVoidedVouchersHistory",
        "full" => $translation->translateLabel('View Voided Vouchers History'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/ViewClosedVouchers",
        "full" => $translation->translateLabel('View Closed Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/ViewVocuhersHistory",
        "full" => $translation->translateLabel('View Vocuhers History'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/ApproveVouchers",
        "full" => $translation->translateLabel('Approve Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
        "short" => "Ap"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/IssuePaymentsforVouchers",
        "full" => $translation->translateLabel('Issue Payments for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
        "short" => "Is"
        ],
        [
        "id" => "AccountsPayable/VoucherScreens/IssueCreditMemosforVouchers",
        "full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
        "short" => "Is"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/DebitMemos",
    "full" => $translation->translateLabel('Debit Memos'),
    "short" => "De",
    "data" => [

        [
        "id" => "AccountsPayable/DebitMemos/ViewDebitMemos",
        "full" => $translation->translateLabel('View Debit Memos'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/DebitMemos/ViewClosedDebitMemo",
        "full" => $translation->translateLabel('View Closed Debit Memo'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/DebitMemos/ViewDebitMemoHistory",
        "full" => $translation->translateLabel('View Debit Memo History'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/DebitMemos/ApplyDebitMemostoPayments",
        "full" => $translation->translateLabel('Apply Debit Memos to Payments'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList",
        "short" => "Ap"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/ReturntoVendorProcessing",
    "full" => $translation->translateLabel('Return to Vendor Processing'),
    "short" => "Re",
    "data" => [

        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/ViewReturns",
        "full" => $translation->translateLabel('View Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/PickPackReturns",
        "full" => $translation->translateLabel('Pick & Pack Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/ShipReturns",
        "full" => $translation->translateLabel('Ship Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/InvoiceShippedReturns",
        "full" => $translation->translateLabel('Invoice Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/ViewReturnInvoices",
        "full" => $translation->translateLabel('View Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/ViewReturnCashReceipts",
        "full" => $translation->translateLabel('View Return Cash Receipts'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorProcessing/ProcessReturnsCashReceipt",
        "full" => $translation->translateLabel('Process Returns Cash Receipt'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/ReturntoVendorScreens",
    "full" => $translation->translateLabel('Return to Vendor Screens'),
    "short" => "Re",
    "data" => [

        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewReturns",
        "full" => $translation->translateLabel('View Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewClosedReturns",
        "full" => $translation->translateLabel('View Closed Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewReturnHistory",
        "full" => $translation->translateLabel('View Return History'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewShippedReturns",
        "full" => $translation->translateLabel('View Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/PickPackReturns",
        "full" => $translation->translateLabel('Pick & Pack Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
        "short" => "Pi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ShipReturns",
        "full" => $translation->translateLabel('Ship Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
        "short" => "Sh"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/InvoiceShippedReturns",
        "full" => $translation->translateLabel('Invoice Shipped Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
        "short" => "In"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewReturnInvoices",
        "full" => $translation->translateLabel('View Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewReturnCashReceipts",
        "full" => $translation->translateLabel('View Return Cash Receipts'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/ReturntoVendorScreens/ProcessReturnsCashReceipt",
        "full" => $translation->translateLabel('Process Returns Cash Receipt'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
        "short" => "Pr"
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
    "id" => "Inventory/ItemsStock",
    "full" => $translation->translateLabel('Items & Stock '),
    "short" => "It",
    "data" => [

        [
        "id" => "Inventory/ItemsStock/ViewInventoryOnHand",
        "full" => $translation->translateLabel('View Inventory On-Hand'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryByWarehouseList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewInventoryItems",
        "full" => $translation->translateLabel('View Inventory Items'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryItemsList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewItemCategories",
        "full" => $translation->translateLabel('View Item Categories'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryCategoriesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewItemFamilies",
        "full" => $translation->translateLabel('View Item Families'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryFamiliesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewItemTypes",
        "full" => $translation->translateLabel('View Item Types'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryItemTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewSerialNumbers",
        "full" => $translation->translateLabel('View Serial Numbers'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventorySerialNumbersList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewPricingCodes",
        "full" => $translation->translateLabel('View Pricing Codes'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingCodeList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/ItemsStock/ViewPricingMethods",
        "full" => $translation->translateLabel('View Pricing Methods'),
        "href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingMethodsList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Inventory/InventoryAdjustments",
    "full" => $translation->translateLabel('Inventory Adjustments '),
    "short" => "In",
    "data" => [

        [
        "id" => "Inventory/InventoryAdjustments/ViewAdjustments",
        "full" => $translation->translateLabel('View Adjustments'),
        "href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentsList",
        "short" => "Vi"
        ],
        [
        "id" => "Inventory/InventoryAdjustments/InventoryAdjustmentTypes",
        "full" => $translation->translateLabel('Inventory Adjustment Types'),
        "href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentTypesList",
        "short" => "In"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Inventory/InventoryTransfers",
    "full" => $translation->translateLabel('Inventory Transfers'),
    "short" => "In",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Inventory/WarehouseTransits",
    "full" => $translation->translateLabel('Warehouse Transits'),
    "short" => "Wa",
    "data" => [

        [
        "id" => "Inventory/WarehouseTransits/WarehouseTransits",
        "full" => $translation->translateLabel('Warehouse Transits'),
        "href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderList",
        "short" => "Wa"
        ],
        [
        "id" => "Inventory/WarehouseTransits/WarehouseTransitsHistory",
        "full" => $translation->translateLabel('Warehouse Transits History'),
        "href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderHistoryList",
        "short" => "Wa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Inventory/ShoppingCartSetup",
    "full" => $translation->translateLabel('Shopping Cart Setup'),
    "short" => "Sh",
    "data" => [

        [
        "id" => "Inventory/ShoppingCartSetup/CartItemsSetup",
        "full" => $translation->translateLabel('Cart Items Setup'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCartDetail",
        "short" => "Ca"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/CategoriesLanguages",
        "full" => $translation->translateLabel('Categories Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
        "short" => "Ca"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/FamiliesLanguages",
        "full" => $translation->translateLabel('Families Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
        "short" => "Fa"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsLanguages",
        "full" => $translation->translateLabel('Items Languages'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsCrossSell",
        "full" => $translation->translateLabel('Items Cross Sell'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsNoticifations",
        "full" => $translation->translateLabel('Items Noticifations'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsRelations",
        "full" => $translation->translateLabel('Items Relations'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsReviews",
        "full" => $translation->translateLabel('Items Reviews'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsSubsitiutions",
        "full" => $translation->translateLabel('Items Subsitiutions'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
        "short" => "It"
        ],
        [
        "id" => "Inventory/ShoppingCartSetup/ItemsWishList",
        "full" => $translation->translateLabel('Items Wish List'),
        "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
        "short" => "It"
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
    "id" => "GeneralLedger/Ledger",
    "full" => $translation->translateLabel('Ledger'),
    "short" => "Le",
    "data" => [

        [
        "id" => "GeneralLedger/Ledger/ViewChartofAccounts",
        "full" => $translation->translateLabel('View Chart of Accounts'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewLedgerAccountGroup",
        "full" => $translation->translateLabel('View Ledger Account Group'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerAccountGroupList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewGLTransactions",
        "full" => $translation->translateLabel('View GL Transactions'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewClosedGLTransactions",
        "full" => $translation->translateLabel('View Closed GL Transactions'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewGLTransactionsHistory",
        "full" => $translation->translateLabel('View GL Transactions History'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewBudgets",
        "full" => $translation->translateLabel('View Budgets'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsBudgetsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Ledger/ViewPriorFiscalYear",
        "full" => $translation->translateLabel('View Prior Fiscal Year'),
        "href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsPriorYearsList",
        "short" => "Vi"
        ]/*,
        [
        "id" => "GeneralLedger/Ledger/LedgerTreeviewSample1",
        "full" => $translation->translateLabel('Ledger Treeview Sample1'),
        "href"=> "EnterpriseASPGL/Ledger/GLCOATreeView",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/Ledger/LedgerTreeviewSample2",
        "full" => $translation->translateLabel('Ledger Treeview Sample2'),
        "href"=> "EnterpriseASPGL/Ledger/GLCOATreeViewSample2",
        "short" => "Le"
        ]*/
    ]
    ],
    [
    "type" => "submenu",
    "id" => "GeneralLedger/Banking",
    "full" => $translation->translateLabel('Banking'),
    "short" => "Ba",
    "data" => [

        [
        "id" => "GeneralLedger/Banking/ViewBankAccounts",
        "full" => $translation->translateLabel('View Bank Accounts'),
        "href"=> "EnterpriseASPGL/Banking/BankAccountsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Banking/ViewBankAccountsContacts",
        "full" => $translation->translateLabel('View Bank Accounts Contacts'),
        "href"=> "EnterpriseASPGL/Banking/BankAccountsContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Banking/ViewBankTransactions",
        "full" => $translation->translateLabel('View Bank Transactions'),
        "href"=> "EnterpriseASPGL/Banking/BankTransactionsList",
        "short" => "Vi"
        ],
        [
        "id" => "GeneralLedger/Banking/ReconcileBankAccounts",
        "full" => $translation->translateLabel('Reconcile Bank Accounts'),
        "href"=> "EnterpriseASPGL/Banking/BankReconciliationList",
        "short" => "Re"
        ],
        [
        "id" => "GeneralLedger/Banking/ViewBankReconciliations",
        "full" => $translation->translateLabel('View Bank Reconciliations'),
        "href"=> "EnterpriseASPGL/Banking/BankReconciliationSummaryList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "GeneralLedger/FixedAssets",
    "full" => $translation->translateLabel('Fixed Assets'),
    "short" => "Fi",
    "data" => [
        [
        "id" => "GeneralLedger/FixedAssets/ViewAssets",
        "full" => $translation->translateLabel('View Assets '),
        "href"=> "EnterpriseASPGL/FixedAssets/FixedAssetsList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "GeneralLedger/LedgerSetup",
    "full" => $translation->translateLabel('Ledger Setup'),
    "short" => "Le",
    "data" => [

        [
        "id" => "GeneralLedger/LedgerSetup/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/ClosePeriod",
        "full" => $translation->translateLabel('Close Period'),
        "href_ended" => "GeneralLedger/LedgerSetup/ClosePeriod&mode=edit&category=Main&item=" . $keyString,
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/CloseYear",
        "full" => $translation->translateLabel('Close Year'),
        "href_ended" => "GeneralLedger/LedgerSetup/CloseYear&mode=view&category=Main&item=" . $keyString,
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/LedgerTransactionTypes",
        "full" => $translation->translateLabel('Ledger Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/LedgerBalanceTypes",
        "full" => $translation->translateLabel('Ledger Balance Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/LedgerAccountTypes",
        "full" => $translation->translateLabel('Ledger Account Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
        "short" => "Le"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/BankTransactionTypes",
        "full" => $translation->translateLabel('Bank Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
        "short" => "Ba"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/AssetType",
        "full" => $translation->translateLabel('Asset Type'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
        "short" => "As"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/AssetStatus",
        "full" => $translation->translateLabel('Asset Status'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
        "short" => "As"
        ],
        [
        "id" => "GeneralLedger/LedgerSetup/DepreciationMethods",
        "full" => $translation->translateLabel('Depreciation Methods'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
        "short" => "De"
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
    "id" => "MRP/BillofMaterials",
    "full" => $translation->translateLabel('Bill of Materials'),
    "short" => "Bi",
    "data" => [

        [
        "id" => "MRP/BillofMaterials/ViewBillOfMaterials",
        "full" => $translation->translateLabel('View Bill Of Materials'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/BillofMaterials/ViewBuildInstructions",
        "full" => $translation->translateLabel('View Build Instructions'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesInstructionsList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/BillofMaterials/CreateInventory",
        "full" => $translation->translateLabel('Create Inventory'),
        "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryCreateAssembly",
        "short" => "Cr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "MRP/WorkOrders",
    "full" => $translation->translateLabel('Work Orders'),
    "short" => "Wo",
    "data" => [

        [
        "id" => "MRP/WorkOrders/ViewWorkOrders",
        "full" => $translation->translateLabel('View Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/WorkOrders/ViewClosedWorkOrders",
        "full" => $translation->translateLabel('View Closed Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList",
        "short" => "Vi"
        ],
        [
        "id" => "MRP/WorkOrders/ViewWorkOrdersHistory",
        "full" => $translation->translateLabel('View Work Orders History'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "MRP/MRPSetup",
    "full" => $translation->translateLabel('MRP Setup'),
    "short" => "MR",
    "data" => [

        [
        "id" => "MRP/MRPSetup/InProgressTypes",
        "full" => $translation->translateLabel('In Progress Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderInProgressList",
        "short" => "In"
        ],
        [
        "id" => "MRP/MRPSetup/PriorityTypes",
        "full" => $translation->translateLabel('Priority Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderPriorityList",
        "short" => "Pr"
        ],
        [
        "id" => "MRP/MRPSetup/WorkOrderStatuses",
        "full" => $translation->translateLabel('Work Order Statuses'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderStatusList",
        "short" => "Wo"
        ],
        [
        "id" => "MRP/MRPSetup/WorkOrderTypes",
        "full" => $translation->translateLabel('Work Order Types'),
        "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderTypesList",
        "short" => "Wo"
        ]
    ]
    ]
]
];
/*
$menuCategories["FundAccounting"] = [
"type" => "submenu",
"id" => "FundAccounting",
"full" => $translation->translateLabel('Fund Accounting'),
"short" => "Fu",
"data" => [

    [
    "type" => "submenu",
    "id" => "FundAccounting/ViewJointPayments",
    "full" => $translation->translateLabel('View Joint Payments'),
    "short" => "Vi",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "FundAccounting/ApproveJointPayments",
    "full" => $translation->translateLabel('Approve Joint Payments'),
    "short" => "Ap",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "FundAccounting/IssueJointPayments",
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
    "id" => "CRMHelpDesk/CRM",
    "full" => $translation->translateLabel('CRM'),
    "short" => "CR",
    "data" => [

        [
        "id" => "CRMHelpDesk/CRM/ViewLeads",
        "full" => $translation->translateLabel('View Leads'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/CRM/ViewLeadContacts",
        "full" => $translation->translateLabel('View Lead Contacts'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadContactsList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/CRM/ViewLeadComments",
        "full" => $translation->translateLabel('View Lead Comments'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadCommentsList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/CRM/ViewLeadSatisfactions",
        "full" => $translation->translateLabel('View Lead Satisfactions'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadSatisfactionList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/CRM/ViewLeadTypes",
        "full" => $translation->translateLabel('View Lead Types'),
        "href"=> "EnterpriseASPHelpDesk/CRM/LeadTypeList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "CRMHelpDesk/HelpDesk",
    "full" => $translation->translateLabel('Help Desk'),
    "short" => "He",
    "data" => [

        [
        "id" => "CRMHelpDesk/HelpDesk/ViewNewsItems",
        "full" => $translation->translateLabel('View News Items'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpNewsBoardList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewReleaseDates",
        "full" => $translation->translateLabel('View Release Dates'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpReleaseDatesList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewHeadings",
        "full" => $translation->translateLabel('View Headings'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageHeadingList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewTopics",
        "full" => $translation->translateLabel('View Topics'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageTopicList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewProblemReports",
        "full" => $translation->translateLabel('View Problem Reports'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemReportList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewSupportRequests",
        "full" => $translation->translateLabel('View Support Requests'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewResources",
        "full" => $translation->translateLabel('View Resources'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourcesList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewPriorities",
        "full" => $translation->translateLabel('View Priorities'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpPriorityList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewProblemTypes",
        "full" => $translation->translateLabel('View Problem Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewRequestMethods",
        "full" => $translation->translateLabel('View Request Methods'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpRequestMethodList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewResourceTypes",
        "full" => $translation->translateLabel('View Resource Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourceTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewSeverities",
        "full" => $translation->translateLabel('View Severities'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSeverityList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewStatuses",
        "full" => $translation->translateLabel('View Statuses'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpStatusList",
        "short" => "Vi"
        ],
        [
        "id" => "CRMHelpDesk/HelpDesk/ViewSupportTypes",
        "full" => $translation->translateLabel('View Support Types'),
        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
        "short" => "Vi"
        ]
    ]
    ]
]
];*/
$menuCategories["Payroll"] = [
"type" => "submenu",
"id" => "Payroll",
"full" => $translation->translateLabel('Human Resources'),
"short" => "Pa",
"data" => [

    [
    "type" => "submenu",
    "id" => "Payroll/EmployeeManagement",
    "full" => $translation->translateLabel('Employee Management'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/EmployeeManagement/ViewEmployees",
        "full" => $translation->translateLabel('View Employees'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeManagement/EmployeeSecurity",
        "full" => $translation->translateLabel('Employee Security'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeManagement/EmployeeLoginHistory",
        "full" => $translation->translateLabel('Employee Login History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
        "short" => "Em"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Payroll/EmployeeExpenses",
    "full" => $translation->translateLabel('Employee Expenses'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/EmployeeExpenses/ExpenseReports",
        "full" => $translation->translateLabel('Expense Reports'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/EmployeeExpenses/ExpenseReportsHistory",
        "full" => $translation->translateLabel('Expense Reports History'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderHistoryList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/EmployeeExpenses/ExpenseReportItems",
        "full" => $translation->translateLabel('Expense Report Items'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportItemsList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/EmployeeExpenses/ExpenseReportReasons",
        "full" => $translation->translateLabel('Expense Report Reasons'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportReasonsList",
        "short" => "Ex"
        ],
        [
        "id" => "Payroll/EmployeeExpenses/ExpenseReportTypes",
        "full" => $translation->translateLabel('Expense Report Types'),
        "href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportTypesList",
        "short" => "Ex"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Payroll/EmployeeSetup",
    "full" => $translation->translateLabel('Employee Setup'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Payroll/EmployeeSetup/ViewEmployees",
        "full" => $translation->translateLabel('View Employees'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeeTypes",
        "full" => $translation->translateLabel('Employee Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeePayType",
        "full" => $translation->translateLabel('Employee Pay Type'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeePayFrequency",
        "full" => $translation->translateLabel('Employee Pay Frequency'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayFrequencyList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeeStatus",
        "full" => $translation->translateLabel('Employee Status'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeeDepartment",
        "full" => $translation->translateLabel('Employee Department'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeDepartmentList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewTaskList",
        "full" => $translation->translateLabel('View Task List'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskHeaderList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewTaskPriorities",
        "full" => $translation->translateLabel('View Task Priorities'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskPriorityList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewTaskTypes",
        "full" => $translation->translateLabel('View Task Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskTypeList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/EmployeeStatusTypes",
        "full" => $translation->translateLabel('Employee Status Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusTypeList",
        "short" => "Em"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeeAccruals",
        "full" => $translation->translateLabel('View Employee Accruals'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewAccrualFrequencies",
        "full" => $translation->translateLabel('View Accrual Frequencies'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualFrequencyList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewAccrualTypes",
        "full" => $translation->translateLabel('View Accrual Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewPayrollEmails",
        "full" => $translation->translateLabel('View Payroll Emails'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmailMessagesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewPayrollInstantMessages",
        "full" => $translation->translateLabel('View Payroll Instant Messages'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollInstantMessagesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeeEmails",
        "full" => $translation->translateLabel('View Employee Emails'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeEmailMessageList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeeInstantMessages",
        "full" => $translation->translateLabel('View Employee Instant Messages'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeInstantMessageList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeesCalendar",
        "full" => $translation->translateLabel('View Employees Calendar'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCalendarList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeesCurrentlyOn",
        "full" => $translation->translateLabel('View Employees Currently On'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCurrentlyOnList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeesEvents",
        "full" => $translation->translateLabel('View Employees Events'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventsList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeesEventTypes",
        "full" => $translation->translateLabel('View Employees Event Types'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventTypesList",
        "short" => "Vi"
        ],
        [
        "id" => "Payroll/EmployeeSetup/ViewEmployeesTimesheets",
        "full" => $translation->translateLabel('View Employees Timesheets'),
        "href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesTimesheetHeaderList",
        "short" => "Vi"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Payroll/PayrollProcessing",
    "full" => $translation->translateLabel('Payroll Processing'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayrollProcessing/PayEmployees",
        "full" => $translation->translateLabel('Pay Employees'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollPayEmployees",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollProcessing/PayrollRegister",
        "full" => $translation->translateLabel('Payroll Register'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollRegisterList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollProcessing/PayrollChecks",
        "full" => $translation->translateLabel('Payroll Checks'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollChecksList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollProcessing/PayrollCheckTypes",
        "full" => $translation->translateLabel('Payroll Check Types'),
        "href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollCheckTypeList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Payroll/PayrollTaxes",
    "full" => $translation->translateLabel('Payroll Taxes'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayrollTaxes/PayrollItemsMaster",
        "full" => $translation->translateLabel('Payroll Items Master'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollItemsMasterList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollFedTax",
        "full" => $translation->translateLabel('Payroll Fed Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollFedTaxTables",
        "full" => $translation->translateLabel('Payroll Fed Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollStateTax",
        "full" => $translation->translateLabel('Payroll State Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollStateTaxTables",
        "full" => $translation->translateLabel('Payroll State Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollCountyTax",
        "full" => $translation->translateLabel('Payroll County Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollCountyTaxTables",
        "full" => $translation->translateLabel('Payroll County Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxTablesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollCityTax",
        "full" => $translation->translateLabel('Payroll City Tax'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollTaxes/PayrollCityTaxTables",
        "full" => $translation->translateLabel('Payroll City Tax Tables'),
        "href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxTablesList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Payroll/PayrollSetup",
    "full" => $translation->translateLabel('Payroll Setup'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Payroll/PayrollSetup/PayrollSetup",
        "full" => $translation->translateLabel('Payroll Setup'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollSetupList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollSetup/PayrollItems",
        "full" => $translation->translateLabel('Payroll Items'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemsList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollSetup/PayrollItemTypes",
        "full" => $translation->translateLabel('Payroll Item Types'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemTypesList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollSetup/PayrollItemBasis",
        "full" => $translation->translateLabel('Payroll Item Basis'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemBasisList",
        "short" => "Pa"
        ],
        [
        "id" => "Payroll/PayrollSetup/W2Details",
        "full" => $translation->translateLabel('W2 Details'),
        "href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW2DetailList",
        "short" => "W2"
        ],
        [
        "id" => "Payroll/PayrollSetup/W3Details",
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
    "id" => "SystemSetup/CompanySetup",
    "full" => $translation->translateLabel('Company Setup'),
    "short" => "Co",
    "data" => [

        [
        "id" => "SystemSetup/CompanySetup/CompanySetup",
        "full" => $translation->translateLabel('Company Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/CompanyDisplayLanguages",
        "full" => $translation->translateLabel('Company Display Languages'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesDisplayLangList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/SystemWideMessage",
        "full" => $translation->translateLabel('System Wide Message'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesSystemWideMessageDetail",
        "short" => "Sy"
        ],
        [
        "id" => "SystemSetup/CompanySetup/CompanyWorkflowByEmployees",
        "full" => $translation->translateLabel('Company Workflow By Employees'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkflowByEmployeesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/CompanyWorkflowTypes",
        "full" => $translation->translateLabel('Company Workflow Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkFlowTypesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/DivisionSetup",
        "full" => $translation->translateLabel('Division Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/DivisionsList",
        "short" => "Di"
        ],
        [
        "id" => "SystemSetup/CompanySetup/DepartmentSetup",
        "full" => $translation->translateLabel('Department Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/DepartmentsList",
        "short" => "De"
        ],
        [
        "id" => "SystemSetup/CompanySetup/CompanyIDNumbers",
        "full" => $translation->translateLabel('Company ID Numbers'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CompaniesNextNumbersList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/CreditCardTypes",
        "full" => $translation->translateLabel('Credit Card Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CreditCardTypesList",
        "short" => "Cr"
        ],
        [
        "id" => "SystemSetup/CompanySetup/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "SystemSetup/CompanySetup/TaxItems",
        "full" => $translation->translateLabel('Tax Items'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxesList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/CompanySetup/TaxGroupDetails",
        "full" => $translation->translateLabel('Tax Group Details'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupDetailList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/CompanySetup/TaxGroups",
        "full" => $translation->translateLabel('Tax Groups'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupsList",
        "short" => "Ta"
        ],
        [
        "id" => "SystemSetup/CompanySetup/Terms",
        "full" => $translation->translateLabel('Terms'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TermsList",
        "short" => "Te"
        ],
        [
        "id" => "SystemSetup/CompanySetup/POSSetup",
        "full" => $translation->translateLabel('POS Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/POSSetupDetail",
        "short" => "PO"
        ],
        [
        "id" => "SystemSetup/CompanySetup/ShipmentMethods",
        "full" => $translation->translateLabel('Shipment Methods'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ShipmentMethodsList",
        "short" => "Sh"
        ],
        [
        "id" => "SystemSetup/CompanySetup/Warehouses",
        "full" => $translation->translateLabel('Warehouses'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehousesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/CompanySetup/WarehouseBins",
        "full" => $translation->translateLabel('Warehouse Bins'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinsList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/CompanySetup/WarehouseBinTypes",
        "full" => $translation->translateLabel('Warehouse Bin Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinTypesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/CompanySetup/WarehouseBinZones",
        "full" => $translation->translateLabel('Warehouse Bin Zones'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinZonesList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/CompanySetup/WarehouseContacts",
        "full" => $translation->translateLabel('Warehouse Contacts'),
        "href"=> "EnterpriseASPSystem/CompanySetup/WarehousesContactsList",
        "short" => "Wa"
        ],
        [
        "id" => "SystemSetup/CompanySetup/ContactIndustries",
        "full" => $translation->translateLabel('Contact Industries'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactIndustryList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/ContactRegions",
        "full" => $translation->translateLabel('Contact Regions'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactRegionsList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/ContactSources",
        "full" => $translation->translateLabel('Contact Sources'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactSourceList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/ContactTypes",
        "full" => $translation->translateLabel('Contact Types'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ContactTypeList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/CompanySetup/TranslationTable",
        "full" => $translation->translateLabel('Translation Table'),
        "href"=> "EnterpriseASPSystem/CompanySetup/Translation",
        "short" => "Tr"
        ],
        [
        "id" => "SystemSetup/CompanySetup/TimeUnits",
        "full" => $translation->translateLabel('Time Units'),
        "href"=> "EnterpriseASPSystem/CompanySetup/TimeUnitsList",
        "short" => "Ti"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SystemSetup/SecuritySetup",
    "full" => $translation->translateLabel('Security Setup'),
    "short" => "Se",
    "data" => [

        [
        "id" => "SystemSetup/SecuritySetup/SecuritySetup",
        "full" => $translation->translateLabel('Security Setup'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
        "short" => "Se"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/UnlockRecords",
        "full" => $translation->translateLabel('Unlock Records'),
        "href"=> "EnterpriseASPSystem/CompanySetup/Unlock",
        "short" => "Un"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/SystemErrorLog",
        "full" => $translation->translateLabel('System Error Log'),
        "href"=> "EnterpriseASPSystem/CompanySetup/ErrorLogList",
        "short" => "Sy"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/AuditDescription",
        "full" => $translation->translateLabel('Audit Description'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTablesDescriptionList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/AuditTrail",
        "full" => $translation->translateLabel('Audit Trail'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/AuditTrailHistory",
        "full" => $translation->translateLabel('Audit Trail History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailHistoryList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/AuditLogin",
        "full" => $translation->translateLabel('Audit Login'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginList",
        "short" => "Au"
        ],
        [
        "id" => "SystemSetup/SecuritySetup/AuditLoginHistory",
        "full" => $translation->translateLabel('Audit Login History'),
        "href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
        "short" => "Au"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SystemSetup/LedgerSetup",
    "full" => $translation->translateLabel('Ledger Setup'),
    "short" => "Le",
    "data" => [

        [
        "id" => "SystemSetup/LedgerSetup/Currencies",
        "full" => $translation->translateLabel('Currencies'),
        "href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
        "short" => "Cu"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/ClosePeriod",
        "full" => $translation->translateLabel('Close Period'),
        "href_ended" => "SystemSetup/LedgerSetup/ClosePeriod&mode=edit&category=Main&item=" . $keyString,
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/CloseYear",
        "full" => $translation->translateLabel('Close Year'),
        "href_ended" => "SystemSetup/LedgerSetup/CloseYear&mode=view&category=Main&item=" . $keyString,
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
        "short" => "Cl"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/LedgerTransactionTypes",
        "full" => $translation->translateLabel('Ledger Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/LedgerBalanceTypes",
        "full" => $translation->translateLabel('Ledger Balance Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/LedgerAccountTypes",
        "full" => $translation->translateLabel('Ledger Account Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
        "short" => "Le"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/BankTransactionTypes",
        "full" => $translation->translateLabel('Bank Transaction Types'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
        "short" => "Ba"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/AssetType",
        "full" => $translation->translateLabel('Asset Type'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
        "short" => "As"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/AssetStatus",
        "full" => $translation->translateLabel('Asset Status'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
        "short" => "As"
        ],
        [
        "id" => "SystemSetup/LedgerSetup/DepreciationMethods",
        "full" => $translation->translateLabel('Depreciation Methods'),
        "href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
        "short" => "De"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SystemSetup/AccountsReceivableSetup",
    "full" => $translation->translateLabel('Accounts Receivable Setup'),
    "short" => "Ac",
    "data" => [

        [
        "id" => "SystemSetup/AccountsReceivableSetup/ARTransactionTypes",
        "full" => $translation->translateLabel('AR Transaction Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ARTransactionTypesList",
        "short" => "AR"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/ContractTypes",
        "full" => $translation->translateLabel('Contract Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ContractTypesList",
        "short" => "Co"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/OrderTypes",
        "full" => $translation->translateLabel('Order Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/OrderTypesList",
        "short" => "Or"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/ReceiptTypes",
        "full" => $translation->translateLabel('Receipt Types'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptTypesList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/ReceiptClasses",
        "full" => $translation->translateLabel('Receipt Classes'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptClassList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/ReceiptMethods",
        "full" => $translation->translateLabel('Receipt Methods'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptMethodsList",
        "short" => "Re"
        ],
        [
        "id" => "SystemSetup/AccountsReceivableSetup/SalesGroups",
        "full" => $translation->translateLabel('Sales Groups'),
        "href"=> "EnterpriseASPSystem/AccountsReceivableSetup/SalesGroupList",
        "short" => "Sa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SystemSetup/AccountsPayableSetup",
    "full" => $translation->translateLabel('Accounts Payable Setup'),
    "short" => "Ac",
    "data" => [

        [
        "id" => "SystemSetup/AccountsPayableSetup/APTransactionTypes",
        "full" => $translation->translateLabel('AP Transaction Types'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/APTransactionTypesList",
        "short" => "AP"
        ],
        [
        "id" => "SystemSetup/AccountsPayableSetup/PaymentClasses",
        "full" => $translation->translateLabel('Payment Classes'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentClassesList",
        "short" => "Pa"
        ],
        [
        "id" => "SystemSetup/AccountsPayableSetup/PaymentTypes",
        "full" => $translation->translateLabel('Payment Types'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentTypesList",
        "short" => "Pa"
        ],
        [
        "id" => "SystemSetup/AccountsPayableSetup/PaymentMethods",
        "full" => $translation->translateLabel('Payment Methods'),
        "href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentMethodsList",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "SystemSetup/EDISetup",
    "full" => $translation->translateLabel('EDI Setup '),
    "short" => "ED",
    "data" => [

        [
        "id" => "SystemSetup/EDISetup/EDISetup",
        "full" => $translation->translateLabel('EDI Setup'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDISetupList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDISetup/EDIDocumentTypes",
        "full" => $translation->translateLabel('EDI Document Types'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIDocumentTypesList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDISetup/EDIDocumentDirections",
        "full" => $translation->translateLabel('EDI Document Directions'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIDirectionList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDISetup/EDIExceptions",
        "full" => $translation->translateLabel('EDI Exceptions'),
        "href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionsList",
        "short" => "ED"
        ],
        [
        "id" => "SystemSetup/EDISetup/EDIExceptionTypes",
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
    "id" => "Reports/Financials",
    "full" => $translation->translateLabel('Financials'),
    "short" => "Fi",
    "data" => [
	    [
            "id" => "Reports/Financials/GaapMain",
            "type" => "relativeLink",
            "full" => $translation->translateLabel('Gaap Financials'),
            "href"=> "page=financials&type=gaap&module=main",
            "short" => "Le"
        ],
    [
    "type" => "submenu",
    "id" => "Reports/Financials/GaapAgedReports",
    "full" => $translation->translateLabel('Gaap Aged Reports'),
    "short" => "Ga",
    "data" => [
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedPayables",
        "full" => $translation->translateLabel('Aged Payables'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedPayablesSummary",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedPayablesComparative",
        "full" => $translation->translateLabel('Aged Payables Comparative'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedPayablesSummaryComparative",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedPayablesYTD",
        "full" => $translation->translateLabel('Aged Payables YTD'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedPayablesSummaryYTD",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedReceivables",
        "full" => $translation->translateLabel('Aged Receivables'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedReceivablesSummary",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedReceivablesComparative",
        "full" => $translation->translateLabel('Aged Receivables Comparative'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedReceivablesSummaryComparative",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/GaapAgedReports/AgedReceivablesYTD",
        "full" => $translation->translateLabel('Aged Receivables YTD'),
        "type" => "relativeLink",
        "target" => "_blank",
        "href"=> "page=financials&type=gaap&module=AgedReceivablesSummaryYTD",
        "short" => "Ag"
        ]
    ]
    ],
	[
            "id" => "Reports/Financials/GaapWorksheets",
            "type" => "relativeLink",
 	       "target" => "_blank",
            "full" => $translation->translateLabel('Worksheets'),
            "href"=> "page=financials&type=common&module=worksheets",
            "short" => "Le"
        ]
    /*[
    "type" => "submenu",
    "id" => "Reports/Financials/IFRSAgedReports",
    "full" => $translation->translateLabel('IFRS Aged Reports'),
    "short" => "IF",
    "data" => [

        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedPayables",
        "full" => $translation->translateLabel('Aged Payables'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedPayablesSummary",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedPayablesComparative",
        "full" => $translation->translateLabel('Aged Payables Comparative'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedPayablesSummaryComparative",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedPayablesYTD",
        "full" => $translation->translateLabel('Aged Payables YTD'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedPayablesSummaryYTD",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedReceivables",
        "full" => $translation->translateLabel('Aged Receivables'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedReceivablesSummary",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedReceivablesComparative",
        "full" => $translation->translateLabel('Aged Receivables Comparative'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedReceivablesSummaryComparative",
        "short" => "Ag"
        ],
        [
        "id" => "Reports/Financials/IFRSAgedReports/AgedReceivablesYTD",
        "full" => $translation->translateLabel('Aged Receivables YTD'),
        "href"=> "reports/IFRSFinancials/RptIFRSAgedReceivablesSummaryYTD",
        "short" => "Ag"
        ]*/
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports",
    "full" => $translation->translateLabel('Accounts Receivable Reports'),
    "short" => "Ac",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports/OrdersInvoices",
    "full" => $translation->translateLabel('Orders & Invoices'),
    "short" => "Or",
    "data" => [

        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/ARTransactionTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('AR Transaction Types'),
        "href"=> "page=autoreports&source=RptListARTransactionTypes&id=754973916&title=AR Transaction Types",
        "short" => "AR"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/ContractHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contract Headers'),
        "href"=> "page=autoreports&source=RptListContractsHeader&id=1058974999&title=Contract Headers",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/ContractDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contract Detail Items'),
        "href"=> "page=autoreports&source=RptListContractsDetail&id=1042974942&title=Contract Detail Items",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/ContractTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contract Types'),
        "href"=> "page=autoreports&source=RptListContractTypes&id=1026974885&title=Contract Types",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/ContractEmailList",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contract Email List'),
        "href"=> "page=autoreports&source=RptListAllContractEmails&id=1569648885&title=Contract Email List",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/OrderHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Order Headers'),
        "href"=> "page=autoreports&source=RptListOrderHeader&id=1906978020&title=Order Headers",
        "short" => "Or"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/OrderDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Order Detail Items'),
        "href"=> "page=autoreports&source=RptListOrderDetail&id=1890977963&title=Order Detail Items",
        "short" => "Or"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/OrderTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Order Types'),
        "href"=> "page=autoreports&source=RptListOrderTypes&id=1922978077&title=Order Types",
        "short" => "Or"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/InvoiceHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Invoice Headers'),
        "href"=> "page=autoreports&source=RptListInvoiceHeader&id=1698977279&title=Invoice Headers",
        "short" => "In"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/OrdersInvoices/InvoiceDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Invoice Detail Items'),
        "href"=> "page=autoreports&source=RptListInvoiceDetail&id=1682977222&title=Invoice Detail Items",
        "short" => "In"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports/SalesProfitability",
    "full" => $translation->translateLabel('Sales & Profitability'),
    "short" => "Sa",
    "data" => [

        [
        "id" => "Reports/AccountsReceivableReports/SalesProfitability/SalesDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Sales Detail'),
        "href"=> "page=autoreports&source=RptSalesCustomerSalesDetail&id=479496937&title=Customer Sales Detail",
        "short" => "Sa"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/SalesProfitability/SalesSummary",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Sales Summary'),
        "href"=> "page=autoreports&source=RptSalesCustomerSalesSummary&id=1834645779&title=Customer Sales Summary",
        "short" => "Sa"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/SalesProfitability/ProfitbyCustomer",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Profit by Customer'),
        "href"=> "page=autoreports&source=RptSalesProfitibilityByCustomer&id=1091847302&title=Profitibility By Customer",
        "short" => "Pr"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/SalesProfitability/ProfitByInvoice",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Profit By Invoice'),
        "href"=> "page=autoreports&source=RptSalesProfitibilityByInvoice&id=1107847359&title=Profitibility By Invoice",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports/CashReceiptsReports",
    "full" => $translation->translateLabel('Cash Receipts Reports'),
    "short" => "Ca",
    "data" => [

        [
        "id" => "Reports/AccountsReceivableReports/CashReceiptsReports/ReceiptsHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Receipts Headers'),
        "href"=> "page=autoreports&source=RptListReceiptsHeader&id=175495854&title=Receipts Headers",
        "short" => "Re"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CashReceiptsReports/ReceiptDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Receipt Detail Items'),
        "href"=> "page=autoreports&source=RptListReceiptsDetail&id=159495797&title=Receipt Detail Items",
        "short" => "Re"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CashReceiptsReports/ReceiptClasses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Receipt Classes'),
        "href"=> "page=autoreports&source=RptListReceiptClass&id=127495683&title=Receipt Classes",
        "short" => "Re"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CashReceiptsReports/ReceiptTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Receipt Types'),
        "href"=> "page=autoreports&source=RptListReceiptTypes&id=143495740&title=Receipt Types",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports/CustomerReports",
    "full" => $translation->translateLabel('Customer Reports'),
    "short" => "Cu",
    "data" => [

        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/Information",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Information'),
        "href"=> "page=autoreports&source=RptListCustomerInformation&id=1202975512&title=Customer Information",
        "short" => "In"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/CreditReferences",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Credit References'),
        "href"=> "page=autoreports&source=RptListCustomerCreditReferences&id=1170975398&title=Customer Credit References",
        "short" => "Cr"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/ShipForLocations",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ship For Locations'),
        "href"=> "page=autoreports&source=RptListCustomerShipForLocations&id=1250975683&title=Customer Ship For Locations",
        "short" => "Sh"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/ShipToLocations",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ship To Locations'),
        "href"=> "page=autoreports&source=RptListCustomerShipToLocations&id=1266975740&title=Customer Ship To Locations",
        "short" => "Sh"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/ItemCrossReference",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Cross Reference'),
        "href"=> "page=autoreports&source=RptListCustomerItemCrossReference&id=1218975569&title=Customer Item Cross Reference",
        "short" => "It"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/PriceCrossReference",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Price Cross Reference'),
        "href"=> "page=autoreports&source=RptListCustomerPriceCrossReference&id=1234975626&title=Customer Price Cross Reference",
        "short" => "Pr"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/Types",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Types'),
        "href"=> "page=autoreports&source=RptListCustomerTypes&id=1282975797&title=Customer Types",
        "short" => "Ty"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/AccountStatuses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Account Statuses'),
        "href"=> "page=autoreports&source=RptListCustomerAccountStatuses&id=1106975170&title=Customer Account Statuses",
        "short" => "Ac"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/Comments",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Comments'),
        "href"=> "page=autoreports&source=RptListCustomerComments&id=1122975227&title=Customer Comments",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/ContactLog",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contact Log'),
        "href"=> "page=autoreports&source=RptListCustomerContactLog&id=1138975284&title=Customer Contact Log",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsReceivableReports/CustomerReports/Contacts",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contacts'),
        "href"=> "page=autoreports&source=RptListCustomerContacts&id=1154975341&title=Customer Contacts",
        "short" => "Co"
        ]
    ]
    ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsPayableReports",
    "full" => $translation->translateLabel('Accounts Payable Reports'),
    "short" => "Ac",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/AccountsPayableReports/Purchases",
    "full" => $translation->translateLabel('Purchases'),
    "short" => "Pu",
    "data" => [

        [
        "id" => "Reports/AccountsPayableReports/Purchases/APTransactionTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('AP Transaction Types'),
        "href"=> "page=autoreports&source=RptListAPTransactionTypes&id=738973859&title=AP Transaction Types",
        "short" => "AP"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Purchases/PurchaseHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Purchase Headers'),
        "href"=> "page=autoreports&source=RptListPurchaseHeader&id=111495626&title=Purchase Headers",
        "short" => "Pu"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Purchases/PurchaseDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Purchase Detail Items'),
        "href"=> "page=autoreports&source=RptListPurchaseDetail&id=95495569&title=Purchase Detail Items",
        "short" => "Pu"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsPayableReports/Vouchers",
    "full" => $translation->translateLabel('Vouchers '),
    "short" => "Vo",
    "data" => [

        [
        "id" => "Reports/AccountsPayableReports/Vouchers/PaymentsHeaders",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payments Headers'),
        "href"=> "page=autoreports&source=RptListPaymentsHeader&id=2002978362&title=Payments Headers",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Vouchers/PaymentDetailItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payment Detail Items'),
        "href"=> "page=autoreports&source=RptListPaymentsDetail&id=1986978305&title=Payment Detail Items",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Vouchers/PaymentTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payment Types'),
        "href"=> "page=autoreports&source=RptListPaymentTypes&id=1970978248&title=Payment Types",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Vouchers/PaymentClasses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payment Classes'),
        "href"=> "page=autoreports&source=RptListPaymentClasses&id=1938978134&title=Payment Classes",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/AccountsPayableReports/Vouchers/PaymentMethods",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payment Methods'),
        "href"=> "page=autoreports&source=RptListPaymentMethods&id=1954978191&title=Payment Methods",
        "short" => "Pa"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsPayableReports/VendorReports",
    "full" => $translation->translateLabel('Vendor Reports'),
    "short" => "Ve",
    "data" => [

        [
        "id" => "Reports/AccountsPayableReports/VendorReports/Information",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Information'),
        "href"=> "page=autoreports&source=RptListVendorInformation&id=335496424&title=Vendor Information",
        "short" => "In"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/ItemCrossReference",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Cross Reference'),
        "href"=> "page=autoreports&source=RptListVendorItemCrossReference&id=351496481&title=Vendor Item Cross Reference",
        "short" => "It"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/PriceCrossReference",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Price Cross Reference'),
        "href"=> "page=autoreports&source=RptListVendorPriceCrossReference&id=367496538&title=Vendor Price Cross Reference",
        "short" => "Pr"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/Types",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Types'),
        "href"=> "page=autoreports&source=RptListVendorTypes&id=383496595&title=Vendor Types",
        "short" => "Ty"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/AccountStatuses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Account Statuses'),
        "href"=> "page=autoreports&source=RptListVendorAccountStatuses&id=271496196&title=Vendor Account Statuses",
        "short" => "Ac"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/Comments",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Comments'),
        "href"=> "page=autoreports&source=RptListVendorComments&id=287496253&title=Vendor Comments",
        "short" => "Co"
        ],
        [
        "id" => "Reports/AccountsPayableReports/VendorReports/Contacts",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contacts'),
        "href"=> "page=autoreports&source=RptListVendorContacts&id=303496310&title=Vendor Contacts",
        "short" => "Co"
        ]
    ]
    ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports",
    "full" => $translation->translateLabel('Ledger Reports'),
    "short" => "Le",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports/LedgerReporting",
    "full" => $translation->translateLabel('Ledger Reporting'),
    "short" => "Le",
    "data" => [

        [
        "id" => "Reports/LedgerReports/LedgerReporting/AccountStatuses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Account Statuses'),
        "href"=> "page=autoreports&source=RptCompanyAccountsStatus&id=718117799&title=Account Statuses",
        "short" => "Ac"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/ChartofAccounts",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Chart of Accounts'),
        "href"=> "page=autoreports&source=RptListLedgerChartOfAccounts&id=1810977678&title=Chart of Accounts",
        "short" => "Ch"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/LedgerTransactions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ledger Transactions'),
        "href"=> "page=autoreports&source=RptListLedgerTransactions&id=1858977849&title=Ledger Transactions",
        "short" => "Le"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/LedgerTransactionDetails",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ledger Transaction Details'),
        "href"=> "page=autoreports&source=RptListLedgerTransactionsDetail&id=1874977906&title=Ledger Transaction Details",
        "short" => "Le"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/LedgerTransactionTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ledger Transaction Types'),
        "href"=> "page=autoreports&source=RptListLedgerTransactionTypes&id=1842977792&title=Ledger Transaction Types",
        "short" => "Le"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/LedgerAccountTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ledger Account Types'),
        "href"=> "page=autoreports&source=RptListLedgerAccountTypes&id=1778977564&title=Ledger Account Types",
        "short" => "Le"
        ],
        [
        "id" => "Reports/LedgerReports/LedgerReporting/LedgerBalanceTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Ledger Balance Types'),
        "href"=> "page=autoreports&source=RptListLedgerBalanceType&id=1794977621&title=Ledger Balance Types",
        "short" => "Le"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports/CurrencyReports",
    "full" => $translation->translateLabel('Currency Reports'),
    "short" => "Cu",
    "data" => [

        [
        "id" => "Reports/LedgerReports/CurrencyReports/CurrencyTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Currency Types'),
        "href"=> "page=autoreports&source=RptListCurrencyTypes&id=1090975113&title=Currency Types",
        "short" => "Cu"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/InvoicesByCurrency",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Invoices By Currency'),
        "href"=> "page=autoreports&source=RptCurrencyInvoice&id=2038454486&title=Invoices By Currency",
        "short" => "In"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/OrdersByCurrency",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Orders By Currency'),
        "href"=> "page=autoreports&source=RptCurrencyOrder&id=2054454543&title=Orders By Currency",
        "short" => "Or"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/PaymentsByCurrency",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payments By Currency'),
        "href"=> "page=autoreports&source=RptCurrencyPayment&id=2070454600&title=Payments By Currency",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/PurchasesByCurrency",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Purchases By Currency'),
        "href"=> "page=autoreports&source=RptCurrencyPurchase&id=2102454714&title=Purchases By Currency",
        "short" => "Pu"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/ReceiptsByCurrency",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Receipts By Currency'),
        "href"=> "page=autoreports&source=RptCurrencyReceipts&id=2118454771&title=Receipts By Currency",
        "short" => "Re"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/CurrencyRequirements",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Currency Requirements'),
        "href"=> "page=autoreports&source=RptCurrencyRequirements&id=2134454828&title=Currency Requirements",
        "short" => "Cu"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/CurrencyPositions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Currency Positions'),
        "href"=> "page=autoreports&source=RptCurrencyPositions&id=2086454657&title=Currency Positions",
        "short" => "Cu"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/UnRealizedGainsLosses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('UnRealized Gains & Losses'),
        "href"=> "page=autoreports&source=RptUnRealizedGainsLosses&id=172123954&title=UnRealized Gains & Losses",
        "short" => "Un"
        ],
        [
        "id" => "Reports/LedgerReports/CurrencyReports/UnRealizedTotal",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('UnRealized Total'),
        "href"=> "page=autoreports&source=RptUnRealizedGainLossOnly&id=156123897&title=UnRealized Gain & Loss Total",
        "short" => "Un"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports/BankingReports",
    "full" => $translation->translateLabel('Banking Reports'),
    "short" => "Ba",
    "data" => [

        [
        "id" => "Reports/LedgerReports/BankingReports/BankAccounts",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Bank Accounts'),
        "href"=> "page=autoreports&source=RptListBankAccounts&id=802974087&title=Bank Accounts",
        "short" => "Ba"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/BankTransactions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Bank Transactions'),
        "href"=> "page=autoreports&source=RptListBankTransactions&id=914974486&title=Bank Transactions",
        "short" => "Ba"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/BankTransactionTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Bank Transaction Types'),
        "href"=> "page=autoreports&source=RptListBankTransactionTypes&id=898974429&title=Bank Transaction Types",
        "short" => "Ba"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/BankReconcilation",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Bank Reconcilation'),
        "href"=> "page=autoreports&source=RptListBankReconciliation&id=818974144&title=Bank Reconcilation",
        "short" => "Ba"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/ReconcilationSummary",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Reconcilation Summary'),
        "href"=> "page=autoreports&source=RptListBankReconciliationSummary&id=882974372&title=Bank Reconcilation Summary",
        "short" => "Re"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/ReconcilationDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Reconcilation Detail'),
        "href"=> "page=autoreports&source=RptListBankReconciliationDetail&id=834974201&title=Bank Reconcilation Detail",
        "short" => "Re"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/ReconcilationCredits",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Reconcilation Credits'),
        "href"=> "page=autoreports&source=RptListBankReconciliationDetailCredits&id=850974258&title=Bank Reconcilation Credits",
        "short" => "Re"
        ],
        [
        "id" => "Reports/LedgerReports/BankingReports/ReconcilationDebits",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Reconcilation Debits'),
        "href"=> "page=autoreports&source=RptListBankReconciliationDetailDebits&id=866974315&title=Bank Reconcilation Debits",
        "short" => "Re"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports/FixedAssetsReports",
    "full" => $translation->translateLabel('Fixed Assets Reports'),
    "short" => "Fi",
    "data" => [

        [
        "id" => "Reports/LedgerReports/FixedAssetsReports/FixedAssets",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Fixed Assets'),
        "href"=> "page=autoreports&source=RptListFixedAssets&id=1474976481&title=Fixed Assets",
        "short" => "Fi"
        ],
        [
        "id" => "Reports/LedgerReports/FixedAssetsReports/AssetStatus",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Asset Status'),
        "href"=> "page=autoreports&source=RptListFixedAssetStatus&id=1442976367&title=Asset Status",
        "short" => "As"
        ],
        [
        "id" => "Reports/LedgerReports/FixedAssetsReports/AssetTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Asset Types'),
        "href"=> "page=autoreports&source=RptListFixedAssetType&id=1458976424&title=Asset Types",
        "short" => "As"
        ],
        [
        "id" => "Reports/LedgerReports/FixedAssetsReports/DepreciationMethods",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Depreciation Methods'),
        "href"=> "page=autoreports&source=RptListFixedAssetDepreciationMethods&id=1426976310&title=Depreciation Methods",
        "short" => "De"
        ]
    ]
    ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports",
    "full" => $translation->translateLabel('Inventory Reports'),
    "short" => "In",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports/ItemsStock",
    "full" => $translation->translateLabel('Items & Stock '),
    "short" => "It",
    "data" => [

        [
        "id" => "Reports/InventoryReports/ItemsStock/InventoryByWarehouse",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Inventory By Warehouse'),
        "href"=> "page=autoreports&source=RptListInventoryByWarehouse&id=1554976766&title=Inventory By Warehouse",
        "short" => "In"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/LowStockAlert",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Low Stock Alert'),
        "href"=> "page=autoreports&source=RptInventoryLowStockAlert&id=546973175&title=Inventory Low Stock Alert",
        "short" => "Lo"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/Items",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Items'),
        "href"=> "page=autoreports&source=RptListInventoryItems&id=1031323084&title=Items",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemCategories",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Categories'),
        "href"=> "page=autoreports&source=RptListInventoryCategories&id=1570976823&title=Item Categories",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemFamilies",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Families'),
        "href"=> "page=autoreports&source=RptListInventoryFamilies&id=1586976880&title=Item Families",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Types'),
        "href"=> "page=autoreports&source=RptListInventoryItemTypes&id=1602976937&title=Item Types",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemPricingCodes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Pricing Codes'),
        "href"=> "page=autoreports&source=RptListInventoryPricingCode&id=1634977051&title=Item Pricing Codes",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemPricingMethods",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Pricing Methods'),
        "href"=> "page=autoreports&source=RptListInventoryPricingMethods&id=1650977108&title=Item Pricing Methods",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/ItemsStock/ItemSerialNumbers",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Serial Numbers'),
        "href"=> "page=autoreports&source=RptListInventorySerialNumbers&id=1666977165&title=Item Serial Numbers",
        "short" => "It"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports/SalesProfitability",
    "full" => $translation->translateLabel('Sales & Profitability'),
    "short" => "Sa",
    "data" => [

        [
        "id" => "Reports/InventoryReports/SalesProfitability/ItemSalesDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Sales Detail'),
        "href"=> "page=autoreports&source=RptSalesItemSalesDetail&id=543497165&title=Item Sales Detail",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/ItemSalesSummary",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Item Sales Summary'),
        "href"=> "page=autoreports&source=RptSalesItemSalesSummary&id=1866645893&title=Item Sales Summary",
        "short" => "It"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/SalesHistoryDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Sales History Detail'),
        "href"=> "page=autoreports&source=RptSalesItemHistoryDetail&id=511497051&title=Item Sales History Detail",
        "short" => "Sa"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/SalesHistorySummary",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Sales History Summary'),
        "href"=> "page=autoreports&source=RptSalesItemHistorySummary&id=1850645836&title=Item Sales History Summary",
        "short" => "Sa"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/ProfitibilityByItem",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Profitibility By Item'),
        "href"=> "page=autoreports&source=RptSalesProfitibilityByItem&id=607497393&title=Profitibility By Item",
        "short" => "Pr"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/Top10ItemsBySales",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Top 10 Items By Sales'),
        "href"=> "page=autoreports&source=RptInventoryTop10ItemsBySales&id=1075847245&title=Top 10 Items By Sales",
        "short" => "To"
        ],
        [
        "id" => "Reports/InventoryReports/SalesProfitability/Top10ItemsByProfit",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Top 10 Items By Profit'),
        "href"=> "page=autoreports&source=RptInventoryTop10ItemsByProfit&id=1059847188&title=Top 10 Items By Profit",
        "short" => "To"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports/InventoryValue",
    "full" => $translation->translateLabel('Inventory Value'),
    "short" => "In",
    "data" => [

        [
        "id" => "Reports/InventoryReports/InventoryValue/ValuationReport",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Valuation Report'),
        "href"=> "page=autoreports&source=RptInventoryValuationReport&id=967322856&title=Inventory Valuation Report",
        "short" => "Va"
        ],
        [
        "id" => "Reports/InventoryReports/InventoryValue/ValuationReportAverage",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Valuation Report Average'),
        "href"=> "page=autoreports&source=RptInventoryValuationReportAverage&id=983322913&title=Inventory Valuation Report Average",
        "short" => "Va"
        ],
        [
        "id" => "Reports/InventoryReports/InventoryValue/ValuationReportFIFO",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Valuation Report FIFO'),
        "href"=> "page=autoreports&source=RptInventoryValuationReportFIFO&id=999322970&title=Inventory Valuation Report FIFO",
        "short" => "Va"
        ],
        [
        "id" => "Reports/InventoryReports/InventoryValue/ValuationReportLIFO",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Valuation Report LIFO'),
        "href"=> "page=autoreports&source=RptInventoryValuationReportLIFO&id=1015323027&title=Inventory Valuation Report LIFO",
        "short" => "Va"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports/AdjustmentsAssemblies",
    "full" => $translation->translateLabel('Adjustments & Assemblies'),
    "short" => "Ad",
    "data" => [

        [
        "id" => "Reports/InventoryReports/AdjustmentsAssemblies/InventoryAssemblies",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Inventory Assemblies'),
        "href"=> "page=autoreports&source=RptListInventoryAssemblies&id=1538976709&title=Inventory Assemblies",
        "short" => "In"
        ],
        [
        "id" => "Reports/InventoryReports/AdjustmentsAssemblies/InventoryAdjustments",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Inventory Adjustments'),
        "href"=> "page=autoreports&source=RptListInventoryAdjustments&id=1506976595&title=Inventory Adjustments",
        "short" => "In"
        ],
        [
        "id" => "Reports/InventoryReports/AdjustmentsAssemblies/AdjustmentsDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Adjustments Detail'),
        "href"=> "page=autoreports&source=RptListInventoryAdjustmentsDetail&id=1522976652&title=Inventory Adjustments Detail",
        "short" => "Ad"
        ],
        [
        "id" => "Reports/InventoryReports/AdjustmentsAssemblies/AdjustmentTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Adjustment Types'),
        "href"=> "page=autoreports&source=RptListInventoryAdjustmentTypes&id=1490976538&title=Inventory Adjustment Types",
        "short" => "Ad"
        ]
    ]
    ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/CRMReports",
    "full" => $translation->translateLabel('CRM Reports'),
    "short" => "CR",
    "data" => [

        [
        "id" => "Reports/CRMReports/LeadInformation",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Lead Information'),
        "href"=> "page=autoreports&source=RptListLeadInformation&id=1746977450&title=Lead Information",
        "short" => "Le"
        ],
        [
        "id" => "Reports/CRMReports/LeadComments",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Lead Comments'),
        "href"=> "page=autoreports&source=RptListLeadComments&id=1714977336&title=Lead Comments",
        "short" => "Le"
        ],
        [
        "id" => "Reports/CRMReports/LeadContacts",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Lead Contacts'),
        "href"=> "page=autoreports&source=RptListLeadContacts&id=1730977393&title=Lead Contacts",
        "short" => "Le"
        ],
        [
        "id" => "Reports/CRMReports/LeadTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Lead Types'),
        "href"=> "page=autoreports&source=RptListLeadType&id=1762977507&title=Lead Types",
        "short" => "Le"
        ],
        [
        "id" => "Reports/CRMReports/AllLeadEmails",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('All Lead Emails'),
        "href"=> "page=autoreports&source=RptListAllLeadEmails&id=1553648828&title=All Lead Emails",
        "short" => "Al"
        ],
        [
        "id" => "Reports/CRMReports/WeeklyLeadEmails",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Weekly Lead Emails'),
        "href"=> "page=autoreports&source=RptListAllWeeklyLeadEmails&id=1585648942&title=Weekly Lead Emails",
        "short" => "We"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/PayrollReports",
    "full" => $translation->translateLabel('Payroll Reports'),
    "short" => "Pa",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/PayrollReports/PayrollSetupReports",
    "full" => $translation->translateLabel('Payroll Setup Reports'),
    "short" => "Pa",
    "data" => [

        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollSetup",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Setup'),
        "href"=> "page=autoreports&source=RptListPayrollSetup&id=2146978875&title=Payroll Setup",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollRegister",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Register'),
        "href"=> "page=autoreports&source=RptListPayrollRegister&id=2114978761&title=Payroll Register",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollRegisterDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Register Detail'),
        "href"=> "page=autoreports&source=RptListPayrollRegisterDetail&id=2130978818&title=Payroll Register Detail",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollItems",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Items'),
        "href"=> "page=autoreports&source=RptListPayrollItems&id=2098978704&title=Payroll Items",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollItemTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Item Types'),
        "href"=> "page=autoreports&source=RptListPayrollItemTypes&id=2082978647&title=Payroll Item Types",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollChecks",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Checks'),
        "href"=> "page=autoreports&source=RptPayrollCheck&id=1818645722&title=Payroll Checks",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollCheckStubs",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Check Stubs'),
        "href"=> "page=autoreports&source=RptPayrollCheckStub&id=431496766&title=Payroll Check Stubs",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/CheckSummary",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Check Summary'),
        "href"=> "page=autoreports&source=RptPayrollCheckSummary&id=447496823&title=Payroll Check Summary",
        "short" => "Ch"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/PayrollCheckType",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Payroll Check Type'),
        "href"=> "page=autoreports&source=RptListPayrollCheckType&id=2018978419&title=Payroll Check Type",
        "short" => "Pa"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/W2Report",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('W2 Report'),
        "href"=> "page=autoreports&source=RptListPayrollW2Detail&id=15495284&title=W2 Report",
        "short" => "W2"
        ],
        [
        "id" => "Reports/PayrollReports/PayrollSetupReports/W3Report",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('W3 Report'),
        "href"=> "page=autoreports&source=RptListPayrollW3Detail&id=31495341&title=W3 Report",
        "short" => "W3"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/PayrollReports/EmployeeReports",
    "full" => $translation->translateLabel('Employee Reports'),
    "short" => "Em",
    "data" => [

        [
        "id" => "Reports/PayrollReports/EmployeeReports/Employees",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Employees'),
        "href"=> "page=autoreports&source=RptListPayrollEmployees&id=2050978533&title=Employees",
        "short" => "Em"
        ],
        [
        "id" => "Reports/PayrollReports/EmployeeReports/EmployeeDetails",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Employee Details'),
        "href"=> "page=autoreports&source=RptListPayrollEmployeesDetail&id=2066978590&title=Employee Details",
        "short" => "Em"
        ],
        [
        "id" => "Reports/PayrollReports/EmployeeReports/EmployeeTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Employee Types'),
        "href"=> "page=autoreports&source=RptListPayrollEmployeeType&id=2034978476&title=Employee Types",
        "short" => "Em"
        ],
        [
        "id" => "Reports/PayrollReports/EmployeeReports/SalesCommissions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Sales Commissions'),
        "href"=> "page=autoreports&source=RptSalesComissions&id=463496880&title=Sales Commissions",
        "short" => "Sa"
        ]
    ]
    ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/SetupReports",
    "full" => $translation->translateLabel('Setup Reports'),
    "short" => "Se",
    "data" => [

    [
    "type" => "submenu",
    "id" => "Reports/SetupReports/CompanySetupReports",
    "full" => $translation->translateLabel('Company Setup Reports'),
    "short" => "Co",
    "data" => [

        [
        "id" => "Reports/SetupReports/CompanySetupReports/Companies",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Companies'),
        "href"=> "page=autoreports&source=RptListCompanies&id=1786645608&title=Companies",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/CompanySetupReports/Divisions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Divisions'),
        "href"=> "page=autoreports&source=RptListDivisions&id=1802645665&title=Divisions",
        "short" => "Di"
        ],
        [
        "id" => "Reports/SetupReports/CompanySetupReports/Departments",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Departments'),
        "href"=> "page=autoreports&source=RptListDepartments&id=1298975854&title=Departments",
        "short" => "De"
        ],
        [
        "id" => "Reports/SetupReports/CompanySetupReports/AuditTrail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Audit Trail'),
        "href"=> "page=autoreports&source=RptListAuditTrail&id=786974030&title=Audit Trail",
        "short" => "Au"
        ],
        [
        "id" => "Reports/SetupReports/CompanySetupReports/AccessPermissions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Access Permissions'),
        "href"=> "page=autoreports&source=RptListAccessPermissions&id=770973973&title=Access Permissions",
        "short" => "Ac"
        ],
        [
        "id" => "Reports/SetupReports/CompanySetupReports/ErrorLog",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Error Log'),
        "href"=> "page=autoreports&source=RptListErrorLog&id=1410976253&title=Error Log",
        "short" => "Er"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/SetupReports/OtherSetupReports",
    "full" => $translation->translateLabel('Other Setup Reports'),
    "short" => "Ot",
    "data" => [

        [
        "id" => "Reports/SetupReports/OtherSetupReports/CreditCardTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Credit Card Types'),
        "href"=> "page=autoreports&source=RptListCreditCardTypes&id=1074975056&title=Credit Card Types",
        "short" => "Cr"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/Terms",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Terms'),
        "href"=> "page=autoreports&source=RptListTerms&id=255496139&title=Terms",
        "short" => "Te"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/CommentTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Comment Types'),
        "href"=> "page=autoreports&source=RptListCommentTypes&id=930974543&title=Comment Types",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/Warehouses",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Warehouses'),
        "href"=> "page=autoreports&source=RptListWarehouses&id=399496652&title=Warehouses",
        "short" => "Wa"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ShipmentMethods",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Shipment Methods'),
        "href"=> "page=autoreports&source=RptListShipmentMethods&id=191495911&title=Shipment Methods",
        "short" => "Sh"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ContactIndustry",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contact Industry'),
        "href"=> "page=autoreports&source=RptListContactIndustry&id=962974657&title=Contact Industry",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ContactRegions",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contact Regions'),
        "href"=> "page=autoreports&source=RptListContactRegions&id=978974714&title=Contact Regions",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ContactSource",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contact Source'),
        "href"=> "page=autoreports&source=RptListContactSource&id=994974771&title=Contact Source",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ContactType",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Contact Type'),
        "href"=> "page=autoreports&source=RptListContactType&id=1010974828&title=Contact Type",
        "short" => "Co"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/Taxes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Taxes'),
        "href"=> "page=autoreports&source=RptListTaxes&id=239496082&title=Taxes",
        "short" => "Ta"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/TaxGroups",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Tax Groups'),
        "href"=> "page=autoreports&source=RptListTaxGroups&id=1054118996&title=Tax Groups",
        "short" => "Ta"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/TaxGroupsDetail",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Tax Groups Detail'),
        "href"=> "page=autoreports&source=RptListTaxGroupDetail&id=1038118939&title=Tax Groups Detail",
        "short" => "Ta"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/Projects",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Projects'),
        "href"=> "page=autoreports&source=RptListProjects&id=79495512&title=Projects",
        "short" => "Pr"
        ],
        [
        "id" => "Reports/SetupReports/OtherSetupReports/ProjectTypes",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Project Types'),
        "href"=> "page=autoreports&source=RptListProjectTypes&id=63495455&title=Project Types",
        "short" => "Pr"
        ]
    ]
    ]
    ]
    ]
]
];
?>
