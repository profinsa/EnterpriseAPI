<?php
/*
   Name of Page: IntefaceList model
    
   Method: It provides data from database and default values, column names and categories
    
   Date created: 22/05/2020 Nikita Zaharov
    
   Use: this model used by views/CompaniesList for:
   - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
   - for loading data from tables, updating, inserting and deleting
    
   Input parameters:
   $db: database instance
   methods have their own parameters
    
   Output parameters:
   - dictionaries as public properties
   - methods have their own output
    
   Called from:
   created and used for ajax requests by controllers/grid
   used as model by views/gridView.php
    
   Calls:
   MySql or MSSQLDatabase
    
   Last Modified: 22/05/2020
   Last Modified by: Nikita Zaharov
 */

require "./models/gridDataSource.php";
class EcommerceList extends gridDataSource{
    public $tableName = "payrollemployees";
    public $dashboardTitle ="ECommerce";
    public $breadCrumbTitle ="ECommerce";
    public $idField ="undefined";
    public $modes = ["grid", "view", "edit"];
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $gridFields = [
    ];
    public $config;
    
    public $editCategories = [
        "Main" => [
        ]
    ];
    public $columnNames = [
    ];

    public function __construct(){
        $this->config = config();
        
        if(key_exists("CompanyID", $_GET))
            Session::set("defaultCompany", $this->defaultCompany = [
                "CompanyID" => key_exists("CompanyID", $_GET) ? $_GET["CompanyID"] : $this->config["defaultCompanyID"],
                "DivisionID" => key_exists("DivisionID", $_GET) ? $_GET["DivisionID"] : $this->config["defaultDivisionID"],
                "DepartmentID" => key_exists("DepartmentID", $_GET) ? $_GET["DepartmentID"] : $this->config["defaultDepartmentID"],            
            ]);
        else
            Session::set("defaultCompany", $this->defaultCompany = [
                "CompanyID" => $this->config["defaultCompanyID"],
                "DivisionID" => $this->config["defaultDivisionID"],
                "DepartmentID" => $this->config["defaultDepartmentID"],            
            ]);
    }

    public function getCartSettings($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        
        $result = DB::select("SELECT * from inventorycart WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

        echo json_encode($result[0], JSON_PRETTY_PRINT);
    }
    
    public function getCompany($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        
        $result = DB::select("SELECT * from companies WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

        echo json_encode($result[0], JSON_PRETTY_PRINT);
   }
        
    public function getCurrencies($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        
        $res = [];
        $result = DB::select("SELECT * from currencytypes WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

        foreach($result as $record)
            $res[$record->CurrencyID] = $record;

        echo json_encode($res, JSON_PRETTY_PRINT);
    }
    
    public function getFamilies($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
         $res = [];
        $result = DB::select("SELECT * from inventoryfamilies WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

        foreach($result as $record)
            if($record->ItemFamilyID != "DEFAULT" && $record->FamilyName != "DEFAULT")
                $res[$record->ItemFamilyID] = $record;

        echo json_encode($res, JSON_PRETTY_PRINT);
    }
    
    public function getCategories($remoteCall = false){
        if(key_exists("familyName", $_GET))
            $familyName = $_GET["familyName"];
        else
            $familyName = false;
        $defaultCompany = Session::get("defaultCompany");
        $res = [];
        if($remoteCall)
            $familyName = $_POST["familyname"];
        
        $result = DB::select("SELECT * from inventorycategories WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemFamilyID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"], $familyName));

        foreach($result as $record)
            $res[$record->ItemCategoryID] = $record;

        echo json_encode($res, JSON_PRETTY_PRINT);
    }

    public function getItems($remoteCall = false){
        if(key_exists("categoryName", $_GET))
            $categoryName = $_GET["categoryName"];
        else
            $categoryName = false;
        
        $defaultCompany = Session::get("defaultCompany");
        $res = [];
        if($remoteCall)
            $categoryName = $_POST["categoryName"];
        
        $result = DB::select("SELECT * from inventoryitems WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemCategoryID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"], $categoryName));

        foreach($result as $record)
            $res[$record->ItemID] = $record;

        echo json_encode($res, JSON_PRETTY_PRINT);
    }

    //Load content

    public function getContent($fieldName, $remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        $fieldName .= "Content";
        //FIXME!
        // $result = DB::select("SELECT $fieldName from inventorycart WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

        //        echo json_encode($result[0], JSON_PRETTY_PRINT);
        echo json_encode([
            [ "$fieldName" => "content" ]
        ]);
    }

    //Search API
    function searchProducts($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        $res = [];
        $categoryName = '';
        if($remoteCall){
            $text = $_POST["text"];
            $family = $_POST["family"];
        }else{
            $text = $_GET["text"];
            $family = $_GET["family"];
        }
        
        $categories = DB::select("SELECT * from inventorycategories WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemFamilyID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"], $family));

        $categoryCondition = "";
        foreach($categories as $category)
            if($categoryCondition == "")
                $categoryCondition .= "AND (ItemCategoryID='" . $category->ItemCategoryID . "'";
            else
                $categoryCondition .= " OR ItemCategoryID='" . $category->ItemCategoryID . "'";
        if($categoryCondition)
            $categoryCondition .= ")";

        if($categoryCondition){
            $result = DB::select("SELECT * from inventoryitems WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? $categoryCondition AND (ItemID like '%" . $text ."%' or ItemName like '%".  $text  ."%' or ItemDescription like '%". $text ."%' or ItemLongDescription like '%". $text ."%')", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"]));

            foreach($result as $record)
                $res[$record->ItemID] = $record;
        }

        echo json_encode($res, JSON_PRETTY_PRINT);
    }

    //Account API
    public function getTransactions($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        $result = DB::select("SELECT * from orderheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND CustomerID=? AND OrderDate > '2019-04-00 00:00:00' order by OrderDate desc", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"], $_GET["CustomerID"]));

        echo json_encode($result, JSON_PRETTY_PRINT);
    }        

    //for Hosting Cart
    public function getInstallations($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        $result = DB::select("SELECT * from appinstallations WHERE CustomerID=? order by InstallationDate desc", [$_GET["CustomerID"]]);
        $result = json_decode(json_encode($result), true);

        echo json_encode($result, JSON_PRETTY_PRINT);
    }

    //Inventories API
    public function getInventoryItem($remoteCall = false){
        $defaultCompany = Session::get("defaultCompany");
        $result = DB::select("SELECT * from inventoryitems WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemID=?", array($defaultCompany["CompanyID"], $defaultCompany["DivisionID"], $defaultCompany["DepartmentID"], $_GET["ItemID"]));
        
        echo json_encode($result, JSON_PRETTY_PRINT);
    }
}
?>
