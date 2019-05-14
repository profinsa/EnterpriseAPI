<?php 
echo "<a href=\"" . $linksMaker->makeGridLinkWithItem("AccountsPayable/DebitMemos/DebitMemoApplyToPayments", $row["VendorID"]) ."&PurchaseNumber={$row["PurchaseNumber"]}\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
