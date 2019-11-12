<?php
$categories = [];
require "menuCategories/GeneralLedger.php";
require "menuCategories/AccountsReceivable.php";
require "menuCategories/AccountsPayable.php";
require "menuCategories/Inventory.php";
require "menuCategories/Payroll.php";
require "menuCategories/CRM.php";
require "menuCategories/ECommerce.php";
require "menuCategories/MRP.php";
require "menuCategories/Setup.php";
require "menuCategories/Reports.php";
$leftMenu = [
    "My" => [
        "type" => "category",
        "title" => "My menu",
        "data" => [
            [
                "type" => "absoluteLink",
                "title" => "Dashboard",
                "link" => "index.php#/?page=dashboard",
                "icon" => "linea-icon linea-basic"
            ],
            [
                "type" => "absoluteLink",
                "title" => "Tasks",
                "link" => "index.php#/?page=dashboard&screen=Tasks",
                "icon" => "linea-icon linea-basic"
            ],
        ]
    ],
    "Main" => [
        "type" => "category",
        "title" => "Main menu",
        "data" => [
            [
                "type" => "submenu",
                "id" => "GeneralLedger",
                "full" => $translation->translateLabel('General Ledger'),
                "link" => "index.php#/?page=dashboard",
                "short" => "Ge",
                "data" => $categories["GeneralLedger"]
            ],
		    [
                "type" => "submenu",
                "id" => "Financials",
                "full" => $translation->translateLabel('Financial Statements'),
                "short" => "Fi",
                "data" => [
                    [
                        "id" => "Financials/GaapMain",
                        "type" => "relativeLink",
                        "full" => $translation->translateLabel('GAAP Financials'),
                        "href"=> "page=financials&type=gaap&module=main",
                        "short" => "Le"
                    ],
                    [
                        "id" => "Financials/GaapMain",
                        "type" => "relativeLink",
                        "full" => $translation->translateLabel('IFRS Financials'),
                        "href"=> "page=financials&type=ifrs&module=main",
                        "short" => "Le"
                    ],
                    [
                        "type" => "submenu",
                        "id" => "Financials/GaapAgedReports",
                        "full" => $translation->translateLabel('GAAP Aged Reports'),
                        "short" => "Ga",
                        "data" => [
                            [
                                "id" => "Financials/GaapAgedReports/AgedPayables",
                                "full" => $translation->translateLabel('Aged Payables'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=gaap&module=AgedPayablesSummary",
                                "short" => "Ag"
                            ],
                            /*				    [
                                                "id" => "Financials/GaapAgedReports/AgedPayablesComparative",
                                                "full" => $translation->translateLabel('Aged Payables Comparative'),
                                                "type" => "relativeLink",
                                                "target" => "_blank",
                                                "href"=> "page=financials&type=gaap&module=AgedPayablesSummaryComparative",
                                                "short" => "Ag"
                                                ],*/
                            [
                                "id" => "Financials/GaapAgedReports/AgedPayablesYTD",
                                "full" => $translation->translateLabel('Aged Payables YTD'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=gaap&module=AgedPayablesSummaryYTD",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Financials/GaapAgedReports/AgedReceivables",
                                "full" => $translation->translateLabel('Aged Receivables'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=gaap&module=AgedReceivablesSummary",
                                "short" => "Ag"
                            ],
                            /*				    [
                                                "id" => "Financials/GaapAgedReports/AgedReceivablesComparative",
                                                "full" => $translation->translateLabel('Aged Receivables Comparative'),
                                                "type" => "relativeLink",
                                                "target" => "_blank",
                                                "href"=> "page=financials&type=gaap&module=AgedReceivablesSummaryComparative",
                                                "short" => "Ag"
                                                ],*/
                            [
                                "id" => "Financials/GaapAgedReports/AgedReceivablesYTD",
                                "full" => $translation->translateLabel('Aged Receivables YTD'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=gaap&module=AgedReceivablesSummaryYTD",
                                "short" => "Ag"
                            ]
                        ]
                    ],
                    [
                        "type" => "submenu",
                        "id" => "Reports/Financials/IFRSAgedReports",
                        "full" => $translation->translateLabel('IFRS Aged Reports'),
                        "short" => "IF",
                        "data" => [
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedPayables",
                                "full" => $translation->translateLabel('Aged Payables'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedPayablesSummary",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedPayablesComparative",
                                "full" => $translation->translateLabel('Aged Payables Comparative'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedPayablesSummaryComparative",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedPayablesYTD",
                                "full" => $translation->translateLabel('Aged Payables YTD'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedPayablesSummaryYTD",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedReceivables",
                                "full" => $translation->translateLabel('Aged Receivables'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedReceivablesSummary",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedReceivablesComparative",
                                "full" => $translation->translateLabel('Aged Receivables Comparative'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedReceivablesSummaryComparative",
                                "short" => "Ag"
                            ],
                            [
                                "id" => "Reports/Financials/IFRSAgedReports/AgedReceivablesYTD",
                                "full" => $translation->translateLabel('Aged Receivables YTD'),
                                "type" => "relativeLink",
                                "target" => "_blank",
                                "href"=> "page=financials&type=ifrs&module=AgedReceivablesSummaryYTD",
                                "short" => "Ag"
                            ]
                        ]
                    ],
                    [
                        "id" => "Financials/GaapWorksheets",
                        "type" => "relativeLink",
                        "target" => "_blank",
                        "full" => $translation->translateLabel('Worksheets'),
                        "href"=> "page=financials&type=common&module=worksheets",
                        "short" => "Le"
                    ]
                ]
		    ],
            [
                "type" => "submenu",
                "id" => "AccountsReceivable",
                "full" => $translation->translateLabel('Receivables'),
                "link" => "index.php#/?page=dashboard&screen=SalesAndShipping",
                "short" => "Ac",
                "data" => $categories["AccountsReceivable"]
            ],
            [
                "type" => "submenu",
                "id" => "AccountsPayable",
                "full" => $translation->translateLabel('Payables'),
                "link" => "index.php#/?page=dashboard&screen=PurchaseAndReceiving",
                "short" => "Ac",
                "data" => $categories["AccountsPayable"]
            ],
            [
                "type" => "submenu",
                "id" => "Inventory",
                "full" => $translation->translateLabel('Inventory'),
                "short" => "In",
                "link" => "index.php#/?page=dashboard&screen=Item",
                "data" => $categories["Inventory"]
            ],
            /*
              [
              "type" => "submenu",
              "id" => "FundAccounting",
              "full" => $translation->translateLabel('Fund Accounting'),
              "short" => "Fu",
              "data" => [

              [
              "type" => "submenu",
              "id" => "FundAccounting/ViewJointPayments",
              "full" => $translation->translateLabel('View Joint Payments'),
              "short" => "Vi",
              "data" => [
              ]
              ],
              [
              "type" => "submenu",
              "id" => "FundAccounting/ApproveJointPayments",
              "full" => $translation->translateLabel('Approve Joint Payments'),
              "short" => "Ap",
              "data" => [
              ]
              ],
              [
              "type" => "submenu",
              "id" => "FundAccounting/IssueJointPayments",
              "full" => $translation->translateLabel('Issue Joint Payments'),
              "short" => "Is",
              "data" => [
              ]
              ]
              ]
              ];

              $menuCategories["CRM&HelpDesk"] = [
              "type" => "submenu",
              "id" => "CRMHelpDesk",
              "full" => $translation->translateLabel('CRM & Help Desk'),
              "short" => "CR",
              "data" => [

              [
              "type" => "submenu",
              "id" => "CRMHelpDesk/CRM",
              "full" => $translation->translateLabel('CRM'),
              "short" => "CR",
              "data" => [
            */
            /*  [
                "type" => "submenu",
                "id" => "CRMHelpDesk/HelpDesk",
                "full" => $translation->translateLabel('Help Desk'),
                "short" => "He",
                "data" => [

                [
                "id" => "CRMHelpDesk/HelpDesk/ViewNewsItems",
                "full" => $translation->translateLabel('View News Items'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpNewsBoardList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewReleaseDates",
                "full" => $translation->translateLabel('View Release Dates'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpReleaseDatesList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewHeadings",
                "full" => $translation->translateLabel('View Headings'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageHeadingList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewTopics",
                "full" => $translation->translateLabel('View Topics'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageTopicList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewProblemReports",
                "full" => $translation->translateLabel('View Problem Reports'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemReportList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewSupportRequests",
                "full" => $translation->translateLabel('View Support Requests'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewResources",
                "full" => $translation->translateLabel('View Resources'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourcesList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewPriorities",
                "full" => $translation->translateLabel('View Priorities'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpPriorityList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewProblemTypes",
                "full" => $translation->translateLabel('View Problem Types'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemTypeList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewRequestMethods",
                "full" => $translation->translateLabel('View Request Methods'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpRequestMethodList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewResourceTypes",
                "full" => $translation->translateLabel('View Resource Types'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourceTypeList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewSeverities",
                "full" => $translation->translateLabel('View Severities'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSeverityList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewStatuses",
                "full" => $translation->translateLabel('View Statuses'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpStatusList",
                "short" => "Vi"
                ],
                [
                "id" => "CRMHelpDesk/HelpDesk/ViewSupportTypes",
                "full" => $translation->translateLabel('View Support Types'),
                "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
                "short" => "Vi"
                ]
                ]
                ]
                ]
                ],*/
            [
                "type" => "submenu",
                "id" => "Payroll",
                "full" => $translation->translateLabel('Human Resources'),
                "short" => "Pa",
                "data" => $categories["Payroll"]
            ],
            [
                "type" => "submenu",
                "id" => "CRMHelpDesk",
                "full" => $translation->translateLabel('CRM'),
                "short" => "CR",
                "link" => "index.php#/?page=dashboard&screen=CRM",
                "data" => $categories["CRM"]
            ],
            [
                "type" => "submenu",
                "id" => "ECommerce",
                "full" => $translation->translateLabel('ECommerce'),
                "short" => "EC",
                "data" => $categories["ECommerce"]
            ],
            [
                "type" => "submenu",
                "id" => "MRP",
                "full" => $translation->translateLabel('MRP'),
                "short" => "MR",
                "link" => "index.php#/?page=dashboard&screen=MRP",
                "data" => $categories["MRP"]
            ],
            [
                "type" => "submenu",
                "id" => "HelpDesk",
                "full" => $translation->translateLabel('Help Desk'),
                "short" => "Co",
                "link" => "index.php#/?page=dashboard&screen=Support",
                "data" => [
                    [
                        "id" => "CRMHelpDesk/HelpDesk/ViewSupportTypes",
                        "full" => $translation->translateLabel('View Support Types'),
                        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
                        "short" => "Vi"
                    ],
                    [
                        "id" => "CRMHelpDesk/HelpDesk/ViewSupportRequests",
                        "full" => $translation->translateLabel('View Support Requests'),
                        "href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestsList",
                        "short" => "Vi"
                    ]
                ]
            ],
            [
                "type" => "submenu",
                "id" => "SystemSetup",
                "full" => $translation->translateLabel('Tools'),
                "short" => "Sy",
                "icon" => "wrench",
                "data" => [
                    [
                        "type" => "submenu",
                        "id" => "CRMHelpDesk",
                        "full" => $translation->translateLabel('CRM'),
                        "short" => "CR",
                        "data" => $categories["CRM"]
                    ],
                    [
                        "type" => "submenu",
                        "id" => "Tools/ECommerce",
                        "full" => $translation->translateLabel('ECommerce'),
                        "short" => "EC",
                        "data" => $categories["ECommerce"]
                    ],
                    [
                        "type" => "submenu",
                        "id" => "SystemSetup/CompanySetup",
                        "full" => $translation->translateLabel('EDI / File Import'),
                        "short" => "Co",
                        "data" => [
                            [
                                "id" => "SystemSetup/EDISetup/EDISetup",
                                "full" => $translation->translateLabel('EDI Setup'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDISetupList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIDocumentTypes",
                                "full" => $translation->translateLabel('EDI Document Types'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIDocumentTypesList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIDocumentDirections",
                                "full" => $translation->translateLabel('EDI Document Directions'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIDirectionList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIExceptions",
                                "full" => $translation->translateLabel('EDI Exceptions'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionsList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIExceptionTypes",
                                "full" => $translation->translateLabel('EDI Exception Types'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionTypesList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIAddresses",
                                "full" => $translation->translateLabel('EDI Addresses'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIAddressesList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIStatements",
                                "full" => $translation->translateLabel('EDI Statements'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIStatementsList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIStatementsHistory",
                                "full" => $translation->translateLabel('EDI Statements History'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIStatementsHistoryList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIOrders",
                                "full" => $translation->translateLabel('EDI Orders'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIOrderHeaderList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIInvoices",
                                "full" => $translation->translateLabel('EDI Invoices'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIInvoiceHeaderList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIPurchase",
                                "full" => $translation->translateLabel('EDI Purchases'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIPurchaseHeaderList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIReceipts",
                                "full" => $translation->translateLabel('EDI Receipts'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIReceiptsHeaderList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIPayments",
                                "full" => $translation->translateLabel('EDI Payments'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIPaymentsHeaderList",
                                "short" => "ED"
                            ],
                            [
                                "id" => "SystemSetup/EDISetup/EDIItems",
                                "full" => $translation->translateLabel('EDI Items'),
                                "href"=> "EnterpriseASPSystem/EDISetup/EDIIItemsList",
                                "short" => "ED"
                            ]
                        ]
                    ],
                    [
                        "type" => "submenu",
                        "id" => "MRP",
                        "full" => $translation->translateLabel('MRP'),
                        "short" => "MR",
                        "data" => $categories["MRP"]
                    ]
                ]
            ],
            [
                "type" => "submenu",
                "id" => "SystemSetup",
                "full" => $translation->translateLabel('System Setup'),
                "short" => "Sy",
                "data" => $categories["Setup"]
            ],
            [
                "type" => "submenu",
                "id" => "Reports",
                "full" => $translation->translateLabel('Reports'),
                "short" => "Re",
                "link" => $linksMaker->makeGridItemNewPartial("Reports/Autoreport/GenericReportDetail") . "&category=Main&item=" . $keyString,
                "data" => $categories["Reports"]
            ]
        ]
    ],
    "Support" => [
        "type" => "category",
        "title" => "Support",
        "data" => [
            [
                "type" => "absoluteLink",
                "title" => "Help Documentaion",
                "link" => "https://www.stfb.net/EnterpriseX/Help/index.php",
                "target" => "_Blank",
                "icon" => "icon-docs"
            ],
            [
                "type" => "absoluteLink",
                "title" => "Support Ticket",
                "link" => "https://www.stfb.net/EnterpriseX/Help/index.php#contact-form",
                "target" => "_Blank",
                "icon" => "icon-support"
            ],
            [
                "type" => "absoluteLink",
                "title" => "Log out",
                "link" => "index.php?page=index&logout=true",
                "icon" => "icon-logout"
            ]
        ]
    ]
];

if(key_exists("config", $ascope) && key_exists("software", $ascope["config"]) && $ascope["config"]["software"] == "Admin"){
	$leftMenu["My"]["data"] = [
        [
            "type" => "absoluteLink",
            "title" => "Dashboard",
            "link" => "index.php#/?page=dashboard",
            "icon" => "linea-icon linea-basic"
        ],
        [
            "short" => "AD",
            "type" => "absoluteLink",
            "title" => "Administration",
            "link" =>  $linksMaker->makeGridLink("SystemSetup/Admin/AppInstallations"),
            "icon" => "linea-icon linea-basic"
        ],
        [
            "type" => "absoluteLink",
            "title" => "Tasks",
            "link" => "index.php#/?page=dashboard&screen=Tasks",
            "icon" => "linea-icon linea-basic"
        ],
    ];
}
?>
