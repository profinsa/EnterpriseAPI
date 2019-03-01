<?php 
echo "<a href=\"" . $linksMaker->makeGridLinkWithItem("AccountsReceivable/CashReceiptsProcessing/CashReceiptInvoiceList", $row["CustomerID"]) . "&ReceiptID={$row["ReceiptID"]}\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
