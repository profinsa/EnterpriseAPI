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
        echo $this->id;
        if($this->id)
            return DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentURL=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $this->id])[0];
        else
            return DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentTitleID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_GET["id"]])[0];
    }

    public function getModules(){
        $user = Session::get("user");
        $result = json_decode(json_encode(DB::Select("select * from helpdocumentmodule WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);

        $modules = [];
        foreach($result as $row){
            $modules[$row["ModuleID"]] = $row;
            $modules[$row["ModuleID"]]["topics"] = [];
        }
        
        $documents = json_decode(json_encode(DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);
        $topics = json_decode(json_encode(DB::Select("select * from helpdocumenttopic WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);

        foreach($documents as $document){
            foreach($topics as $topic){
                if($topic["TopicID"] == $document["DocumentTopic"])
                    if(!key_exists($document["DocumentTopic"],$modules[$document["DocumentModule"]]["topics"])){
                        $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]] = $topic;
                        $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]]["documents"] = [];
                    }
                $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]]["documents"][$document["DocumentTitleID"]] = $document;
            }
        }
            //if(
        //        echo json_encode($modules);
        return $modules;
    }

    public function getTopics(){
        $user = Session::get("user");
        //        return DB::Select("select * from helpdocumenttopic WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
    }
}
?>
