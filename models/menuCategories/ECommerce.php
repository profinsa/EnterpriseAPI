<?php
$categories["ECommerce"] = [
    [
        "type" => "absoluteLink",
        "target" => "_blank",
        "id" => "Tools/ECommerce/ShoppingCart",
        "full" => $translation->translateLabel('Open Cart'),
        "href" => "/EnterpriseX/Cart/index.php?config={$_SESSION["configName"]}&loadusername=dland&loadpassword=dland&CompanyID={$ascope["user"]["CompanyID"]}&DivisionID={$ascope["user"]["DivisionID"]}&DepartmentID={$ascope["user"]["DepartmentID"]}"
    ],
    [
        "type" => "submenu",
        "id" => "Tools/ECommerce/ShoppingCartSetup",
        "full" => $translation->translateLabel('Cart Setup'),
        "short" => "Sh",
        "data" => [

            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/CartItemsSetup",
                "full" => $translation->translateLabel('Cart Setup'),
                "type" => "relativeLink",
                "href"=> "page=grid&action=Tools/ECommerce/ShoppingCartSetup/CartItemsSetup&mode=view&category=Main&item=" . $keyString,
                "short" => "Ca"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/CategoriesLanguages",
                "full" => $translation->translateLabel('Categories Languages'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
                "short" => "Ca"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/FamiliesLanguages",
                "full" => $translation->translateLabel('Families Languages'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
                "short" => "Fa"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsLanguages",
                "full" => $translation->translateLabel('Items Languages'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsCrossSell",
                "full" => $translation->translateLabel('Items Cross Sell'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsNoticifations",
                "full" => $translation->translateLabel('Items Noticifations'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsRelations",
                "full" => $translation->translateLabel('Items Relations'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsReviews",
                "full" => $translation->translateLabel('Items Reviews'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsSubsitiutions",
                "full" => $translation->translateLabel('Items Subsitiutions'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
                "short" => "It"
            ],
            [
                "id" => "Tools/ECommerce/ShoppingCartSetup/ItemsWishList",
                "full" => $translation->translateLabel('Items Wish List'),
                "href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
                "short" => "It"
            ]
        ]
    ]
];
?>