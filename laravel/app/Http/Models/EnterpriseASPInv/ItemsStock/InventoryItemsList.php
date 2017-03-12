<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitems";
protected $gridFields =["ItemID","IsActive","ItemTypeID","ItemName","ItemDescription","ItemUPCCode","Price"];
public $dashboardTitle ="Inventory Items";
public $breadCrumbTitle ="Inventory Items";
public $idField ="ItemID";
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"IsActive" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemCategoryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemFamilyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"LargePictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeight" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeightMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemShipWeight" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemUPCCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemEPCCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemRFID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemSize" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemSizeCmm" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDimentions" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDimentionsCmm" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemColor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemNRFColor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemStyle" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemNRFStyle" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemCareInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDefaultWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDefaultWarehouseBin" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationX" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationY" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationZ" => [
"inputType" => "text",
"defaultValue" => ""
],
"DownloadLocation" => [
"inputType" => "text",
"defaultValue" => ""
],
"DownloadPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemUOM" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLItemSalesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLItemCOGSAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLItemInventoryAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Price" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPricingCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"PricingMethods" => [
"inputType" => "text",
"defaultValue" => ""
],
"Taxable" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadTimeUnit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReOrderLevel" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReOrderQty" => [
"inputType" => "text",
"defaultValue" => ""
],
"BuildTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"BuildTimeUnit" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseageRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseageRateUnit" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesForecast" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesForecastUnit" => [
"inputType" => "text",
"defaultValue" => ""
],
"CalculatedCover" => [
"inputType" => "text",
"defaultValue" => ""
],
"CalculatedCoverUnits" => [
"inputType" => "text",
"defaultValue" => ""
],
"IsAssembly" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemAssembly" => [
"inputType" => "text",
"defaultValue" => ""
],
"LIFO" => [
"inputType" => "text",
"defaultValue" => ""
],
"LIFOValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"LIFOCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"Average" => [
"inputType" => "text",
"defaultValue" => ""
],
"AverageValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"AverageCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"FIFO" => [
"inputType" => "text",
"defaultValue" => ""
],
"FIFOValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"FIFOCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"Expected" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"Landed" => [
"inputType" => "text",
"defaultValue" => ""
],
"LandedValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"LandedCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"Other" => [
"inputType" => "text",
"defaultValue" => ""
],
"OtherValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"OtherCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"Commissionable" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionType" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"IsActive" => "Is Active",
"ItemTypeID" => "Item Type ID",
"ItemName" => "Item Name",
"ItemDescription" => "Item Description",
"ItemUPCCode" => "Item UPC Code",
"Price" => "Price",
"ItemLongDescription" => "ItemLongDescription",
"ItemCategoryID" => "ItemCategoryID",
"ItemFamilyID" => "ItemFamilyID",
"SalesDescription" => "SalesDescription",
"PurchaseDescription" => "PurchaseDescription",
"PictureURL" => "PictureURL",
"LargePictureURL" => "LargePictureURL",
"ItemWeight" => "ItemWeight",
"ItemWeightMetric" => "ItemWeightMetric",
"ItemShipWeight" => "ItemShipWeight",
"ItemEPCCode" => "ItemEPCCode",
"ItemRFID" => "ItemRFID",
"ItemSize" => "ItemSize",
"ItemSizeCmm" => "ItemSizeCmm",
"ItemDimentions" => "ItemDimentions",
"ItemDimentionsCmm" => "ItemDimentionsCmm",
"ItemColor" => "ItemColor",
"ItemNRFColor" => "ItemNRFColor",
"ItemStyle" => "ItemStyle",
"ItemNRFStyle" => "ItemNRFStyle",
"ItemCareInstructions" => "ItemCareInstructions",
"ItemDefaultWarehouse" => "ItemDefaultWarehouse",
"ItemDefaultWarehouseBin" => "ItemDefaultWarehouseBin",
"ItemLocationX" => "ItemLocationX",
"ItemLocationY" => "ItemLocationY",
"ItemLocationZ" => "ItemLocationZ",
"DownloadLocation" => "DownloadLocation",
"DownloadPassword" => "DownloadPassword",
"ItemUOM" => "ItemUOM",
"GLItemSalesAccount" => "GLItemSalesAccount",
"GLItemCOGSAccount" => "GLItemCOGSAccount",
"GLItemInventoryAccount" => "GLItemInventoryAccount",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"ItemPricingCode" => "ItemPricingCode",
"PricingMethods" => "PricingMethods",
"Taxable" => "Taxable",
"VendorID" => "VendorID",
"LeadTime" => "LeadTime",
"LeadTimeUnit" => "LeadTimeUnit",
"ReOrderLevel" => "ReOrderLevel",
"ReOrderQty" => "ReOrderQty",
"BuildTime" => "BuildTime",
"BuildTimeUnit" => "BuildTimeUnit",
"UseageRate" => "UseageRate",
"UseageRateUnit" => "UseageRateUnit",
"SalesForecast" => "SalesForecast",
"SalesForecastUnit" => "SalesForecastUnit",
"CalculatedCover" => "CalculatedCover",
"CalculatedCoverUnits" => "CalculatedCoverUnits",
"IsAssembly" => "IsAssembly",
"ItemAssembly" => "ItemAssembly",
"LIFO" => "LIFO",
"LIFOValue" => "LIFOValue",
"LIFOCost" => "LIFOCost",
"Average" => "Average",
"AverageValue" => "AverageValue",
"AverageCost" => "AverageCost",
"FIFO" => "FIFO",
"FIFOValue" => "FIFOValue",
"FIFOCost" => "FIFOCost",
"Expected" => "Expected",
"ExpectedValue" => "ExpectedValue",
"ExpectedCost" => "ExpectedCost",
"Landed" => "Landed",
"LandedValue" => "LandedValue",
"LandedCost" => "LandedCost",
"Other" => "Other",
"OtherValue" => "OtherValue",
"OtherCost" => "OtherCost",
"Commissionable" => "Commissionable",
"CommissionType" => "CommissionType",
"CommissionPerc" => "CommissionPerc",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy",
"TaxGroupID" => "TaxGroupID",
"TaxPercent" => "TaxPercent"];
}?>
