<?php
/*
  Name of Page: dashboard data source

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

  Last Modified: 03.12.2019
  Last Modified by: Nikita Zaharov
*/

class dashboardData{
    public $breadCrumbTitle = "General Ledger";
    public $dashboardTitle = "General Ledger";

    //Accounting dashboard    
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

        public function getCompanyDailyActivityByDepartments(){
        $user = Session::get("user");

        $departments =  DB::select("SELECT CompanyID, DivisionID, DepartmentID from departments WHERE CompanyID=?", [$user["CompanyID"]]);
        foreach($departments as &$row){
            $row->Status = [];

           $row->Status["quotes"] = DB::select("select count(OrderNumber) as Quotes, sum(IFNULL(Total,0)) as QuoteTotals from orderheader WHERE LOWER(OrderTypeID) = LOWER('Quote') and  OrderDate >= now() - INTERVAL 1 DAY and CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());
            //        $results["quotes"] = DB::select("CALL spCompanyDailyActivityQuotes('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
            $row->Status["orders"] = DB::select("CALL spCompanyDailyActivityOrders('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
            $row->Status["receivings"] = DB::select("select count(PurchaseNumber) as Receivings, sum(IFNULL(Total,0)) as ReceiptTotals from purchaseheader WHERE Received=0 and  PurchaseDate >= now() - INTERVAL 1 DAY and CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());
            //        $results["receivings"] = DB::select("CALL spCompanyDailyActivityReceivings('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
            $row->Status["purchases"] = DB::select("CALL spCompanyDailyActivityPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
            $row->Status["shipments"] = DB::select("CALL spCompanyDailyActivityShipments('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        }
        
        return $departments;
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
    
    public function top10Leads(){
        $user = Session::get("user");

        return DB::select("select LeadID, LeadEmail from leadinformation WHERE FirstContacted >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? ORDER BY FirstContacted DESC LIMIT 10", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
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

    //For multi-entity Accounting
    public function getDepartments(){
        $user = Session::get("user");
        return DB::select("SELECT CompanyID, DivisionID, DepartmentID from departments WHERE CompanyID=?", [$user["CompanyID"]]);
    }

    public function getAccountsStatusesByDepartments(){
        $user = Session::get("user");
        
        $departments =  DB::select("SELECT CompanyID, DivisionID, DepartmentID from departments WHERE CompanyID=?", [$user["CompanyID"]]);
        foreach($departments as &$row)
            $row->Status = DB::select("CALL spCompanyAccountsStatus(?, ?, ? ,@SWP_RET_VALUE)", [$row->CompanyID, $row->DivisionID, $row->DepartmentID]);
        return $departments;
    }
    
    public function getTopOrdersReceiptsByDepartments(){
        $user = Session::get("user");

        $departments =  DB::select("SELECT CompanyID, DivisionID, DepartmentID from departments WHERE CompanyID=?", [$user["CompanyID"]]);
        foreach($departments as &$row){
            $row->Status = [];
            $row->Status["orders"] = DB::select("CALL spTopOrdersReceipts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
            $row->Status["purchases"] = DB::select("CALL spTopOrdersReceiptsPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        }
        
        return $departments;
    }

    //for other Accounting dashboards
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

    //Vendor dashboard
    public function vendorGetVendorsNumbers(){
        $user = Session::get("user");

        $newmonth = DB::select("select VendorID from vendorinformation WHERE CustomerSince >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $newyear = DB::select("select VendorID from vendorinformation WHERE CustomerSince >= NOW() - INTERVAL 365 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $inactive = DB::select("select VendorID from vendorinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $total = DB::select("select VendorID from vendorinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $ret = [
            "newmonth" => count($newmonth),
            "newyear" => count($newyear),
            "inactive" => count($inactive),
            "total" => count($total)
        ];

        return $ret;
    }


    public function vendorReceivables(){
        $user = Session::get("user");

        $results = DB::select("select * from vendorfinancials WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        
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
            $ret["Current"]["Totals"] += $row->CurrentAPBalance;
        }

        return $ret;
    }

    public function vendorGetMonthlyExpenses(){
        $user = Session::get("user");

        $orders = DB::SELECT("select BalanceDue from purchaseheader WHERE PurchaseDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $pTotal = 0;
        foreach($orders as $row)
            $pTotal += $row->BalanceDue;

        $payments = DB::SELECT("select Amount from paymentsheader WHERE PaymentDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND Paid=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $rTotal = 0;
        foreach($payments as $row)
            $rTotal += $row->Amount;

        return [
            "real" => $rTotal,
            "projected" => $pTotal
        ];
    }

    public function Top10PurchasesPayables(){
        $user = Session::get("user");

        $results = [];
        $ordersQuery = <<<EOF
   SELECT 
   PurchaseNumber,
	  PurchaseShipDate,
	  VendorID,
	  (IFNULL(Total,0)) as PurchaseTotal
   FROM PurchaseHeader
   WHERE CompanyID = ? AND
   DivisionID = ? AND
   DepartmentID = ? and
   lower(PurchaseNumber) <> 'default' and
   Total <> 0 and
   PurchaseDate <= CURRENT_TIMESTAMP AND
   (LOWER(IFNULL(PurchaseHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND
   (IFNULL(Posted, 0) = 1)
   ORDER BY PurchaseTotal DESC LIMIT 10;
EOF;
        $results["orders"] = DB::select($ordersQuery, array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));
        
        $paymentsQuery = <<<EOF
   SELECT 
   PaymentID,
	  PurchaseDate,
	  VendorID,
	  (IFNULL(Amount,0)) as PaymentTotal
   FROM PaymentsHeader
   WHERE CompanyID = ? AND
   DivisionID = ? AND
   DepartmentID = ? and
   lower(PaymentID) <> 'default' and
   Amount <> 0 and
   PaymentDate <= CURRENT_TIMESTAMP AND
   (LOWER(IFNULL(PaymentsHeader.PaymentTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND
   (IFNULL(Paid, 0) = 1)
   ORDER BY PaymentTotal DESC LIMIT 10;
EOF;
        
        $results["payments"] = DB::select($paymentsQuery, array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));
        
        return $results;
    }

    //Item dashboard

    function itemGetCriticalyLowInventory(){
        $user = Session::get("user");

        $results = DB::select("SELECT * from inventorybywarehouse WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND QtyCommitted > 0 AND QtyOnHand=0", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);

        return $results;
    }

    public function itemGetItemsNumbers(){
        $user = Session::get("user");

        $receivingstoday = DB::select("select VendorID from purchaseheader WHERE ShipDate >= NOW() - INTERVAL 1 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND Received=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $receivingsmonth = DB::select("select VendorID from purchaseheader WHERE ShipDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND Received=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $transitstoday = DB::select("select TransitID from warehousetransitheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND TransitEnteredDate <= NOW() - INTERVAL 1 DAY", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $transitstotal = DB::select("select TransitID from warehousetransitheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $ret = [
            "receivingstoday" => count($receivingstoday),
            "receivingsmonth" => count($receivingsmonth),
            "transitstoday" => count($transitstoday),
            "transitstotal" => count($transitstotal)
        ];

        return $ret;
    }

    public function accountingGetNumbers(){
        $user = Session::get("user");

        $ret = [
            "newinvoices" => count(DB::select("select InvoiceNumber from invoiceheader WHERE (NOT (LOWER(IFNULL(InvoiceHeader.TransactionTypeID,N'')) IN ('return', 'service invoice', 'credit memo')) AND (ABS(InvoiceHeader.BalanceDue) >= 0.005 OR ABS(InvoiceHeader.Total) < 0.005 OR IFNULL(InvoiceHeader.Posted,0) = 0)) AND InvoiceDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "newpurchases" => count(DB::select("select PurchaseNumber from purchaseheader WHERE (NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND ((IFNULL(Received,0) = 0) OR (IFNULL(PurchaseHeader.Paid,0) = 0) OR UPPER(PurchaseNumber)='DEFAULT') AND PurchaseDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]))
        ];

        return $ret;
    }

    public function salesGetNumbers(){
        $user = Session::get("user");

        $orders = DB::select("select OrderNumber, Total from orderheader WHERE  CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $totalAmount = 0;
        foreach($orders as $record)
            $totalAmount += $record->Total;
        $ret = [
            "shiptoday" => count(DB::select("select OrderNumber from orderheader WHERE OrderShipDate >= NOW() - INTERVAL 1 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "shipthismonth" => count(DB::select("select OrderNumber from orderheader WHERE OrderShipDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalorders" => count(DB::select("select OrderNumber from orderheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalordersamount" => $totalAmount
        ];

        return $ret;
    }

    public function purchaseGetNumbers(){
        $user = Session::get("user");

        $orders = DB::select("select PurchaseNumber, Total from purchaseheader WHERE  CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $totalAmount = 0;
        foreach($orders as $record)
            $totalAmount += $record->Total;
        $ret = [
            "receivingtoday" => count(DB::select("select PurchaseNumber from purchaseheader WHERE PurchaseShipDate >= NOW() - INTERVAL 1 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "receivingthismonth" => count(DB::select("select PurchaseNumber from purchaseheader WHERE PurchaseShipDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalorders" => count(DB::select("select PurchaseNumber from purchaseheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalordersamount" => $totalAmount
        ];

        return $ret;
    }

    //functions for Support dashboard
    public function supportGetNumbers(){
        $user = Session::get("user");

        $ret = [
            "newmonth" => count(DB::select("select CaseId from helpsupportrequest WHERE SupportDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmailConfirmed=1 AND IFNULL(SupportStatus, '') <> 'Resolved'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "newyear" => count(DB::select("select CaseId from helpsupportrequest WHERE SupportDate >= NOW() - INTERVAL 365 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmailConfirmed=1 AND IFNULL(SupportStatus, '') <> 'Resolved'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "resolved" => count(DB::select("select CaseId from helpsupportrequest WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND IFNULL(SupportStatus, '') = 'Resolved' AND EmailConfirmed=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "total" => count(DB::select("select CaseId from helpsupportrequest WHERE  CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmailConfirmed=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]))
        ];

        return $ret;
    }

    //Functions for CRM Dashboard
    public function leadsGetNumbers(){
        $user = Session::get("user");

        $newmonth = DB::select("select LeadID from leadinformation WHERE FirstContacted >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $newyear = DB::select("select LeadID from leadinformation WHERE FirstContacted >= NOW() - INTERVAL 365 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $inactive = DB::select("select LeadID from leadinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND LastVisit < NOW() - INTERVAL 100 DAY", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $total = DB::select("select LeadID from leadinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $ret = [
            "newmonth" => count($newmonth),
            "newyear" => count($newyear),
            "inactive" => count($inactive),
            "total" => count($total)
        ];

        return $ret;
    }


    public function MRPGetNumbers(){
        $user = Session::get("user");

        $orders = DB::select("select WorkOrderNumber, WorkOrderTotalCost from workorderheader WHERE  CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $totalAmount = 0.01;
        foreach($orders as $record)
            $totalAmount += $record->WorkOrderTotalCost;
        $ret = [
            "today" => count(DB::select("select WorkOrderNumber from workorderheader WHERE WorkOrderStartDate >= NOW() - INTERVAL 1 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "thismonth" => count(DB::select("select WorkOrderNumber from workorderheader WHERE WorkOrderStartDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalorders" => count(DB::select("select WorkOrderNumber from workorderheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND WorkOrderNumber <> 'DEFAULT'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalordersamount" => $totalAmount
        ];

        return $ret;
    }

    public function getWorkOrdersForCalendar(){
        $user = Session::get("user");

        $result = DB::select("select WorkOrderNumber, WorkOrderCompletedDate from workorderheader WHERE WorkOrderNumber <> 'DEFAULT' AND CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function MRPgetTopWarehouseTransits(){
        $user = Session::get("user");

        return DB::select("select * from warehousetransitheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND TransitID <> 'DEFAULT' ORDER BY TransitEnteredDate DESC LIMIT 5", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $results["orders"] = DB::select("CALL spTopOrdersReceipts('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
        $results["purchases"] = DB::select("CALL spTopOrdersReceiptsPurchases('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)", array());
    }

        public function financialGetNumbers(){
        $user = Session::get("user");

        $orders = DB::select("select PaymentID, Amount from paymentsheader WHERE  CompanyID=? AND DivisionID=? AND DepartmentID=? AND (IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        $totalAmount = 0.01;
        foreach($orders as $record)
            $totalAmount += $record->Amount;
        $ret = [
            "today" => count(DB::select("select PaymentID from paymentsheader WHERE DueToDate >= NOW() - INTERVAL 1 DAY AND DueToDate < NOW() + INTERVAL 1 DAY  AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND (IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "thismonth" => count(DB::select("select PaymentID from paymentsheader WHERE DueToDate >= NOW() - INTERVAL 30 DAY AND CompanyID=? AND DivisionID=? AND DepartmentID=? AND (IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "total" => count(DB::select("select PaymentID from paymentsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND PaymentID <> 'DEFAULT' AND (IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]])),
            "totalamount" => $totalAmount
        ];

        return $ret;
    }
}
?>