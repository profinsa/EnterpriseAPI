<?php
require "../models/menuIdToHref.php";

$list = [];
foreach($menuIdToPath as $key)
    $list[] = $key;

echo count($list);
file_put_contents("../EnterpriseScreens.json", json_encode($list, JSON_PRETTY_PRINT));
?>