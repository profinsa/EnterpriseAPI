<?php
/*
Name of Page: GAAP Income Statement page data source

Method: It provides data from database for Income Statement page

Date created: Nikita Zaharov, 27.04.2016

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

Last Modified: 11.05.2016
Last Modified by: Nikita Zaharov
*/

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

function formatCurrency($value){
    $afterdot = 2;
    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
        return numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
    else
        return numberToStr($value) . ".00";

}

function gridFormatFields($stmt, $result){
    if(count($result)){
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                $result[$rkey][$key . "Original"] = $value;
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL" || $meta[$key]["native_type"] == "LONGLONG"){
                    $afterdot = 2;
                    if($meta[$key]["native_type"] == "LONGLONG")
                        $result[$rkey][$key] = numberToStr($value) . ".00";
                    else if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }
    }
    return $result;
}

class financialsReportData{
    public $title = "INCOME STATEMENT";
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

        if(preg_match('/Period/', $this->type, $numberParts))
            $params .= "'" . $_GET["year"] . "', '" . $_GET["period"] . "', ";
        
        $stmt = $conn->prepare("CALL RptGLIncomeStatement" . $typesToProc[$this->type] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', " . $params . "@PeriodEndDate, @IncomeTotal, @CogsTotal, @ExpenseTotal" . ($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD" ? ", @IncomeTotalComparative, @CogsTotalComparative, @ExpenseTotalComparative" : "") . ", @ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));

        $rs = $stmt->execute();

        $rcount = $stmt->rowCount();
        if($rcount){
            $result = $stmt->fetchAll($conn::FETCH_ASSOC);
            $result = gridFormatFields($stmt, $result);
        }else
            $result = [];

        /*        $stmt->nextRowset();
        $totals = $stmt->fetchAll($conn::FETCH_ASSOC);
        $totals = gridFormatFields($stmt, $totals);

        $stmt->nextRowset();
        $details = $stmt->fetchAll($conn::FETCH_ASSOC);
        $details = gridFormatFields($stmt, $details);
        */
        $stmt = null;

        $data = [];
        $data["raw"] = $result;
        foreach($result as $row){
            if($row["GLBalanceType"] == "Expense"){
                if($row["GLAccountNumber"][0] == '5')
                    $data["Cogs"][] = $row;
                else
                    $data["Expense"][] = $row;

            }else
                $data[$row["GLBalanceType"]][] = $row;
        }
        if(!key_exists("Income", $data))
            $data["Income"] = [];
        if(!key_exists("Cogs", $data))
            $data["Cogs"] = [];
        if(!key_exists("Expense", $data))
            $data["Expense"] = [];
        //        if(!key_exists("Expense", $data))
        //  $data["Equity"] = [];


        $st = $conn->prepare("select @PeriodEndDate, @IncomeTotal, @CogsTotal, @ExpenseTotal" . ($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD" ? ", @IncomeTotalComparative, @CogsTotalComparative, @ExpenseTotalComparative" : ""));
        $st->execute();
        $result = $st->fetchAll($conn::FETCH_ASSOC)[0];
        $data["PeriodEndDate"] = date_create($result["@PeriodEndDate"])->format("F d, y");
        $data["IncomeTotal"] = formatCurrency($result["@IncomeTotal"]);
        $data["CogsTotal"] = formatCurrency($result["@CogsTotal"]);
        $data["ExpenseTotal"] = formatCurrency($result["@ExpenseTotal"]);
        $data["NetIncome"] =  formatCurrency($result["@IncomeTotal"] - $result["@CogsTotal"] - $result["@ExpenseTotal"]);
        $data["GrossProfit"] =  formatCurrency($result["@IncomeTotal"] - $result["@CogsTotal"]);

        if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"){
            $data["IncomeTotalComparative"] = formatCurrency($result["@IncomeTotalComparative"]);
            $data["CogsTotalComparative"] = formatCurrency($result["@CogsTotalComparative"]);
            $data["ExpenseTotalComparative"] = formatCurrency($result["@ExpenseTotalComparative"]);
            $data["NetIncomeComparative"] =  formatCurrency($result["@IncomeTotalComparative"] - $result["@CogsTotalComparative"] - $result["@ExpenseTotalComparative"]);
        $data["GrossProfitComparative"] =  formatCurrency($result["@IncomeTotalComparative"] - $result["@CogsTotalComparative"]);
        }
        
        $st = null;
        return $data;
    }
}
?>