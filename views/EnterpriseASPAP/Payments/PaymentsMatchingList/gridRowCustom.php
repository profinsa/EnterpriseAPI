<?php
$hpurchaseNumber = renderGridValue($scope, $data, $drill, $row, "PurchaseNumber", $row["PurchaseNumber"]);
$hvendorID = renderGridValue($scope, $data, $drill, $row, "VendorID", $row["VendorID"]);
$htotal = renderGridValue($scope, $data, $drill, $row, "Total", $row["Total"]);
$hreceivingNumber = renderGridValue($scope, $data, $drill, $row, "RecivingNumber", $row["RecivingNumber"]);
$hamountPaid = renderGridValue($scope, $data, $drill, $row, "AmountPaid", $row["AmountPaid"]);
$hpaymentID = renderGridValue($scope, $data, $drill, $row, "PaymentID", $row["PaymentID"]);
$hinvoiceNumber = renderGridValue($scope, $data, $drill, $row, "InvoiceNumber", $row["InvoiceNumber"]);
$hamount = renderGridValue($scope, $data, $drill, $row, "Amount", $row["Amount"]);
if($row["RecivingNumber"]){
    $docreportsReceiving = <<<EOF
    <a href="$public_prefix/docreports/receiving/{$row["RecivingNumber"]}" target="_blank">
      <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
    </a>
EOF;
}
else
    $docreportsReceiving = "";
     
$_html = <<<EOF
<tr>
  <td>$hpurchaseNumber</td>
  <td>
    <a href=$public_prefix/docreports/purchaseorder/{$row["PurchaseNumber"]} target="_blank">
      <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
    </a>
  </td>
  <td>$hvendorID</td>
  <td>{$row["CurrencyID"]}</td>
  <td>$htotal</td>
  <td>$hreceivingNumber</td>
  <td>
    $docreportsReceiving
  </td>
  <td>{$row["CurrencyID"]}</td>
  <td>$hamountPaid</td>
  <td>$hpaymentID</td>
  <td>
    <a href="$public_prefix/docreports/payment/{$row["PaymentID"]}" target="_blank">
      <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
    </a>
  </td>
  <td>$hinvoiceNumber</td>
  <td>{$row["CurrencyID"]}</td>
  <td>$hamount</td>
</tr>
EOF;
echo $_html;
?>
