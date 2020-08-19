<?php
/*
  Name of Page: API controller

  Method: controller for API

  Date created: Nikita Zaharov, 17.10.2019

  Use: The controller is responsible for:
  - page rendering using view

  Input parameters:
  $app : application instance, object

  Output parameters:
  $scope: object, used by view, most like model
  $translation: model, it is responsible for translation in view

  Called from:
  + index.php

  Calls:
  models/translation.php
  models/help/*
  app from index.php

  Last Modified: 19.08.2020
  Last Modified by: Nikita Zaharov
*/

require_once 'models/translation.php';
require_once 'models/security.php';
require_once 'models/permissionsGenerated.php';
//require 'models/users.php';
require_once 'models/linksMaker.php';
require_once 'models/interfaces.php';

/*! \mainpage Enterprirse Universal API Documentaion
 *
 * \section intro_sec Introduction
 *
 * - For ALL API requests we using GET and POST HTTP methods.
 * - For body we using JSON encoding. 
 * - You can use any language which can send the GET and POST HTTP requests.
 * - Any request to API start from base of URL - /EnterpriseUniversalAPI/index.php?page=api&module=modulename
 * - EnterpriseUniversalAPI can be changed to any other name, if you'll change folder of project.
 * - modulename is name of module for using. For example, we have following modules:
 *   + auth
 *     for login, session control etc
 *   + forms
 *     for working with all records in system. It's all CRUD operations and actions
 *   + language
 *     for changing language
 *   + etc

 * Each module can have own paths(for some submodules) and actions.
 * A common API using scenario:
 * - request for login and getting session_id
 * - request for
 *   + list records
 *   + get record
 *   + insert record
 *   + update record
 *   + delete record
 *   + execute some action(in most cases Action is sql stored procedure or analog, implemented inside API server)
 *     
 * Example:
 * - request for login and getting session_id
 *   +Request URL: /EnterpriseUniversalAPI/index.php?page=api&module=auth&action=login
 *   +Request Method: POST
 *   + Request JSON:
 *     {
 *       CompanyID : "DINOS",
 *       DivisionID : "DEFAULT",
 *       DepartmentID : "DEFAULT",
 *       EmployeeID : "Demo",
 *       EmployeePassword : "Demo",
 *       language : "english"
 *    }
 *   + Response JSON:
 *     {
 *       session_id : "session number"
 *     }
 *
 *   or
 *   401 status if credentials wrong
 * 
 * - request to get list of Orders. If request success, then data will be array of the order records.
 *   + Request URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=list&session_id=session_number
 *   + Request Method: GET
 *   + JSON Response:
 *     [ ... ] - array of order objects

 *   401 status if credentials wrong
 *
 * \section modules_sec Modules and their API
 * - auth
 *   Module exports API for working with authentification and session management.
 *   For now it expose only "login" action for login and getting session_id which you need to use in any other API request.
 *   + Method: POST
 *   + URL: /EnterpriseUniversalAPI/index.php?page=api&module=auth&action=login'
 *   + example: examples/get_list.html and other examples
 * - forms
 *  Module exports API for
 *  - list
 *    Method: GET
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=list&session_id=sessionId
 *    example: examples/list.html
 *  - get empty record(record filled by default values for filling with values and inserting into system)
 *    Method: GET
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=emptyRecord&session_id=sessionId
 *    example: examples/create.html
 *  - get record
 *    Method: GET
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=get&id=DINOS__DEFAULT__DEFAULT__2110&session_id=sessionId
 *    example: examples/get_and_upate.html
 *  - create record
 *    Method: POST
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=create&session_id=sessionId
 *    example: examples/create.html
 *  - update record
 *    Method: POST
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=update&id=DINOS__DEFAULT__DEFAULT__2110&session_id=${session.session_id}
 *    example: examples/get_and_update.html
 *  - delete record
 *    Method: GET
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=delete&id=DINOS__DEFAULT__DEFAULT__2110&session_id=${session.session_id}
 *  - procedure
 *    execute some action(in most cases Action is sql stored procedure or analog, implemented inside API server)
 *    METHOD: POST
 *    URL: /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/OrderProcessing/ViewOrders&action=procedure&procedure=Post&session_id=${session.session_id}
 *    
 *
 *  Most actions has following parameters:
 *  - session_id
 *    session_id which was getted by login request
 *  - path
 *    it's path to submodule which uses for actions. For example: AccountsReceivable/OrderProcessing/ViewOrders is path for working with Orders
 *    There is many paths in system and we working on documentation about it. For now you can use these paths:
 *    + AccountsReceivable/OrderScreens/ViewOrders
 *      for Orders
 *    + AccountsReceivable/OrderScreens/ViewInvoices
 *      for Invoices
 *    + AccountsReceivable/ServiceScreens/ViewServiceOrders
 *      for Service Orders
 *    + AccountsReceivable/ServiceScreens/ViewServiceInvoices
 *      for Service Invoices
 *    + AccountsReceivable/CreditMemos/ViewCreditMemos 
 *      for Credit Memos
 *    + AccountsReceivable/RMAProcessing/ViewRMA
 *      for RMA
 *    + AccountsReceivable/CashReceiptsProcessing/ViewCashReceipts
 *      for Cash Receipts
 *    + AccountsReceivable/Customers/ViewCustomers
 *      for Customers
 *    + AccountsPayable/Vendors/ViewVendors
 *      for Vendors
 *    + AccountsPayable/PurchaseScreens/ViewPurchases
 *      for Purchases
 *    + AccountsPayable/VoucherScreens/ViewVouchers
 *      for Payments
 *    + AccountsPayable/DebitMemos/ViewDebitMemos
 *      for Debit Memo
 *    + AccountsPayable/ReturntoVendorProcessing/ViewReturns
 *      for Returns
 *    + GeneralLedger/Ledger/ViewGLTransactions
 *      for GL Transactions
 *    + GeneralLedger/Ledger/ViewChartofAccounts
 *      for Chart Of Accounts
 *    and many other paths. We working on full list and explanation about each path. Now you can get full list of path in models/menuIdToHref.php. It's a just array of values.
 *  - id
 *    it's "__" separated key values of records. For example: order has four key values: CompanyID, DivisionID, DepartmentID, OrderNumber and id is DINOS__DEFAULT__DEFAULT__2110
 *    we working on getting description request to know which submodule which key expected.
 * - dictionaries
 *   + Method: GET
 *   + URL: /EnterpriseUniversalAPI/index.php?page=api&module=dictionaries&list=OrderTypes,CurrencySymbol,Projects,TaxGroups
 *     - Dictionaries list is comma separated.
 *     - Response where keys are Dictionary names but values are dictionaries itself.
 *     - Dictionaries used for getting some common lists or values from system which you need to fill records
 *     - For now, we implemented following dictionaries:
 *       + "Items",
 *       + "Customers",
 *       + "Vendors",
 *       + "CompaniesWorkFlowTypes",
 *       + "InventoryFamilies",
 *       + "AdjustmentTypes",
 *       + "ReceiptClasses",
 *       + "ReceiptTypes",
 *       + "ExpenseReportTypes",
 *       + "ExpenseReportReasons",
 *       + "WorkOrderTypes",
 *       + "WorkOrderProgress",
 *       + "WorkOrderPriority",
 *       + "WorkOrderStatus",
 *       + "Companies",
 *       + "Divisions",
 *       + "Departments",
 *       + "TaxGroups",
 *       + "CreditCardTypes",
 *       + "PaymentMethods",
 *       + "PaymentTypes",
 *       + "ShipMethods",
 *       + "Terms",
 *       + "PayrollEmployees",
 *       + "Warehouses",
 *       + "WarehouseBinTypes",
 *       + "WarehouseBinZones",
 *       + "WarehouseBins",
 *       + "ARTransactionTypes",
 *       + "OrderTypes",
 *       + "LedgerBalanceTypes",
 *       + "LedgerBudgetId",
 *       + "LedgerAccountTypes",
 *       + "TransactionAccounts",
 *       + "ProjectTypes",
 *       + "Projects",
 *       + "ContactRegions",
 *       + "ContactTypes",
 *       + "LedgerTransactionTypes",
 *       + "BankTransactionTypes",
 *       + "GLControlNumbers",
 *       + "Accounts",
 *       + "CurrencyExchangeRates",
 *       + "CurrencyTypes",
 *       + "ContactSourceIds",
 *       + "ContactIndustryIds",
 *       + "LeadIds",
 *       + "LeadTypes",
 *       + "CommentTypes",
 *       + "EDIDirectionTypeIDs",
 *       + "EDIDocumentTypeIDs",
 *       + "InventoryAdjustmentTypes",
 *       + "InventoryItemTypes",
 *       + "InventoryCategories",
 *       + "InventoryPricingMethods",
 *       + "CustomerAccountStatuses",
 *       + "Employees",
 *       + "VendorAccountStatuses",
 *       + "CustomerTypes",
 *       + "VendorTypes",
 *       + "InventoryAssemblies",
 *       + "InventoryPricingCodes",
 *       + "PayrollEmployeesTaskTypes",
 *       + "HelpDocumentTopics",
 *       + "HelpDocumentModules",
 *       + "HelpStatuses",
 *       + "CurrentCompany",
 *       + "CurrencySymbol"
 *       + This list of Dictionaries will be extended in following together with documentaion.
 *   + More complicated example how to use dictionaries and why you can see in examples/create_complicated.html
 * \section customer_sec Customer API
 * For Create, Get and Update Customer Information you need to use Forms API.
 *
 * To get Customer Information you need to do following steps:
 * - /EnterpriseUniversalAPI/index.php?page=api&module=auth&action=login 
 *   To get session_id
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/Customers/ViewCustomers&action=list&session_id=session_number
 *   To get list of Customers in Database. Then choose CustomerID which you need and
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/Customers/ViewCustomers&action=get&session_id=session_number
 *   to get Customer Infromation
 *
 *  <a href="/EnterpriseUniversalAPI/examples/Customer/read.html">Example how to get Customers List and read Customer Information</a>
 *
 * To create Customer you need to do following steps:
 * - /EnterpriseUniversalAPI/index.php?page=api&module=auth&action=login 
 *   To get session_id
 * - /EnterpriseUniversalAPI/index.php?page=api&module=dictionaries&list=comma,separated,list,of,dictionaries&session_id=session_number
 *   To get values of choosen dictionaries
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/Customers/ViewCustomers&action=emptyRecord&session_id=session_number
 *   To get empty record with default values
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=AccountsReceivable/Customers/ViewCustomers&action=create&session_id=session_number
 *   To create Customer
 *
 *  <a href="/EnterpriseUniversalAPI/examples/Customer/create.html">Example how to create new Customer and the get Customers List</a>
 * \section inventory Inventory API
 * For getting Inventory Items and Inventory By Warehouse you need to use Forms API.
 *
 * To get Inventory Item you need to do following steps:
 * - /EnterpriseUniversalAPI/index.php?page=api&module=auth&action=login 
 *   To get session_id
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=Inventory/ItemsStock/ViewInventoryItems&action=list&session_id=session_number
 *   To get list of Items in Database. Then choose ItemID which you need and
 * - /EnterpriseUniversalAPI/index.php?page=api&module=forms&path=Inventory/ItemsStock/ViewInventoryItems&action=get&session_id=session_number
 *   to get Inventory Item
 *
 * To get Inventory By Warehouse you need to do same steps as for Inventory Item, but using path=Inventory/ItemsStock/ViewInventoryOnHand
 * Examples how to get Inventory Items and Inventory By Warehouse:
 * - <a href="/EnterpriseUniversalAPI/examples/Inventory/InventoryItems.html">Inventory Items</a>
 * - <a href="/EnterpriseUniversalAPI/examples/Inventory/InventoryOnHand.html">Inventory By Warehouse</a>
 * \section install_sec Installation
 *  + install PHP Tools over Visual Studio -> Menu -> Manage Extensions
 *  + install MS Web Platform installer(tool for installtion Web Platform components like PHP, Microsoft Drivers for PHP for SQL server etc)
 *  + install PHP, Microsoft Drivers for PHP for SQL Server on IISExpress, Microsoft Drivers for PHP for SQL Server on IIS. 
 *    ALl this components must have same version. You can install these components with MS Web Platform installer
 *  + unpack in some place which accesable for webserver, for example it may be C:\inetpub\EnterpriseUniversalAPI
 *    That means that address in browser will be something like that: localhost\EnterpriseUniversalAPI
 *  + restore Enterprise database from Enterprise Cloud version
 *  + change rights to EnterpriseUniversalAPI and Windows/Temp - allow read and write to Users and IIS Users
 *
 *  Then you can folow two different ways:
 *  + start project from Visual Studio
 *    - open solution in Visual Studio
 *    - run
 *  + start project from IIS(this is Windows Server way)
 *    - just open localhost/EnterpriseUniversalAPI/examples/list.html in browser
 */

