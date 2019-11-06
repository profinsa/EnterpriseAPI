<?php
function config(){
    return array(
        "theme" => 'none',
        //"theme" => 'dark', uncomment for dark theme
        "title" => 'Integral Accounting X Help System',
        "loginForm" => "login",
        "db_host" => "localhost",
        "db_user" => "enterprise",
        "db_password" => "enterprise",
        "db_base" => "stfbenterprise",
        "loginLogo" => "assets/images/stfb-logo.gif",
        "mediumLogo" => "assets/images/stfb-logo.gif",
        "smallLogo" => "assets/images/stfblogosm.jpg",
        "timeoutMinutes" => 10,
        "warningMinutes" => 2,
        "timeoutWarning" => "Your session will end in 2 minutes!",
        "editCategoriesWidth" => [ //how many space left and right blocks takes in Detail mode. Left+Right must be 12
            "left" => 4,
            "right" => 8
        ],
        "user" => [
            "CompanyID" => "STFB",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
        ],
        "supportProducts" => [
            "Enterprise X",
            "Enterprise Cloud"
        ],
        "supportLink" => "https://stfb.net/EnterpriseX/index.php?config=STFBEnterprise", //link to support system, it uses for links to Help from menu and topbar
        "supportInsertUser" => [ //user credentials for inserting Help Request tickets as they are in STFBEnterprise config
            "CompanyID" => "DINOS",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT"
        ],
        "mailServer" => "box789.bluehost.com",
        "mailUsername" => "support@stfb.com",
        "mailUserpass" => "STFB!xticket1024",
        "mailFrom" => "support@stfb.com",
        "mailFromTitle" => "Support",
        "mailSales" => "sales@stfb.com",
        //"confirmationHost" => "http://192.168.56.107", //development
        "confirmationHost" => "https://stfb.net" production
    );
}

function defaultUser(){
    return [
        "Company" => "STFB",
        "Division" => "DEFAULT",
        "Department" => "DEFAULT",
        "Username" => "Demo",
        "Password" => "DemoDemo",
        "Language" => "English"
    ];
}

function isDebug(){
    return true;
}
?>
