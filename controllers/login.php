<?php
/*
Name of Page: Login

Method: This is controller for login page. It contains logic for user verification and captcha generation

Date created: Nikita Zaharov, 08.02.2016

Use: controller is used by index.php, load by GET request parameter - page=login.

The controller is responsible for:
+ loading data models and rendering login page
+ user verification and login on request
+ captcha generating and updating

Input parameters:
$db: database instance
$app : application instance, object

Output parameters:
$scope: object, used by view, most like model
$translation: model, it is responsible for translation in view

Called from:
+ index.php

Calls:
models/translation.php
models/users.php
app from index.php

Last Modified: 10.02.2016
Last Modified by: Nikita Zaharov
*/

use Gregwar\Captcha\CaptchaBuilder;

require 'models/translation.php';
require 'models/users.php';

class controller{
    public $companies = [];

    public $styles = [
        "blue",
        "gray"
    ];

    public $captchaBuilder = false;

    public $user = false;
    
    public function __construct($db){
        $result = mysqli_query($db, 'SELECT CompanyID from companies') or die('mysql query error: ' . mysqli_error($db));

        while ($line = mysqli_fetch_assoc($result)) {
            $this->companies[$line["CompanyID"]] = $line["CompanyID"];
        }
        mysqli_free_result($result);
        $this->captchaBuilder = new CaptchaBuilder;
    }
    
    public function process($app){
        $users = new users($app->db);
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {//login request process
            $wrong_captcha = false;
            if($_POST["captcha"] != $_SESSION["captcha"])
                $wrong_captcha = true;

            if(!$wrong_captcha && $user = $users->search($_POST["company"], $_POST["name"], $_POST["password"])){//access granted, captcha is matched                 
                $app->renderUi = false;
                $user["language"] = $_POST["language"];
                $_SESSION["user"] = $user;
                http_response_code(200);
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
                echo json_encode(array(
                    "captcha" =>  $this->captchaBuilder->inline()
                ));
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') { //rendering login page
            $this->captchaBuilder->build();
            $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
            $translation = new translation($app->db, "english");
            $scope = $this;
            require 'views/login.php';
        }
    }
}
?>