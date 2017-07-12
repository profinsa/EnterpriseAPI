<?php 
/*
   print button action
 */
$keyString = $row["CompanyID"] . "__" . $row["DivisionID"] . "__" . $row["DepartmentID"] . "__" . $row["GLTransactionNumber"];
$AccountNumber = $scope->item;
echo "<a href=\"" . $linksMaker->makeEmbeddedviewItemViewLink("GeneralLedger/Ledger/ViewGLAccountTransactions", "GeneralLedger/Ledger/ViewGLAccountTransactions", $keyString, $AccountNumber) ."\" target=\"_blank\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
