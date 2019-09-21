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
        "db_base" => "enterprise",
        "loginLogo" => "assets/images/stfb-logo.gif",
        "mediumLogo" => "assets/images/stfb-logo.gif",
        "smallLogo" => "assets/images/stfblogosm.jpg",
        "timeoutMinutes" => 10,
        "warningMinutes" => 2,
        "timeoutWarning" => "Your session will end in 2 minutes!",
        "user" => [
            "CompanyID" => "STFB",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
        ],
        "mailServer" => "box789.bluehost.com",
        "mailUsername" => "support@stfb.com",
        "mailUserpass" => "STFB!xticket1024",
        "mailFrom" => "support@stfb.com",
        "mailFromTitle" => "Support"
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
