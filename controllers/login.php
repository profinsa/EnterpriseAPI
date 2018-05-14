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

Last Modified: 14.05.2018
Last Modified by: Nikita Zaharov
*/

use Gregwar\Captcha\CaptchaBuilder;

require 'models/translation.php';
require 'models/companies.php';
require 'models/users.php';

$GLOBALS["capsule"]->setAsGlobal();

class controller{
    public $styles = [
        "blue",
        "gray"
    ];

    public $captchaBuilder = false;

    public $user = false;

    //controllers constructor, initialize CaptchaBuilder
    public function __construct(){
        $this->captchaBuilder = new CaptchaBuilder;
    }

    /*
      entry point of controller. Rendering page, loading models, log in with checking
     */
    public function process($app){
        $user = false;
        $users = new users();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {//login request process
            $wrong_captcha = false;
            if($_POST["captcha"] != $_SESSION["captcha"])
                $wrong_captcha = true;

            if(($user = $users->search($_POST["company"], $_POST["name"], $_POST["password"], $_POST["division"], $_POST["department"])) &&
               ($user["accesspermissions"]["RestrictSecurityIP"] ? $user["accesspermissions"]["IPAddress"] == $_SERVER['REMOTE_ADDR'] : true) &&
               !$wrong_captcha){//access granted, captcha is matched                 
                $app->renderUi = false;
                $user["language"] = $_POST["language"];
                $_SESSION["user"] = $user;
                header('Content-Type: application/json');
                echo json_encode(array(
                    "message" =>  "ok"
                ));
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
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') { //rendering login page
            $this->captchaBuilder->build();
            $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
            if(!key_exists("user", $_SESSION) || !$_SESSION["user"])
                $_SESSION["user"] = ["language" => "English"];

            $this->user = $_SESSION["user"];
            $translation = new translation( $_SESSION["user"]["language"]);
            $companies = new companies();
            $scope = $this;

            require 'views/login.php';
        }
    }
}
?>