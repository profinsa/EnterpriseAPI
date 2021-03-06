<?php
/*
  Name of Page: DebitMemoHeaderApplyToPayments model
   
  Method: Model for gridView It provides data from database and default values, column names and categories
   
  Date created: 13/05/2019 Nikita Zaharov
   
  Use: this model used by views/DebitMemoHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers
  used as model by views/gridView.php
   
  Calls:
  MySql Database
   
  Last Modified: 14/05/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class DebitMemoHeaderApplyToPaymentsList extends gridDataSource{
    public $tableName = "paymentsheader";
    public $dashboardTitle ="Payments For Debit Memo";
    public $breadCrumbTitle ="Payments For Debit Memo";
    public $idField ="PaymentID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID"];
    public $modes = ["grid"];
    public $features = ["selecting"];
    public $gridFields = [
        "PaymentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "PaymentTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CheckNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "PaymentDate" => [
            "dbType" => "timestamp",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "AvailableAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text",
        ],
        "AmountToApply" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text",
            "editable" => true
        ]
    ];

	public $columnNames = [
        "PaymentID" => "Payment ID",
        "PaymentTypeID" => "Payment Type ID",
        "PaymentDate" => "Payment Date",
        "VendorID" => "Vendor ID",
        "CurrencyID" => "Currency ID",
        "AvailableAmount" => "Available Amount",
        "AmountToApply" => "Amount To Apply",
        "CheckNumber" => "Check Number",
        "CheckDate" => "Check Date",
        "InvoiceNumber" => "Invoice Number"
	];


    public function Post(){
        $user = Session::get("user");

         DB::statement("CALL DebitMemo_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PurchaseNumber"] . "',@Succes, @PostingResult,@SWP_RET_VALUE)");

         $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
             http_response_code(400);
             echo $result[0]->PostingResult;
         } else
            echo "ok";
    }

    //getting rows for grid
    public function getPage($VendorID){
        $user = Session::get("user");
        $query = <<<EOF
			SELECT CompanyID, DivisionID, DepartmentID,
			PaymentID, PaymentTypeID, CheckNumber, VendorID,
			InvoiceNumber, PaymentDate, CurrencyID,
			Amount AS AvailableAmount,
			0 AS AmountToApply
			FROM PaymentsHeader AS DebitMemoHeaderApplyToPayment
			WHERE
			(CompanyID = '{$user["CompanyID"]}' AND
			DivisionID = '{$user["DivisionID"]}' AND
			DepartmentID = '{$user["DepartmentID"]}' AND
			VendorID = '$VendorID' AND
			(IFNULL(DebitMemoHeaderApplyToPayment.Posted, 0) = 1) AND
			(IFNULL(DebitMemoHeaderApplyToPayment.Paid, 0) = 0) AND
			(DebitMemoHeaderApplyToPayment.CreditAmount IS NULL OR DebitMemoHeaderApplyToPayment.CreditAmount > 0) AND
			(IFNULL(DebitMemoHeaderApplyToPayment.ApprovedForPayment, 0) = 1) AND
			(IFNULL(DebitMemoHeaderApplyToPayment.CheckNumber, N'') = N''))
EOF;
        
        $result = DB::select($query, array());
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function ApplyToPayment(){
        $user = Session::get("user");
        $postData = file_get_contents("php://input");
        
        // `application/x-www-form-urlencoded`  `multipart/form-data`
        $data = parse_str($postData);
        // or
        // `application/json`
        $data = json_decode($postData, true);
        $success = true;
        //        print_r($data);
        // return;
        foreach($data as $row){
            //           print_r($row);
            DB::statement("CALL DebitMemo_ApplyToPayment(?, ?, ?, ?, ?, ?,  @Result, @SWP_RET_VALUE)", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["PurchaseNumber"], $row["PaymentID"], $row["AmountToApply"]));
        
            $result = DB::select('select @Result as Result, @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == 0){
                $success = false;
                echo $result[0]->SWP_RET_VALUE;
            }
        }
        
        echo "ok";        
    }
}

class DebitMemoHeaderApplyToPaymentsList extends DebitMemoHeaderApplyToPaymentsList {}
?>