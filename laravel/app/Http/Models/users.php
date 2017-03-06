<?php
/*
Name of Page: Users model

Method: Users model, used for log in users, searching and working with permissions

Date created: Nikita Zaharov, 22.02.2016

Use: For searching, verificating users. Also this model provide method for work with permissions

Input parameters:
$db: database instance

Output parameters:
$users: model, it is responsible for working with users and them permissions

Called from:
+ most controllers most controllers from /controllers

Calls:
DB

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Models;

use Illuminate\Support\Facades\DB;

class users{
    public function search($company, $name, $password, $division, $department){
        $result = DB::select("SELECT * from payrollemployees WHERE CompanyID='" . $company . "' AND EmployeeUserName='". $name ."' AND EmployeePassword='" . $password . "' AND DivisionID='" . $division . "' AND DepartmentID='" . $department . "'", array());
        if(!$result)
            return false;
        
        $result = json_decode(json_encode($result), true);
        $result = $result[0];
        DB::insert("INSERT INTO auditlogin(CompanyID,DivisionID,DepartmentID,EmployeeID,LoginDateTime,IPAddress) values('" . $result["CompanyID"] . "','" . $result["DivisionID"] ."','" . $result["DepartmentID"] . "','" . $result["EmployeeID"] . "',CURDATE(),'" . $_SERVER['REMOTE_ADDR'] ."')");
            
        $result["accesspermissions"] = json_decode(json_encode(DB::select("SELECT * FROM accesspermissions WHERE CompanyID='" . $result["CompanyID"] . "' AND DivisionID='" . $result["DivisionID"] ."' AND DepartmentID='" . $result["DepartmentID"] . "' AND EmployeeID='" . $result["EmployeeID"] . "'")), true)[0];
        
        return $result;
    }
}
?>