<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a href=\"" . $linksMaker->makeGridItemViewWithBackPath("GeneralLedger/LedgerSetup/LedgerStoredAccounts", $keyString, "GeneralLedger/LedgerSetup/LedgerStoredAccounts", $ascope["item"]) ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
