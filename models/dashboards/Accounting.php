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

  Last Modified: 08.10.2019
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

        $results = DB::select("SELECT DueDate, TaskTypeID as Task, Description  FROM PayrollEmployeesTaskHeader WHERE CompanyID=? and DivisionID=? and DepartmentID=? and EmployeeID=? and DueDate <= CURRENT_TIMESTAMP and	IFNULL(Completed,0) = 0 and LOWER(EmployeeTaskID) <> 'default'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $user["EmployeeID"]]);

        return $results; // employee
    }

    public function TopOrdersReceipts(){
        $user = Session::get("user");

        $results = [];
        $results["orders"] = DB::select("CALL spTopOrdersReceipts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["purchases"] = DB::select("CALL spTopOrdersReceiptsPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        return $results;
    }

    public function Top10OrdersInvoices(){
        $user = Session::get("user");

        $results = [];
        $ordersQuery = <<<EOF
   SELECT 
   OrderNumber,
	  OrderShipDate,
	  CustomerID,
	  (IFNULL(Total,0)) as OrderTotal
   FROM OrderHeader
   WHERE CompanyID = ? AND
   DivisionID = ? AND
   DepartmentID = ? and
   lower(OrderNumber) <> 'default' and
   Total <> 0 and
   OrderDate <= CURRENT_TIMESTAMP AND
   (LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND
   (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold')AND
   (IFNULL(Posted, 0) = 1)
   ORDER BY OrderTotal DESC LIMIT 10;
EOF;
        $results["orders"] = DB::select($ordersQuery, array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));
        
        $invoicesQuery = <<<EOF
   SELECT 
   InvoiceNumber,
	  InvoiceShipDate,
	  CustomerID,
	  (IFNULL(Total,0)) as InvoiceTotal
   FROM InvoiceHeader
   WHERE CompanyID = ? AND
   DivisionID = ? AND
   DepartmentID = ? and
   lower(InvoiceNumber) <> 'default' and
   Total <> 0 and
   InvoiceDate <= CURRENT_TIMESTAMP AND
   (LOWER(IFNULL(InvoiceHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND
   (IFNULL(Posted, 0) = 1)
   ORDER BY InvoiceTotal DESC LIMIT 10;
EOF;
        
        $results["invoices"] = DB::select($invoicesQuery, array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));
        
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

        $new = DB::select("select * from appinstallations WHERE Clean=0 AND InstallationDate <= NOW() AND InstallationDate > NOW() - INTERVAL 7 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $expiring = DB::select("select * from appinstallations WHERE Clean=0 AND ExpirationDate >= NOW() - INTERVAL 30 DAY AND ExpirationDate < now() AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $expired = DB::select("select * from appinstallations WHERE Clean=0 AND ExpirationDate >= now() AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $ret = [
            "new" => count($new),
            "expiring" => count($expiring),
            "expired" => count($expired)
        ];

        return $ret;
    }

    public function adminGetCustomers(){
        $user = Session::get("user");

        $ret = DB::select("select * from appinstallations WHERE Clean=0 AND Active=1 AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);

        return $ret;
    }

    public function adminGetPrefferedProducts(){
        $user = Session::get("user");

        $prefferedProducts = [];
        $ret = DB::select("select SoftwareID from appinstallations WHERE Clean=0 AND Active=1 AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
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
        $result = DB::select("select InstallationDate, SoftwareID from appinstallations WHERE Clean=0 AND Active=1 AND InstallationDate <= NOW() AND InstallationDate > NOW() - INTERVAL 1 YEAR AND CompanyID=? AND DivisionID=? AND DepartmentID=? order by InstallationDate ", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
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

    public function adminGetReceivablesPayables(){
        $user = Session::get("user");

        $receivables = DB::SELECT("select GLAccountNumber, GLAccountName, GLAccountBalance from ledgerchartofaccounts where GLAccountType='Accounts Receivable' AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $rTotal = 0;
        foreach($receivables as $row)
            $rTotal += $row->GLAccountBalance;

        $payables = DB::SELECT("select GLAccountNumber, GLAccountName, GLAccountBalance from ledgerchartofaccounts where GLAccountType='Accounts Payable' AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $pTotal = 0;
        foreach($payables as $row)
            $pTotal += $row->GLAccountBalance;

        return [
            [
                "name" => "Receivables",
                "numbers" => $rTotal
            ],
            [
                "name" => "Payables",
                "numbers" => $pTotal
            ]
        ];
    }

    public function adminGetMonthlyIncome(){
        $user = Session::get("user");

        $orders = DB::SELECT("select BalanceDue from orderheader WHERE OrderDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $pTotal = 0;
        foreach($orders as $row)
            $pTotal += $row->BalanceDue;

        $invoices = DB::SELECT("select BalanceDue from invoiceheader WHERE InvoiceDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND Shipped=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $rTotal = 0;
        foreach($invoices as $row)
            $rTotal += $row->BalanceDue;

        return [
            "real" => $rTotal,
            "projected" => $pTotal
        ];
    }

    //Functions for Customer Dashboard
    public function customerGetCustomersNumbers(){
        $user = Session::get("user");

        $newmonth = DB::select("select CustomerID from customerinformation WHERE CustomerSince >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $newyear = DB::select("select CustomerID from customerinformation WHERE CustomerSince >= NOW() - INTERVAL 365 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $inactive = DB::select("select CustomerID from customerinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $total = DB::select("select CustomerID from customerinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $ret = [
            "newmonth" => count($newmonth),
            "newyear" => count($newyear),
            "inactive" => count($inactive),
            "total" => count($total)
        ];

        return $ret;
    }

    public function customerReceivables(){
        $user = Session::get("user");

        $results = DB::select("select * from customerfinancials WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        
        //        $results = DB::select("CALL spCompanyAccountsStatus('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());

        $ret = [
            "Over90" => [
                "FieldName" => "Over 90",
                "Totals" => 0
            ],
            "Over60" => [
                "FieldName" => "60-90",
                "Totals" => 0
            ],
            "Over30" => [
                "FieldName" => "30-60",
                "Totals" => 0
            ],
            "Current" => [
                "FieldName" => "Current",
                "Totals" => 0
            ]
        ];

        foreach($results as $row){
            $ret["Over30"]["Totals"] += $row->Over30;
            $ret["Over60"]["Totals"] += $row->Over60;
            $ret["Over90"]["Totals"] += $row->Over90;
            $ret["Current"]["Totals"] += $row->CurrentARBalance;
        }

        return $ret;
    }

}
?>