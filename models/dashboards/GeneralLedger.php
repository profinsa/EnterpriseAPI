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

class dashboardData{
    public function CollectionAlerts(){
        $user = $_SESSION["user"];

        $GLOBALS["capsule"]::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = $GLOBALS["capsule"]::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1)
            echo $results[0]->PostingResult;
        else {
            http_response_code(400);
            echo $results[0]->PostingResult;
        }
    }

    public function CompanyDailyActivity(){
    }

    public function CompaniIncomeStatement(){
    }

    public function CompanyAccountsStatus(){
    }

    public function CompanySystemWideMessage(){
    }

    public function InventoryLowStockAlert(){
    }

    public function LeadFollowUp(){
    }

    public function TodaysTasks(){
    }

    public function TopOrdersReceipts(){
    }
}
?>