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

  Last Modified: 10.09.2019
  Last Modified by: Nikita Zaharov
*/

class dashboardData{
    public $breadCrumbTitle = "General Ledger";
    public $dashboardTitle = "General Ledger";
    
    public function CompanyAccountsStatus(){
        $user = Session::get("user");

        $results = DB::select("CALL spCompanyAccountsStatus('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CollectionAlerts(){
        $user = Session::get("user");

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
        $user = Session::get("user");

        $results = DB::select("CALL spCompanyIncomeStatement('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function CompanySystemWideMessage(){
        $user = Session::get("user");

        $results = DB::select("CALL spCompanySystemWideMessage('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function InventoryLowStockAlert(){
        $user = Session::get("user");

        $results = DB::select("CALL spInventoryLowStockAlert('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function LeadFollowUp(){
        $user = Session::get("user");

        $results = DB::select("CALL spLeadFollowUp('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; //employee
    }

    public function TodaysTasks(){
        $user = Session::get("user");

        $results = DB::select("CALL spTodaysTasks('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "')", array());

        return $results; // employee
    }

    public function TopOrdersReceipts(){
        $user = Session::get("user");

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

    public function helpRequests(){
        $user = Session::get("user");

        $results = DB::select("select CustomerID, CaseID, SupportQuestion from helpsupportrequest WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? order by SupportDate DESC limit 10", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);

        return $results;
    }

    public function adminGetCustomersStatus(){
        $user = Session::get("user");

        $new = DB::select("select * from appinstallations WHERE Clean=0 AND InstallationDate <= NOW() AND InstallationDate > NOW() - INTERVAL 7 DAY");
        $expiring = DB::select("select * from appinstallations WHERE Clean=0 AND ExpirationDate >= NOW() - INTERVAL 30 DAY AND ExpirationDate < now()");
        $expired = DB::select("select * from appinstallations WHERE Clean=0 AND ExpirationDate >= now()");
        $ret = [
            "new" => count($new),
            "expiring" => count($expiring),
            "expired" => count($expired)
        ];

        return $ret;
    }

    public function adminGetCustomers(){
        $user = Session::get("user");

        $ret = DB::select("select * from appinstallations WHERE Clean=0 AND Active=1");

        return $ret;
    }

    public function adminGetPrefferedProducts(){
        $user = Session::get("user");

        $prefferedProducts = [];
        $ret = DB::select("select SoftwareID from appinstallations WHERE Clean=0 AND Active=1");
        foreach($ret as $row)
            if(key_exists($row->SoftwareID, $prefferedProducts))
                $prefferedProducts[$row->SoftwareID]["numbers"]++;
            else
                $prefferedProducts[$row->SoftwareID] = [
                    "name" => $row->SoftwareID,
                    "numbers" => 1
                ];
        
        return $prefferedProducts;
    }

    public function adminGetApplicationsPerYear(){
        $user = Session::get("user");

        $ret = [
            "labels" => [],
            "data" => []
        ];
        $periods = [];
        $result = DB::select("select InstallationDate, SoftwareID from appinstallations WHERE Clean=0 AND Active=1 AND InstallationDate <= NOW() AND InstallationDate > NOW() - INTERVAL 1 YEAR order by InstallationDate");
        foreach($result as $row){
            if(!in_array($row->SoftwareID, $ret["labels"]))
                $ret["labels"][] = $row->SoftwareID;
        }
        
        foreach($result as $row){
            $dateArr = date_parse($row->InstallationDate);
            if(!key_exists($dateArr["year"] . "-" . $dateArr["month"], $periods)){
                $periods[$dateArr["year"] . "-" . $dateArr["month"]] = [
                    "period" => $dateArr["year"] . "-" . $dateArr["month"]
                ];
                foreach($ret["labels"] as $label)
                    $periods[$dateArr["year"] . "-" . $dateArr["month"]][$label] = 0;
                $periods[$dateArr["year"] . "-" . $dateArr["month"]][$row->SoftwareID]++;
            }else{
                $periods[$dateArr["year"] . "-" . $dateArr["month"]][$row->SoftwareID]++;
            }
        }
        foreach($periods as $period)
            $ret["data"][] = $period;

        return $ret;
    }
}
?>