/**
 * The main API controller, every REST API request is processed by this controller.
 *
 * Main purpose this controller - pre-processing REST requests and sending they to controllers which will do work by own
 * specialization. Something like internal router which pre-process requests bodies before send it to spezialized controllers. 
 * 
 */
class apiController{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $config;
    public $path;
    public $interfaces;
    public $dictionaries = [
        "CompaniesWorkFlowTypes",
        "InventoryFamilies",
        "AdjustmentTypes",
        "ReceiptClasses",
        "ReceiptTypes",
        "ExpenseReportTypes",
        "ExpenseReportReasons",
        "WorkOrderTypes",
        "WorkOrderProgress",
        "WorkOrderPriority",
        "WorkOrderStatus",
        "Companies",
        "Divisions",
        "Departments",
        "TaxGroups",
        "CreditCardTypes",
        "PaymentMethods",
        "PaymentTypes",
        "ShipMethods",
        "Terms",
        "PayrollEmployees",
        "Warehouses",
        "WarehouseBinTypes",
        "WarehouseBinZones",
        "WarehouseBins",
        "ARTransactionTypes",
        "OrderTypes",
        "LedgerBalanceTypes",
        "LedgerBudgetId",
        "LedgerAccountTypes",
        "TransactionAccounts",
        "ProjectTypes",
        "Projects",
        "ContactRegions",
        "ContactTypes",
        "LedgerTransactionTypes",
        "BankTransactionTypes",
        "GLControlNumbers",
        "Accounts",
        "CurrencyExchangeRates",
        "CurrencyTypes",
        "ContactSourceIds",
        "ContactIndustryIds",
        "LeadIds",
        "LeadTypes",
        "CommentTypes",
        "EDIDirectionTypeIDs",
        "EDIDocumentTypeIDs",
        "InventoryAdjustmentTypes",
        "InventoryItemTypes",
        "InventoryCategories",
        "InventoryPricingMethods",
        "CustomerAccountStatuses",
        "Employees",
        "VendorAccountStatuses",
        "CustomerTypes",
        "VendorTypes",
        "InventoryAssemblies",
        "InventoryPricingCodes",
        "PayrollEmployeesTaskTypes",
        "HelpDocumentTopics",
        "HelpDocumentModules",
        "HelpStatuses",
        "CurrentCompany",
        "CurrencySymbol"
    ];

