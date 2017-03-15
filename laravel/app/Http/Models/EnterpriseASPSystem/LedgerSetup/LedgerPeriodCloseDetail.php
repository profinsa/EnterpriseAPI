<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companies";
protected $gridFields =["FiscalStartDate","FiscalEndDate","CurrentFiscalYear","CurrentPeriod","Period1Date","Period2Date","Period3Date","Period4Date","Period5Date","Period6Date","Period7Date","Period8Date","Period9Date","Period10Date","Period11Date","Period12Date","Period13Date","Period14Date"];
public $dashboardTitle ="Period Close ";
public $breadCrumbTitle ="Period Close ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"CompanyName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyState" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyWebAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyLogoUrl" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyLogoFilename" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyShoppingCartURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyReportsDirectoryURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanySupportDirectoryURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyWebCRMDirectoryURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"Terms" => [
"inputType" => "text",
"defaultValue" => ""
],
"FedTaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"StateTaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VATRegistrationNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"VATSalesTaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VATPurchaseTaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VATOtherRegistrationNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultGLPostingDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultSalesGLTracking" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultGLPurchaseGLTracking" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultSalesTaxGroup" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPurchaseTaxGroup" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultInventoryCostingMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"AgeInvoicesBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"AgePurchaseOrdersBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"FinanceCharge" => [
"inputType" => "text",
"defaultValue" => ""
],
"FinanceChargePercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChargeHandling" => [
"inputType" => "text",
"defaultValue" => ""
],
"HandlingAsPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"HandlingRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChargeMinimumSurcharge" => [
"inputType" => "text",
"defaultValue" => ""
],
"MinimumSurchargeThreshold" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPCashAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPInventoryAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPFreightAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPHandlingAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPMiscAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPDiscountAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPPrePaidAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAPWriteOffAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARCashAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARSalesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARCOGSAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARInventoryAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARFreightAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARHandlingAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARDiscountAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARMiscAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARReturnAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARWriteOffAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedAccumDepreciationAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedDepreciationAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedAssetAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFixedDisposalAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankInterestEarnedAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankServiceChargesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankMiscWithdrawlAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankBankMisDepositAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankOtherChargesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLRetainedEarningsAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLProfitLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLUnrealizedCurrencyProfitLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLRealizedCurrencyProfitLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLARFreightProfitLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrencyGainLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLUnrealizedCurrencyGainLossAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"FiscalStartDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"FiscalEndDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrentFiscalYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentPeriod" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period1Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period2Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period3Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period4Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period5Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period6Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period7Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period8Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period9Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period10Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period11Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period12Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period13Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period14Date" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Period1Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period2Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period3Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period4Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period5Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period6Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period7Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period8Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period9Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period10Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period11Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period12Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period13Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Period14Closed" => [
"inputType" => "text",
"defaultValue" => ""
],
"GAAPCompliant" => [
"inputType" => "text",
"defaultValue" => ""
],
"EditGLTranssactions" => [
"inputType" => "text",
"defaultValue" => ""
],
"EditBankTransactions" => [
"inputType" => "text",
"defaultValue" => ""
],
"EditAPTransactions" => [
"inputType" => "text",
"defaultValue" => ""
],
"EditARTransactions" => [
"inputType" => "text",
"defaultValue" => ""
],
"HardClose" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditTrail" => [
"inputType" => "text",
"defaultValue" => ""
],
"PeriodPosting" => [
"inputType" => "text",
"defaultValue" => ""
],
"SystemDates" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"FiscalStartDate" => "FiscalStartDate",
"FiscalEndDate" => "FiscalEndDate",
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
