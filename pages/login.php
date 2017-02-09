<?php
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
    public function __construct(){
        $result = mysql_query('SELECT CompanyID from companies') or die('mysql query error: ' . mysql_error());

        while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
            $this->companies[$line["CompanyID"]] = $line["CompanyID"];
        }
        mysql_free_result($result);
    }
}
$pageScope = new login;
?>