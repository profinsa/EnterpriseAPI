<?php
/*
   Name of Page: Help System data source

   Method: It provides data from database for Help System

   Date created: Nikita Zaharov, 16.07.2019

   Use: this model used for 
   - for loading data using stored procedures

   Input parameters:
   $capsule: database instance
   methods has own parameters

   Output parameters:
   - methods has own output

   Called from:
   controllers/docreports

   Calls:
   sql

   Last Modified: 16.07.2019
   Last Modified by: Nikita Zaharov
 */

class helpData{
    protected $id = "";

    public function __construct($id){
        $this->id = $id;
    }

    public function getDocument(){
        $user = Session::get("user");
        return DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentURL=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $this->id])[0];
    }
}
?>
