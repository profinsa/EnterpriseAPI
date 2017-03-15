<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companies";
public $dashboardTitle ="Year Close ";
public $breadCrumbTitle ="Year Close ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"FiscalStartDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"FiscalEndDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"CurrentFiscalYear" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
],
"CurrentPeriod" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period1Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period2Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period3Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period4Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period5Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period6Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period7Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period8Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period9Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period10Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period11Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period12Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period13Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"Period14Date" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"CompanyName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyWebAddress" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyLogoUrl" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyLogoFilename" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyShoppingCartURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyReportsDirectoryURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanySupportDirectoryURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyWebCRMDirectoryURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"BankAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Terms" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"FedTaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"StateTaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VATRegistrationNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VATSalesTaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VATPurchaseTaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VATOtherRegistrationNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultGLPostingDate" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultSalesGLTracking" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultGLPurchaseGLTracking" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultSalesTaxGroup" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPurchaseTaxGroup" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultInventoryCostingMethod" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AgeInvoicesBy" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AgePurchaseOrdersBy" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"FinanceCharge" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"FinanceChargePercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingMethod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ChargeHandling" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"HandlingAsPercent" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"HandlingRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ChargeMinimumSurcharge" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumSurchargeThreshold" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPCashAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPInventoryAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPFreightAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPHandlingAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPMiscAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPDiscountAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPPrePaidAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAPWriteOffAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARCashAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARSalesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARCOGSAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARInventoryAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARFreightAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARHandlingAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARDiscountAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARMiscAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARReturnAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARWriteOffAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedAccumDepreciationAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedDepreciationAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedAssetAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedDisposalAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankInterestEarnedAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankServiceChargesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankMiscWithdrawlAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankBankMisDepositAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankOtherChargesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLRetainedEarningsAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLProfitLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLUnrealizedCurrencyProfitLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLRealizedCurrencyProfitLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLARFreightProfitLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrencyGainLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLUnrealizedCurrencyGainLossAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"FiscalStartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"FiscalEndDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrentFiscalYear" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentPeriod" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period1Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period2Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period3Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period4Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period5Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period6Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period7Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period8Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period9Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period10Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period11Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period12Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period13Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period14Date" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period1Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period2Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period3Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period4Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period5Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period6Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period7Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period8Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period9Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period10Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period11Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period12Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period13Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Period14Closed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GAAPCompliant" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EditGLTranssactions" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EditBankTransactions" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EditAPTransactions" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EditARTransactions" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"HardClose" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditTrail" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PeriodPosting" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"SystemDates" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"FiscalStartDate" => "Fiscal Start Date",
"FiscalEndDate" => "Fiscal End Date",
"CurrentFiscalYear" => "Current Fiscal Year",
"CurrentPeriod" => "Current Period",
"Period1Date" => "Period1 Date",
"Period2Date" => "Period2 Date",
"Period3Date" => "Period3 Date",
"Period4Date" => "Period4 Date",
"Period5Date" => "Period5 Date",
"Period6Date" => "Period6 Date",
"Period7Date" => "Period7 Date",
"Period8Date" => "Period8 Date",
"Period9Date" => "Period9 Date",
"Period10Date" => "Period10 Date",
"Period11Date" => "Period11 Date",
"Period12Date" => "Period12 Date",
"Period13Date" => "Period13 Date",
"Period14Date" => "Period14 Date",
"CompanyName" => "CompanyName",
"CompanyAddress1" => "CompanyAddress1",
"CompanyAddress2" => "CompanyAddress2",
"CompanyAddress3" => "CompanyAddress3",
"CompanyCity" => "CompanyCity",
"CompanyState" => "CompanyState",
"CompanyZip" => "CompanyZip",
"CompanyCountry" => "CompanyCountry",
"CompanyPhone" => "CompanyPhone",
"CompanyFax" => "CompanyFax",
"CompanyEmail" => "CompanyEmail",
"CompanyWebAddress" => "CompanyWebAddress",
"CompanyLogoUrl" => "CompanyLogoUrl",
"CompanyLogoFilename" => "CompanyLogoFilename",
"CompanyShoppingCartURL" => "CompanyShoppingCartURL",
"CompanyReportsDirectoryURL" => "CompanyReportsDirectoryURL",
"CompanySupportDirectoryURL" => "CompanySupportDirectoryURL",
"CompanyWebCRMDirectoryURL" => "CompanyWebCRMDirectoryURL",
"CompanyNotes" => "CompanyNotes",
"CurrencyID" => "CurrencyID",
"BankAccount" => "BankAccount",
"Terms" => "Terms",
"FedTaxID" => "FedTaxID",
"StateTaxID" => "StateTaxID",
"VATRegistrationNumber" => "VATRegistrationNumber",
"VATSalesTaxID" => "VATSalesTaxID",
"VATPurchaseTaxID" => "VATPurchaseTaxID",
"VATOtherRegistrationNumber" => "VATOtherRegistrationNumber",
"DefaultGLPostingDate" => "DefaultGLPostingDate",
"DefaultSalesGLTracking" => "DefaultSalesGLTracking",
"DefaultGLPurchaseGLTracking" => "DefaultGLPurchaseGLTracking",
"DefaultSalesTaxGroup" => "DefaultSalesTaxGroup",
"DefaultPurchaseTaxGroup" => "DefaultPurchaseTaxGroup",
"DefaultInventoryCostingMethod" => "DefaultInventoryCostingMethod",
"AgeInvoicesBy" => "AgeInvoicesBy",
"AgePurchaseOrdersBy" => "AgePurchaseOrdersBy",
"FinanceCharge" => "FinanceCharge",
"FinanceChargePercent" => "FinanceChargePercent",
"WarehouseID" => "WarehouseID",
"WarehouseBinID" => "WarehouseBinID",
"ShippingMethod" => "ShippingMethod",
"ChargeHandling" => "ChargeHandling",
"HandlingAsPercent" => "HandlingAsPercent",
"HandlingRate" => "HandlingRate",
"ChargeMinimumSurcharge" => "ChargeMinimumSurcharge",
"MinimumSurchargeThreshold" => "MinimumSurchargeThreshold",
"GLAPAccount" => "GLAPAccount",
"GLAPCashAccount" => "GLAPCashAccount",
"GLAPInventoryAccount" => "GLAPInventoryAccount",
"GLAPFreightAccount" => "GLAPFreightAccount",
"GLAPHandlingAccount" => "GLAPHandlingAccount",
"GLAPMiscAccount" => "GLAPMiscAccount",
"GLAPDiscountAccount" => "GLAPDiscountAccount",
"GLAPPrePaidAccount" => "GLAPPrePaidAccount",
"GLAPWriteOffAccount" => "GLAPWriteOffAccount",
"GLARAccount" => "GLARAccount",
"GLARCashAccount" => "GLARCashAccount",
"GLARSalesAccount" => "GLARSalesAccount",
"GLARCOGSAccount" => "GLARCOGSAccount",
"GLARInventoryAccount" => "GLARInventoryAccount",
"GLARFreightAccount" => "GLARFreightAccount",
"GLARHandlingAccount" => "GLARHandlingAccount",
"GLARDiscountAccount" => "GLARDiscountAccount",
"GLARMiscAccount" => "GLARMiscAccount",
"GLARReturnAccount" => "GLARReturnAccount",
"GLARWriteOffAccount" => "GLARWriteOffAccount",
"GLFixedAccumDepreciationAccount" => "GLFixedAccumDepreciationAccount",
"GLFixedDepreciationAccount" => "GLFixedDepreciationAccount",
"GLFixedAssetAccount" => "GLFixedAssetAccount",
"GLFixedDisposalAccount" => "GLFixedDisposalAccount",
"GLBankInterestEarnedAccount" => "GLBankInterestEarnedAccount",
"GLBankServiceChargesAccount" => "GLBankServiceChargesAccount",
"GLBankMiscWithdrawlAccount" => "GLBankMiscWithdrawlAccount",
"GLBankBankMisDepositAccount" => "GLBankBankMisDepositAccount",
"GLBankOtherChargesAccount" => "GLBankOtherChargesAccount",
"GLRetainedEarningsAccount" => "GLRetainedEarningsAccount",
"GLProfitLossAccount" => "GLProfitLossAccount",
"GLUnrealizedCurrencyProfitLossAccount" => "GLUnrealizedCurrencyProfitLossAccount",
"GLRealizedCurrencyProfitLossAccount" => "GLRealizedCurrencyProfitLossAccount",
"GLARFreightProfitLossAccount" => "GLARFreightProfitLossAccount",
"GLCurrencyGainLossAccount" => "GLCurrencyGainLossAccount",
"GLUnrealizedCurrencyGainLossAccount" => "GLUnrealizedCurrencyGainLossAccount",
"Period1Closed" => "Period1Closed",
"Period2Closed" => "Period2Closed",
"Period3Closed" => "Period3Closed",
"Period4Closed" => "Period4Closed",
"Period5Closed" => "Period5Closed",
"Period6Closed" => "Period6Closed",
"Period7Closed" => "Period7Closed",
"Period8Closed" => "Period8Closed",
"Period9Closed" => "Period9Closed",
"Period10Closed" => "Period10Closed",
"Period11Closed" => "Period11Closed",
"Period12Closed" => "Period12Closed",
"Period13Closed" => "Period13Closed",
"Period14Closed" => "Period14Closed",
"GAAPCompliant" => "GAAPCompliant",
"EditGLTranssactions" => "EditGLTranssactions",
"EditBankTransactions" => "EditBankTransactions",
"EditAPTransactions" => "EditAPTransactions",
"EditARTransactions" => "EditARTransactions",
"HardClose" => "HardClose",
"AuditTrail" => "AuditTrail",
"PeriodPosting" => "PeriodPosting",
"SystemDates" => "SystemDates"];
}?>
