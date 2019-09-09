<?php
function config(){
    return array(
        "theme" => 'none',
        //"theme" => 'dark', uncomment for dark theme
        "title" => 'Enterprise X Admin',
        "software" => "Admin",
        "loginForm" => "login",
        "db_host" => "localhost",
        "db_user" => "enterprise",
        "db_password" => "enterprise",
        "db_base" => "enterpriseadmin",
        "loginLogo" => "assets/images/stfb-logo.gif",
        "mediumLogo" => "assets/images/stfb-logo.gif",
        "smallLogo" => "assets/images/stfblogosm.jpg",
        "timeoutMinutes" => 10,
        "warningMinutes" => 2,
        "timeoutWarning" => "Your session will end in 2 minutes!",
        "defaultDashboard" => "Admin",
        "user" => [
            "CompanyID" => "DINOS",
            "DivisionID" => "DEFAULT",
            "DepartmentID" => "DEFAULT",
            "language" => "english"
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
