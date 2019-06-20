<?php
/*
  Name of Page: GAAP Direct Trial Balance page data source

  Method: It provides data from database for Trial Balance page

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
    public $title = "TRIAL BALANCE";
    public $type = "Standard";
    public function __construct($type){
        $this->type = $type;
        if($_GET["itype"] == "Comparative")
            $this->title .= " Comparative";
        if($_GET["itype"] == "YTD")
            $this->title .= " YTD";
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
        
        $stmt = $conn->prepare("CALL RptGLTrialBalance" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', @PeriodEndDate, @ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));

        $rs = $stmt->execute();

        $rcount = $stmt->rowCount();
        if($rcount){
            $result = $stmt->fetchAll($conn::FETCH_ASSOC);
            $result = gridFormatFields($stmt, $result);
        }else
            $result = [];

        $stmt = null;

        $data = [];
        $data["raw"] = $result;

        $itype = $_GET["itype"];
        $data["DebitTotal"] = 0;
        $data["CreditTotal"] = 0;
        $data["DebitTotal" . $itype] = 0;
        $data["CreditTotal" . $itype] = 0;
        $data["Credit"] = [];
        $data["Debit"] = [];
        
        foreach($result as $row){
            if($row["GLBalanceType"] == "Credit"){
                $data["Credit"][] = $row;
                $data["CreditTotal"] += $row["GLAccountBalanceOriginal"];
                if($itype != "Standard")
                    $data["CreditTotal" . $itype] += $row["GLAccountBalance" . $itype . "Original"];
            }else if($row["GLBalanceType"] == "Debit"){
                $data["Debit"][] = $row;
                $data["DebitTotal"] += $row["GLAccountBalanceOriginal"];
                if($itype != "Standard")
                    $data["DebitTotal" . $itype] += $row["GLAccountBalance" . $itype . "Original"];
            } 
        }
        $data["DebitTotal"] = formatCurrency($data["DebitTotal"]);
        $data["CreditTotal"] = formatCurrency($data["CreditTotal"]);
        if($itype != "Standard"){
            $data["DebitTotal" . $itype] = formatCurrency($data["DebitTotal" . $itype]);
            $data["CreditTotal" . $itype] = formatCurrency($data["CreditTotal" . $itype]);
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