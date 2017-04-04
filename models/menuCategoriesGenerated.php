<?php 
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
        ],
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
        ]
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
        "href_ended" => "GeneralLedger/LedgerSetup/CloseYear&mode=edit&category=Main&item=" . $keyString,
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
        "id" => "Reports/Financials/ExcelWorksheets",
        "full" => $translation->translateLabel('Excel Worksheets'),
        "href"=> "reports/Worksheets/Worksheet",
        "short" => "Ex"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsReceivableReports",
    "full" => $translation->translateLabel('Accounts Receivable Reports'),
    "short" => "Ac",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/AccountsPayableReports",
    "full" => $translation->translateLabel('Accounts Payable Reports'),
    "short" => "Ac",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/LedgerReports",
    "full" => $translation->translateLabel('Ledger Reports'),
    "short" => "Le",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/InventoryReports",
    "full" => $translation->translateLabel('Inventory Reports'),
    "short" => "In",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/CRMReports",
    "full" => $translation->translateLabel('CRM Reports'),
    "short" => "CR",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/PayrollReports",
    "full" => $translation->translateLabel('Payroll Reports'),
    "short" => "Pa",
    "data" => [
    ]
    ],
    [
    "type" => "submenu",
    "id" => "Reports/SetupReports",
    "full" => $translation->translateLabel('Setup Reports'),
    "short" => "Se",
    "data" => [
    ]
    ]
]
];

$menuCategories["AccountsReceivable"] = [
"type" => "submenu",
"id" => "AccountsReceivable",
"full" => $translation->translateLabel('Accounts Receivable'),
"short" => "Ac",
"data" => [

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
        "id" => "AccountsReceivable/OrderScreens/StoreInvoices",
        "full" => $translation->translateLabel('Store Invoices'),
        "href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderStoreList",
        "short" => "St"
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
        "id" => "AccountsReceivable/ServiceScreens/StoreServiceOrders",
        "full" => $translation->translateLabel('Store Service Orders'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderStoreList",
        "short" => "St"
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
        [
        "id" => "AccountsReceivable/ServiceScreens/StoreServiceInvoices",
        "full" => $translation->translateLabel('Store Service Invoices'),
        "href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderStoreList",
        "short" => "St"
        ]
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
        "id" => "AccountsReceivable/CreditMemos/StoreCreditMemos",
        "full" => $translation->translateLabel('Store Credit Memos'),
        "href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderStoreList",
        "short" => "St"
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
        "id" => "AccountsReceivable/RMAScreens/StoreRMAs",
        "full" => $translation->translateLabel('Store RMA\'s'),
        "href"=> "EnterpriseASPAR/RMA/RMAHeaderStoreList",
        "short" => "St"
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
        "id" => "AccountsReceivable/CashReceiptsScreens/StoreCashReceipts",
        "full" => $translation->translateLabel('Store Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderStoreList",
        "short" => "St"
        ],
        [
        "id" => "AccountsReceivable/CashReceiptsScreens/ProcessCashReceipts",
        "full" => $translation->translateLabel('Process Cash Receipts'),
        "href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
        "short" => "Pr"
        ]
    ]
    ],
    [
    "type" => "submenu",
    "id" => "AccountsReceivable/Customers",
    "full" => $translation->translateLabel('Customers'),
    "short" => "Cu",
    "data" => [

        [
        "id" => "AccountsReceivable/Customers/ViewCustomers",
        "full" => $translation->translateLabel('View Customers'),
        "href"=> "EnterpriseASPAR/Customers/CustomerInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsReceivable/Customers/ViewCustomerFinancials",
        "full" => $translation->translateLabel('View Customer Financials'),
        "href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
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
        "id" => "AccountsPayable/PurchaseScreens/StorePurchases",
        "full" => $translation->translateLabel('Store Purchases'),
        "href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderStoreList",
        "short" => "St"
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
        "id" => "AccountsPayable/VoucherScreens/StoreVocuhers",
        "full" => $translation->translateLabel('Store Vocuhers'),
        "href"=> "EnterpriseASPAP/Payments/PaymentsHeaderStoreList",
        "short" => "St"
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
        "id" => "AccountsPayable/DebitMemos/ViewStoreDebitMemo",
        "full" => $translation->translateLabel('View Store Debit Memo'),
        "href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderStoreList",
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
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewStoreReturns",
        "full" => $translation->translateLabel('View Store Returns'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderStoreList",
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
        "id" => "AccountsPayable/ReturntoVendorScreens/ViewStoreReturnInvoices",
        "full" => $translation->translateLabel('View Store Return Invoices'),
        "href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderStoreList",
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
    ],
    [
    "type" => "submenu",
    "id" => "AccountsPayable/Vendors",
    "full" => $translation->translateLabel('Vendors'),
    "short" => "Ve",
    "data" => [

        [
        "id" => "AccountsPayable/Vendors/ViewVendors",
        "full" => $translation->translateLabel('View Vendors'),
        "href"=> "EnterpriseASPAP/Vendors/VendorInformationList",
        "short" => "Vi"
        ],
        [
        "id" => "AccountsPayable/Vendors/ViewVendorFinancials",
        "full" => $translation->translateLabel('View Vendor Financials'),
        "href"=> "EnterpriseASPAP/Vendors/VendorFinancialsList",
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
        ],
        [
        "id" => "MRP/WorkOrders/StoreWorkOrders",
        "full" => $translation->translateLabel('Store Work Orders'),
        "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderStoreList",
        "short" => "St"
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
];
$menuCategories["Payroll"] = [
"type" => "submenu",
"id" => "Payroll",
"full" => $translation->translateLabel('Payroll'),
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
        "href_ended" => "SystemSetup/LedgerSetup/CloseYear&mode=edit&category=Main&item=" . $keyString,
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
?>