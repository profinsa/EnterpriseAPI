<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a href=\"" . $linksMaker->makeGridLinkWithItem("GeneralLedger/LedgerSetup/LedgerStoredAccounts", $row["Industry"] . "__" . $row["ChartType"] . "__" . $row["ChartDescription"]) ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";

echo "<a onclick=\"Copy('" . $row["Industry"] . "','" . $row["ChartType"] . "','" . $row["GLAccountNumber"] . "')\" data-toggle=\"tooltip\" title=\"Copy\"><span class=\"grid-action-button glyphicon glyphicon-copy\" aria-hidden=\"true\"></span></a>";
//if($security->isAdmin() || $security->isGLAdmin())
    echo "<a onclick=\"Load('" . $row["Industry"] . "','" . $row["ChartType"] . "','" . $row["GLAccountNumber"] . "')\" data-toggle=\"tooltip\" title=\"Load\"><span class=\"grid-action-button glyphicon glyphicon-open\" aria-hidden=\"true\"></span></a>";
?>