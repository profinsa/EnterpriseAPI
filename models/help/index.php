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

   Last Modified: 12.12.2019
   Last Modified by: Nikita Zaharov
 */

class helpData{
    protected $id = "";
    protected $user;

    public function __construct($id){
        $this->user = $GLOBALS["scope"]->user;
        $this->id = $id;
    }

    public function getDocument(){
        $user = $this->user;
        $result = [];
        if($this->id)
            $result = DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentURL=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $this->id]);
        else
            $result = DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentTitleID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], key_exists("id", $_GET) ? $_GET["id"] : ""]);

        if(!count($result))
            $result = DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND DocumentTitleID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], 'GettingStarted'])[0];
        else
            $result = $result[0];

        $result->ModuleDescription = DB::Select("select * from helpdocumentmodule WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ModuleID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $result->DocumentModule])[0];
        $result->TopicDescription = DB::Select("select * from helpdocumenttopic WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND TopicID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $result->DocumentTopic])[0];

        return $result;
    }

    /*public function getModules(){
        $user = $this->user;
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
                if($topic["TopicID"] == $document["DocumentTopic"]){
                    if(!key_exists($document["DocumentTopic"],$modules[$document["DocumentModule"]]["topics"])){
                        $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]] = $topic;
                        $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]]["documents"] = [];
                    }
                    $modules[$document["DocumentModule"]]["topics"][$document["DocumentTopic"]]["documents"][$document["DocumentTitleID"]] = $document;
                }
            }
        }
            //if(
        //        echo json_encode($modules);
        return $modules;
    }*/

    public function getTopics(){
        $user = $this->user;
        $ret_topics = [];
        
        $modules = json_decode(json_encode(DB::Select("select * from helpdocumentmodule WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);
       
        $documents = json_decode(json_encode(DB::Select("select * from helpdocument WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);
        $topics = json_decode(json_encode(DB::Select("select * from helpdocumenttopic WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])), true);

        foreach($documents as $document){
            foreach($topics as $topic){
                if($topic["TopicID"] == $document["DocumentTopic"]){
                    if(!key_exists($document["DocumentTopic"], $ret_topics)){
                        $ret_topics[$document["DocumentTopic"]] = $topic;
                        $ret_topics[$document["DocumentTopic"]]["modules"] = [];
                    }
                    if(!key_exists($document["DocumentModule"], $ret_topics[$document["DocumentTopic"]]["modules"])){
                        foreach($modules as $module)
                            if($module["ModuleID"] == $document["DocumentModule"]){
                                $module["documents"] = [];
                                $ret_topics[$document["DocumentTopic"]]["modules"][$document["DocumentModule"]] = $module;
                            }
                    }

                    $ret_topics[$document["DocumentTopic"]]["modules"][$document["DocumentModule"]]["documents"][] = $document;
                }
            }
        }

        $orderedRetFirst = [];
        $orderedRetSecond = [];
        $orderedRetLast = [];
        foreach($ret_topics as $key=>$topic)
            if($topic["TopicID"] == "WELCOME")
                $orderedRetFirst[] = $topic;
            else if($topic["TopicID"] != "WELCOME" &&
                    $topic["TopicID"] != "TECH" &&
                    $topic["TopicID"] != "TROUBLE" &&
                    $topic["TopicID"] != "USER")
                $orderedRetSecond[] = $topic;
                
        foreach($ret_topics as $key=>$topic)
            if($topic["TopicID"] == "TECH")
                $orderedRetFirst[] = $topic;

        foreach($ret_topics as $key=>$topic)
            if($topic["TopicID"] == "TROUBLE")
                $orderedRetFirst[] = $topic;

        foreach($ret_topics as $key=>$topic)
            if($topic["TopicID"] == "USER")
                $orderedRetLast[] = $topic;

        return array_merge($orderedRetFirst, $orderedRetSecond, $orderedRetLast);
    }

    //    public function getTopics(){
    //  $user = $this->user;
        //        return DB::Select("select * from helpdocumenttopic WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
    //    }
}
?>
