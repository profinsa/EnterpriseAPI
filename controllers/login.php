<?php
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
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $wrong_captcha = false;
            if($_POST["captcha"] != $_SESSION["captcha"])
                $wrong_captcha = true;
            $user = $users->search($_POST["company"], $_POST["name"], $_POST["password"]);

            if(!$wrong_captcha && $user){                 
                $app->renderUi = false;
                $user["language"] = $_POST["language"];
                $_SESSION["user"] = $user;
                http_response_code(200);
                header('Content-Type: application/json');
                echo json_encode(array(
                    "message" =>  "ok"
                ));
            }else{
                $this->captchaBuilder->build();
                $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
                $app->renderUi = false;
                http_response_code(401);
                header('Content-Type: application/json');
                echo json_encode(array(
                    "captcha" =>  $this->captchaBuilder->inline()
                ));
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
            $this->captchaBuilder->build();
            $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
            $translation = new translation($app->db, "english");
            $scope = $this;
            require 'views/login.php';
        }
    }
}
?>