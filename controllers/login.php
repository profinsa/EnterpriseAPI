<?php
/*
  Name of Page: Login

  Method: This is controller for login page. It contains logic for user verification and captcha generation

  Date created: Nikita Zaharov, 08.02.2017

  Use: controller is used by index.php, load by GET request parameter - page=login.

  The controller is responsible for:
  + loading data models and rendering login page
  + user verification and login on request
  + captcha generating and updating

  Input parameters:
  $app : application instance, object

  Output parameters:
  $scope: object, used by view, most like model
  $translation: model, it is responsible for translation in view

  Called from:
  + index.php

  Calls:
  models/translation.php
  models/users.php
  models/companies.php
  app from index.php

  Last Modified: 15.04.2020
  Last Modified by: Nikita Zaharov
*/

use Gregwar\Captcha\CaptchaBuilder;

require_once 'models/translation.php';
require_once 'models/companies.php';
require_once 'models/users.php';
require_once 'models/interfaces.php';

$GLOBALS["capsule"]->setAsGlobal();

class loginController{
    public $styles = [
        "blue",
        "gray"
    ];

    public $interfaces;
    public $captchaBuilder = false;

    public $user = false;

    //controllers constructor, initialize CaptchaBuilder
    public function __construct(){
        $this->captchaBuilder = new CaptchaBuilder;
        $this->interfaces = new interfaces();
    }

    /*
      entry point of controller. Rendering page, loading models, log in with checking
     */
    public function process($app){
        $user = false;
        $users = new users();
        $config = config();
        if(key_exists("loginform", $_GET))
            $config["loginForm"] = $_GET["loginform"]; 
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {//login request process
            $wrong_captcha = false;
            if(key_exists("captcha", $_POST) && $_POST["captcha"] != $_SESSION["captcha"])
                $wrong_captcha = true;
            if(key_exists("captcha", $_POST)){
                $interface = $_SESSION["user"]["interface"];
                $interfaceType = $_SESSION["user"]["interfaceType"];
            }else{
                $interface = "default";
                $interfaceType = "ltr";
            }
            
            if(($config["loginForm"] == "login" ?
                ($user = $users->search($_POST["company"], $_POST["name"], $_POST["password"], $_POST["division"], $_POST["department"])) &&
               ($user["accesspermissions"]["RestrictSecurityIP"] ? $user["accesspermissions"]["IPAddress"] == $_SERVER['REMOTE_ADDR'] : true):
               $user = $users->searchSimple($_POST["name"], $_POST["password"])) &&
               !$wrong_captcha){
                //access granted, captcha is matched
                $companies = [];
                $app->renderUi = false;
                if($config["loginForm"] == "login"){
                    $user["language"] = $_POST["language"];
                    $_SESSION["user"] = $user;
                }else {
                    $companies = $user;
                    //    $user["language"] = "English";
                }

                $_SESSION["user"]["interface"] = $interface;
                $_SESSION["user"]["interfaceType"] = $interfaceType;
                header('Content-Type: application/json');
                echo json_encode(array(
                    "session_id" => session_id(),
                    "companies" => $companies,
					"user" => $_SESSION["user"],
                    "message" =>  "ok"
                ), JSON_PRETTY_PRINT);
            }else{//something wrong: captcha, company, username, password. Generating new captcha
                $this->captchaBuilder->build();
                $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
                $app->renderUi = false;
                http_response_code(401);
                header('Content-Type: application/json');
                $response = array(
                    "captcha" =>  $this->captchaBuilder->inline()
                );
                if($wrong_captcha)
                    $response["wrong_captcha"] = true;
                if(!$user)
                    $response["wrong_user"] = true;

                echo json_encode($response);
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET'){ //json with info login form
            $this->captchaBuilder->build();
			
			$result = [
				"captchaNumber" => $this->captchaBuilder->getPhrase(),
                 "captcha" =>  $this->captchaBuilder->inline(),
				"language" => "English",
			    "translation" => new translation("English"),
				"companies" => new companies()
			];
           
			echo json_encode($result);
        }
    }
}
?>