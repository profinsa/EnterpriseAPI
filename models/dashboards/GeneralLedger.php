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

Last Modified: 07.04.2016
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
    public $breadCrumbTitle = "General Ledger";
    public $dashboardTitle = "General Ledger";
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

        $results = [];
        $results["quotes"] = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivityQuotes('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["orders"] = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivityOrders('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["receivings"] = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivityReceivings('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["purchases"] = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivityPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["shipments"] = $GLOBALS["capsule"]::select("CALL spCompanyDailyActivityShipments('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

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

        //echo "second" . json_encode($rowset2);

        return $results;
    }
}
?>