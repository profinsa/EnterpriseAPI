<?php
$menuCategories = [];
if($scope->user["accesspermissions"]["GLView"]){
    $menuCategories["GeneralLedger"] = [
        "id" => "GeneralLedger",
        "full"=> $translation->translateLabel('General Ledger'),
        "short" => "GL",
        "type" => "submenu",
        "data" => [
			[
			    "id" => "GeneralLedger/chartOfAccounts",
			    "full" => $translation->translateLabel('Chart Of Accounts'),
			    "short" => "CO",
			    "href"=> "GeneralLedger/chartOfAccounts"
			],
			[
			    "id" => "GeneralLedger/ledgerAccountGroup",
			    "full" => $translation->translateLabel('Ledger Account Group'),
			    "short" => "LA",
			    "href" => "GeneralLedger/ledgerAccountGroup"
			],
			[
			    "id" => "GeneralLedger/bankTransactions",
			    "full" => $translation->translateLabel('Bank Transactions'),
			    "short" => "BT",
			    "href" => "GeneralLedger/bankTransactions"
			],
			[
			    "id" => "GeneralLedger/bankAccounts",
			    "full" => $translation->translateLabel('Bank Accounts'),
			    "short" => "BA",
			    "href" => "GeneralLedger/bankAccounts"
			]
        ]
    ];
}

$menuCategories['Receivables'] = [
    "type" => "submenu",
    "id" => "Receivables",
    "full" => $translation->translateLabel('Receivables'),
    "short" => "AR",
    "data" => [
        [
			"id" => "Receivables/Quotes",
			"full" => $translation->translateLabel('Quotes'),
			"short" => "Qu",
			"href"=> "#"
        ],
        [
			"id" => "Receivables/Orders",
			"full" => $translation->translateLabel('Orders'),
			"short" => "Or",
			"href" => "#"
        ],
        [
			"id" => "Receivables/Invoices",
			"full" => $translation->translateLabel('Invoices'),
			"short" => "In",
			"href" => "#"
        ]
    ]
];
	    
$menuCategories["Payables"] = [
    "type" => "submenu",
    "id" => "Payables",
    "full" => $translation->translateLabel('Payables'),
    "short" => "AP",
    "data" => [
        [
			"id" => "Payables/PurchaseOrders",
			"full" => $translation->translateLabel('Purchase Orders'),
			"href"=> "#",
			"short" => "PO"
        ],
        [
			"id" => "Payables/Vouchers",
			"full" => $translation->translateLabel('Vouchers'),
			"href" => "#",
			"short" => "Vo"
        ],
        [
			"id" => "Payables/Vendors",
			"full" => $translation->translateLabel('Vendors'),
			"href" => "#",
			"short" => "Ve"
        ]
    ]
];

$menuCategories["Projects"] = [
    "type" => "submenu",
    "id" => "Projects",
    "full" => $translation->translateLabel('Projects'),
    "short" => "Pr",
    "data" => [

        [
            "id" => "Projects/ProjectTypes",
            "full" => $translation->translateLabel('Project Types'),
            "href"=> "Projects/ProjectTypes",
            "short" => "Pr"
        ],
        [
            "id" => "Projects/Projects",
            "full" => $translation->translateLabel('Projects'),
            "href"=> "Projects/Projects",
            "short" => "Pr"
        ]
    ]
];

