<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
    "format" => "{0:n}",
    "inputType" => "text"
],
"MinimumOrderAmount" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ApprovedDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"UseCustomerSpecificPricing" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"DefaultPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemOrDefaultWarehouse" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowStock" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"HideOutOfStockItems" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OfferSubstitute" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowFeatures" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowSales" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowCrossSell" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowRelations" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowReviews" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowWishList" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowItemNotifications" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShowRMA" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ChargeRestockingFee" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"RestockingFee" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumOrder" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"MinimumOrderAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MultiCurrency" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"MultiLanguage" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"GiftsOrCoupons" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
