<?php
/*
  Name of Page: Recalculation Helper

  Method: Relaculation logic for pages like Order, Invoice etc

  Date created: 06/12/2017 Nikita Zaharov

  Use: this model used by Order Like pages for recalculation action

  Input parameters:
  - header rod data

  Output parameters:
  - row data for write to database

  Called from: models for pages like Order Form(Order, Invoice, Quote, etc)

  Calls:
  MySql Database

  Last Modified: 08/14/2017
  Last Modified by: Zaharov Nikita
*/

class recalcHelper{
    public function getPrecision($currencyID) {
        $user = Session::get("user");

        $result = DB::select("SELECT CurrencyPrecision from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CurrencyID='" . $currencyID . "'" , array());

        if ($result) {
            return $result[0]->CurrencyPrecision;
        } else {
            return 2;
        }
    }

    public function lookForProcedure($procedureName) {
        $result = DB::select("SELECT * from information_schema.parameters WHERE SPECIFIC_NAME='" . $procedureName . "'" , array());

        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    public function recalcRMADetail($currencyPrecision, $purchaseDetail) {
        $DiscountPerc = $purchaseDetail->DiscountPerc;
        $Qty = $purchaseDetail->OrderQty;
        $Taxable = $purchaseDetail->Taxable;
        $TaxPercent = $purchaseDetail->TaxPercent ? $purchaseDetail->TaxPercent : 0;
        $ItemUnitPrice = $purchaseDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating PurchaseDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function recalcRMA($user, $purchaseNumber) {
        $result = DB::select("SELECT * from PurchaseHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        $purchaseHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($purchaseHeader->CurrencyID);

        $purchaseDetails = DB::select("SELECT * from PurchaseDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        foreach($purchaseDetails as $purchaseDetail) {
            $detailResult = $this->recalcRMADetail($Precision, $purchaseDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE PurchaseDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseLineNumber='" . $purchaseDetail->PurchaseLineNumber ."'");
        }

        $Handling = $purchaseHeader->Handling;
        $HeaderTaxPercent = $purchaseHeader->TaxPercent;

        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $purchaseHeader->Freight;
        $TaxFreight = $purchaseHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE PurchaseHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $purchaseHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber ."'");
    }

    public function recalcServiceOrderDetail($currencyPrecision, $allowanceDiscountPerc, $serviceOrderDetail) {
        $DiscountPerc = $serviceOrderDetail->DiscountPerc + $allowanceDiscountPerc;
        $Qty = $serviceOrderDetail->OrderQty;
        $Taxable = $serviceOrderDetail->Taxable;
        $TaxPercent = $serviceOrderDetail->TaxPercent ? $serviceOrderDetail->TaxPercent : 0;
        $ItemUnitPrice = $serviceOrderDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating OrderDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function recalcServiceOrder($user, $orderNumber) {
        $result = DB::select("SELECT * from OrderHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());

        $orderHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($orderHeader->CurrencyID);

        $serviceOrderDetails = DB::select("SELECT * from OrderDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());
        foreach($serviceOrderDetails as $serviceOrderDetail) {
            $detailResult = $this->recalcServiceOrderDetail($Precision, $orderHeader->AllowanceDiscountPerc, $serviceOrderDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE OrderDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderLineNumber='" . $serviceOrderDetail->OrderLineNumber ."'");
        }

        $Handling = $orderHeader->Handling;
        $HeaderTaxPercent = $orderHeader->TaxPercent;

        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $orderHeader->Freight;
        $TaxFreight = $orderHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE OrderHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $orderHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber ."'");
    }

    public function recalcOrderDetail($currencyPrecision, $allowanceDiscountPerc, $orderDetail) {
        $DiscountPerc = $orderDetail->DiscountPerc + $allowanceDiscountPerc;
        $Qty = $orderDetail->OrderQty;
        $Taxable = $orderDetail->Taxable;
        $TaxPercent = $orderDetail->TaxPercent ? $orderDetail->TaxPercent : 0;
        $ItemUnitPrice = $orderDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating OrderDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function recalcOrder($user, $orderNumber) {
        $result = DB::select("SELECT * from OrderHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());

        $orderHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($orderHeader->CurrencyID);

        $orderDetails = DB::select("SELECT * from OrderDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());
        foreach($orderDetails as $orderDetail) {
            $detailResult = $this->recalcOrderDetail($Precision, $orderHeader->AllowanceDiscountPerc, $orderDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE OrderDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderLineNumber='" . $orderDetail->OrderLineNumber ."'");
        }

        $Handling = $orderHeader->Handling;
        $HeaderTaxPercent = $orderHeader->TaxPercent;

        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $orderHeader->Freight;
        $TaxFreight = $orderHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE OrderHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $orderHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber ."'");
    }

    public function recalcPurchaseDetail($currencyPrecision, $purchaseDetail) {
        $DiscountPerc = $purchaseDetail->DiscountPerc;
        $Qty = $purchaseDetail->OrderQty;
        $Taxable = $purchaseDetail->Taxable;
        $TaxPercent = $purchaseDetail->TaxPercent ? $purchaseDetail->TaxPercent : 0;
        $ItemUnitPrice = $purchaseDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating PurchaseDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function purchaseRecalc(){
        $user = Session::get("user");

        $purchaseNumber = $_POST["PurchaseNumber"];

        $result = DB::select("SELECT * from PurchaseHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        $purchaseHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($purchaseHeader->CurrencyID);

        $purchaseDetails = DB::select("SELECT * from PurchaseDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        foreach($purchaseDetails as $purchaseDetail) {
            $detailResult = $this->recalcPurchaseDetail($Precision, $purchaseDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE PurchaseDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE PurchaseLineNumber='" . $purchaseDetail->PurchaseLineNumber ."'");
        }


        $Handling = $purchaseHeader->Handling;
        $HeaderTaxPercent = $purchaseHeader->TaxPercent;


        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $purchaseHeader->Freight;
        $TaxFreight = $purchaseHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE PurchaseHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $purchaseHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE PurchaseNumber='" . $purchaseNumber ."'");
    }

    public function recalcPurchaseContractDetail($currencyPrecision, $purchaseContractDetail) {
        $DiscountPerc = $purchaseContractDetail->DiscountPerc;
        $Qty = $purchaseContractDetail->OrderQty;
        $Taxable = $purchaseContractDetail->Taxable;
        $TaxPercent = $purchaseContractDetail->TaxPercent ? $purchaseContractDetail->TaxPercent : 0;
        $ItemUnitPrice = $purchaseContractDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating PurchaseContractDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function recalcPurchaseContract(){
        $user = Session::get("user");

        $purchaseContractNumber = $_POST["PurchaseContractNumber"];

        $result = DB::select("SELECT * from PurchaseContractHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseContractNumber='" . $purchaseContractNumber . "'", array());

        $purchaseContractHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($purchaseContractHeader->CurrencyID);

        $purchaseContractDetails = DB::select("SELECT * from PurchaseContractDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseContractNumber='" . $purchaseContractNumber . "'", array());

        foreach($purchaseContractDetails as $purchaseContractDetail) {
            $detailResult = $this->recalcPurchaseContractDetail($Precision, $purchaseContractDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE PurchaseContractDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE PurchaseContractLineNumber='" . $purchaseContractDetail->PurchaseContractLineNumber ."'");
        }


        $Handling = $purchaseContractHeader->Handling;
        $HeaderTaxPercent = $purchaseContractHeader->TaxPercent;


        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $purchaseContractHeader->Freight;
        $TaxFreight = $purchaseContractHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE PurchaseContractHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $purchaseContractHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE PurchaseContractNumber='" . $purchaseContractNumber ."'");
    }

    public function invoiceDetailRecalc($header, $Precision, $detail, $HItemTotalTaxable, $HItemDicountAmount, $HAllowanceDiscountPercent){
        if($HAllowanceDiscountPercent < 0)
            $AllowanceDiscountPercent = $header->AllowanceDiscountPercent;
        else
            $AllowanceDiscountPercent = 0;
        $DiscountPerc = $detail->DiscountPerc + $AllowanceDiscountPercent;
        $Qty = $detail->OrderQty;
        $Taxable = $detail->Taxable;
        $TaxPercent = $detail->TaxPercent ? $detail->TaxPercent : 0;
        $ItemUnitPrice = $detail->ItemUnitPrice;
        $ItemSubtotal = round($Qty * $ItemUnitPrice, $Precision);
        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $Precision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $Precision);

        $ItemTaxAmount = 0;
        $ItemTotalTaxable = 0;
        if($Taxable){
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $Precision);
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        }

        return [
            "ItemDiscountAmount" => $ItemDiscountAmount,
            "ItemTotalTaxable" => $ItemTotalTaxable,
                
            "ItemTaxAmount" => $ItemTaxAmount,
            "ItemTotal" => $ItemTotal,
            "ItemSubTotal" => $ItemSubtotal,
                
            "HeaderTotalTaxable" => 1,
        ];
    }
    public function invoiceRecalc($user, $invoiceNumber){
        $result = DB::select("SELECT * from InvoiceHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());

        $invoiceHeader = $result[0];
        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;
        $AllowanceDiscountPercent = $invoiceHeader->AllowanceDiscountPerc;
        $Precision = $this->getPrecision($invoiceHeader->CurrencyID);
        $details = DB::select("SELECT * from InvoiceDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());
        foreach($details as $detail){
            $detailRecalcResult = $this->invoiceDetailRecalc($invoiceHeader, $Precision, $detail, $ItemTotalTaxable, $ItemDiscountAmount, $AllowanceDiscountPercent);
            $SubTotal += $detailRecalcResult["ItemSubTotal"];
            $Total += $detailRecalcResult["ItemTotal"];

            $TaxAmount += $detailRecalcResult["ItemTaxAmount"];
            $TotalTaxable += $detailRecalcResult["ItemTotalTaxable"];
            $DiscountAmount += $detailRecalcResult["ItemDiscountAmount"];
            
            DB::update("UPDATE InvoiceDetail set SubTotal='" . $detailRecalcResult["ItemSubTotal"] . "', TaxAmount='" . $detailRecalcResult["ItemTaxAmount"] . "', Total='" . $detailRecalcResult["ItemTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'" . " AND InvoiceLineNumber='" . $detail->InvoiceLineNumber ."'");
        }
        
        $Handling = $invoiceHeader->Handling;
        $HeaderTaxPercent = $invoiceHeader->TaxPercent;
        if($Handling)
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        
        $Freight = $invoiceHeader->Freight;
        $TaxFreight = $invoiceHeader->TaxFreight;

        if($Freight > 0 && $TaxFreight)
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        $Total += $Handling + $Freight + $HeaderTaxAmount;
                             
        
        DB::update("UPDATE InvoiceHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $invoiceHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'");
    }

    public function serviceInvoiceDetailRecalc($header, $Precision, $detail, $HItemTotalTaxable, $HItemDicountAmount, $HAllowanceDiscountPercent){
        if($HAllowanceDiscountPercent < 0)
            $AllowanceDiscountPercent = $header->AllowanceDiscountPercent;
        else
            $AllowanceDiscountPercent = 0;
        $DiscountPerc = $detail->DiscountPerc + $AllowanceDiscountPercent;
        $Qty = $detail->OrderQty;
        $Taxable = $detail->Taxable;
        $TaxPercent = $detail->TaxPercent ? $detail->TaxPercent : 0;
        $ItemUnitPrice = $detail->ItemUnitPrice;
        $ItemSubtotal = round($Qty * $ItemUnitPrice, $Precision);
        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $Precision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $Precision);

        $ItemTaxAmount = 0;
        $ItemTotalTaxable = 0;
        if($Taxable){
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $Precision);
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        }

        return [
            "ItemDiscountAmount" => $ItemDiscountAmount,
            "ItemTotalTaxable" => $ItemTotalTaxable,
                
            "ItemTaxAmount" => $ItemTaxAmount,
            "ItemTotal" => $ItemTotal,
            "ItemSubTotal" => $ItemSubtotal,
        ];
    }
    public function serviceInvoiceRecalc($user, $invoiceNumber){
        $result = DB::select("SELECT * from InvoiceHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());

        $invoiceHeader = $result[0];
        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;
        $AllowanceDiscountPercent = $invoiceHeader->AllowanceDiscountPerc;
        $Precision = $this->getPrecision($invoiceHeader->CurrencyID);
        $details = DB::select("SELECT * from InvoiceDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());
        foreach($details as $detail){
            $detailRecalcResult = $this->serviceInvoiceDetailRecalc($invoiceHeader, $Precision, $detail, $ItemTotalTaxable, $ItemDiscountAmount, $AllowanceDiscountPercent);
            $SubTotal += $detailRecalcResult["ItemSubTotal"];
            $Total += $detailRecalcResult["ItemTotal"];

            $TaxAmount += $detailRecalcResult["ItemTaxAmount"];
            $TotalTaxable += $detailRecalcResult["ItemTotalTaxable"];
            $DiscountAmount += $detailRecalcResult["ItemDiscountAmount"];
            
            DB::update("UPDATE InvoiceDetail set SubTotal='" . $detailRecalcResult["ItemSubTotal"] . "', TaxAmount='" . $detailRecalcResult["ItemTaxAmount"] . "', Total='" . $detailRecalcResult["ItemTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'" . " AND InvoiceLineNumber='" . $detail->InvoiceLineNumber ."'");
        }
        
        $Handling = $invoiceHeader->Handling;
        $HeaderTaxPercent = $invoiceHeader->TaxPercent;
        if($Handling)
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        
        $Freight = $invoiceHeader->Freight;
        $TaxFreight = $invoiceHeader->TaxFreight;

        if($Freight > 0 && $TaxFreight)
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        $Total += $Handling + $Freight + $HeaderTaxAmount;
                             
        
        DB::update("UPDATE InvoiceHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $invoiceHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'");
    }

    public function debitMemoRecalc($user, $purchaseNumber) {
        $result = DB::select("SELECT * from PurchaseHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        $purchaseHeader = $result[0];

        $Total = 0;

        $Precision = $this->getPrecision($purchaseHeader->CurrencyID);

        $purchaseDetails = DB::select("SELECT * from PurchaseDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());
        foreach($purchaseDetails as $purchaseDetail) {
            $Total += $purchaseDetail->Total;

            DB::update("UPDATE PurchaseDetail set SubTotal='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseLineNumber='" . $purchaseDetail->PurchaseLineNumber ."'");
        }

        DB::update("UPDATE PurchaseHeader set SubTotal='" . $Total . "', DiscountAmount='0', TaxableSubTotal='" . $Total . "', BalanceDue='" . round($Total - $purchaseHeader->AmountPaid, $Precision) ."', TaxAmount='0', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber ."'");
    }

    public function creditMemoRecalc($user, $invoiceNumber){
        $result = DB::select("SELECT * from InvoiceHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());

        $invoiceHeader = $result[0];
        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;
        $AllowanceDiscountPercent = $invoiceHeader->AllowanceDiscountPerc;
        $Precision = $this->getPrecision($invoiceHeader->CurrencyID);
        $details = DB::select("SELECT * from InvoiceDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND InvoiceNumber='" . $invoiceNumber . "'", array());
        foreach($details as $detail){
            $Total += $detail->Total;

            DB::update("UPDATE InvoiceDetail set SubTotal='" . $detail->Total . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'" . " AND InvoiceLineNumber='" . $detail->InvoiceLineNumber ."'");
        }
        
        DB::update("UPDATE InvoiceHeader set SubTotal='" . $Total . "', DiscountAmount='0', TaxableSubTotal='0', BalanceDue='" . round($Total - $invoiceHeader->AmountPaid, $Precision) ."', TaxAmount='0', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND InvoiceNumber='" . $invoiceNumber ."'");
    }

    public function recalcInventoryWorkOrderDetail($detail){
        $Precision = 2;
        $BOMUnitPrice = $detail->WorkOrderBOMUnitCost;
        $OtherCost = $detail->WorkOrderBOMOtherCost;
        $LaborCost = $detail->WorkOrderBOMUnitLabor;
        $BOMQty = $detail->WorkOrderBOMQuantity;

        return round($BOMQty * ($BOMUnitPrice + $OtherCost + $LaborCost), $Precision);
    }

    public function recalcInventoryWorkOrder($user, $WorkOrderNumber){
        $result = DB::select("SELECT * from WorkOrderHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND WorkOrderNumber='" . $WorkOrderNumber . "'", array());
 
        $TotalHeader = 0;
        $details = DB::select("SELECT * from WorkOrderDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND WorkOrderNumber='" . $WorkOrderNumber . "'", array());
        foreach($details as $detail){
            $Total = $this->recalcInventoryWorkOrderDetail($detail);
            $TotalHeader += $Total;
            DB::update("UPDATE WorkOrderDetail set WorkOrderTotalCost='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND WorkOrderNumber='" . $WorkOrderNumber ."'" . " AND WorkOrderLineNumber='" . $detail->WorkOrderLineNumber ."'");
        }

        DB::update("UPDATE WorkOrderHeader set WorkOrderTotalCost='" . $TotalHeader . "' WHERE CompanyID='" . $user["CompanyID"] ."'" . " AND DivisionID='" . $user["DivisionID"] ."'" . " AND DepartmentID='" . $user["DepartmentID"] ."'" . " AND WorkOrderNumber='" . $WorkOrderNumber ."'");
    }
}