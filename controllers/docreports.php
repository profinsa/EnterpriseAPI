<?php
/*
  Name of Page: docreports controller

  Method: controller for docreports pages

  Date created: Nikita Zaharov, 03.05.2017

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
  models/autoreports.php
  app from index.php

  Last Modified: 01.09.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $path;

    public function process($app){
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $type = $_GET["type"];
        $id = $_GET["id"];
        require "models/reports/doc/" . $_GET["type"] .".php";
        
        //$_perm = new permissionsByFile();
        //preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        // if(key_exists($filename[1], $_perm->permissions))
        //  $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
        // else
        //  return response('permissions not found', 500)->header('Content-Type', 'text/plain');

        $this->user = $_SESSION["user"];
               
        $data = new docReportsData($id);
        $invoiceTemplateTypes = [
            "invoice" => "invoice",
            "invoicehistory" => "invoice",
            "quote" => "invoice",
            "order" => "invoice",
            "orderhistory" => "invoice",
            "serviceorder" => "invoice",
            "serviceorderhistory" => "invoice",
            "serviceinvoice" => "invoice",
            "serviceinvoicehistory" => "invoice",
            "creditmemo" => "invoice",
            "creditmemohistory" => "invoice",
            "debitmemo" => "invoice",
            "debitmemohistory" => "invoice",
            "rmaorder" => "invoice",
            "purchaseorder" => "invoice",
            "returninvoice" => "invoice",
            "receiving" => "invoice",
            "customertransactions" => "customertransactions",
            "customerstatements" => "customerstatements",
            "payment" => "payment"
            
        ];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            if(key_exists("title", $_GET))
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Report: " ) . $translation->translateLabel($_GET["title"]);
            
               $scope = $this;

               $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
               $content = $invoiceTemplateTypes[$type] . ".php";
               require 'views/reports/doc/container.php';
        }
    }
}
?>