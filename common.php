<?php
function config(){
    return array(
        "theme" => 'none', //name of theme, we can create theme with other styles
        //"theme" => 'dark', uncomment for dark theme
        "title" => 'Integral Accounting X', // name of Software
        "loginForm" => "login", // default login form, can be login(full version) and simplelogin(for short version without Company, Division and Department
        "db_type" => "sqlsrv", //type of database. mssql
        "db_host" => "23.254.215.125", //host of mssql database
        "db_user" => "sa", //user of mssql database
        "db_password" => "fq6sappTf6fBKh", //password of mssql database user
        "db_base" => "Enterprise", //name of mssql database*/
        /*        "db_type" => "sqlsrv", //type of database. mssql
        "db_host" => "localhost", //host of mssql database
        "db_user" => "enterprise", //user of mssql database
        "db_password" => "enterprise", //password of mssql database user
        "db_base" => "Enterprise", //name of mssql database*/
        /*        "db_type" => "mysql", //type of database, mysql
        "db_host" => "localhost", //host of mysql database
        "db_user" => "enterprise", //user of mysql database
        "db_password" => "enterprise", //password of mysql database user
        "db_base" => "enterprise", //name of mysql database*/
        "loginLogo" => "assets/images/stfb-logo.gif",
        "mediumLogo" => "assets/images/stfb-logo.gif",
        "smallLogo" => "assets/images/stfblogosm.jpg",
        "hideDeniedFeatures" => false,
        "timeoutMinutes" => 144000, //time to wait before automatic session expired
        "warningMinutes" => 2, //time to wait for warning message, after that session is expired
        "timeoutWarning" => "Your session will end in 2 minutes!", //text of expiration message
        "editCategoriesWidth" => [ //how many space left and right blocks takes in Detail mode. Left+Right must be 12
            "left" => 4,
            "right" => 8
        ],
        "user" => [
            "CompanyID" => "DINOS", //production, for help module
            //"CompanyID" => "DINOS",
            
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
        ],
        "publicAccess" => [
            "CompanyID" => "DINOS", //production, for help module
            //"CompanyID" => "DINOS",            
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
        ],
        "supportProducts" => [
            "Enterprise X",
            "Enterprise X Cart",
            "Enterprise Cloud",
        ],
        "supportLink" => "https://stfb.net/EnterpriseX/index.php?config=STFBEnterprise", //link to support system, it uses for links to Help from menu and topbar
        "supportInsertUser" => [ //user credentials for inserting Help Request tickets as they are in STFBEnterprise config
            "CompanyID" => "DINOS",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT"
        ],
        //mail server address, credentials and from Title
        "mailServer" => "stfb.com",
        //"mailServer" => "box789.bluehost.com",
        "mailUsername" => "support@stfb.com",
        "mailUserpass" => "STFB!xticket1024",
        "mailFrom" => "support@stfb.com",
        "mailFromTitle" => "Support",
        "mailSales" => "sales@stfb.com",
        //"confirmationHost" => "http://192.168.56.107", //development
        "confirmationHost" => "https://stfb.net" //production
    );
}

function defaultUser(){
    return [ //default user for ByPassLogin
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