$menuCategories["OrderProcessing"] = [
    "type" => "submenu",
    "id" => "OrderProcessing",
    "full" => $translation->translateLabel('OrderProcessing'),
    "short" => "Or",
    "data" => [

        [
            "id" => "OrderProcessing/ContractTrackingHeader",
            "full" => $translation->translateLabel('ContractTrackingHeader'),
            "href"=> "OrderProcessing/ContractTrackingHeader",
            "short" => "Co"
        ],
        [
            "id" => "OrderProcessing/ContractsHeader",
            "full" => $translation->translateLabel('Contracts'),
            "href"=> "OrderProcessing/ContractsHeader",
            "short" => "Co"
        ],
        [
            "id" => "OrderProcessing/InvoiceHeaderClosed",
            "full" => $translation->translateLabel('Closed Invoices'),
            "href"=> "OrderProcessing/InvoiceHeaderClosed",
            "short" => "Cl"
        ],
        [
            "id" => "OrderProcessing/InvoiceHeader",
            "full" => $translation->translateLabel('Invoices'),
            "href"=> "OrderProcessing/InvoiceHeader",
            "short" => "In"
        ],
        [
            "id" => "OrderProcessing/InvoiceHeaderHistory",
            "full" => $translation->translateLabel('Invoices History'),
            "href"=> "OrderProcessing/InvoiceHeaderHistory",
            "short" => "In"
        ],
        [
            "id" => "OrderProcessing/InvoiceHeaderMemorized",
            "full" => $translation->translateLabel('Memorized Invoices'),
            "href"=> "OrderProcessing/InvoiceHeaderMemorized",
            "short" => "Me"
        ],
        [
            "id" => "OrderProcessing/InvoiceTrackingHeader",
            "full" => $translation->translateLabel('InvoiceTrackingHeader'),
            "href"=> "OrderProcessing/InvoiceTrackingHeader",
            "short" => "In"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderBack",
            "full" => $translation->translateLabel('Back Orders'),
            "href"=> "OrderProcessing/OrderHeaderBack",
            "short" => "Ba"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderClosed",
            "full" => $translation->translateLabel('Closed Orders'),
            "href"=> "OrderProcessing/OrderHeaderClosed",
            "short" => "Cl"
        ],
        [
            "id" => "OrderProcessing/OrderHeader",
            "full" => $translation->translateLabel('Orders'),
            "href"=> "OrderProcessing/OrderHeader",
            "short" => "Or"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderHistory",
            "full" => $translation->translateLabel('Orders History'),
            "href"=> "OrderProcessing/OrderHeaderHistory",
            "short" => "Or"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderHold",
            "full" => $translation->translateLabel('Orders On Hold'),
            "href"=> "OrderProcessing/OrderHeaderHold",
            "short" => "Or"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderInvoice",
            "full" => $translation->translateLabel('Invoice Shipped Orders'),
            "href"=> "OrderProcessing/OrderHeaderInvoice",
            "short" => "In"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderPick",
            "full" => $translation->translateLabel('Pick Orders'),
            "href"=> "OrderProcessing/OrderHeaderPick",
            "short" => "Pi"
        ],
        [
            "id" => "OrderProcessing/OrderHeaderShip",
            "full" => $translation->translateLabel('Ship Orders'),
            "href"=> "OrderProcessing/OrderHeaderShip",
            "short" => "Sh"
        ],
        [
            "id" => "OrderProcessing/OrderTrackingDetail",
            "full" => $translation->translateLabel('OrderTrackingDetail'),
            "href"=> "OrderProcessing/OrderTrackingDetail",
            "short" => "Or"
        ],
        [
            "id" => "OrderProcessing/OrderTrackingHeader",
            "full" => $translation->translateLabel('OrderTrackingHeader'),
            "href"=> "OrderProcessing/OrderTrackingHeader",
            "short" => "Or"
        ],
        [
            "id" => "OrderProcessing/QuoteHeader",
            "full" => $translation->translateLabel('Quotes'),
            "href"=> "OrderProcessing/QuoteHeader",
            "short" => "Qu"
        ],
        [
            "id" => "OrderProcessing/QuoteTrackingHeader",
            "full" => $translation->translateLabel('QuoteTrackingHeader'),
            "href"=> "OrderProcessing/QuoteTrackingHeader",
            "short" => "Qu"
        ],
        [
            "id" => "OrderProcessing/ServiceOrderHeader",
            "full" => $translation->translateLabel('Service Orders'),
            "href"=> "OrderProcessing/ServiceOrderHeader",
            "short" => "Se"
        ]
    ]
];

