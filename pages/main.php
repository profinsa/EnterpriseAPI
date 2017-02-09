<?php
class main{
    public function __construct(){
        /*        $result = mysql_query('SELECT CompanyID from companies') or die('mysql query error: ' . mysql_error());

        while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
            $this->companies[$line["CompanyID"]] = $line["CompanyID"];
        }
        mysql_free_result($result);
        $this->captchaBuilder = new CaptchaBuilder;*/
    }
    
    public function process($app){
       if ($_SERVER['REQUEST_METHOD'] === 'POST') {
       }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
       }
    }
}
$pageScope = new main($_app);
?>