<?php
/*
  Name of Page: Interfaces model

  Method: Interfaces model, used for describing all interfaces in system

  Date created: Nikita Zaharov, 19.09.2019

  Use: providing information about interfaces like: which dashboard should be used, which menu etc

  Input parameters:
  $db: database instance

  Output parameters:
  $users: model

  Called from:
  + most controllers most controllers from /controllers

  Calls:
  sql

  Last Modified: 20.09.2019
  Last Modified by: Nikita Zaharov
*/

class interfaces{
    public $description = [
        "simplebusiness" => [
            "title" => "Simple Business",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "simplebusinessrtl" => [
            "title" => "Simple Business RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],

        "simpleservice" => [
            "title" => "Simple Service",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "simpleservicertl" => [
            "title" => "Simple Service RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],
    
        "distribution" => [
            "title" => "Distribution",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "distributionrtl" => [
            "title" => "Distribution RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],
    
        "financial" => [
            "title" => "Financial",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "financialrtl" => [
            "title" => "Financial RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],
    
        "trustaccounting" => [
            "title" => "Trust Accounting",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "trustaccountingrtl" => [
            "title" => "Trust Accounting RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],
    
        "ngoaccounting" => [
            "title" => "NGO Accounting",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "ngoaccountingrtl" => [
            "title" => "NGO Accounting RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ],
    
        "saasadmin" => [
            "title" => "Saas Admin",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Admin.php"
        ],
        "saasadminrtl" => [
            "title" => "Saas Admin RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Admin.php"
        ],
    
        "default" => [
            "title" => "All Functions",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting.php"
        ],
        "defaultrtl" => [
            "title" => "All Functions RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting.php"
        ]
    ];
}
