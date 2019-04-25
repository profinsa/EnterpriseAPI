<?php
/*
  Name of Page: gridController

  Method: controller for many grid pages(like General Ledger pages etc), used for rendering page and interacting with it

  Date created: Nikita Zaharov, 21.02.2017

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
  models/gridDataSource derivatives -- models who inherits from gridDataSource
  app from index.php

  Last Modified: 18.03.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/users.php';
require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';

class controller{
    public $user = false;
    public $interface = "default";
    public $interfaceType = "ltr";
    public $action = "";
    public $mode = "grid";
    public $category = "Main";
    public $item = "0";
    public $dashboardTitle = "";
    public $breadCrumbTitle = "";
    public $path;
    public $pathPage;
    
    protected  $redirectModel = [
        "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipStep2List" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",

        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList" => "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",

        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",

        "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList" => "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",

        "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList" => "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
        "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList" => "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",

        "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList" => "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",

        "EnterpriseASPAR/RMA/RMAHeaderClosedList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderApproveList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderReceiveList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderReceivedList" => "EnterpriseASPAR/RMA/RMAHeaderList",

        "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",

        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList" => "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList" => "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",

        "EnterpriseASPAP/Payments/PaymentsHeaderVoidList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderClosedList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderApproveList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderIssueList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",

        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        
        "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList"
    ];

    public function process($app){
        $users = new users();
        $users->checkLoginInUrl();
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $this->interface = $_SESSION["user"]["interface"] = $interface = key_exists("interface", $_GET) ? $_GET["interface"] : (key_exists("interface", $_SESSION["user"]) ? $_SESSION["user"]["interface"] : "default");
        $this->interfaceType = $_SESSION["user"]["interfaceType"] = $interfaceType = key_exists("interfacetype", $_GET) ? $_GET["interfacetype"] : (key_exists("interfaceType", $_SESSION["user"]) ? $_SESSION["user"]["interfaceType"] : $this->interfaceType);
            
        require 'models/menuIdToHref.php';
        $drill = new drillDowner();
        $linksMaker = new linksMaker();
        
        $this->action = $this->path =  $_GET["action"];
        $model_path = $menuIdToPath[$_GET["action"]];

        $requireModelPath = key_exists($model_path, $this->redirectModel) ? $this->redirectModel[$model_path] : $model_path;
        if(!file_exists('models/' . $requireModelPath . '.php'))
            throw new Exception("model " . 'models/' . $requireModelPath . '.php' . " is not found");
        require 'models/' . $requireModelPath. '.php';
        
        if($requireModelPath != $model_path){
            preg_match("/\/([^\/]+)$/", $model_path, $filename);
            $newPath = $filename[1];
            $data = new $newPath;
        }
        else
            $data = new gridData();

        preg_match("/\/(\w+)$/", $this->action, $page);
        $this->pathPage = $page = $page[1];

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
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList/" => [
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
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList/" => [
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
                    "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList/" => [
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
                    "EnterpriseASPAR/RMA/RMAHeaderReceiveList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPAR/RMA/RMAHeaderReceivedList/" => [
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
                    "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    /*"EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                        ],*/
                    "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList/" => [
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
                    ],
                    "EnterpriseASPSystem/EDISetup/EDIInvoiceHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPSystem/EDISetup/EDIOrderHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ] ,
                    "EnterpriseASPSystem/EDISetup/EDIReceiptsHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPSystem/EDISetup/EDIPurchaseHeaderList/" => [
                        "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                        "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                    ],
                    "EnterpriseASPSystem/EDISetup/EDIPaymentsHeaderList/" => [
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
                
                $security->setModel($data, $this->item, $this->mode);
                
                $scope = $this;
                $user = $this->user;
                $ascope = json_decode(json_encode($scope), true);

                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'models/menuCategoriesGenerated.php';
                require 'views/gridView.php';
            }
        }
    }
}
?>