<?php
$params = [];
if(count($_GET))
    foreach($_GET as $key=>$value)
        $params[] = "$key=$value";
header("Location: /EnterpriseX/Cart/index.php?config=AppShop" . (count($_GET) ? "&" . implode("&", $params) : ""));
?>