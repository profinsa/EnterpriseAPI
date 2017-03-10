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

?>
