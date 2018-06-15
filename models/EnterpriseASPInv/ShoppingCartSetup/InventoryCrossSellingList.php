<?php

/*
Name of Page: InventoryCrossSellingList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCrossSellingList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryCrossSellingList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCrossSellingList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCrossSellingList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "inventorycrossselling";
public $dashboardTitle ="InventoryCrossSelling";
public $breadCrumbTitle ="InventoryCrossSelling";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CrossSellItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CrossSellItemReason" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"CrossSellItemPromotion" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"CrossSellItemPromotionEnds" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemReason" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotion" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotionEnds" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"CrossSellItemID" => "Cross Sell Item ID",
"CrossSellItemReason" => "Reason",
"CrossSellItemPromotion" => "Promotion",
"CrossSellItemPromotionEnds" => "Promotion Ends"];
}?>
