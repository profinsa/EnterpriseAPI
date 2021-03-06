<?php
/*
  Name of Page: Shipping Rate Helper

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

  Last Modified: 06/22/2017
  Last Modified by: Tetarenko Eugene
*/

class shippingInfo{
    public $CountryFrom = "";
    public $ZipFrom = "";
    public $CountryTo = "";
    public $ZipTo = "";
    public $Weight = 0;
    public $Amount = 0.0000;

    public function reset() {
        $CountryFrom = "";
        $ZipFrom = "";
        $CountryTo = "";
        $ZipTo = "";
        $Weight = 0;
        $Amount = 0.0000;
    }

    public function same($obj) {
        return ($this->$CountryFrom != "") && ($obj->$CountryFrom != "") && 
            ($this->$ZipFrom != "") && ($obj->$ZipFrom != "") &&
            ($this->$CountryTo != "") && ($obj->$CountryTo != "") &&
            ($this->$ZipTo != "") && ($obj->$ZipTo != "") && 
            ($this->$CountryFrom == $obj->$CountryFrom) && 
            ($this->$ZipFrom == $obj->$ZipFrom) &&
            ($this->$CountryTo == $obj->$CountryTo) &&
            ($this->$ZipTo == $obj->$ZipTo) &&
            ($this->$Weight == $obj->$Weight) &&
            ($this->$Amount == $obj->$Amount);
    }
}

class shippingRateData{
    public function __construct() {
        $this->$FedExShipInfo = new shippingInfo;
        $this->$UPSShipInfo = new shippingInfo; 
    }
    public $FedExShipInfo;
    public $UPSShipInfo;
    public $Rates = [];
    public $Errors = [];
    public $UPSError = "";
    public $FedExError = "";
    public $FedExMethods = [
        "FedEx First Overnight",
        "FedEx Priority Overnight",
        "FedEx Standard Overnight",
        "FedEx 2Day",
        "FedEx Express Saver",
        "FedEx Home Delivery",
        "FedEx Ground"
    ];
    public $UPSMethods = [
        "Next Day Air Early AM",
        "Next Day Air",
        "Next Day Air Saver",
        "2nd Day Air AM",
        "2nd Day Air",
        "3 Day Select",
        "Ground"
    ];
    
    private function readUrl($Url, $Cookie, $PostData, $IgnoreCookie) {
        $data = array('key1' => 'value1', 'key2' => 'value2');

        $options = [
            'http' => [
                'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
                'method'  => 'POST',
                'content' => http_build_query($PostData)
            ]
        ];

        if (($Cookie != "") && !$IgnoreCookie) {
            $options['http']['Set-Cookie'] = $Cookie;
        }

        $context  = stream_context_create($options);
        $result = file_get_contents($Url, false, $context);

        return $result;
    }

    // $CalcError
    // int
    public function GetRate($ShipInfo, $Method) {
        if (substr(strtoupper(trim($Method)), 0, 5) === "FEDEX") {
            if (!$this->$FedExShipInfo->same($ShipInfo)) {
                $CalcError = "";
                $this->$FedExError = "";
                echo "FedEx: need recalc";
                $this->$FedExCalcRates($ShipInfo);
                $this->FedExShipInfo = $ShipInfo;
                if ($this->$FedExError != "") {
                    $CalcError = "FedEx: " . $this->$FedExError;
                }
            }
        } else if (!$this->$UPSShipInfo->same($ShipInfo)) {
            $CalcError = "";
            $this->$UPSError = "";
            echo "UPS: need recalc";
            $this->UPSCalcRates($ShipInfo);
            $this->$UPSShipInfo = $ShipInfo;
            if ($this->$UPSError != "") {
                $CalcError = "UPS: " . $this->$UPSError;
            }
        }

        $Meth = strtoupper(trim($Method));
        $result = $this->Rates[$Meth];
        $err = "";

        if ($result == "") {
            echo "shippingrate: " . $Method . ": looking for near match";

            foreach ($this->$Rates as $key => $value) {
                $pos = strpos($Meth, strtoupper($key));

                if ($pos !== false) {
                    echo "shippingrate: match: " . $key;

                    $result = $this->$Rates[$key];
                    $err = (string)$this->$Errors[$key];
                }
            }
            
            if ($result == "") {
                echo "shippingrate: unknown method " . $Method;
                if (substr(strtoupper(trim($Method)), 0, 5) === "FEDEX") {
                    $this->$FedExShipInfo.reset();
                } else {
                    $this->$UPSShipInfo.reset();
                }

                if ($CalcError == "") {
                    $CalcError = "unknown method";
                }

                $result = 0;
            }
        } else {
            $err = (string)($this->$Errors($Meth));
        }

        if ($err != "") {
            $CalcError = $err;
        }

        return [
            "CalcError" => $CalcError,
            "result" => (int)$result 
        ];
    }

