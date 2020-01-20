<?php
$record = [
    "timestamp" => date('U = Y-m-d H:i:s'),
    "query" => $_SERVER["REQUEST_URI"]
];

if(!key_exists("page", $_GET)){
    file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
    echo "Hello dear friend";
    exit;
};
if(strlen($_GET["page"]) > 50){
    file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
    echo "Hello dear friend";
    exit;
}
if(!file_exists('controllers/' . $_GET["page"] . '.php')){
    file_put_contents(__DIR__ . "/malicious.log", json_encode($record) . ",\n", FILE_APPEND);
    header("Location: index.php?page=login");
    exit;
}

//file_put_contents(__DIR__ . "/error.log", json_encode($record) . ",\n", FILE_APPEND);
//exit;
?>