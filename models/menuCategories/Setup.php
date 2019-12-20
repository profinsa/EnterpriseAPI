<?php
$categories["Setup"] = [
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
                "id" => "GeneralLedger/LedgerSetup/ViewStoredChartofAccounts",
                "full" => $translation->translateLabel('View Stored Chart of Accounts'),
                "href"=> "EnterpriseASPGL/LedgerSetup/LedgerStoredChartOfAccountsList",
                "short" => "Vi"
            ],
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
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIAddresses",
                "full" => $translation->translateLabel('EDI Addresses'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIAddressesList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIStatements",
                "full" => $translation->translateLabel('EDI Statements'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIStatementsList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIStatementsHistory",
                "full" => $translation->translateLabel('EDI Statements History'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIStatementsHistoryList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIOrders",
                "full" => $translation->translateLabel('EDI Orders'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIOrderHeaderList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIInvoices",
                "full" => $translation->translateLabel('EDI Invoices'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIInvoiceHeaderList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIPurchase",
                "full" => $translation->translateLabel('EDI Purchases'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIPurchaseHeaderList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIReceipts",
                "full" => $translation->translateLabel('EDI Receipts'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIReceiptsHeaderList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIPayments",
                "full" => $translation->translateLabel('EDI Payments'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIPaymentsHeaderList",
                "short" => "ED"
            ],
            [
                "id" => "SystemSetup/EDISetup/EDIItems",
                "full" => $translation->translateLabel('EDI Items'),
                "href"=> "EnterpriseASPSystem/EDISetup/EDIIItemsList",
                "short" => "ED"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "SystemSetup/SupportSetup",
        "full" => $translation->translateLabel('Support Set-up'),
        "short" => "Co",
        "data" => [
            [
                "id" => "CRMHelpDesk/HelpDesk/ViewSupportTypes",
                "full" => $translation->translateLabel('View Support Types'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
                "short" => "Vi"
            ],
            [
                "id" => "CRMHelpDesk/HelpDesk/ViewSupportRequests",
                "full" => $translation->translateLabel('View Support Requests'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestsList",
                "short" => "Vi"
            ]
        ]
    ]	
];
?>