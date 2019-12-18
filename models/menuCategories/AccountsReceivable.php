<?php
$categories["AccountsReceivable"] = [
    [
        "type" => "submenu",
        "id" => "AccountsReceivable/Customers",
        "full" => $translation->translateLabel('Customers'),
        "link" => "index.php#/?page=dashboard&screen=Customer",	
        "short" => "Cu",
        "data" => [
            [
				"id" => "AccountsReceivable/Customers/ViewCustomerFinancials",
				"full" => $translation->translateLabel('View Customer Financials'),
				"href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
				"short" => "Vi"
            ],
            [
                "type" => "submenu",
                "id" => "CRMHelpDesk",
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
                        "id" => "AccountsReceivable/OrderScreens/ViewQuotes",
                        "full" => $translation->translateLabel('View Quotes'),
                        "href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",
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
				"id" => "AccountsReceivable/OrderProcessing/ViewOrdersSimple",
				"full" => $translation->translateLabel('View Orders Simple'),
				"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderSimpleList",
				"short" => "Vi"
            ],
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
            ],
            [
				"id" => "AccountsReceivable/OrderProcessing/ViewInvoicesSimple",
				"full" => $translation->translateLabel('View Invoices Simple'),
				"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderSimpleList",
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
				"id" => "AccountsReceivable/OrderProcessing/ViewOrdersSimple",
				"full" => $translation->translateLabel('View Orders Simple'),
				"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderSimpleList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsReceivable/OrderScreens/ViewOrders",
				"full" => $translation->translateLabel('View Orders'),
				"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsReceivable/OrderScreens/ViewMemorizedOrders",
				"full" => $translation->translateLabel('Memorized Orders'),
				"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderMemorizedList",
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
				"id" => "AccountsReceivable/OrderProcessing/ViewInvoicesSimple",
				"full" => $translation->translateLabel('View Invoices Simple'),
				"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderSimpleList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsReceivable/OrderScreens/ViewInvoices",
				"full" => $translation->translateLabel('View Invoices'),
				"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsReceivable/OrderScreens/ViewMemorizedInvoices",
				"full" => $translation->translateLabel('Memorized Invoices'),
				"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderMemorizedList",
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
				"id" => "AccountsReceivable/OrderScreens/ViewMemorizedQuotes",
				"full" => $translation->translateLabel('Memorized Quotes'),
				"href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderMemorizedList",
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
];

?>