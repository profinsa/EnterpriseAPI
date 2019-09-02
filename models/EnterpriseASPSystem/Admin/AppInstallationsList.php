<?php
/*
  Name of Page: AppInstallations

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 30/08/2019 NikitaZaharov

  Use: this model used by gridView for:
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
  used as model by 

  Calls:
  MySql Database

  Last Modified: 02/09/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "AppInstallations";
    public $dashboardTitle ="App Installations";
    public $breadCrumbTitle ="App Installations";
    public $idField ="CustomerID";
    public $idFields = ["CustomerID"];
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SoftwareID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "InstallationName" => [
            "dbType" => "varchar(100)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ExpirationDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "Active" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "LoggedIn" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "defaultValue" => ""
            ],
            "SoftwareID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ConfigName" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InstallationName" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InstallationDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ExpirationDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Active" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Clean" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "LoggedIn" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "SoftwareID" => "Software ID",
        "ConfigName" => "Config Name",
        "InstallationName" => "Installation Name",
        "InstallationDate" => "Installation Date",
        "ExpirationDate" => "Expiration Date",
        "Active" => "Active",
        "Clean" => "Clean",
        "LoggedIn" => "Logged In"
    ];

    public function createInstallation(){
        $result = DB::SELECT("select * from appinstallations WHERE Clean=1");
        if(!count($result)); //need to clone new database from cleanenterprise;
        $installation = $result[0];
        DB::UPDATE("update appinstallations set Clean=0 WHERE ConfigName=?", [$installation->ConfigName]);
        $title = "Integral Accounting Test";
        $dbname = $installation->ConfigName;
        $dbuser = "enterprise";
        $dbpassword = "enterprise";
        $config = <<<EOF
<?php
function config(){
    return array(
        "theme" => 'none',
        //"theme" => 'dark', uncomment for dark theme
        "title" => '$title',
        "loginForm" => "login",
        "db_host" => "localhost",
        "db_user" => "$dbuser",
        "db_password" => "$dbpassword",
        "db_base" => "$dbname",
        "loginLogo" => "assets/images/stfb-logo.gif",
        "mediumLogo" => "assets/images/stfb-logo.gif",
        "smallLogo" => "assets/images/stfblogosm.jpg",
        "timeoutMinutes" => 10,
        "warningMinutes" => 2,
        "timeoutWarning" => "Your session will end in 2 minutes!",
        "user" => [
            "CompanyID" => "DINOS",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
        ],
        "supportInsertUser" => [
            "CompanyID" => "DINOS",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT"
        ]
    );
}

function defaultUser(){
    return [
        "Company" => "DINOS",
        "Division" => "DEFAULT",
        "Department" => "DEFAULT",
        "Username" => "Demo",
        "Password" => "Demo",
        "Language" => "English"
    ];
}

function isDebug(){
    return true;
}
?>
EOF;
        file_put_contents(__DIR__ . "/../../../" . $installation->ConfigName . ".php", $config);
        echo $config;
    }
}
?>
