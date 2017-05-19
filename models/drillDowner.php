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
            return "<a target=\"_Blank\" href=\"index.php#/?page=grid&action=AccountsPayable/Vendors/ViewVendorFinancials&mode=view&category=Main&item=$keyString\">$value</a>";
            break;
        case "CustomerID" :
            $keyString .= "__" . $value;
		return "<a target=\"_Blank\" href=\"index.php#/?page=grid&action=AccountsReceivable/Customers/ViewCustomerFinancials&mode=view&category=Main&item=$keyString\">$value</a>";
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
		return "<a target=\"_blank\" href=\"index.php#/?page=grid&action=GeneralLedger/Ledger/ViewChartofAccounts&mode=view&category=Main&item=$keyString\">$name</a>";
	    }

        return $name;
    }

    public function getLinkByCustomerID($CustomerID){
        if($CustomerID)
            return "<a target=\"_blank\" href=\"index.php?page=docreports&type=customertransactions&id=$CustomerID\">$CustomerID</a>";
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
        
        return "<a target=\"_blank\" href=\"index.php?page=docreports&type=" . $pfixes["prefix"] . "invoice" . $pfixes["postfix"] . "&id=$InvoiceNumber\">$InvoiceNumber</a>";
    }
    
    public function getReportLinkByOrderNumber($OrderNumber, $page){
        $pfixes = $this->getPrefixAndPostfixByPage($page);
        
        if(!$this->checkOrder($OrderNumber, $pfixes))
            return $OrderNumber;
        
        return "<a target=\"_blank\" href=\"index.php?page=docreports&type=" . $pfixes["prefix"] . "order" . $pfixes["postfix"] . "&id=$OrderNumber\">$OrderNumber</a>";

    }

    public function getViewHrefByTransactionNumberAndType($number, $type){
        $user = $GLOBALS["user"];
        $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $number;
        
        $typeToView = [
            "Order" => "?page=grid&action=AccountsReceivable/OrderProcessing/ViewOrders&mode=view&category=Main&item=",
            "Service Order" => "?page=grid&action=AccountsReceivable/ServiceProcessing/ViewServiceOrderss&mode=view&category=Main&item=",
            "Service Invoice" => "?page=grid&action=AccountsReceivable/ServiceProcessing/ViewServiceInvoicess&mode=view&category=Main&item=",
            "Invoice" => "?page=grid&action=AccountsReceivable/OrderProcessing/ViewInvoicess&mode=view&category=Main&item=",
            "Check" => "?page=grid&action=AccountsPayable/VoucherProcessing/ViewVoucherss&mode=view&category=Main&item=",
            "Purchase Order" => "?page=grid&action=AccountsPayable/PurchaseProcessing/ViewPurchasess&mode=view&category=Main&item=",
            "Credit Memo" => "?page=grid&action=AccountsReceivable/CreditMemos/ViewCreditMemoss&mode=view&category=Main&item=",
            "Debit Memo" => "?page=grid&action=AccountsPayable/DebitMemos/ViewDebitMemoss&mode=view&category=Main&item=",
            "RMA" => "?page=grid&action=AccountsReceivable/RMAScreens/ViewRMAs&mode=view&category=Main&item=",
            "Return" => "?page=grid&action=AccountsPayable/ReturntoVendorProcessing/ViewReturnss&mode=view&category=Main&item=",
            "Cash" => "?page=grid&action=AccountsReceivable/CashReceiptsProcessing/ViewCashReceiptss&mode=view&category=Main&item=",
            "Visa" => "?page=grid&action=AccountsReceivable/CashReceiptsProcessing/ViewCashReceiptss&mode=view&category=Main&item=",
            "Quote" => "?page=grid&action=AccountsReceivable/OrderScreens/ViewQuotess&mode=view&category=Main&item="
        ];

        return "index.php#/" . (key_exists($type, $typeToView) ? $typeToView[$type] : "?page=grid&action=AccountsReceivable/OrderProcessing/ViewOrders&mode=view&category=Main&item=") . "$keyString";
    }

    public function getReportLinkByTransactionNumberAndType($number, $type){
        $typeToReport = [
            "Order" => "order",
            "Service Order" => "serviceorder",
            "Service Invoice" => "serviceinvoice",
            "Invoice" => "invoice",
            "Check" => "purchaseorder",
            "Purchase Order" => "purchaseorder",
            "Credit Memo" => "creditmemo",
            "Debit Memo" => "debitmemo",
            "RMA" => "rmaorder",
            "Return" => "returninvoice",
            "Quote" => "quote"
        ];

        return "<a target=\"_blank\" href=\"" . "docreports/" . (key_exists($type, $typeToReport) ? $typeToReport[$type] : "order") . "/$number\">$number</a>";
    }
}
?>