<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "orderheader"
;protected $gridFields =["ShipDate"];
public $dashboardTitle ="Ship Orders";
public $breadCrumbTitle ="Ship Orders";
public $idField ="OrderNumber";
public $editCategories = [];
public $columnNames = [

"ShipDate" => "Ship Date"];
}?>
