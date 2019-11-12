<?php
$categories["MRP"] = [
    [
        "type" => "submenu",
        "id" => "MRP/BillofMaterials",
        "full" => $translation->translateLabel('Bill of Materials'),
        "short" => "Bi",
        "data" => [

            [
                "id" => "MRP/BillofMaterials/ViewBillOfMaterials",
                "full" => $translation->translateLabel('View Bill Of Materials'),
                "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesList",
                "short" => "Vi"
            ],
            [
                "id" => "MRP/BillofMaterials/ViewBuildInstructions",
                "full" => $translation->translateLabel('View Build Instructions'),
                "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesInstructionsList",
                "short" => "Vi"
            ],
            [
                "id" => "MRP/BillofMaterials/CreateInventory",
                "full" => $translation->translateLabel('Create Inventory'),
                "href"=> "EnterpriseASPInv/BillOfMaterials/InventoryCreateAssembly",
                "short" => "Cr"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "MRP/WorkOrders",
        "full" => $translation->translateLabel('Work Orders'),
        "short" => "Wo",
        "data" => [

            [
                "id" => "MRP/WorkOrders/ViewWorkOrders",
                "full" => $translation->translateLabel('View Work Orders'),
                "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList",
                "short" => "Vi"
            ],
            [
                "id" => "MRP/WorkOrders/ViewClosedWorkOrders",
                "full" => $translation->translateLabel('View Closed Work Orders'),
                "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList",
                "short" => "Vi"
            ],
            [
                "id" => "MRP/WorkOrders/ViewWorkOrdersHistory",
                "full" => $translation->translateLabel('View Work Orders History'),
                "href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList",
                "short" => "Vi"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "MRP/MRPSetup",
        "full" => $translation->translateLabel('MRP Setup'),
        "short" => "MR",
        "data" => [

            [
                "id" => "MRP/MRPSetup/InProgressTypes",
                "full" => $translation->translateLabel('In Progress Types'),
                "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderInProgressList",
                "short" => "In"
            ],
            [
                "id" => "MRP/MRPSetup/PriorityTypes",
                "full" => $translation->translateLabel('Priority Types'),
                "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderPriorityList",
                "short" => "Pr"
            ],
            [
                "id" => "MRP/MRPSetup/WorkOrderStatuses",
                "full" => $translation->translateLabel('Work Order Statuses'),
                "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderStatusList",
                "short" => "Wo"
            ],
            [
                "id" => "MRP/MRPSetup/WorkOrderTypes",
                "full" => $translation->translateLabel('Work Order Types'),
                "href"=> "EnterpriseASPInv/MRPSetup/WorkOrderTypesList",
                "short" => "Wo"
            ]
        ]
    ]
];
?>