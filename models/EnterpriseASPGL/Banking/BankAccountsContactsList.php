<?php
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "bankaccountscontacts";
    public $dashboardTitle ="BankAccountsContacts";
    public $breadCrumbTitle ="BankAccountsContacts";
    public $idField ="BankID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID","ContactID"];
    public $gridFields = [
        "BankID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ContactID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ContactTypeID" => [
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
        ],
        "ContactEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ContactID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ContactTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getContactTypes"
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
            "ContactPasswordExpiresDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ContactPasswordExpires" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ContactRegion" => [
                "dbType" => "varchar(50)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getContactRegions"
            ],
            "ContactNotes" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "BankID" => "Bank ID",
        "ContactID" => "Contact ID",
        "ContactTypeID" => "Contact Type ID",
        "ContactLastName" => "Last Name",
        "ContactFirstName" => "First Name",
        "ContactPhone" => "Phone",
        "ContactEmail" => "Email",
        "ContactDescription" => "Description",
        "ContactAddress1" => "Address 1",
        "ContactAddress2" => "Address 2",
        "ContactAddress3" => "Address 3",
        "ContactCity" => "City",
        "ContactState" => "State",
        "ContactZip" => "Zip",
        "ContactFax" => "Fax",
        "ContactCellular" => "Cellular",
        "ContactPager" => "Pager",
        "ContactWebPage" => "Web Page",
        "ContactLogin" => "Login",
        "ContactPassword" => "Password",
        "ContactPasswordOld" => "Password Old",
        "ContactPasswordDate" => "Password Date",
        "ContactPasswordExpires" => "Password Expires",
        "ContactPasswordExpiresDate" => "Password Expires Date",
        "ContactRegion" => "Region",
        "ContactNotes" => "Notes"
    ];
}
?>
