<?php
$categories["Reports"] = [
    [
        "id" => "Reports/GenericReport",
        "type" => "relativeLink",
        "full" => $translation->translateLabel('Reports Engine'),
        "href"=> "page=grid&action=Reports/Autoreport/GenericReportDetail&mode=new&category=Main&item=" . $keyString,
        "short" => "Pr"
    ],
    [
        "type" => "submenu",
        "id" => "Reports/SavedReports",
        "full" => $translation->translateLabel('Saved Reports'),
        "short" => "Ac",
        "data" => []
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
];
?>