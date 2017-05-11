<?php
/*
Name of Page: drillDowner model

Method: It makes links to reports, grids and any page by passed Property name, Property value and other data

Date created: Nikita Zaharov, 05.05.2016

Use: this model used for 
For creating links(drill-down) to some resource by name of resource or other resource properties
For Example:
creating link to Account by account number
creating link to transaction by transaction number

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

class drillDowner{
    protected $accounts = null;
    
    public function getLinkByField($name, $value){
        $user = $GLOBALS["user"];
        $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"];

        switch($name){
        case "VendorID" :
		$keyString .= "__" . $value;
            return "<a target=\"_Blank\" href=\"" . $this->prefix . "/index#/grid/AccountsPayable/Vendors/ViewVendorFinancials/view/Main/$keyString\">$value</a>";
            break;
        case "CustomerID" :
            $keyString .= "__" . $value;
		return "<a target=\"_Blank\" href=\"" . $this->prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerFinancials/view/Main/$keyString\">$value</a>";
		break;
            default:
		return $value;
        }
    }

    public function getLinkByAccountNameAndBalance($name, $balance){
        $user = $GLOBALS["user"];
        $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"];

        if(!$this->accounts){
            $this->accounts = $GLOBALS["capsule"]::select("SELECT GLAccountNumber,GLAccountName,GLAccountBalance from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());
        }
        
        foreach($this->accounts as $value)
            if($value->GLAccountName == $name && $value->GLAccountBalance == $balance){
		$keyString .= "__" . $value->GLAccountNumber;
		return "<a target=\"_blank\" href=\"" . $this->prefix . "/index#/grid/GeneralLedger/Ledger/ViewChartofAccounts/view/Main/$keyString\">$name</a>";
	    }

        return $name;
    }

    public function getLinkByCustomerID($CustomerID){
        if($CustomerID)
            return "<a target=\"_blank\" href=\"" . $this->prefix . "/docreports/customertransactions/$CustomerID\">$CustomerID</a>";
    }

    protected function getPrefixAndPostfixByPage($page){
        $prefix = "";
        $postfix = "";
        if(preg_match('/Service/', $page))
            $prefix = "service";
        if(preg_match('/Return/', $page))
            $prefix = "return";
        if(preg_match('/Purchases/', $page))
            $prefix = "purchase";
        if(preg_match('/Voucher/', $page))
            $prefix = "purchase";

        if(preg_match('/History$/', $page))
            $postfix = "history";
        
        return [
            "prefix" => $prefix,
            "postfix" => $postfix
        ];
    }

    protected $orders = [];
    
    protected function checkOrder($OrderNumber, $pfixes){
        $user = $GLOBALS["user"];
        $table = "orderheader";
        if($pfixes["postfix"] == "history")
            $table = "orderheaderhistory";
        
        if(!count($this->orders))
            $this->orders = $GLOBALS["capsule"]::select("SELECT OrderNumber from $table WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($this->orders as $order)
            if($order->OrderNumber == $OrderNumber)
                return true;
        
        return false;
    }

    protected $invoices = [];
    
    protected function checkInvoice($InvoiceNumber, $pfixes){
        $user = $GLOBALS["user"];
        $table = "invoiceheader";
        if($pfixes["postfix"] == "history")
            $table = "invoiceheaderhistory";
        
        if(!count($this->invoices))
            $this->invoices = $GLOBALS["capsule"]::select("SELECT InvoiceNumber from $table WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($this->invoices as $invoice)
            if($invoice->InvoiceNumber == $InvoiceNumber)
                return true;
        
        return false;
    }

    public function getReportLinkByInvoiceNumber($InvoiceNumber, $page){
        $pfixes = $this->getPrefixAndPostfixByPage($page);

        if(!$this->checkInvoice($InvoiceNumber, $pfixes))
            return $InvoiceNumber;
        
        return "<a target=\"_blank\" href=\"" . $this->prefix . "/docreports/" . $pfixes["prefix"] . "invoice" . $pfixes["postfix"] . "/$InvoiceNumber\">$InvoiceNumber</a>";
    }
    
    public function getReportLinkByOrderNumber($OrderNumber, $page){
        $pfixes = $this->getPrefixAndPostfixByPage($page);
        
        if(!$this->checkOrder($OrderNumber, $pfixes))
            return $OrderNumber;
        
        return "<a target=\"_blank\" href=\"" . $this->prefix . "/docreports/" . $pfixes["prefix"] . "order" . $pfixes["postfix"] . "/$OrderNumber\">$OrderNumber</a>";

    }
}
?>