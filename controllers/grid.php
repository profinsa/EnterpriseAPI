<?php
/*
Name of Page: gridController

Method: controller for many grid pages(like General Ledger pages etc), used for rendering page and interacting with it

Date created: Nikita Zaharov, 21.02.2016

Use: The controller is responsible for:
- page rendering using view
- handling XHR request(delete, update and new item in grid)

Input parameters:
$app : application instance, object

Output parameters:
$scope: object, used by view, most like model
$translation: model, it is responsible for translation in view

Called from:
+ index.php

Calls:
models/translation.php
models/gridDataSource derevatives -- models who inherits from gridDataSource
app from index.php

Last Modified: 11.05.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "grid";
    public $category = "Main";
    public $item = "0";
    public $dashboardTitle = "";
    public $breadCrumbTitle = "";
    public $path;

    public function process($app){
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        require 'models/menuIdToHref.php';
        $drill = new drillDowner();
        $linksMaker = new linksMaker();
        
        $this->action = $this->path =  $_GET["action"];
        $model_path = $menuIdToPath[$_GET["action"]];
        if(!file_exists('models/' . $model_path . '.php'))
            throw new Exception("model " . 'models/' . $model_path . '.php' . " is not found");
        require 'models/' . $menuIdToPath[$_GET["action"]] . '.php';

        preg_match("/\/(\w+)$/", $this->action, $page);
        $page = $page[1];

        $PartsPath = $model_path . "/";
        $_perm = new permissionsByFile();
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        if(key_exists($filename[1], $_perm->permissions))
            $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
        else{
            http_response_code(400);
            echo 'permissions not found';
            return;
        }

        $this->user = $GLOBALS["user"] = $_SESSION["user"];
               
        $data = new gridData();
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("update", $_GET)){
                $data->updateItem($_POST["id"], $_POST["category"], $_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("new", $_GET)){
                $data->insertItem($_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("procedure", $_GET)){
                $name = $_GET["procedure"];
                $data->$name();
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("getItem", $_GET)){
                echo json_encode($data->getItem($_GET["getItem"]));
            }else if(key_exists("delete", $_GET)){
                $data->deleteItem($_GET["id"]);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else{
                $translation = new translation($this->user["language"]);
                $this->dashboardTitle = $translation->translateLabel($data->dashboardTitle);
                $this->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle);
            
                $redirectView = [
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/QuoteHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/RMA/RMAHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/RMA/RMAHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
            
                    "EnterpriseASPAP/Purchases/PurchaseHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
            
                    "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],

                    "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Payments/PaymentsHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Payments/PaymentsHeaderVoidList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Payments/PaymentsHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],

                    "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ]
                ];
                if(key_exists("mode", $_GET))
                    $this->mode = $_GET["mode"];
                if(key_exists("category", $_GET))
                    $this->category = $_GET["category"];
                if(key_exists("item", $_GET))
                    $this->item = $_GET["item"];
                
                $scope = $this;
                $ascope = json_decode(json_encode($scope), true);

                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'models/menuCategoriesGenerated.php';
                require 'views/gridView.php';
            }
        }
    }
}
?>