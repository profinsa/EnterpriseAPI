<?php
$categories["Inventory"] = [
    [
        "type" => "submenu",
        "id" => "Inventory/ItemsStock",
        "full" => $translation->translateLabel('Items & Stock '),
        "short" => "It",
        "data" => [
            [
				"id" => "Inventory/ItemsStock/ViewInventoryOnHand",
				"full" => $translation->translateLabel('View Inventory On-Hand'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryByWarehouseList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewInventoryItems",
				"full" => $translation->translateLabel('View Inventory Items'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemsList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewItemCategories",
				"full" => $translation->translateLabel('View Item Categories'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryCategoriesList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewItemFamilies",
				"full" => $translation->translateLabel('View Item Families'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryFamiliesList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewItemTypes",
				"full" => $translation->translateLabel('View Item Types'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemTypesList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewSerialNumbers",
				"full" => $translation->translateLabel('View Serial Numbers'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventorySerialNumbersList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewPricingCodes",
				"full" => $translation->translateLabel('View Pricing Codes'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingCodeList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/ItemsStock/ViewPricingMethods",
				"full" => $translation->translateLabel('View Pricing Methods'),
				"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingMethodsList",
				"short" => "Vi"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Inventory/InventoryAdjustments",
        "full" => $translation->translateLabel('Inventory Adjustments '),
        "short" => "In",
        "data" => [

            [
				"id" => "Inventory/InventoryAdjustments/ViewAdjustments",
				"full" => $translation->translateLabel('View Adjustments'),
				"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentsList",
				"short" => "Vi"
            ],
            [
				"id" => "Inventory/InventoryAdjustments/InventoryAdjustmentTypes",
				"full" => $translation->translateLabel('Inventory Adjustment Types'),
				"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentTypesList",
				"short" => "In"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Inventory/InventoryTransfers",
        "full" => $translation->translateLabel('Inventory Transfers'),
        "short" => "In",
        "data" => [
            [
				"id" => "Inventory/InventoryTransfers/TransferInventory",
				"full" => $translation->translateLabel('Transfer Inventory'),
				"href"=> "EnterpriseASPInv/InvetoryTranfers/InventoryTransferList",
				"short" => "Ti"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Inventory/WarehouseTransits",
        "full" => $translation->translateLabel('Warehouse Transits'),
        "short" => "Wa",
        "data" => [
            [
				"id" => "Inventory/WarehouseTransits/WarehouseTransits",
				"full" => $translation->translateLabel('Warehouse Transits'),
				"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderList",
				"short" => "Wa"
            ],
            [
				"id" => "Inventory/WarehouseTransits/WarehouseTransitsHistory",
				"full" => $translation->translateLabel('Warehouse Transits History'),
				"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderHistoryList",
				"short" => "Wa"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Inventory/ShoppingCartSetup",
        "full" => $translation->translateLabel('Shopping Cart Setup'),
        "short" => "Sh",
        "data" => [

            [
				"id" => "Inventory/ShoppingCartSetup/CartItemsSetup",
				"full" => $translation->translateLabel('Cart Setup'),
                "type" => "relativeLink",
				"href"=> "page=grid&action=Inventory/ShoppingCartSetup/CartItemsSetup&mode=view&category=Main&item=" . $keyString,
				"short" => "Ca"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/CategoriesLanguages",
				"full" => $translation->translateLabel('Categories Languages'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
				"short" => "Ca"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/FamiliesLanguages",
				"full" => $translation->translateLabel('Families Languages'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
				"short" => "Fa"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsLanguages",
				"full" => $translation->translateLabel('Items Languages'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsCrossSell",
				"full" => $translation->translateLabel('Items Cross Sell'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsNoticifations",
				"full" => $translation->translateLabel('Items Noticifations'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsRelations",
				"full" => $translation->translateLabel('Items Relations'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsReviews",
				"full" => $translation->translateLabel('Items Reviews'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsSubsitiutions",
				"full" => $translation->translateLabel('Items Subsitiutions'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
				"short" => "It"
            ],
            [
				"id" => "Inventory/ShoppingCartSetup/ItemsWishList",
				"full" => $translation->translateLabel('Items Wish List'),
				"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
				"short" => "It"
            ]
        ]
    ]
];
?>