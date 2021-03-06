<?php
/*
  Name of Page: CustomerContactsList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerContactsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactsList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CustomerContactsList extends gridDataSource{
    public $tableName = "customercontacts";
    public $dashboardTitle ="Customer Contacts";
    public $breadCrumbTitle ="Customer Contacts";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID"];
    public $gridFields = [

        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ContactID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ContactType" => [
            "dbType" => "varchar(36)",
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
        "ContactPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [

            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactLastName" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactFirstName" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactTitle" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactDepartment" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactSource" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactSalutation" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactIndustry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactAddress3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPhone2" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPhone3" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactCellular" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPager" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactWebPage" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactLogin" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPassword" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPasswordOld" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactPasswordDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ContactPasswordExpires" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ContactPasswordExpiresDate" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactRegion" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactNotes" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactCallingRestrictions" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]];
    public $columnNames = [

        "CustomerID" => "Customer ID",
        "ContactID" => "Contact ID",
        "ContactType" => "Contact Type",
        "ContactLastName" => "Contact Last Name",
        "ContactFirstName" => "Contact First Name",
        "ContactPhone" => "Contact Phone",
        "ContactDescription" => "Contact Description",
        "ContactTitle" => "Contact Title",
        "ContactDepartment" => "Contact Department",
        "ContactSource" => "Contact Source",
        "ContactSalutation" => "Contact Salutation",
        "ContactIndustry" => "Contact Industry",
        "ContactAddress1" => "Contact Address 1",
        "ContactAddress2" => "Contact Address 2",
        "ContactAddress3" => "Contact Address 3",
        "ContactCity" => "Contact City",
        "ContactState" => "Contact State",
        "ContactZip" => "Contact Zip",
        "ContactPhone2" => "Contact Phone 2",
        "ContactPhone3" => "Contact Phone 3",
        "ContactFax" => "Contact Fax",
        "ContactCellular" => "Contact Cellular",
        "ContactPager" => "Contact Pager",
        "ContactEmail" => "Contact Email",
        "ContactWebPage" => "Contact Web Page",
        "ContactLogin" => "Contact Login",
        "ContactPassword" => "Contact Password",
        "ContactPasswordOld" => "Contact Password Old",
        "ContactPasswordDate" => "Contact Password Date",
        "ContactPasswordExpires" => "Contact Password Expires",
        "ContactPasswordExpiresDate" => "Contact Password ExpiresDate",
        "ContactRegion" => "Contact Region",
        "ContactNotes" => "Contact Notes",
        "ContactCallingRestrictions" => "Contact Calling Restrictions"];
}
?>
