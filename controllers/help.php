<?php
/*
  Name of Page: Help System controller

  Method: controller for Help System pages

  Date created: Nikita Zaharov, 16.07.2019

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

  Last Modified: 14.04.2020
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
//require 'models/users.php';
require 'models/linksMaker.php';
require 'models/interfaces.php';
require 'models/EnterpriseASPHelpDesk/CRM/LeadInformationList.php';

use Gregwar\Captcha\CaptchaBuilder;

class helpController{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $config;
    public $path;
    public $captchaBuilder = false;
    public $interfaces;

    public function __construct(){
        $this->captchaBuilder = new CaptchaBuilder;
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

        $id = key_exists("url", $_GET) ? $_GET["url"] : "";
        $this->config = $config = config();
        $this->user = $config["user"];
        $this->user["EmployeeID"] = "Help";
        SESSION::set("user", $this->user);          
        $scope = $GLOBALS["scope"] = $this;
        require "models/help/index.php";
        
        //$this->user = $_SESSION["user"];
               
        $data = new helpData($id);
        $linksMaker = new linksMaker();
        $ascope = json_decode(json_encode($this), true);
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("method", $_GET)){
                $leadInformation = new LeadInformationList();
                switch($_GET["method"]){
                case "newsletterSubscribe" :
                    $result = [];
                    foreach($leadInformation->editCategories as $key=>$value)
                        $result = array_merge($result, $leadInformation->getNewItem("", $key));
                    $result["LeadID"] = $_POST["EMAIL"];
                    $leadInformation->insertItemLocal($result, true);
                    echo "<html><body>Thanks for your interest to our software!<br>Newletter we will email you when updates are made to the software!</body></html>";
                    break;
                case "checkCaptcha" :
                    $response = [];
                    if($_POST["captcha"] != $_SESSION["captcha"]){
                        $response["captchaText"] = $this->captchaBuilder->getPhrase();
                        $this->captchaBuilder->build();
                        $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
                        $response["captcha"] =  $this->captchaBuilder->inline();
                        $response["wrong_captcha"] = true;
                        http_response_code(401);
                    }
                
                    header('Content-Type: application/json');
                    echo json_encode($response);

                    break;
                default:
                    echo "ok";
                }
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
            if(key_exists('testmail', $_GET)){
                echo "ok";
                //                session_write_close(); //close the session
                //fastcgi_finish_request(); //this returns 200 to the user, and processing continues
                $mailer = new mailer();
        
                $mailer->send([
                    "subject" => "test",
                    "body" => "Test message",
                    "email" => "ix@2du.ru"//$config["mailFrom"]
                ]);
            }else{
                $this->captchaBuilder->build();
                $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
                $translation = new translation($this->user["language"]);
                if(key_exists("title", $_GET))
                    $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Help System" );
            
                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'views/help/index.php';
            }
        }
    }
}
?>