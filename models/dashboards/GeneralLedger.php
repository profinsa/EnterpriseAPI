<?php
/*
Name of Page: dashboard data sourcee

Method: It provides data from database for GeneralLedger dashboard

Date created: Nikita Zaharov, 05.04.2016

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

Last Modified: 05.04.2016
Last Modified by: Nikita Zaharov
*/

/*        $db = $GLOBALS["capsule"]::connection()->getPdo();

// if any params are present, add them
/*        $sParamsIn = '';
if(isset($aParams) && is_array($aParams) && count($aParams)>0) {
// loop through params and set
foreach($aParams as $sParam) {
$sParamsIn .= '?,';
}

// trim the last comma from the params in string
$sParamsIn = substr($sParamsIn, 0, strlen($sParamsIn)-1);
}

// create initial stored procedure call
$stmt = $db->prepare("CALL spCompanyAccountsStatus('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)");

/*        // if any params are present, add them
if(isset($aParams) && is_array($aParams) && count($aParams)>0) {
$iParamCount = 1;

// loop through params and bind value to the prepare statement
foreach ($aParams as &$value) {
$stmt->bindParam($iParamCount, $value);
$iParamCount++;
}
}

// execute the stored procedure
$stmt->execute();

// loop through results and place into array if found
$results = $stmt->fetchAll(PDO::FETCH_CLASS, 'stdClass');
echo json_encode($results);*/

class dashboardData{
    public function CompanyAccountsStatus(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spCompanyAccountsStatus('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CollectionAlerts(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spCollectionAlerts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "')", array());

        return $results;
    }

    public function CompanyDailyActivity(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivity('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CompanyIncomeStatement(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spCompanyIncomeStatement('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CompanySystemWideMessage(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spCompanySystemWideMessage('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function InventoryLowStockAlert(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spInventoryLowStockAlert('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function LeadFollowUp(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spLeadFollowUp('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; //employee
    }

    public function TodaysTasks(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spTodaysTasks('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; // employee
    }

    public function TopOrdersReceipts(){
        $user = $_SESSION["user"];

        $results = $GLOBALS["capsule"]::select("CALL spTopOrdersReceipts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }
}
?>