<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycart";
protected $gridFields =["DefaultPricingCode","RestockingFee","MinimumOrderAmount","ApprovedDate"];
public $dashboardTitle ="InventoryCart ";
public $breadCrumbTitle ="InventoryCart ";
public $idField ="undefined";
public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseCustomerSpecificPricing" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPricingCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemOrDefaultWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultBin" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckStock" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowStock" => [
"inputType" => "text",
"defaultValue" => ""
],
"HideOutOfStockItems" => [
"inputType" => "text",
"defaultValue" => ""
],
"OfferSubstitute" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowFeatures" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowSales" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowCrossSell" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowRelations" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowReviews" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowWishList" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowItemNotifications" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShowRMA" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChargeRestockingFee" => [
"inputType" => "text",
"defaultValue" => ""
],
"RestockingFee" => [
"inputType" => "text",
"defaultValue" => ""
],
"MinimumOrder" => [
"inputType" => "text",
"defaultValue" => ""
],
"MinimumOrderAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"MultiCurrency" => [
"inputType" => "text",
"defaultValue" => ""
],
"MultiLanguage" => [
"inputType" => "text",
"defaultValue" => ""
],
"GiftsOrCoupons" => [
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
