<?php
/*
  Name of Page: Transaction Shipping Rate Helper

  Method: Relaculation logic for pages like Order, Invoice etc

  Date created: 06/12/2017 Nikita Zaharov

  Use: this model used by Order Like pages for recalc shipping action

  Input parameters:
  - header rod data

  Output parameters:
  - row data for write to database

  Called from: models for pages like Order Form(Order, Invoice, Quote, etc)

  Calls:
  MySql Database

  Last Modified: 06/12/2017
  Last Modified by: Zaharov Nikita
*/

require "shippingRate.php";
class transactionShippingRate{
    protected $tableBase = "";
    protected $success = "";

    protected $CountryFrom = "";
    protected $ZipFrom = "";
    protected $ChargeHandling = "";
    protected $HandlingAsPercent = "";
    protected $HandlingRate = 0;
    protected $CountryTo = "";
    protected $ZipTo = "";
    protected $Weight = "";
    protected $Method = 0;
    protected $Amount = 0.0000;
    
    //calculation results
    protected $Shipping = 0.000;
    protected $Handling = 0.000;

    function __construct($type){
        if($type == "Order" || $type == "Invoice")
            $this->tableBase = $type;
    }

    public function calculate($user, $data, $header, $details, $idField, $id){
        $this->success = true;
        $company = DB::select("SELECT CompanyCountry, CompanyZip, ChargeHandling, HandlingAsPercent, HandlingRate from companies WHERE CompanyID='" . $user["CompanyID"] . "'", array())[0];

        $this->CountryFrom = $company->CompanyCountry;
        $this->ZipFrom = $company->CompanyZip;
        $this->ChargeHandling = $company->ChargeHandling;
        $this->HandlingAsPercent = $company->HandlingAsPercent;
        $this->HandlingRate = $company->HandlingRate;

        $data->Recalc();
        /* Get document shipping info
           Here we don't use Subtotal Header field because
           transaction isn't recalculated yet*/
                              
        $Weight = 0;
        foreach($details as $detail)
            $Weight += round($detail->TotalWeight);

        $Amount = $header->Subtotal;
        $CountryTo = $header->ShippingCountry;
        $ZipTo = $header->ShippingZip;
        
        $Method = DB::select("SELECT ShipMethodID from shipmentmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND ShipMethodID='" . $header->ShipMethodID . "'", array());
        if(count($Method))
            $Method = $Method[0]->ShipMethodDescription;

        
        //Request shipping rate

        $shippingRate = new ShippingRate();
        
        $rateResult = $shippingRate->getRate($this->CountryFrom, $this->ZipFrom, $this->CountryTo, $this->ZipTo, $Weight, $Amount, $this->ChargeHandling, $this->HandlingAsPercent, $this->HandlingRate, $Method);

        if($rateResult["error"]){
            if($rateResult["error"] == "query error")
                echo "An error ocurred while calculating shipping rate.\nThis can be caused by either overweight or problems with remote\nshipping rate calculation service.";
            else
                echo "Cannot calculate shipping rate: " . $rateResult["error"];
        }
        
        //Update document
        
        DB::update("UPDATE " . $this->tableBase . "Header set Freight='" . $rateResult["Shipping"] . "', Handling='" . $rateResult["Handling"] . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND $idField='" . $id ."'");

        $data->Recalc();
    }
}
