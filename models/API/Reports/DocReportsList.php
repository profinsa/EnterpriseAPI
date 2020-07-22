<?php
/*
   Name of Page: Doc model
    
   Method: It provides data from database and default values, column names and categories
    
   Date created: 20/07/2020 Nikita Zaharov
    
   Use: this model exports API for docreports
    
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
    
   Last Modified: 22/07/2020
   Last Modified by: Nikita Zaharov
 */

require "./models/gridDataSource.php";
class DocReportsList extends gridDataSource{
    public $tableName = "payrollemployees";
    public $dashboardTitle ="Doc";
    public $breadCrumbTitle ="Doc";
    public $idField ="undefined";
    public $modes = ["grid", "view", "edit"];
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $gridFields = [
    ];
    
    public $editCategories = [
        "Main" => [
        ]
    ];
    public $columnNames = [
    ];


    public function geDocReportsData($remoteCall = false){
        require "./models/reports/doc/{$_GET["type"]}.php";
        $data = new docReportsData($_GET["id"]);

        $result = [
            "user" => $data->getUser(),
            "currencySymbol" => $data->getCurrencySymbol(),
            "header" => $data->getHeaderData(),
            "detail" => $data->getDetailData()
        ];

        echo json_encode($result, JSON_PRETTY_PRINT);
    }
  }
?>
