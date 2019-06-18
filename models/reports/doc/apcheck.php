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
    public $tableName = "paymentsheader";
    public $keyField = "PaymentID";
    protected $id = ""; //invoice number
    public $headTableOne = [
        "NO." => "CheckNumber",
        "Date" => "CheckDate",
        "$" => "CheckAmount"
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

        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RPTCheckByPayment('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}',  '{$user["EmployeeID"]}', '{$this->id}', @ret)");
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

        /*        //echo json_encode($result);
        
        //        return $result;
        $result = DB::select("SELECT * from paymentsheader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PaymentID='" . $this->id . "'", array());

        $result = $result[0];
        $result->CheckDate = formatDatetime($result->CheckDate);
        $result->PaymentDate = formatDatetime($result->PaymentDate);
        $result->DueToDate = formatDatetime($result->DueToDate);
        $result->Amount =  formatCurrency($result->Amount);
        */
        //        echo json_encode($result);
        return $result[0];
    }

    public function getDetailData(){
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

    public function getBankAccount($BankAccountNumber) {
        $user = Session::get("user");

        $result = DB::select("SELECT * from bankaccounts WHERE BankAccountNumber='" . $BankAccountNumber . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        // echo json_encode($result), $BankAccountNumber;

        return $result[0];
    }

    public function getBankBalance($BankAccountNumber) {
        $user = Session::get("user");

        $result = DB::select("SELECT * from bankreconciliationsummary WHERE BankAccountNumber='" . $BankAccountNumber . "' AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        return formatCurrency($result[0]->BankRecEndingBalance);
    }

    public function getVendorAddress($vendorID){
        $user = Session::get("user");
 
        $result = DB::select("SELECT VendorID,VendorAddress1,VendorAddress2 ,VendorAddress3 ,VendorCity ,VendorState ,VendorZip ,VendorCountry from vendorinformation WHERE VendorName='" . $vendorID . "' AND CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        return $result[0];
    }

}
?>