    public function __construct(){
        $this->interfaces = new interfaces();
    }
    
    public function process($app){
        /*$users = new users();
        $users->checkLoginInUrl();
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
            }*/
        if(key_exists("module", $_GET)){
            $module = $_GET["module"]; 
            switch($_GET["module"]){
            case "auth":
                $_GET["module"] = "login";
                break;
            case "forms":
                $_GET["module"] = "grid";
                break;
            case "dictionaries":
                $_GET["module"] = "grid";
                break;
            }
            require 'controllers/' . $_GET["module"] . '.php';
            $controllerName = $_GET["module"] . "Controller";
            $app->controller = new $controllerName();
            header('Content-Type: application/json');
            if($_SERVER['REQUEST_METHOD'] === 'POST') {
                //FIXME we need list of exceptions procedures which already uses JSON
                $postData = file_get_contents("php://input");
                $_POST = $data = json_decode($postData, true);

                switch($_GET["module"]){
                case "login" :
                    switch($_GET["action"]){
                    case "login":
                        $_POST["company"] = $_POST["CompanyID"];
                        $_POST["division"] = $_POST["DivisionID"];
                        $_POST["department"] = $_POST["DepartmentID"];
                        $_POST["name"] = $_POST["EmployeeID"];
                        $_POST["password"] = $_POST["EmployeePassword"];
                        break;
                    }
                    break;
                case "grid" :
                    switch($_GET["action"]){
                    case "create":
                        $_GET["procedure"] = "insertItemRemote";
                        break;
                    case "createMany":
                        $_GET["procedure"] = "insertItemsRemote";
                        break;
                    case "update":
                        $_POST["id"] = $_GET["id"];
                        $_POST["type"] = false;
                        $_GET["procedure"] = "updateItemRemote";
                        break;
                    case "procedure":
                        break;
                    }
                    $_GET["action"] = $_GET["path"];
                    
                    break;
                }
                $app->controller->process($app);
            }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
                if($module == "dictionaries"){
                    $_GET["procedure"] = "getDictionaries";
                    $_GET["action"] = "AccountsReceivable/OrderScreens/ViewOrders";
                }else{
                    switch($_GET["module"]){
                    case "grid" :
                        switch($_GET["action"]){
                        case "list" :
                            $_GET["procedure"] = "getPageRemote";
                            break;
                        case "get" :
                            $_GET["procedure"] = "getEditItemAllRemote";
                            break;
                        case "emptyRecord":
                            $_POST["id"] = "";
                            $_GET["procedure"] = "getNewItemAllRemote";
                            break;
                        case "delete":
                            $_GET["procedure"] = "deleteItem";
                            break;
                        }
                        $_GET["action"] = $_GET["path"];
                    
                        break;
                    }
                }
                $app->controller->process($app);
            }
        }else{
            $id = key_exists("url", $_GET) ? $_GET["url"] : "";
            $this->config = $config = config();
            $this->user = $config["user"];
            $this->user["EmployeeID"] = "Help";
            SESSION::set("user", $this->user);
            $scope = $GLOBALS["scope"] = $this;
        
            //$this->user = $_SESSION["user"];
               
            $linksMaker = new linksMaker();
            $ascope = json_decode(json_encode($this), true);
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                if(key_exists("method", $_GET)){
                    require_once 'models/EnterpriseASPHelpDesk/CRM/LeadInformationList.php';
                    $leadInformation = new LeadInformationList();
                    switch($_GET["method"]){
                    case "addLead" :
                        $result = [];
                        foreach($leadInformation->editCategories as $key=>$value)
                            $result = array_merge($result, $leadInformation->getNewItem("", $key));
                        $result["LeadID"] = $_POST["EMAIL"];
                        $leadInformation->insertItemLocal($result, true);
                        echo "<html><body>Thanks for your interest to our software!<br>Newletter we will email you when updates are made to the software!</body></html>";
                        break;
                    default:
                        echo "ok";
                    }
                }
            }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
                $translation = new translation($this->user["language"]);            
                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'views/api/index.js';
            }
        }
    }
}
?>