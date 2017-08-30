<?php 
/*
   print button action
 */
// echo json_encode($ascope);
$keyString = $row["CompanyID"] . "__" . $row["DivisionID"] . "__" . $row["DepartmentID"] . "__" . $row["CurrencyID"];
echo "<a href=\"" . $linksMaker->makeEmbeddedviewItemViewLink("SystemSetup/CompanySetup/CurrenciesHistory", "SystemSetup/CompanySetup/Currencies", $keyString, $scope->item)  ."\"><span class=\"grid-action-button glyphicon glyphicon-list-alt\" aria-hidden=\"true\"></span></a>";
?>
