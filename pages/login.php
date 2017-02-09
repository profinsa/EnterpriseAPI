<?php
use Gregwar\Captcha\CaptchaBuilder;

class login{
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
           $app->renderUi = false;
           foreach($_POST as $key => $value)
               echo $key . " is " . $value;
           
           echo "captcha is " . $_SESSION["captcha"];
       }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
           $this->captchaBuilder->build();
           $_SESSION['captcha'] = $this->captchaBuilder->getPhrase();
       }
    }
}
$pageScope = new login($_app);
?>