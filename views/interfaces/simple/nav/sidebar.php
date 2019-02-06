<div class="bs-glyphicons">
    <ul class="bs-glyphicons-list" style="margin-top: 9px">
        <?php
                                        $public_prefix = '';
            $iconbarCategories = [
                "Accounting" => [
                    "label" => $translation->translateLabel('ACCOUNTING'),
                    "link" => $public_prefix . "/index#/dashboard",
                    "iconclass" => "calendar"
                ],
                "Customer" => [
                    "label" => $translation->translateLabel('CUSTOMER'),
                    "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomers/grid/Main/all",
                    "iconclass" => "user",
                    "topbar" => [
                        "Add Customer" => [
                            "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomers/new/Main/new",
                            "label" => $translation->translateLabel('Add Customer')
                        ],
                        "Setup" => [
                            [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomers/grid/Main/all",
                                "label" => $translation->translateLabel('View Customers'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerFinancials/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer Financials'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewShipToLocations/grid/Main/all",
                                "label" => $translation->translateLabel('View Ship To Locations'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewShipForLocations/grid/Main/all",
                                "label" => $translation->translateLabel('View Ship For Locations'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCreditReferences/grid/Main/all",
                                "label" => $translation->translateLabel('View Credit References'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerContacts/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer Contacts'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewContactLog/grid/Main/all",
                                "label" => $translation->translateLabel('View Contact Log'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewComments/grid/Main/all",
                                "label" => $translation->translateLabel('View Comments'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCommentTypes/grid/Main/all",
                                "label" => $translation->translateLabel('View Comment Types'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewAccountStatus/grid/Main/all",
                                "label" => $translation->translateLabel('View Account Status'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewItemXref/grid/Main/all",
                                "label" => $translation->translateLabel('View Item Xref'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewPriceXref/grid/Main/all",
                                "label" => $translation->translateLabel('View Price Xref'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerReferences/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer References'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerSatisfactions/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer Satisfactions'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerTypes/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer Types'),
                                ]
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListCustomerInformation?id=1202975512&title=Customer Information",
                                "label" => $translation->translateLabel("Information"),
                            ],
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListCustomerCreditReferences?id=1170975398&title=Customer Credit References",
                                "label" => $translation->translateLabel("Credit References"),
                            ],
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListCustomerShipForLocations?id=1250975683&title=Customer Ship For Locations",
                                "label" => $translation->translateLabel("Ship For Locations"),
                            ],
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListCustomerShipToLocations?id=1266975740&title=Customer Ship To Locations",
                                "label" => $translation->translateLabel("Ship To Locations"),
                            ],
                          
                        ]

                    ]
                ],
                "Vehicle" => [
                    "label" => $translation->translateLabel('Vendor'),
                    "link" => $public_prefix . "/index#/grid/Inventory/Vehicles/ViewVehicles/grid/Main/all",
                    "iconclass" => "user",
                    "topbar" => [
                        "Add Vehicle" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/Vehicles/ViewVehicles/new/Main/new",
                            "label" => $translation->translateLabel('Add Vehicle')
                        ],
                        "Setup" => [
                            [
                            "link" => $public_prefix . "/index#/grid/Inventory/Vehicles/ViewVehicles/grid/Main/all",
                            "label" => $translation->translateLabel('View Vehicles'),
                            ],
                            [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/ManufacturerSetup/ManufacturerSetup/grid/Main/all",
                            "label" => $translation->translateLabel('Vehicle Setup'),
                            ]                    
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListVehiclesHeader?id=77896561&title=Vehicles",
                                "label" => $translation->translateLabel("Vehicles"),    
                            ]
                        ]

                    ]
                ],
                "Sales" => [
                    "label" => $translation->translateLabel('SALES'),
                    "iconclass" => "list-alt",
                    "data" => [
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderScreens/ViewQuotes/grid/Main/all",
                        "label" => $translation->translateLabel('View Quotes')
                        ],
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderProcessing/ViewOrders/grid/Main/all",
                        "label" => $translation->translateLabel('View Orders')
                        ],
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderProcessing/ViewInvoices/grid/Main/all",
                        "label" => $translation->translateLabel('View Invoices')
                        ]
                    ],
                    "topbar" => [
                        "Desking" => [
                            "label" => $translation->translateLabel('Desking'),
                            "link" => $public_prefix . "/index#/dashboard?screen=Desking",
                        ],
                        "Floor Plan" => [
                            "label" => $translation->translateLabel('Floor Plan'),
                            "link" => $public_prefix . "/index#/dashboard?screen=FloorPlan",
                        ],
                        "FI" => [
                            "label" => $translation->translateLabel('F & I'),
                            "link" => $public_prefix . "/index#/dashboard?screen=FI",
                        ],
                        "BHPH Payment" => [
                            "label" => $translation->translateLabel('BHPH Payment'),
                            "link" => $public_prefix . "/index#/dashboard?screen=BuyHerePayHere",
                        ],            
                        "Setup" => [
                            "node" => "AccountsReceivable",
                        ],
                        "Reports" => [
                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesCustomerSalesDetail?id=479496937&title=Customer Sales Detail",
                            "label"=> $translation->translateLabel("Sales Detail"),
                            ],

                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesCustomerSalesSummary?id=1834645779&title=Customer Sales Summary",
                            "label"=> $translation->translateLabel("Sales Summary"),
                            ],

                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesProfitibilityByCustomer?id=1091847302&title=Profitibility By Customer",
                            "label"=> $translation->translateLabel("Profit by Customer"),
                            ],

                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesProfitibilityByInvoice?id=1107847359&title=Profitibility By Invoice",
                            "label"=> $translation->translateLabel("Profit By Invoice"),
                            ],

                        ]
                    ],

                ],
                /*                "Service" => [
                    "label" => $translation->translateLabel('SERVICE'),
                    "link" => $public_prefix . "/index#/dashboard?screen=ServiceManager",
                    "iconclass" => "briefcase",
                    "topbar" => [
                        "Add RO" => [
                            "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/ViewServiceOrders/new/Main/new",
                            "label" => $translation->translateLabel('Add RO')
                        ],
                        "Lend Car" => [
                        ],
                        "Setup" => [
                            [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/ViewServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('View Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/FulfillServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Fulfill Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/PerformServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Perform Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/InvoiceServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Invoice Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceProcessing/ViewServiceInvoices/grid/Main/all",
                                "label" => $translation->translateLabel('View Repair Invoices'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ViewServiceQuotes/grid/Main/all",
                                "label" => $translation->translateLabel('View Repair Estimates'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ViewServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('View Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ServiceOrdersonHold/grid/Main/all",
                                "label" => $translation->translateLabel('Repair Orders on Hold'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ClosedServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Closed Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ServiceOrderHistory/grid/Main/all",
                                "label" => $translation->translateLabel('Repair Order History'),
                                ],

                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/FulfillServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Fulfill Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/PerformServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Perform Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/InvoiceServiceOrders/grid/Main/all",
                                "label" => $translation->translateLabel('Invoice Repair Orders'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ViewServiceInvoices/grid/Main/all",
                                "label" => $translation->translateLabel('View Repair Invoices'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ClosedServiceInvoices/grid/Main/all",
                                "label" => $translation->translateLabel('Closed Repair Invoices'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/ServiceScreens/ServiceInvoiceHistory/grid/Main/all",
                                "label" => $translation->translateLabel('Repair Invoice History'),
                                ],
                        
                                ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListServiceOrders?id=190699898&title=Service Orders",
                                "label" => $translation->translateLabel("Service Orders"),
                            ],    
                            [
                            "link" => $public_prefix . "/index#/autoreports/RptListOrderHeader?id=1906978020&title=Order Headers",
                            "label" => $translation->translateLabel("Order Headers"),
                            ],
                            [
                            "link" => $public_prefix . "/index#/autoreports/RptListOrderDetail?id=1890977963&title=Order Detail Items",
                            "label" => $translation->translateLabel("Order Detail"),
                            ],
                            [
                            "link" => $public_prefix . "/index#/autoreports/RptListOrderTypes?id=1922978077&title=Order Types",
                            "label" => $translation->translateLabel("Order Types"),
                            ],
                            [
                            "link" => $public_prefix . "/index#/autoreports/RptListInvoiceHeader?id=1698977279&title=Invoice Headers",
                            "label" => $translation->translateLabel("Invoice Headers"),
                            ],
                            [
                            "link" => $public_prefix . "/index#/autoreports/RptListInvoiceDetail?id=1682977222&title=Invoice Detail Items",
                            "label" => $translation->translateLabel("Invoice Detail Items"),
                            ],
                        ],

                    ]

                    ],*/
                "Parts" => [
                    "label" => $translation->translateLabel('Items'),
                    "link" => $public_prefix . "/index#/dashboard?screen=Parts",
                    "iconclass" => "list",
                    "topbar" => [
                        "Counter Sale" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/PartsInvoice/new/Main/new",
                            "label" => $translation->translateLabel('Counter Sale')
                        ],
                        "Add Part" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/EnterViewParts/new/Main/new",
                            "label" => $translation->translateLabel('Add Part')
                        ],
                        "Check Stock" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/PartsLookup/grid/Main/all",
                            "label" => $translation->translateLabel('Check Stock')
                        ],
                        "Order Part" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/PurchaseParts/new/Main/new",
                            "label" => $translation->translateLabel('Order Part')
                        ],
                        "Receive Part" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/ReceivePart/grid/Main/all",
                            "label" => $translation->translateLabel('Receive Part')
                        ],
                        "Adjustment" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/InventoryAdjustments/ViewAdjustments/new/Main/new",
                            "label" => $translation->translateLabel('Adjustment')
                        ],
                        "Setup" => [
                            "node" => "Inventory",
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListParts?id=1554973463&title=Parts",
                                "label" => $translation->translateLabel('Parts'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryByWarehouse?id=1554976766&title=Inventory By Warehouse",
                                "label" => $translation->translateLabel('Inventory By Warehouse'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptInventoryLowStockAlert?id=546973175&title=Inventory Low Stock Alert",
                                "label" => $translation->translateLabel('Low Stock Alert'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryItems?id=1031323084&title=Items",
                                "label" => $translation->translateLabel('Items'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryCategories?id=1570976823&title=Item Categories",
                                "label" => $translation->translateLabel('Item Categories'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryFamilies?id=1586976880&title=Item Families",
                                "label" => $translation->translateLabel('Item Families'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryItemTypes?id=1602976937&title=Item Types",
                                "label" => $translation->translateLabel('Item Types'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryPricingCode?id=1634977051&title=Item Pricing Codes",
                                "label" => $translation->translateLabel('Item Pricing Codes'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventoryPricingMethods?id=1650977108&title=Item Pricing Methods",
                                "label" => $translation->translateLabel('Item Pricing Methods'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/autoreports/RptListInventorySerialNumbers?id=1666977165&title=Item Serial Numbers",
                                "label" => $translation->translateLabel('Item Serial Numbers'),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptSalesItemSalesDetail?id=543497165&title=Item Sales Detail",
                                    "label" => $translation->translateLabel("Item Sales Detail"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptSalesItemSalesSummary?id=1866645893&title=Item Sales Summary",
                                    "label" => $translation->translateLabel("Item Sales Summary"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptSalesItemHistoryDetail?id=511497051&title=Item Sales History Detail",
                                    "label" => $translation->translateLabel("Item Sales History Detail"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptSalesItemHistorySummary?id=1850645836&title=Item Sales History Summary",
                                    "label" => $translation->translateLabel("Item Sales History Summary"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptSalesProfitibilityByItem?id=607497393&title=Profitibility By Item",
                                    "label" => $translation->translateLabel("Profitibility By Item"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryTop10ItemsBySales?id=1075847245&title=Top 10 Items By Sales",
                                    "label" => $translation->translateLabel("Top 10 Items By Sales"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryTop10ItemsByProfit?id=1059847188&title=Top 10 Items By Profit",
                                    "label" => $translation->translateLabel("Top 10 Items By Profit"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryValuationReport?id=967322856&title=Inventory Valuation Report",
                                    "label" => $translation->translateLabel("Inventory Valuation Report"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryValuationReportAverage?id=983322913&title=Inventory Valuation Report Average",
                                    "label" => $translation->translateLabel("Inventory Valuation Report Average"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryValuationReportFIFO?id=999322970&title=Inventory Valuation Report FIFO",
                                    "label" => $translation->translateLabel("Inventory Valuation Report FIFO"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptInventoryValuationReportLIFO?id=1015323027&title=Inventory Valuation Report LIFO",
                                    "label" => $translation->translateLabel("Inventory Valuation Report LIFO"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptListInventoryAssemblies?id=1538976709&title=Inventory Assemblies",
                                    "label" => $translation->translateLabel("Inventory Assemblies"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustments?id=1506976595&title=Inventory Adjustments",
                                    "label" => $translation->translateLabel("Inventory Adjustments"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentsDetail?id=1522976652&title=Inventory Adjustments Detail",
                                    "label" => $translation->translateLabel("Inventory Adjustments Detail"),
                                ],
                                [
                                    "link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentTypes?id=1490976538&title=Inventory Adjustment Types",
                                    "label" => $translation->translateLabel("Inventory Adjustment Types"),
                                ],

                        ],
                    ],
                ],
                "Reporting" => [
                    "label" => $translation->translateLabel('Report Engine'),
                    "link" => $public_prefix . "/index#/grid/Reports/Autoreport/GenericReportDetail/new/Main/" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
                    "iconclass" => "stats"
                ],
                "Favorits" => [
                    "label" => $translation->translateLabel('FAVORITES'),
                    "favorits" => true,
                    "iconclass" => "heart"
                ],
                "Setup" => [
                    "label" => $translation->translateLabel('TOOLS'),
                    // "link" => $public_prefix . "/index#/grid/SystemSetup/CompanySetup/CompanySetup/view/Main/" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
                    "iconclass" => "cog",
                    "topbar" => [
                        "Add User" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/SecuritySetup/SecuritySetup/new/Main/new",
                            "label" => $translation->translateLabel('Add User')
                        ],
                        "User Security" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/SecuritySetup/SecuritySetup/view/Main/" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"] . '__' . $user["EmployeeID"],
                            "label" => $translation->translateLabel('User Security')
                        ],
                        "Audit" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/SecuritySetup/AuditDescription/grid/Main/all",
                            "label" => $translation->translateLabel('Audit')
                        ],
                        "Integrations" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/CompanySetup/CompanyIntegrations/grid/Main/all",
                            "label" => $translation->translateLabel('Integrations')
                        ],
                        "Global Settings" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/CompanySetup/CompanySetup/view/Main/" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
                            "label" => $translation->translateLabel('Global Settings')
                        ],
                    ]
                ],
                "Help" => [
                    "label" => $translation->translateLabel('HELP'),
                    "link" => "https://stfbinc.helpdocs.com",
                    "target" => "_blank",
                    "iconclass" => "question-sign"                    
                ]
            ];

            foreach ($iconbarCategories as $key=>$item){
                if (!key_exists("favorits", $item)) {
                    echo '<li onmouseenter="onShowSubMenu(event);" onmouseleave="onHideSubMenu(event);" ><a onclick="'. (key_exists("link", $item) ? 'location.href=\'' . $item["link"].'\';' :' ') .     (key_exists("topbar", $item) ? 'fillByTypical(\''. $key . '\');'  : 'fillTopmenu();')  .'" style="cursor: pointer"  class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["label"] . '</span></a>';
                    if (key_exists("data", $item)) {
                        echo "<ul onmouseenter=\"onShowSubMenu(event);\" onmouseleave=\"onHideSubMenu(event);\" class=\"iconbarsubmenu dropdown-menu\" style=\" left: 99px !important; margin-top: -50px !important; z-index: 9999\">";
                            foreach($item["data"] as $subitem) {
                                echo '<li style="height:60px"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="' . $subitem["link"] . '" class="nav-link">' . $subitem["label"] .'</a></li>';
                            }
                        echo '</ul>';
                    }
                    echo '</li>';
                } else {
                    echo '<li  onmouseenter="onShowSubMenu(event);" onmouseleave="onHideSubMenu(event);" ><a onclick="fillByFavorits();" style="cursor: pointer" class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["label"] . '</span></a>';
                    foreach ($menuCategories as $key=>$item){
                        if ($item["type"] == "custom") {
                            echo "<ul onmouseenter=\"onShowSubMenu(event);\" onmouseleave=\"onHideSubMenu(event);\" id=\"" . $item["id"] . "\" class=\"iconbarsubmenu dropdown-menu\" style=\" left: 99px !important; margin-top: -50px !important; z-index: 9999\">";
                            foreach($item["actions"] as $key=>$subitem) {
                                echo '<li id="' . $subitem["id"] . '"onclick="' . $subitem["action"] . '"  style="height:60px; width: 100%"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="javascript:;" class="nav-link">' . $subitem["full"] .'</a></li>';
                            }
                            echo '</ul>';
                        }
                    }
                    echo '</li>';
                }
            }
        ?>
    </ul>
</div>
<script>

function onShowSubMenu(e) {
    var menu = $(e.target).find('ul');
    $(menu[0]).css({display: 'block'});
    $(menu[0]).css({top: 'auto'});
}

function onHideSubMenu(e) {
    $('.iconbarsubmenu').css("display", "none");
    submenuToggled = false;
}

$(document).click(function(e){
    $('.iconbarsubmenu').css("display", "none");
    submenuToggled = false;
});

var submenuToggled;
$('.dropdown-submenu a.mysubmenu').on("mouseover", function(e){
    if (submenuToggled) {
        $(submenuToggled).next('ul').toggle();
    }
    submenuToggled = this;
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
});
$('.dropdown-submenu a.mysubmenu').on("mouseout", function(e){
    if (submenuToggled) {
        $(submenuToggled).next('ul').toggle();
    }
    submenuToggled = this;
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
});

 var sidebarItems = $(".collapse-sidebar-item");
 var twoLevelItems = $(".collapse-sidebar-two-level-item");
 var threeLevelItems = $(".collapse-sidebar-three-level-item");
 function onhidden(e) {
     $(e.currentTarget).css('display', 'none');
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     $content.height('100%');
     if($sidebar.height() > $content.height())
         $content.height($sidebar.height());
     e.stopPropagation();
 }
 sidebarItems.on('hidden.bs.collapse', onhidden);
 twoLevelItems.on('hidden.bs.collapse', onhidden);
 threeLevelItems.on('hidden.bs.collapse', onhidden);
 sidebarItems.on('show.bs.collapse', function(e){
     sideBarCloseAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 sidebarItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", ($sidebar.height() + 20) + "px");
 });

 twoLevelItems.on('show.bs.collapse', function(e){
     var parent = $(e.currentTarget).parent().parent().parent().parent();
     //     console.log(parent, parent.is('.in, .collapse'));
     //     if(!parent.is('.in, .collapse'))
     sideBarCloseTwoLevelAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 twoLevelItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", ($sidebar.height() + 20) + "px");
 });

 threeLevelItems.on('show.bs.collapse', function(e){
     sideBarCloseThreeLevelAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 threeLevelItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
         $content = $("#content");
     if($sidebar.height() > $content.height())
         $content.css("height", ($sidebar.height() + 20) + "px");
 });

 function sideBarCloseAll(){
     sidebarItems.css('display', 'none');
     sidebarItems.collapse('hide');
 }

 function sideBarCloseTwoLevelAll(){
     twoLevelItems.css('display', 'none');
     twoLevelItems.collapse('hide');
 }

 function sideBarCloseThreeLevelAll(){
     threeLevelItems.css('display', 'none');
     threeLevelItems.collapse('hide');
 }

 function sideBarDeselectAll(){
     $('.nav-item-level2, .nav-item-level3, .nav-item-level4').removeClass('left-iconbar-active');
 }

function iconbarDeselectAll() {
    $('.bs-glyphicons li, .bs-glyphicons li a').removeClass('left-iconbar-active');
}

 function sideBarSelectItem(object){
     var shortcuts = $("#MyShortcuts"), scChildren = shortcuts.children(), ind = 0;
     if(scChildren.length > 1){
	 while(ind != scChildren.length){
	     if(scChildren[ind].id == object.item.id){
		//  $("li").removeClass('active');
		//  $(scChildren[ind]).addClass('active');
		//  shortcuts.parent().collapse("show");
		//  shortcuts.parent().css("display:block");
		 return;
	     }
	     ind++;
	 }
     }else{
	 setTimeout(function(){
	     var scChildren = shortcuts.children(), ind = 0;
	     while(ind != scChildren.length){
		 if(scChildren[ind].id == object.item.id){
		    //  $(scChildren[ind]).addClass('active');
		     //console.log(scChildren[ind]);
		    //  shortcuts.parent().collapse("show");
		    //  shortcuts.parent().css("display:block");
		     //		 shortcuts.parent().collapse("hide");
		     //		 shortcuts.parent().collapse("show");
		 }
		 ind++;
	     }
	 }, 1500);
     }
     if(!object)
         return;
     var _item = $(document.getElementById("list" + object.menu.id)), sitem, ssitem;
     //console.log(object, _item);
     if(!_item.hasClass('in')){
         sideBarCloseAll();
         setTimeout(function(){
	     _item.collapse('show');
	     _item.css('display', 'block');
         }, 500);
     }

     if(object.hasOwnProperty("submenu")){
         sitem = $(document.getElementById("list" + object.submenu.id.replace(/\//g, "")));
         if(!sitem.hasClass('in')){
	     sideBarCloseTwoLevelAll();
	     setTimeout(function(){
		 sitem.collapse('show');
		 sitem.css('display', 'block');
	     }, 500);
         }
     }

     if(object.hasOwnProperty("subsubmenu")){
         ssitem = $(document.getElementById("list" + object.subsubmenu.id.replace(/\//g, "")));
         if(!ssitem.hasClass('in')){
	     sideBarCloseThreeLevelAll();
	     setTimeout(function(){
		 sitem.collapse('show');
		 ssitem.css('display', 'block');
	     }, 500);
         }
     }

     var selItem = document.getElementById(object.item.id);
     if(!$(selItem).hasClass("left-iconbar-active")){
         sideBarDeselectAll();
         $('.selItebs-glyphicons lim, .selItebs-glyphicons lim a').addClass("left-iconbar-active");
     }
 }

 function setIconbarActive(object){
    //  console.log(object.parentNode);
     iconbarDeselectAll();
     $(object).addClass("left-iconbar-active");
     $(object.parentNode).addClass("left-iconbar-active");
 }

 var sidebarToggled = true;
 function toggleSideBar(){
     if(sidebarToggled){
         $('body').addClass('minimized');
         $('#logosection').addClass("hide-logo");
         $('#sideBarHider')[0].style.display = 'none';
         $('#sideBarShower')[0].style.display = 'block';
         sidebarToggled = false;
     }else{
         $('body').removeClass('minimized');
         $('#logosection').removeClass("hide-logo");
         $('#sideBarHider')[0].style.display = 'block';
         $('#sideBarShower')[0].style.display = 'none';
         sidebarToggled = true;
     }
 }
 (function(){
     var $sidebar   = $("#sidebar"),
         $window    = $(window),
         offset     = $sidebar.offset(),
         topPadding = 20,
         $content = $("#content");

     $window.scroll(function(){
         var wscroll = $window.scrollTop();
         if(!wscroll){
             $sidebar.css("top", topPadding + 'px');
         }else if(wscroll){
             //     console.log($sidebar.height(), $(".sidebar-toggler").offset());
             //console.log(wscroll, $sidebar.height(), $window.height());
             if(wscroll < $sidebar.height() - $window.height() + 150)
                 $sidebar.css("top", (wscroll * -1) + 'px');
             else
                 $sidebar.css("bottom", '0px');
             //    $sidebar.stop().animate({
             // marginTop: $window.scrollTop() - offset.top + topPadding
             //   });
         }
     });
 })();

// function createFavItem(id) {
//     var shortcutsRaw = localStorage.getItem('shortcuts');
//     var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

//     var hh = "" + "/index#/grid/" + id + "/grid/Main/all";

//     $('#custom-toolbar').append(
//         '<li style="float: left" id="' + id + '"class="top-bar-link"><a href="' + hh+ '" style="padding: 5px 7px !important">' + shortcuts[id].label + '</a></li>'
//     );
// }

// function clearCustomToolbar() {
//     // var parent = document.getElementById('custom-toolbar');
//     // while (parent.firstChild) {
//     //     parent.removeChild(parent.firstChild);
//     // }
// }
// function compare(a,b) {
//     if (a.order < b.order)
//         return -1;
//     if (a.order > b.order)
//         return 1;
//     return 0;
// }

function fillByFavorits() {
    // clearCustomToolbar();
    // var shortcutsRaw = localStorage.getItem('shortcuts');
    // var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
    // var keys = Object.keys(shortcuts).map(function (key) {
    //     return shortcuts[key];
    // }).sort(compare);
    // // var keys = Object.keys(shortcuts);
    // var parent = document.getElementById('custom-toolbar');

    // for (var i = 0; i < keys.length; i++) {
    //     createFavItem(keys[i].id);
    // }
}

</script>