$menuCategories["ServiceProcessing"] = [
    "type" => "submenu",
    "id" => "ServiceProcessing",
    "full" => $translation->translateLabel('ServiceProcessing'),
    "short" => "Se",
    "data" => [

        [
            "id" => "ServiceProcessing/ServiceInvoiceHeaderClosed",
            "full" => $translation->translateLabel('Closed Service Invoices'),
            "href"=> "ServiceProcessing/ServiceInvoiceHeaderClosed",
            "short" => "Cl"
        ],
        [
            "id" => "ServiceProcessing/ServiceInvoiceHeader",
            "full" => $translation->translateLabel('Service Invoices'),
            "href"=> "ServiceProcessing/ServiceInvoiceHeader",
            "short" => "Se"
        ],
        [
            "id" => "ServiceProcessing/ServiceInvoiceHeaderHistory",
            "full" => $translation->translateLabel('Service Invoices History'),
            "href"=> "ServiceProcessing/ServiceInvoiceHeaderHistory",
            "short" => "Se"
        ],
        [
            "id" => "ServiceProcessing/ServiceInvoiceHeaderMemorized",
            "full" => $translation->translateLabel('InvoiceHeader'),
            "href"=> "ServiceProcessing/ServiceInvoiceHeaderMemorized",
            "short" => "In"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderClosed",
            "full" => $translation->translateLabel('Closed Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderClosed",
            "short" => "Cl"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeader",
            "full" => $translation->translateLabel('Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeader",
            "short" => "Se"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderHistory",
            "full" => $translation->translateLabel('Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderHistory",
            "short" => "Se"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderHold",
            "full" => $translation->translateLabel('Service Orders On Hold'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderHold",
            "short" => "Se"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderInvoice",
            "full" => $translation->translateLabel('Invoice Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderInvoice",
            "short" => "In"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderMemorized",
            "full" => $translation->translateLabel('Memorized Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderMemorized",
            "short" => "Me"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderPick",
            "full" => $translation->translateLabel('Fulfill Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderPick",
            "short" => "Fu"
        ],
        [
            "id" => "ServiceProcessing/ServiceOrderHeaderShip",
            "full" => $translation->translateLabel('Perform Service Orders'),
            "href"=> "ServiceProcessing/ServiceOrderHeaderShip",
            "short" => "Pe"
        ]
    ]
];

$menuCategories["Customers"] = [
    "type" => "submenu",
    "id" => "Customers",
    "full" => $translation->translateLabel('Customers'),
    "short" => "Cu",
    "data" => [

        [
            "id" => "Customers/CommentTypes",
            "full" => $translation->translateLabel('Comment Types'),
            "href"=> "Customers/CommentTypes",
            "short" => "Co"
        ],
        [
            "id" => "Customers/CustomerAccountStatuses",
            "full" => $translation->translateLabel('Customer Account Statuses'),
            "href"=> "Customers/CustomerAccountStatuses",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerComments",
            "full" => $translation->translateLabel('Customer Comments'),
            "href"=> "Customers/CustomerComments",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerContactLog",
            "full" => $translation->translateLabel('Customer Contact Log'),
            "href"=> "Customers/CustomerContactLog",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerContacts",
            "full" => $translation->translateLabel('Customer Contacts'),
            "href"=> "Customers/CustomerContacts",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerCreditReferences",
            "full" => $translation->translateLabel('Customer Credit References'),
            "href"=> "Customers/CustomerCreditReferences",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerFinancials",
            "full" => $translation->translateLabel('Customer Financials'),
            "href"=> "Customers/CustomerFinancials",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerInformation",
            "full" => $translation->translateLabel('Customer Information'),
            "href"=> "Customers/CustomerInformation",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerItemCrossReference",
            "full" => $translation->translateLabel('Customer Item Cross Reference'),
            "href"=> "Customers/CustomerItemCrossReference",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerPriceCrossReference",
            "full" => $translation->translateLabel('Customer Price Cross Reference'),
            "href"=> "Customers/CustomerPriceCrossReference",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerReferences",
            "full" => $translation->translateLabel('CustomerReferences'),
            "href"=> "Customers/CustomerReferences",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerSatisfaction",
            "full" => $translation->translateLabel('CustomerSatisfaction'),
            "href"=> "Customers/CustomerSatisfaction",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerShipForLocations",
            "full" => $translation->translateLabel('Customer Ship For Locations'),
            "href"=> "Customers/CustomerShipForLocations",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerShipToLocations",
            "full" => $translation->translateLabel('Customer Ship To Locations'),
            "href"=> "Customers/CustomerShipToLocations",
            "short" => "Cu"
        ],
        [
            "id" => "Customers/CustomerTypes",
            "full" => $translation->translateLabel('Customer Types'),
            "href"=> "Customers/CustomerTypes",
            "short" => "Cu"
        ]
    ]
];

?>
