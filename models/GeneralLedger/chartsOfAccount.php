<?php
/*
Name of Page: chartsOfAccount model

Method: 

Date created: Nikita Zaharov, 13.02.2016

Use:

Input parameters:
$db: database instance

Output parameters:


Called from:


Calls:
sql

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

class chartsOfAccount{
    protected $db = false;

    public function __construct($database){
        $this->db = $database;
    }

    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        
        $result = mysqli_query($this->db, "SELECT * from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

}
?>