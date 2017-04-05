<?php
//require
echo json_encode($data->CompanyAccountsStatus());
echo "<br/>";
echo json_encode($data->CollectionAlerts());
echo "<br/>";
echo json_encode($data->CompanyDailyActivity());
echo "<br/>";
echo json_encode($data->CompanyIncomeStatement());
echo "<br/>";
echo json_encode($data->CompanySystemWideMessage());
echo "<br/>";
echo json_encode($data->InventoryLowStockAlert());
echo "<br/>";
echo json_encode($data->TopOrdersReceipts());
?>
