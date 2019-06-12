<?php
/*
  Name of Page: dashboard data sourcee

  Method: It provides data from database for dashboards

  Date created: Nikita Zaharov, 05.04.2017

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

  Last Modified: 12.06.2019
  Last Modified by: Nikita Zaharov
*/

class dashboardData{
    public $breadCrumbTitle = "General Ledger";
    public $dashboardTitle = "General Ledger";
    
    public function CompanyAccountsStatus(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spCompanyAccountsStatus('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CollectionAlerts(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spCollectionAlerts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "')", array());

        return $results;
    }

    public function CompanyDailyActivity(){
        $user = Session::get("user");

        $results = [];
        $results["quotes"] = DB::select("select count(OrderNumber) as Quotes, sum(IFNULL(Total,0)) as QuoteTotals from orderheader WHERE LOWER(OrderTypeID) = LOWER('Quote') and  OrderDate >= now() - INTERVAL 1 DAY and CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());
        //        $results["quotes"] = DB::select("CALL spCompanyDailyActivityQuotes('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["orders"] = DB::select("CALL spCompanyDailyActivityOrders('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["receivings"] = DB::select("select count(PurchaseNumber) as Receivings, sum(IFNULL(Total,0)) as ReceiptTotals from purchaseheader WHERE Received=0 and  PurchaseDate >= now() - INTERVAL 1 DAY and CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());
        //        $results["receivings"] = DB::select("CALL spCompanyDailyActivityReceivings('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["purchases"] = DB::select("CALL spCompanyDailyActivityPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["shipments"] = DB::select("CALL spCompanyDailyActivityShipments('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CompanyIncomeStatement(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spCompanyIncomeStatement('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CompanySystemWideMessage(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spCompanySystemWideMessage('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function InventoryLowStockAlert(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spInventoryLowStockAlert('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function LeadFollowUp(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spLeadFollowUp('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; //employee
    }

    public function TodaysTasks(){
        $user = $_SESSION["user"];

        $results = DB::select("CALL spTodaysTasks('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; // employee
    }

    public function TopOrdersReceipts(){
        $user = $_SESSION["user"];

        $results = [];
        $results["orders"] = DB::select("CALL spTopOrdersReceipts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["purchases"] = DB::select("CALL spTopOrdersReceiptsPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function getShipmentsForCalendar(){
        $user = Session::get("user");

        $result = DB::select("select OrderNumber, CustomerID, ShipDate, OrderDate from orderheader WHERE (LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function getReceivingsForCalendar(){
        $user = Session::get("user");

        $result = DB::select("select PurchaseNumber, VendorID, ShipDate, PurchaseDate from purchaseheader WHERE (NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>