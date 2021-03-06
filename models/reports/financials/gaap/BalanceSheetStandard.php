<?php
/*
  Name of Page: GAAP Balance Sheet pages data source

  Method: It provides data from database for BalanceSheet pages

  Date created: Nikita Zaharov, 27.04.2017

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
    public $title = "BALANCE SHEET";
    public $type = "standard";
    public function __construct($type){
        $this->type = $type;
        if($_GET["itype"] == "Comparative")
            $this->title .= " Comparative";
    }

    public function getCurrencySymbol(){
        $user = $_SESSION["user"];

        $result =  $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrenycySymbol from Companies I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());
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

        $_GET["vtype"] = $this->type;

        if(preg_match('/Period/', $this->type, $numberParts))
            $params .= "'" . $_GET["year"] . "', '" . $_GET["period"] . "', ";

        //echo "CALL RptGLBalanceSheet" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', " . $params . "@PeriodEndDate, @ret)";
        $stmt = $conn->prepare("CALL RptGLBalanceSheet" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', " . $params . "@PeriodEndDate, @ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));
        $rs = $stmt->execute();

        $rcount = $stmt->rowCount();
        if($rcount){
            $result = $stmt->fetchAll($conn::FETCH_ASSOC);
            $result = gridFormatFields($stmt, $result);
        }else
            $result = [];

        $stmt = null;

        $data = [];
        foreach($result as $row)
            $data[$row["GLBalanceType"]][] = $row;
        
        foreach($data as $key=>$trow){
            $total = 0;
            if($_GET["itype"] == "Comparative")
                $totalComparative = 0;
            foreach($trow as $row){
                if($row["GLAccountBalanceOriginal"])
                    $total += $row["GLAccountBalanceOriginal"];
                if($_GET["itype"] == "Comparative")
                    if($row["GLAccountBalanceComparativeOriginal"])
                        $totalComparative += $row["GLAccountBalanceComparativeOriginal"];
            }
            $data[$key . "Total"] = $total;
            if($_GET["itype"] == "Comparative")
                $data[$key . "Total"] = $total;
        }
        
        if(!key_exists("AssetTotal", $data))
            $data["AssetTotal"] = 0;
        if(!key_exists("LiabilityTotal", $data))
            $data["LiabilityTotal"] = 0;
        if(!key_exists("EquityTotal", $data))
            $data["EquityTotal"] = 0;

        
        if($_GET["itype"] == "Comparative"){
            if(!key_exists("AssetTotalComparative", $data))
                $data["AssetTotalComparative"] = 0;
            if(!key_exists("LiabilityTotalComparative", $data))
                $data["LiabilityTotalComparative"] = 0;
            if(!key_exists("EquityTotalComparative", $data))
                $data["EquityTotalComparative"] = 0;
        }
        
        if(!key_exists("Asset", $data))
            $data["Asset"] = [];
        if(!key_exists("Liability", $data))
            $data["Liability"] = [];
        if(!key_exists("Equity", $data))
            $data["Equity"] = [];

        $data["NetIncome"] = $data["AssetTotal"] - ( $data["LiabilityTotal"] + $data["EquityTotal"]);
        $data["LiabilityEquityTotal"] = formatCurrency($data["LiabilityTotal"] + $data["EquityTotal"] + $data["NetIncome"]);
        $data["LiabilityTotal"] = formatCurrency($data["LiabilityTotal"]);
        $data["EquityTotal"] = formatCurrency($data["EquityTotal"]);
        $data["AssetTotal"] = formatCurrency($data["AssetTotal"]);
        $data["Equity"][] = [
            "GLAccountName" => "Net Income",
            "GLAccountBalance" => formatCurrency($data["NetIncome"])
        ];
        if($_GET["itype"] == "Comparative"){
            $data["NetIncomeComparative"] = $data["AssetTotalComparative"] - ( $data["LiabilityTotalComparative"] + $data["EquityTotalComparative"]);
            $data["LiabilityEquityTotalComparative"] = formatCurrency($data["LiabilityTotalComparative"] + $data["EquityTotalComparative"]);
            $data["LiabilityTotalComparative"] = formatCurrency($data["LiabilityTotalComparative"]);
            $data["EquityTotalComparative"] = formatCurrency($data["EquityTotalComparative"]);
            $data["AssetTotalComparative"] = formatCurrency($data["AssetTotalComparative"]);
            $data["Equity"][count($data["Equity"]) - 1]["GLAccountBalanceComparative"] = formatCurrency($data["NetIncomeComparative"]);
        }

        $st = $conn->prepare("select @PeriodEndDate");
        $st->execute();
        $data["PeriodEndDate"] = date_create($st->fetchAll($conn::FETCH_ASSOC)[0]["@PeriodEndDate"])->format("F d, Y");
        $st = null;
        return $data;
    }
}
?>