    private function UPSCalcRates($ShipInfo) {
        foreach($this->$UPSMethods as $method) {
            $this->$Rates[$method] = 0;
            $this->$Errors[$method] = "";
        }

        $methods = ["1DM", "1DA", "1DP", "2DM", "2DA", "3DS", "GND"];
        $methodPos = 0;

        while($methodPos < count($methods)) {
            $methodPos++;

            if ($this->$UPSCalcRateForMethod($ShipInfo, $methods[$methodPos], $this->$UPSMethods[$methodPos])) {
                echo "UPS: caught exception";
                $this->$UPSShipInfo.reset();
                $this->$UPSError = "query error";
                return false;
            }
        }

        return true;
    }

    private function UPSCalcRateForMethod($ShipInfo, $Code, $Method) {
        $DummyCookie = "";
        
        $result = $this->readUrl(
            "http://www.ups.com/using/services/rave/qcostcgi.cgi?accept_UPS_license_agreement=yes" .
            "&10_action=3&13_product=" . $Code .
            "&14_origCountry=" . $ShipInfo->$CountryFrom .
            "&15_origPostal=" . $ShipInfo->$ZipFrom .
            "&19_destPostal=" . $ShipInfo->$ZipTo .
            "&22_destCountry=" . $ShipInfo->$CountryTo .
            "&23_weight=" . $ShipInfo->$Weight . "49_residential=1",
            $DummyCookie
        );

        if (!$result) {
            echo "UPS: ReadUrl: error";
            $this->$Rates[$Method] = 0;
            $this->$Errors[$Method] = "query error";
            return;
        }

        echo "UPS: response: " . $result;

        $a = split("%", $result);

        switch (substr($a[0], -1)) {
            case "3":
                $v = $a[10];
                break;
            case "4":
                $v = $a[10];
                break;
            case "5":
                $this->Errors[$Method] = $a[1];
                $v = "0";
                break;
            case "6":
                $this->Errors[$Method] = $a[1];
                $v = "0";
                break;
            default:
                $this->Errors[$Method] = "query error";
                $v = "0";
        }

        echo "UPS: got value = " . $v;

        if ($v != "") {
            $this->$Rates[$Method] = (int)$v;

            if (!is_numeric($this->$Rates[$Method])) {
                $this->$Rates[$Method] = 0;
                echo "UPS: invalid numeric value";
                $this->$Errors[$Method] = "query error";
                return false;
            }
        } else {
            $this->$Rates[$Method] = 0;
            echo "UPS: blank price field";
            $this->$Errors[$Method] = "query error";
            return false;
        }
    }

    private function fedExCalcRates($ShipInfo) {
        foreach($this->$FedExMethods as $method) {
            $this->$Rates[$method] = 0;
            $this->$Errors[$method] = "";
        }

        $Cookie = "";
        $res1 = $this->fedExCalcRatesForMethods($ShipInfo, false, "Express", $Cookie, [
            "FedEx First Overnight",
            "FedEx Priority Overnight",
            "FedEx Standard Overnight",
            "FedEx 2Day",
            "FedEx Express Saver"
        ]);

        $res2 = $this->fedExCalcRatesForMethods($ShipInfo, true, "Ground", $Cookie, [
            "FedEx Home Delivery"
        ]);

        $res3 = $this->fedExCalcRatesForMethods($ShipInfo, false, "Ground", $Cookie, [
            "FedEx Ground"
        ]);

        if (!$res1 || !$res2 || !$res3) {
            $this->$FedExShipInfo.reset();
            $this->$FedExError = "query error";
        }
    }

