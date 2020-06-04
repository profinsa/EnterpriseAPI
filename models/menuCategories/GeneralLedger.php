<?php
$categories["GeneralLedger"] = [
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
				"id" => "GeneralLedger/Ledger/ViewLedgerAccountSubGroup",
				"full" => $translation->translateLabel('View Ledger Account Sub Group'),
				"href"=> "EnterpriseASPGL/Ledger/LedgerAccountSubGroupList",
				"short" => "Vi"
            ],
            [
				"id" => "GeneralLedger/Ledger/ViewGLTransactions",
				"full" => $translation->translateLabel('View GL Transactions'),
				"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsList",
				"short" => "Vi"
            ],
            [
				"id" => "GeneralLedger/Ledger/MemorizedGLTransactions",
				"full" => $translation->translateLabel('Memorized GL Transactions'),
				"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsMemorizedList",
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
				"id" => "GeneralLedger/Ledger/BankDeposits",
				"full" => $translation->translateLabel('View Bank Deposits'),
				"href"=> "EnterpriseASPGL/Ledger/LedgerBankDeposits",
				"short" => "Bd"
            ],        [
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
				"id" => "GeneralLedger/LedgerSetup/ViewStoredChartofAccounts",
				"full" => $translation->translateLabel('View Stored Chart of Accounts'),
				"href"=> "EnterpriseASPGL/LedgerSetup/LedgerStoredChartOfAccountsList",
				"short" => "Vi"
            ],
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
            ],
            [
				"id" => "GeneralLedger/LedgerSetup/ControlNumbers",
				"full" => $translation->translateLabel('Control Numbers'),
				"href"=> "EnterpriseASPSystem/LedgerSetup/ControlNumbersList",
				"short" => "De"
            ],
            [
				"id" => "GeneralLedger/LedgerSetup/OFXImport",
				"full" => $translation->translateLabel('QFX & OFX Import'),
				"href"=> "EnterpriseASPSystem/LedgerSetup/OFXImportList",
				"short" => "De"
            ]
        ]
    ]
];
?>