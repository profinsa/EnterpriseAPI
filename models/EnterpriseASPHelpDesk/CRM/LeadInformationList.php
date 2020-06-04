<?php
/*
  Name of Page: LeadInformationList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadInformationList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/LeadInformationList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadInformationList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadInformationList.php
   
  Calls:
  MySql Database
   
  Last Modified: 21/03/2020
  Last Modified by: Nikita Zaharov
*/
require "./models/gridDataSource.php";
class LeadInformationList extends gridDataSource{
    public $tableName = "leadinformation";
    public $dashboardTitle ="Lead Information";
    public $breadCrumbTitle ="Lead Information";
    public $idField ="LeadID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID"];
    public $gridFields = [
        "LeadID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "required" => "true",
        ],
        "Hot" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "LeadEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text"
        ],
        "LeadCompany" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "LeadLastName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "LeadFirstName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "Confirmed" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "LeadID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "required" => "true",
                "defaultValue" => ""
            ],
            "LeadLastName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadFirstName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadSalutation" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadCompany" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadAddress3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadZip" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadWebPage" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadRegionID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getContactRegions"
            ],
            "LeadSourceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getContactSourceIds"
            ],
            "LeadIndustryID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getContactIndustryIds"
            ],
            "LeadLogin" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadPassword" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            /*            "LeadPasswordOld" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadPasswordDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "LeadPasswordExpires" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "LeadPasswordExpiresDate" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
                ],*/
            "LeadSecurityGroup" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Attention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getPayrollEmployees"
            ],
            "LeadTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getLeadTypes"
            ],
            "Hot" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "FirstContacted" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "LastFollowUp" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Newsletter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MessageBoard" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "NextFollowUp" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ReferedByExistingCustomer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ReferedBy" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PrimaryInterest" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ConvertedToCustomer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ConvertedToCustomerBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ConvertedToCustomerDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getCurrencyTypes"
            ],
            "Confirmed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OptInEmail" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OptInNewsletter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            /*            "ReferedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
                ],*/
            "IPAddress" => [
                "dbType" => "varchar(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReferalURL" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UniqID" => [
                "dbType" => "varchar(50)",
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ]            
            /*,
            "LastVisit" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "NumberOfVisits" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Validated" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Portal" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
                ],*/
        ],
        "Memos" => [
            "LeadMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "LeadContacts" => [
            "LeadID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
        ],
        "LeadComments" => [
            "LeadID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
        ],
        "LeadSatisfaction" => [
            "LeadID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
        ]
    ];
    
    public $detailPages = [
        "LeadContacts" => [
            "hideFields" => "true",
            //"disableNew" => "true",
            "viewPath" => "CRMHelpDesk/CRM/ViewLeadContacts",
            "newKeyField" => "LeadID",
            "keyFields" => ["LeadID", "ContactID"],
            "detailIdFields" => ["CompanyID", "DivisionID", "DepartmentID", "LeadID", "ContactID"],
            "gridFields" => [
                "LeadID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text",
                    "disabledEdit" => "true"
                ],
                "ContactID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "disabledEdit" => "true"
                ],
                "LeadType" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "ContactDescription" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ],
                "ContactLastName" => [
                    "dbType" => "varchar(20)",
                    "inputType" => "text"
                ],
                "ContactFirstName" => [
                    "dbType" => "varchar(20)",
                    "inputType" => "text"
                ],
                "ContactTitle" => [
                    "dbType" => "varchar(20)",
                    "inputType" => "text"
                ],
                "ContactPhone" => [
                    "dbType" => "varchar(30)",
                    "inputType" => "text"
                ],
                "ContactEmail" => [
                    "dbType" => "varchar(60)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ]
            ]
        ],
        "LeadComments" => [
            "hideFields" => "true",
            //"disableNew" => "true",
            "viewPath" => "CRMHelpDesk/CRM/ViewLeadComments",
            "newKeyField" => "LeadID",
            "keyFields" => ["LeadID"],
            "detailIdFields" => ["CompanyID", "DivisionID", "DepartmentID", "CommentNumber"],
            "gridFields" => [
                "LeadID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ],
                "CommentNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "CommentDate" => [
                    "dbType" => "timestamp",
                    "format" => "{0:d}",
                    "inputType" => "datetime"
                ],
                "CommentType" => [
                    "dbType" => "varchar(15)",
                    "inputType" => "text"
                ],
                "Comment" => [
                    "dbType" => "varchar(255)",
                    "inputType" => "text"
                ]
            ]
        ],
        "LeadSatisfaction" => [
            "hideFields" => "true",
            //"disableNew" => "true",
            "viewPath" => "CRMHelpDesk/CRM/ViewLeadSatisfaction",
            "newKeyField" => "LeadID",
            "keyFields" => ["LeadID", "ItemID", "SurveyDate"],
            "detailIdFields" => ["CompanyID", "DivisionID", "DepartmentID", "LeadID", "ItemID", "SurveyDate"],
            "gridFields" => [
                "LeadID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ],
                "ItemID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "SurveyDate" => [
                    "dbType" => "datetime",
                    "format" => "{0:d}",
                    "inputType" => "datetime"
                ]
            ]
        ],
    ];

    public $columnNames = [
        "LeadID" => "Lead ID",
        "LeadLastName" => "Last Name",
        "LeadFirstName" => "First Name",
        "LeadEmail" => "Email",
        "LeadLogin" => "Login",
        "LeadPassword" => "Password",
        "Hot" => "Hot",
        "Confirmed" => "Confirmed",
        "LeadCompany" => "Company",
        "LeadSalutation" => "Lead Salutation",
        "LeadAddress1" => "Lead Address 1",
        "LeadAddress2" => "Lead Address 2",
        "LeadAddress3" => "Lead Address 3",
        "LeadCity" => "Lead City",
        "LeadState" => "Lead State",
        "LeadZip" => "Lead Zip",
        "LeadCountry" => "Lead Country",
        "LeadWebPage" => "Lead Web Page",
        "LeadPhone" => "Lead Phone",
        "LeadFax" => "Lead Fax",
        "LeadPasswordOld" => "Lead Password Old",
        "LeadPasswordDate" => "Lead Password Date",
        "LeadPasswordExpires" => "Lead Password Expires",
        "LeadPasswordExpiresDate" => "Lead Password Expires Date",
        "LeadSecurityGroup" => "Lead Security Group",
        "Attention" => "Attention",
        "EmployeeID" => "Employee ID",
        "CurrencyID" => "Currency ID",
        "LeadTypeID" => "LeadType ID",
        "LeadRegionID" => "Lead Region ID",
        "LeadSourceID" => "Lead Source ID",
        "LeadIndustryID" => "Lead Industry ID",
        "FirstContacted" => "First Contacted",
        "LastFollowUp" => "Last Follow Up",
        "NextFollowUp" => "Next Follow Up",
        "ReferedByExistingCustomer" => "Refered By Existing Customer",
        "ReferedBy" => "Refered By",
        "ReferedDate" => "Refered Date",
        "ReferalURL" => "Referal URL",
        "LastVisit" => "Last Visit",
        "IPAddress" => "IP Address",
        "NumberOfVisits" => "Number Of Visits",
        "PrimaryInterest" => "Primary Interest",
        "Validated" => "Validated",
        "OptInEmail" => "Opt In Email",
        "Newsletter" => "Newsletter",
        "OptInNewsletter" => "Opt In Newsletter",
        "MessageBoard" => "Message Board",
        "Portal" => "Portal",
        "ConvertedToCustomer" => "Converted To Customer",
        "ConvertedToCustomerBy" => "Converted To Customer By",
        "ConvertedToCustomerDate" => "Converted To Customer Date",
        "LeadMemo1" => "Lead Memo 1",
        "LeadMemo2" => "Lead Memo 2",
        "LeadMemo3" => "Lead Memo 3",
        "LeadMemo4" => "Lead Memo 4",
        "LeadMemo5" => "Lead Memo 5",
        "LeadMemo6" => "Lead Memo 6",
        "LeadMemo7" => "Lead Memo 7",
        "LeadMemo8" => "Lead Memo 8",
        "LeadMemo9" => "Lead Memo 9",
        "ContactID" => "Contact ID",
        "LeadType" => "Lead Type",
        "ContactDescription" => "Description",
        "ContactLastName" => "Last Name",
        "ContactFirstName" => "First Name",
        "ContactTitle" => "Title",
        "ContactPhone" => "Phone",
        "ContactEmail" => "Email",
        "CommentNumber" => "Comment Number",
        "CommentDate" => "Comment Date",
        "CommentType" => "Comment Type",
        "Comment" => "Comment",
        "ItemID" => "Item ID",
        "SurveyDate" => "Survey Date",
        "UniqID" => "Uniq ID"
    ];

    public function getPage($id){
        $user = Session::get("user");
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "newmonth"){
            $this->gridConditions = "FirstContacted >= NOW() - INTERVAL 30 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "newyear"){
            $this->gridConditions = "FirstContacted >= NOW() - INTERVAL 365 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "inactive"){
            $this->gridConditions = "LastVisit < NOW() - INTERVAL 100 DAY";
            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }

    //getting rows for Lead Contacts grid
    public function getLeadContacts($LeadID){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["LeadContacts"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["LeadContacts"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND LeadID='" . $LeadID . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from leadcontacts " . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    //getting rows for Lead Comments grid
    public function getLeadComments($LeadID){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["LeadComments"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["LeadComments"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND LeadID='" . $LeadID . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from leadcomments " . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting rows for Lead Satisfaction grid
    public function getLeadSatisfaction($LeadID){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["LeadSatisfaction"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["LeadSatisfaction"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND LeadID='" . $LeadID . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from leadsatisfaction " . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function Customer_CreateFromLead(){
        $user = Session::get("user");
        
        DB::statement("CALL Customer_CreateFromLead('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "','" . $_POST["LeadID"] . "',@PostingResult,@SWP_RET_VALUE)");

         $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
            echo "error";
         } else {
            echo "ok";
         }
    }

    public function insertLeadForViewDemo(){
        $user = Session::get("user");
        $config = config();

        if(count(DB::select("select LeadID from leadinformation WHERE LeadID=?", [$_POST["LeadID"]])) == 0){
            $leadInformation = [];
            foreach($this->editCategories as $key=>$value)
                $leadInformation = array_merge($leadInformation, $this->getNewItem($_POST["id"], $key));
            $leadInformation["LeadID"] = $_POST["LeadID"];
            $leadInformation["Hot"] = 1;
            $leadInformation["Confirmed"] = 0;
            $leadInformation["LeadEmail"] = $_POST["LeadEmail"];
            $leadInformation["LeadCompany"] = $_POST["LeadCompany"];
            $leadInformation["LeadFirstName"] = $_POST["LeadFirstName"];
            $leadInformation["LeadLastName"] = $_POST["LeadLastName"];
            $leadInformation["LeadPhone"] = $_POST["LeadPhone"];
            $leadInformation["LeadAddress1"] = $_POST["LeadAddress1"];
            $leadInformation["LeadMemo1"] = $_POST["LeadMemo1"];
            $leadInformation["LeadMemo2"] = $_POST["LeadMemo2"];
            $uid = $leadInformation["UniqID"] = uniqid();

            $item = $this->insertItemLocal($leadInformation);
            echo json_encode($leadInformation, JSON_PRETTY_PRINT);

            //session_write_close(); //close the session
            //fastcgi_finish_request(); //this returns 200 to the user, and processing continues
            $mailer = new mailer();
            $mailer->send([
                "subject" => "The confirmation message",
                "body" => "<html><body>To confirm your email please click <a href=\"{$config["confirmationHost"]}/EnterpriseX/index.php?config=STFBEnterprise&page=grid&action=CRMHelpDesk/CRM/ViewLeads&mode=view&category=Main&uid=$uid&procedure=confirm\">here</a></body></html>",
                "email" => $_POST["LeadEmail"]
            ]);
        }else{
            $this->updateItem($_POST["id"] . "__" . $_POST["LeadID"], "Main", $_POST);
        }
    }

    public function confirm(){
        DB::update("update leadinformation set Confirmed=1, OptInEmail = 1 WHERE UniqID=?", [$_GET["uid"]]);
        echo "Your Email is confirmed";
    }
}?>
