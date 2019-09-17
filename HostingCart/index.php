<?php
header("Location: /EnterpriseX/Cart/index.php?config=AppShop" . (count($_GET) ? "&" . implode("&", $_GET) : ""));
?>