<?php
use Gregwar\Captcha\CaptchaBuilder;

class login{
    protected function user_search($company, $name, $password){
        $result = mysql_query("SELECT * from payrollemployees WHERE CompanyID='" . $company . "' AND EmployeeUserName='". $name ."' AND EmployeePassword='" . $password . "'") or die('mysql query error: ' . mysql_error());

        if(!($ret = mysql_fetch_array($result, MYSQL_ASSOC)))
            $ret = false;

        mysql_free_result($result);
        
        return $ret;
    }

    protected function user_get_permissions($name){
    }

    protected function user_log($name){
    }
    
    public $companies = [
    ];
    public $languages = [
        "Arabic",
        "ChineseSimple",
        "ChineseTrad",
        "Dutch",
        "English",
        "French",
        "Fund",
        "German",
        "Hindi",
        "Italian",
        "Japanese",
        "Korean",
        "Portuguese",
        "Russian",
        "Spanish",
        "Swedish",
        "Thai"
    ];
    public $styles = [
        "blue",
        "gray"
    ];

    public $captchaBuilder = false;

    public $user = false;
    
    public function __construct(){
        $result = mysql_query('SELECT CompanyID from companies') or die('mysql query error: ' . mysql_error());

        while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
            $this->companies[$line["CompanyID"]] = $line["CompanyID"];
        }
        mysql_free_result($result);
        $this->captchaBuilder = new CaptchaBuilder;
    }
    
    public function process($app){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $wrong_captcha = false;
            if($_POST["captcha"] != $_SESSION["captcha"])
                $wrong_captcha = true;
            $user = $this->user_search($_POST["company"], $_POST["name"], $_POST["password"]);

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
        }
    }
}
$pageScope = new login();
?>