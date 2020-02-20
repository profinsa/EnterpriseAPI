<?php
date_default_timezone_set('America/Los_Angeles');
$paramsToCheck = [
    "item",
    "action",
    "mode",
    "category",
    "config",
    "interface",
    "getreport",
    "screen"
];

$record = [
    "timestamp" => date('U = Y-m-d H:i:s'),
    "query" => $_SERVER["REQUEST_URI"]
];

if(key_exists("page", $_GET)){
    if(strlen($_GET["page"]) > 50){
        file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
        header("Location: index.php?page=login");
        exit;
    }
    if(!file_exists('controllers/' . $_GET["page"] . '.php')){
        file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
        header("Location: index.php?page=login");
        exit;
    }

    $pattern = "/[\'\&]/";
    foreach($paramsToCheck as $value){
        if(key_exists($value, $_GET) && preg_match($pattern, $_GET[$value], $matches)){
            file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
            header("Location: index.php?page=login");
            exit;
        }
    }
}
?>
