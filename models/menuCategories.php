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

$menuCategories["CashReceipts"] = [
    "type" => "submenu",
    "id" => "CashReceipts",
    "full" => $translation->translateLabel('CashReceipts'),
    "short" => "Ca",
    "data" => [

        [
            "id" => "CashReceipts/CashReceiptCustomer",
            "full" => $translation->translateLabel('Cash Receipts - Customers'),
            "href"=> "CashReceipts/CashReceiptCustomer",
            "short" => "Ca"
        ],
        [
            "id" => "CashReceipts/CashReceiptInvoice",
            "full" => $translation->translateLabel('View Cash Receipt Invoices'),
            "href"=> "CashReceipts/CashReceiptInvoice",
            "short" => "Vi"
        ],
        [
            "id" => "CashReceipts/CashReceiptsHeader",
            "full" => $translation->translateLabel('View Customer Receipts'),
            "href"=> "CashReceipts/CashReceiptsHeader",
            "short" => "Vi"
        ],
        [
            "id" => "CashReceipts/ReceiptsHeaderClosed",
            "full" => $translation->translateLabel('Closed Receipt'),
            "href"=> "CashReceipts/ReceiptsHeaderClosed",
            "short" => "Cl"
        ],
        [
            "id" => "CashReceipts/ReceiptsHeader",
            "full" => $translation->translateLabel('Receipts'),
            "href"=> "CashReceipts/ReceiptsHeader",
            "short" => "Re"
        ],
        [
            "id" => "CashReceipts/ReceiptsHeaderHistory",
            "full" => $translation->translateLabel('Receipts History'),
            "href"=> "CashReceipts/ReceiptsHeaderHistory",
            "short" => "Re"
        ],
        [
            "id" => "CashReceipts/ReceiptsHeaderMemorized",
            "full" => $translation->translateLabel('Memorized Receipts'),
            "href"=> "CashReceipts/ReceiptsHeaderMemorized",
            "short" => "Me"
        ]
    ]
];

?>
