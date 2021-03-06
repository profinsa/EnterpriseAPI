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
        "simple" => [
            "title" => "Simple Business",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting"
        ],
        "simplertl" => [
            "title" => "Simple Business RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting"
        ],
        "simpleservice" => [
            "title" => "Simple Service",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting"
        ],
        "simpleservicertl" => [
            "title" => "Simple Service RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting"
        ],
    
        "distribution" => [
            "title" => "Distribution",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Distribution"
        ],
        "distributionrtl" => [
            "title" => "Distribution RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Distribution"
        ],
    
        "financial" => [
            "title" => "Financial",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Financial"
        ],
        "financialrtl" => [
            "title" => "Financial RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Financial"
        ],
    
        "trustaccounting" => [
            "title" => "Trust Accounting",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Trust"
        ],
        "trustaccountingrtl" => [
            "title" => "Trust Accounting RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Trust"
        ],
    
        "ngoaccounting" => [
            "title" => "NGO Accounting",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "NGO"
        ],
        "ngoaccountingrtl" => [
            "title" => "NGO Accounting RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "NGO"
        ],
    
        "saasadmin" => [
            "title" => "Saas Admin",
            "link" => "/EnterpriseX/index.php?page=ByPassLogin&config=Admin&interface=saasadmin",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Admin"
        ],
        "saasadminrtl" => [
            "title" => "Saas Admin RTL",
            "link" => "/EnterpriseX/index.php?page=ByPassLogin&config=Admin&interface=saasadminrtl",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Admin"
        ],    
        "nonprofit" => [
            "title" => "Non-Profit",
            "interface" => "simple",
            "interfaceType" => "ltr",
            "translationsRewrite" => [
                "/(Customer)/i" => "Donor",
                "/(Customer ID)/i" => "Donor ID",
                "/(CustomerID)/i" => "Donor ID",
                "/(Lead)/i" => "Potential Donor"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "nonprofitrtl" => [
            "title" => "Non-Profit RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
            "translationsRewrite" => [
                "/(Customer)/i" => "Donor",
                "/(Customer ID)/i" => "Donor ID",
                "/(CustomerID)/i" => "Donor ID",
                "/(Lead)/i" => "Potential Donor"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "farmingandranching" => [
            "title" => "Farming & Ranching",
            "interface" => "simple",
            "interfaceType" => "ltr",
             "translationsRewrite" => [
                 "/(Projects & Jobs)/" => "Fields & Animals",
                "/(Project ID)/i" => "Field or Animal ID",
                "/(Project)/i" => "Field or Animal"
            ],
           "defaultDashboard" => "Accounting"
        ],
        "farmingandranchingrtl" => [
            "title" => "Farming & Ranching RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
             "translationsRewrite" => [
                 "/(Projects & Jobs)/" => "Fields & Animals",
                "/(Project ID)/i" => "Field or Animal ID",
                "/(Project)/i" => "Field or Animal"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "fleetmanagement" => [
            "title" => "Fleet Management",
            "interface" => "simple",
            "interfaceType" => "ltr",
             "translationsRewrite" => [
                 "/(Projects & Jobs)/" => "Vehicles",
                "/(Project ID)/i" => "Vehicle ID",
                "/(Project)/i" => "Vehicle"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "fleetmanagementrtl" => [
            "title" => "Fleet Management RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
             "translationsRewrite" => [
                 "/(Projects & Jobs)/" => "Vehicles",
                "/(Project ID)/i" => "Vehicle ID",
                "/(Project)/i" => "Vehicle"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "propertymanagement" => [
            "title" => "Property Management",
            "interface" => "simple",
            "interfaceType" => "ltr",
             "translationsRewrite" => [
                 "/(Customer)/" => "Tenant",
                 "/(Lead)/" => "Prospective Tenant",
                 "/(Projects & Jobs)/" => "Properties",
                "/(Project ID)/i" => "Property ID",
                "/(Project)/i" => "Property"
            ],
            "defaultDashboard" => "Accounting"
        ],
        "propertymanagementrtl" => [
            "title" => "Property Management RTL",
            "interface" => "simple",
            "interfaceType" => "rtl",
             "translationsRewrite" => [
                 "/(Customer)/" => "Tenant",
                 "/(Lead)/" => "Prospective Tenant",
                 "/(Projects & Jobs)/" => "Properties",
                "/(Project ID)/i" => "Property ID",
                "/(Project)/i" => "Property"
            ],
            "defaultDashboard" => "Accounting"
        ],
        //" , "
        "default" => [
            "title" => "All Functions",
            "interface" => "default",
            "interfaceType" => "ltr",
            "defaultDashboard" => "Accounting"
        ],
        "defaultrtl" => [
            "title" => "All Functions RTL",
            "interface" => "default",
            "interfaceType" => "rtl",
            "defaultDashboard" => "Accounting"
        ]
    ];
}
