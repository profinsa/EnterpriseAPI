<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitems";
public $dashboardTitle ="Inventory Items";
public $breadCrumbTitle ="Inventory Items";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"IsActive" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"ItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ItemUPCCode" => [
    "dbType" => "varchar(12)",
    "inputType" => "text"
],
"Price" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"IsActive" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCategoryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemFamilyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"LargePictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeight" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeightMetric" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ItemShipWeight" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUPCCode" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemEPCCode" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemRFID" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemSize" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemSizeCmm" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDimentions" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDimentionsCmm" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemColor" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemNRFColor" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemStyle" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemNRFStyle" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCareInstructions" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDefaultWarehouse" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDefaultWarehouseBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationX" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationY" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLocationZ" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"DownloadLocation" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"DownloadPassword" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUOM" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"GLItemSalesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLItemCOGSAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLItemInventoryAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Price" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PricingMethods" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Taxable" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadTime" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadTimeUnit" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ReOrderLevel" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ReOrderQty" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"BuildTime" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"BuildTimeUnit" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"UseageRate" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"UseageRateUnit" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesForecast" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesForecastUnit" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"CalculatedCover" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CalculatedCoverUnits" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"IsAssembly" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemAssembly" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LIFO" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LIFOValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LIFOCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Average" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"AverageValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"AverageCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FIFO" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FIFOValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FIFOCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Expected" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Landed" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LandedValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LandedCost" => [
"dbType" => "char(10)",
"inputType" => "text",
"defaultValue" => ""
],
"Other" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"OtherValue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"OtherCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Commissionable" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CommissionType" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"CommissionPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
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
