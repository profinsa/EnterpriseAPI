<?php
/*
	Name of Page:
	Method:
	Date created:
	Use: 
	Output parameters:
	Called from:
	Calls:
	Last Modified: 10.06.2019
	Last Modified by: Zaharov Nikita
*/

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

function formatCurrency($money){
    $afterdot = 2;
    if(preg_match('/([-+\d]+)\.(\d+)/', $money, $numberParts))
        return numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
    return $money;
}

function formatDatetime($date){
    if($date != "")
        return date("m/d/y", strtotime($date));
    return $date;
}

require __DIR__ . "/docreportsbase.php";
class docReportsData extends docReportsBase{
    protected $id = ""; //invoice number
    public $headTableOne = [
        "NO." => "CheckNumber",
        "Date" => "DueToDate",
        "$" => "Amount"
    ];
    public $vendorAddress = [
        "Address 1" => "VendorAddress1",
        "Address 2" => "VendorAddress2",
        "Address 3" => "VendorAddress3",
        "City" => "VendorCity",
        "State" => "VendorState",
        "Zip" => "VendorZip",
        "Country" => "VendorCountry"
    ];

    public function __construct($id){
        $this->id = $id;
    }

    public function getHeaderData(){
        $user = Session::get("user");

        
        $payment = DB::select("SELECT * from paymentsheader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PaymentID='" . $this->id . "'", array())[0];

        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RPTCheck('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}',  '{$user["EmployeeID"]}', @ret)");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);

        if(!count($result))
            return false;
        
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL"){
                    $afterdot = 2;
                    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }

        echo json_encode($result);
        
        //        return $result;
        $result = DB::select("SELECT * from paymentsheader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PaymentID='" . $this->id . "'", array());

        $result = $result[0];
        $result->CheckDate = formatDatetime($result->CheckDate);
        $result->PaymentDate = formatDatetime($result->PaymentDate);
        $result->DueToDate = formatDatetime($result->DueToDate);
        $result->Amount =  formatCurrency($result->Amount);

        return $result;
    }

    public function getDetailData($vendorID){
        $user = Session::get("user");
        
        $payment = DB::select("SELECT * from paymentsheader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PaymentID='" . $this->id . "'", array())[0];

        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RPTCheckStub('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}',  '{$user["EmployeeID"]}', '{$payment->CheckNumber}', @ret)");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);

        if(!count($result))
            return false;
        
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL"){
                    $afterdot = 2;
                    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }
        
        return $result;
    }

    public function getBankAccount($GLBankAccount) {
        $user = Session::get("user");

        $result = DB::select("SELECT * from bankaccounts WHERE GLBankAccount='" . $GLBankAccount . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        // echo json_encode($result), $GLBankAccount;

        return $result[0];
    }

    public function getBankBalance($GLBankAccount) {
        $user = Session::get("user");

        $result = DB::select("SELECT * from bankreconciliationsummary WHERE GLBankAccount='" . $GLBankAccount . "' AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        return formatCurrency($result[0]->BankRecEndingBalance);
    }

    public function getVendorAddress($vendorID){
        $user = Session::get("user");
 
        $result = DB::select("SELECT VendorID,VendorAddress1,VendorAddress2 ,VendorAddress3 ,VendorCity ,VendorState ,VendorZip ,VendorCountry from vendorinformation WHERE VendorID='" . $vendorID . "' AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        return $result[0];
    }

}
?>