    private function fedExCalcRatesForMethods($ShipInfo, $ToResidence, $ShipType, $Cookie, $methods) {
        $FinderUrl = "http://www.fedex.com/ratefinder/shipInfo";
        $queryTry = 0;
        $maxQueryTries = 3;
        $result = FALSE;
        $QueryError = "query error";

        while(($queryTry < $maxQueryTries) && !$result) {
            $queryTry++;
            try {
                $result = $this->readUrl(
                    $FinderUrl . "?cc=US&language=en&locId=&origCountry=" .
                    $ShipInfo->$CountryFrom . "&origZip=" .
                    $ShipInfo->$ZipFrom . "&destCountry=" .
                    $ShipInfo->$CountryTo . "&destZip=" .
                    $ShipInfo->$ZipTo . "shipToResidence=" .
                    strtolower($ToResidence) . "&companyType=" .
                    $ShipType. "&submitShipInfo=Continue",
                    $Cookie
                );
            } catch (Exception $e) {
                echo "Fedex error.";
                foreach($methods as $method) {
                    $this->$Rates[$method] = 0;
                    $this->$Errors[$method] = "query error";
                }
                return false;
            }
        }

        if (!$result) {
            $pos = strpos($result, "groundCOD");
            if ($pos === false) {
                echo "fedex: no cookie or fedex session expired";
            } else {
                echo "obtained 2nd form";
            }
        }

        if ($queryTry == 3) {
            echo "fedex: failed to begin session";
            //     FedExError = "query error"
        }

        $IsExpress = !$ToResidence && (ShipType == "Express");
        $IsGround = !$ToResidence && (ShipType == "Ground");

        $PostData = "cc=US&language=en&locId=&groundCOD=false&isExpress=" . strtolower($IsExpress)
            . "&isGround=" . strtolower($IsGround) .
            "&packageForm.packageList%5B0%5D.weight=" . $ShipInfo->$Weight .
            "&packageForm.packageList%5B0%5D.weightUnit=lbs" .
            "&packageForm.packageList%5B0%5D.packageType=1" .
            "&packageForm.packageList%5B0%5D.dimLength=0.1" .
            "&packageForm.packageList%5B0%5D.dimWidth=0.1" .
            "&packageForm.packageList%5B0%5D.dimHeight=0.1" .
            "&packageForm.packageList%5B0%5D.dimUnit=in" .
            "&packageForm.packageList%5B0%5D.declaredValue=" . (string)$ShipInfo->$Amount .
            "&optionsList%5B0%5D.optionCode=999&optionsList%5B1%5D.optionCode=4&" .
            "&optionsList%5B2%5D.optionCode=14&submitGetRates=Continue+%3E%3E";
                
        try {
            $result = $this->readUrl(
                $FinderUrl,
                $Cookie,
                $PostData
            );
        } catch (Exception $e) {
            echo "Fedex error.";
            foreach($methods as $method) {
                $this->$Rates[$method] = 0;
                $this->$Errors[$method] = "query error";
            }

            return false;
        }

        if (!$result) {
            $pos = strpos($result, "for packages exceeding");
            if ($pos === false) {
                echo "FedEx: overweight";

                foreach($methods as $method) {
                    $this->$Rates[$method] = 0;
                    $this->$Errors[$method] = "query error";
                }
                return false;
            }
        }

        foreach($methods as $method) {
            $this->$Errors[$method] = "";

            if (preg_match("/<TD[^>]*>.*?" . $method . ".*?>\s*(\d+|\d+\.\d+)\s*(&nbsp;)?\s*</s", $result, $matches)) {
                echo "fedex: " . $method . " -> " . $matches[0];
                $val = (int)$matches[0];

                if (is_numeric($val)) {
                    $this->$Rates[$method] = $val;
                } else {
                    echo "fedex: invalid numeric value";
                    $this->$Rates[$method] = 0;
                    $this->$Errors[$method] = "query error";
                }
            } else {
                echo "fedex: could not find method " . $method;
                $this->$Rates[$method] = 0;
                $this->$Errors[$method] = "query error";
                $this->$FedExShipInfo->reset();
            }
        }

        return true;
    }

}

class shippingRate{
    public function getRate(
            $CountryFrom,
            $ZipFrom,
            $CountryTo,
            $ZipTo,
            $Weight,
            $Amount,
            $ChargeHandling,
            $HandlingAsPercent,
            $HandlingRate,
            $Method
        ){
            $d = new shippingRateData;

            // Static d As ShippingRateData = Nothing
            // If d Is Nothing Then
            //     DebugPrint("shippingrate: creating new ShippingRateData")
            //     d = New ShippingRateData
            // Else
            //     DebugPrint("shippingrate: reusing ShippingRateData")
            // End If

            $ShipInfo = new shippingInfo;
            $ShipInfo->$CountryFrom = $CountryFrom;
            $ShipInfo->$ZipFrom = $ZipFrom;
            $ShipInfo->$CountryTo = $CountryTo;
            $ShipInfo->$ZipTo = $ZipTo;
            $ShipInfo->$Weight = $Weight;
            $ShipInfo->$Amount = $Amount;

            $sd = new shippingRateData;
            $sd = $d;

            $Price = $sd.GetRate($ShipInfo, $Method, $CalcError);

            if ($CalcError == "") {
                if ($ChargeHandling) {
                    if ($HandlingAsPercent) {
                        $Handling = $Amount * $HandlingRate / 100;
                    } else {
                        $Handling = $HandlingRate;
                    }

                    $Price += $Handling;
                } else {
                    $Handling = 0;
                }
            } else {
                $Price = 0;
                $Handling = 0;
            }

            return [
                "error" => $CalcError,
                "Shipping" => $Price,
                "Handling" => $Handling 
            ];
    }
}

