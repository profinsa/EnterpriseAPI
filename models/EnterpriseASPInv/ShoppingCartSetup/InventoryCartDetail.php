<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycart";
public $dashboardTitle ="InventoryCart ";
public $breadCrumbTitle ="InventoryCart ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DefaultPricingCode" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RestockingFee" => [
    "dbType" => "float",
    "inputType" => "text"
],
"MinimumOrderAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"ApprovedDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"UseCustomerSpecificPricing" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemOrDefaultWarehouse" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultWarehouse" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckStock" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowStock" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"HideOutOfStockItems" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"OfferSubstitute" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowFeatures" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowSales" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowCrossSell" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowRelations" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowReviews" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowWishList" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowItemNotifications" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ShowRMA" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ChargeRestockingFee" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"RestockingFee" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumOrder" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumOrderAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MultiCurrency" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MultiLanguage" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GiftsOrCoupons" => [
"dbType" => "tinyint(1)",
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
]
]];
public $columnNames = [

"DefaultPricingCode" => "Default Pricing Code",
"RestockingFee" => "Restocking Fee",
"MinimumOrderAmount" => "Minimum Order Amount",
"ApprovedDate" => "Approved Date",
"UsePricingCodes" => "UsePricingCodes",
"UseCustomerSpecificPricing" => "UseCustomerSpecificPricing",
"ItemOrDefaultWarehouse" => "ItemOrDefaultWarehouse",
"DefaultWarehouse" => "DefaultWarehouse",
"DefaultBin" => "DefaultBin",
"CheckStock" => "CheckStock",
"ShowStock" => "ShowStock",
"HideOutOfStockItems" => "HideOutOfStockItems",
"OfferSubstitute" => "OfferSubstitute",
"ShowFeatures" => "ShowFeatures",
"ShowSales" => "ShowSales",
"ShowCrossSell" => "ShowCrossSell",
"ShowRelations" => "ShowRelations",
"ShowReviews" => "ShowReviews",
"ShowWishList" => "ShowWishList",
"ShowItemNotifications" => "ShowItemNotifications",
"ShowRMA" => "ShowRMA",
"ChargeRestockingFee" => "ChargeRestockingFee",
"MinimumOrder" => "MinimumOrder",
"MultiCurrency" => "MultiCurrency",
"MultiLanguage" => "MultiLanguage",
"GiftsOrCoupons" => "GiftsOrCoupons",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy"];
}?>
