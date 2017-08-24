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
   
  Last Modified: 08/11/2017
  Last Modified by: Nikita Zaharov
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "leadinformation";
    public $dashboardTitle ="Lead Information";
    public $breadCrumbTitle ="Lead Information";
    public $idField ="LeadID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID"];
    public $gridFields = [
        "LeadID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "LeadLastName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "LeadFirstName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "LeadEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text"
        ],
        "LeadLogin" => [
            "dbType" => "varchar(60)",
            "inputType" => "text"
        ],
        "LeadPassword" => [
            "dbType" => "varchar(20)",
            "inputType" => "text"
        ],
        "Hot" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
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
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "LeadCompany" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
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
            "LeadWebPage" => [
                "dbType" => "varchar(80)",
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
            "LeadPasswordOld" => [
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
            ],
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
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadRegionID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadSourceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadIndustryID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
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
            "ReferedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ReferalURL" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastVisit" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "IPAddress" => [
                "dbType" => "varchar(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NumberOfVisits" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PrimaryInterest" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Confirmed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Validated" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OptInEmail" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Newsletter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OptInNewsletter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MessageBoard" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Portal" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Hot" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            ]
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
        ]
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
        "LeadCompany" => "Lead Company",
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
        "LeadMemo9" => "Lead Memo 9"
    ];
}?>
