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
class InterfaceList extends gridDataSource{
    public $tableName = "payrollemployees";
    public $dashboardTitle ="Interface";
    public $breadCrumbTitle ="Interface";
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

    public function getTranslation(){
        $result = $GLOBALS["capsule"]::select("SELECT ObjID,ObjDescription," . $_GET["language"] . ",Translated from translation", array());
        $terms = [];
        foreach($result as $row) {
            $terms[$row->ObjID] = $row;
        }
        echo json_encode($terms);
    }
}
?>
