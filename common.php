<?php
function config(){
    return array(
        "theme" => 'none',
        //"theme" => 'dark',
        "title" => 'Integral Accounting X',
        "db_host" => "localhost",
        "db_user" => "enterprise",
        "db_password" => "enterprise",
        "db_base" => "myenterprise",
        "loginLogo" => "assets/images/stfb-logo.gif"
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
    return false;
}
?>
