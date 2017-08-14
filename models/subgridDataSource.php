<?php
/*
  Name of Page: subGridDataSource model

  Method: Model parent for all subrig models

  Date created: 08/10/2017 Zaharov Nikita

  Use: this model used by subgrid views

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by grid controllers
  used as model by views

  Calls:
  MySql Database

  Last Modified: 08/14/2017
  Last Modified by: Zaharov Nikita
*/

require "./gridDataSource.php";

class subgridDataSource extends gridDataSource{
    //getting rows for grid
    public function getPage($id){        
        $user = Session::get("user");
        $fields = [];
        $keyValues = explode("__", $id);
        $keyFields = "";
        foreach($this->idFields as $key){
            $fields[] = $key;
            $keyValue = array_shift($keyValues);
            if($keyValue){
                $keyFields .= $key . "='$keyValue' AND ";
            }
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        foreach($this->gridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }

        $result = DB::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>