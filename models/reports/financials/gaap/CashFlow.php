<?php
/*
  Name of Page: GAAP Direct Cash Flow page data source

  Method: It provides data from database for Direct Cash Flow page

  Date created: Nikita Zaharov, 02.05.2017

  Use: this model used for 
  - for loading data using stored procedures

  Input parameters:
  $capsule: database instance
  methods has own parameters

  Output parameters:
  - methods has own output

  Called from:
  controllers/financials

  Calls:
  sql

  Last Modified: 20.06.2019
  Last Modified by: Nikita Zaharov
*/

require_once "./models/reports/format.php";

class financialsReportData{
    public $title = "DIRECT CASH FLOW STATEMENT";
    public $type = "standard";
    public function __construct($type){
        $this->type = $type;
        if($_GET["itype"] == "Comparative")
            $this->title .= " Comparative";
        if($_GET["itype"] == "YTD")
            $this->title .= " YTD";
    }

    public function getCurrencySymbol(){
        $user = $_SESSION["user"];

        $result = $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrenycySymbol from Companies I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());
        $result = [];
        
        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrenycySymbol : "$"
        ];
    }

    public function getUser(){
        $user = $_SESSION["user"];

        $user["company"] = $GLOBALS["capsule"]::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];
        
        return $user;
    }

    public function getData(){
        $user = $_SESSION["user"];
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $conn->setAttribute($conn::ATTR_EMULATE_PREPARES, true);
        $typesToProc = [
            "Standard" => "",
            "Company" => "Company",
            "Division" => "Division",
            "Period" => "Period",
            "DivisionPeriod" => "PeriodDivision",
            "CompanyPeriod" => "PeriodCompany"
        ];

        $params = '';

        if(preg_match('/Period/', $this->type, $numberParts))
            $params .= "'" . $_GET["year"] . "', '" . $_GET["period"] . "', ";
        
        $stmt = $conn->prepare("CALL RptGLCashFlow" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "Drills('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', " . $params . "@PeriodEndDate, @ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));

        $rs = $stmt->execute();

        $rcount = $stmt->rowCount();
        if($rcount){
            $result = $stmt->fetchAll($conn::FETCH_ASSOC);
            $result = gridFormatFields($stmt, $result);
        }else
            $result = [];

        

        $stmt = null;

        $data = [];

        //       echo "RptGLCashFlow" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "Drills(";
        //echo json_encode($result[0]);
        $itype = $_GET["itype"];
        
        $data["OperatingDebitsTotal"] = 0;
        $data["OperatingCreditsTotal"] = 0;
        $data["InvestingDebitsTotal"] = 0;
        $data["InvestingCreditsTotal"] = 0;
        $data["FinancingDebitsTotal"] = 0;
        $data["FinancingCreditsTotal"] = 0;
        $data["BeginningYearBalance"] = 0;
        $data["EndYearBalance"] = 0;
        $data["TotalYearBalance"] = 0;
        $data["OperatingDebitsTotal" . $itype] = 0;
        $data["OperatingCreditsTotal" . $itype] = 0;
        $data["InvestingDebitsTotal" . $itype] = 0;
        $data["InvestingCreditsTotal" . $itype] = 0;
        $data["FinancingDebitsTotal" . $itype] = 0;
        $data["FinancingCreditsTotal" . $itype] = 0;
        $data["BeginningYearBalance" . $itype] = 0;
        $data["EndYearBalance" . $itype] = 0;
        $data["TotalYearBalance" . $itype] = 0;
        $data["Operating"] = [];
        $data["Investing"] = [];
        $data["Financing"] = [];
        
        foreach($result as $row){
            if($row["CashFlowType"] == "Operating Activities"){
                if($row["Debit"]){
                    $row["debit"] = $row["Debit"];
                    $data["OperatingDebitsTotal"] += $row["DebitOriginal"];
                }
                if($row["Credit"]){
                    $row["credit"] = $row["Credit"];
                    $data["OperatingCreditsTotal"] += $row["CreditOriginal"];
                }
                $data["Operating"][] = $row;
            }else if($row["CashFlowType"] == "Investing Activities"){
                if($row["Debit"]){
                    $row["debit"] = $row["Debit"];
                    $data["InvestingDebitsTotal"] += $row["DebitOriginal"];
                }
                if($row["Credit"]){
                    $row["credit"] = $row["Credit"];
                    $data["InvestingCreditsTotal"] += $row["CreditOriginal"];
                }
                $data["Investing"][] = $row;
            }else if($row["CashFlowType"] == "Financing Activities"){
                if($row["Debit"]){
                    $row["debit"] = $row["Debit"];
                    $data["FinancingDebitsTotal"] += $row["DebitOriginal"];
                }
                if($row["Credit"]){
                    $row["credit"] = $row["Credit"];
                    $data["FinancingCreditsTotal"] += $row["CreditOriginal"];
                }
                $data["Financing"][] = $row;
            }else if($row["CashFlowType"] == "BeginningYearBalance")
                $data["BeginningYearBalance"] += $row["Total"];

            if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"){
                if($row["CashFlowType"] == "Operating Activities"){
                    if($row["Debit" . $itype]){
                        $row["debit" . $itype] = $row["Debit" . $itype];
                        $data["OperatingDebitsTotal" . $itype] += $row["Debit" .  $itype . "Original"];
                    }
                    if($row["Credit" . $itype]){
                        $row["credit" . $itype] = $row["Credit" . $itype];
                        $data["OperatingCreditsTotal" . $itype] += $row["Credit" .  $itype . "Original"];
                    }
                }else if($row["CashFlowType"] == "Investing Activities"){
                    if($row["Debit"]){
                        $row["debit"] = $row["Debit"];
                        $data["InvestingDebitsTotal"] += $row["DebitOriginal"];
                    }
                    if($row["Credit" . $itype]){
                        $row["credit" . $itype] = $row["Credit" . $itype];
                        $data["InvestingCreditsTotal" . $itype] += $row["Credit"  . $itype . "Original"];
                    }
                }else if($row["CashFlowType"] == "Financing Activities"){
                    if($row["Debit" . $itype]){
                        $row["debit" . $itype] = $row["Debit" . $itype];
                        $data["FinancingDebitsTotal" . $itype] += $row["Debit"  . $itype . "Original"];
                    }
                    if($row["Credit" . $itype]){
                        $row["credit" . $itype] = $row["Credit" . $itype];
                        $data["FinancingCreditsTotal" . $itype] += $row["Credit"  . $itype . "Original"];
                    }
                }else if($row["CashFlowType"] == "BeginningYearBalance")
                    $data["BeginningYearBalance" . $itype] += $row["Total" . $itype];
            }
        }

        $data["TotalYearBalance"] = $data["OperatingDebitsTotal"] + $data["OperatingCreditsTotal"] + $data["InvestingDebitsTotal"] + $data["InvestingCreditsTotal"] + $data["FinancingDebitsTotal"] + $data["FinancingCreditsTotal"];
        $data["EndYearBalance"] = formatCurrency($data["BeginningYearBalance"] + $data["TotalYearBalance"]);
        $data["BeginningYearBalance"] = formatCurrency($data["BeginningYearBalance"]);
        $data["TotalYearBalance"] = formatCurrency($data["TotalYearBalance"]);
                                                   
        $data["OperatingTotal"] = formatCurrency($data["OperatingDebitsTotal"] + $data["OperatingCreditsTotal"]);
        $data["OperatingDebitsTotal"] = formatCurrency($data["OperatingDebitsTotal"]);
        $data["OperatingCreditsTotal"] = formatCurrency($data["OperatingCreditsTotal"]);
        $data["InvestingTotal"] = formatCurrency($data["InvestingDebitsTotal"] + $data["InvestingCreditsTotal"]);
        $data["InvestingDebitsTotal"] = formatCurrency($data["InvestingDebitsTotal"]);
        $data["InvestingCreditsTotal"] = formatCurrency($data["InvestingCreditsTotal"]);
        $data["FinancingTotal"] = formatCurrency($data["FinancingDebitsTotal"] + $data["FinancingCreditsTotal"]);
        $data["FinancingDebitsTotal"] = formatCurrency($data["FinancingDebitsTotal"]);
        $data["FinancingCreditsTotal"] = formatCurrency($data["FinancingCreditsTotal"]);

        if($itype == "Comparative" || $itype == "YTD"){
            $data["TotalYearBalance" . $itype] = $data["OperatingDebitsTotal" . $itype] + $data["OperatingCreditsTotal" . $itype] + $data["InvestingDebitsTotal" . $itype] + $data["InvestingCreditsTotal" . $itype] + $data["FinancingDebitsTotal" . $itype] + $data["FinancingCreditsTotal" . $itype];
            $data["EndYearBalance" . $itype] = formatCurrency($data["BeginningYearBalance" . $itype] + $data["TotalYearBalance" . $itype]);
            $data["BeginningYearBalance" . $itype] = formatCurrency($data["BeginningYearBalance" . $itype]);
            $data["TotalYearBalance" . $itype] = formatCurrency($data["TotalYearBalance" . $itype]);
                                                   
            $data["OperatingTotal" . $itype] = formatCurrency($data["OperatingDebitsTotal" . $itype] + $data["OperatingCreditsTotal" . $itype]);
            $data["OperatingDebitsTotal" . $itype] = formatCurrency($data["OperatingDebitsTotal" . $itype]);
            $data["OperatingCreditsTotal" . $itype] = formatCurrency($data["OperatingCreditsTotal" . $itype]);
            $data["InvestingTotal" . $itype] = formatCurrency($data["InvestingDebitsTotal" . $itype] + $data["InvestingCreditsTotal" . $itype]);
            $data["InvestingDebitsTotal" . $itype] = formatCurrency($data["InvestingDebitsTotal" . $itype]);
            $data["InvestingCreditsTotal" . $itype] = formatCurrency($data["InvestingCreditsTotal" . $itype]);
            $data["FinancingTotal" . $itype] = formatCurrency($data["FinancingDebitsTotal" . $itype] + $data["FinancingCreditsTotal" . $itype]);
            $data["FinancingDebitsTotal" . $itype] = formatCurrency($data["FinancingDebitsTotal" . $itype]);
            $data["FinancingCreditsTotal" . $itype] = formatCurrency($data["FinancingCreditsTotal" . $itype]);
        }
        
        $st = $conn->prepare("select @PeriodEndDate");
        $st->execute();
        $result = $st->fetchAll($conn::FETCH_ASSOC)[0];
        $data["PeriodEndDate"] = date_create($result["@PeriodEndDate"])->format("F d, Y");
        
        $st = null;
        return $data;
    }
}
?>