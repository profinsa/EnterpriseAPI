<?php 
echo "<a href=\"" . $linksMaker->makeGridLinkWithItem("AccountsPayable/ReturntoVendorScreens/ReturnCashReceiptInvoiceList", $row["CustomerID"]) . "&ReceiptID={$row["ReceiptID"]}\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
