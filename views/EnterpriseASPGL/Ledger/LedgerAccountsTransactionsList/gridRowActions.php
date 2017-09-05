<?php 
/*
   print button action
 */
// echo json_encode($row);
// $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $row["GLTransactionNumber"];
echo "<a href=\"" . $linksMaker->makeEmbeddedviewItemViewLink("GeneralLedger/Ledger/ViewGLAccountTransactions", "GeneralLedger/Ledger/ViewGLAccountsTransactions", $keyString, $ascope["item"]) ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
