<?php
/*
Name of Page: dashboard data sourcee

Method: It provides data from database for Tasks dashboard

Date created: Nikita Zaharov, 06.06.2016

Use: this model used for 
- for loading data using stored procedures

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
controllers/dashboard

Calls:
sql

Last Modified: 06.06.2016
Last Modified by: Nikita Zaharov
*/

class dashboardData{
    public $breadCrumbTitle = "Tasks";
    public $dashboardTitle = "Tasks";
    public function TodaysTasks(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spTodaysTasks('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; // employee
    }
}
?>