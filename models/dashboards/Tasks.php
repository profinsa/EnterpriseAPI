<?php
/*
  Name of Page: dashboard data sourcee

  Method: It provides data from database for Tasks dashboard

  Date created: Nikita Zaharov, 06.06.2017

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

  Last Modified: 06.06.2017
  Last Modified by: Nikita Zaharov
*/

class dashboardData{
    public $breadCrumbTitle = "Tasks";
    public $dashboardTitle = "Tasks";
    public function TodaysTasks(){
        $user = Session::get("user");

        $results = DB::select("SELECT DueDate, TaskTypeID as Task, Description  FROM PayrollEmployeesTaskHeader WHERE CompanyID=? and DivisionID=? and DepartmentID=? and EmployeeID=? and DueDate <= CURRENT_TIMESTAMP and	IFNULL(Completed,0) = 0 and LOWER(EmployeeTaskID) <> 'default'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $user["EmployeeID"]]);

        return $results; // employee
    }
}
?>