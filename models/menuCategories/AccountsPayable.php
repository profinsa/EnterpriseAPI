<?php
$categories["AccountsPayable"] = [
    [
        "type" => "submenu",
        "id" => "AccountsPayable/Vendors",
        "full" => $translation->translateLabel('Vendors'),
        "link" => "index.php#/?page=dashboard&screen=Vendor",
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
				"id" => "AccountsPayable/PurchaseProcessing/ViewPurchasesSimple",
				"full" => $translation->translateLabel('View Purchases Simple'),
				"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderSimpleList",
				"short" => "Vi"
            ],
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
				"id" => "AccountsPayable/PurchaseProcessing/ViewPurchasesSimple",
				"full" => $translation->translateLabel('View Purchases Simple'),
				"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderSimpleList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsPayable/PurchaseScreens/ViewPurchases",
				"full" => $translation->translateLabel('View Purchases'),
				"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
				"short" => "Vi"
            ],
            [
				"id" => "AccountsPayable/PurchaseScreens/ViewMemorizedPurchases",
				"full" => $translation->translateLabel('Memorized Purchases'),
				"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderMemorizedList",
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
				"full" => $translation->translateLabel('View Vouchers History'),
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
        "id" => "AccountsPayable/Checks",
        "full" => $translation->translateLabel("Checks"),
        "short" => "CS",
        "data" => [
            [
				"id" => "AccountsPayable/Checks/PositivePayDetail",
				"full" => $translation->translateLabel('Positive Pay'),
				"href_ended" => "AccountsPayable/Checks/PositivePayDetail&mode=new&category=Main&item=" . $keyString,
				"href"=> "EnterpriseASAP/Checks/PositivePayDetail",
				"short" => "Pp"
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
];
?>