<?php
    $hpurchaseNumber = renderGridValue($ascope, $data, $drill, $row, "PurchaseNumber", $row["PurchaseNumber"]);
    $hvendorID = renderGridValue($ascope, $data, $drill, $row, "VendorID", $row["VendorID"]);
    $htotal = renderGridValue($ascope, $data, $drill, $row, "Total", $row["Total"]);
    $hreceivingNumber = renderGridValue($ascope, $data, $drill, $row, "RecivingNumber", $row["RecivingNumber"]);
    $hamountPaid = renderGridValue($ascope, $data, $drill, $row, "AmountPaid", $row["AmountPaid"]);
    $hpaymentID = renderGridValue($ascope, $data, $drill, $row, "PaymentID", $row["PaymentID"]);
    $hinvoiceNumber = renderGridValue($ascope, $data, $drill, $row, "InvoiceNumber", $row["InvoiceNumber"]);
    $hamount = renderGridValue($ascope, $data, $drill, $row, "Amount", $row["Amount"]);
    if($row["RecivingNumber"]){
	$docreportsReceiving = <<<EOF
    <a href="{$linksMaker->makeDocreportsLink("receiving", $row["RecivingNumber"])}" target="_blank">
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
    <a href="{$linksMaker->makeDocreportsLink("purchaseorder", $row["PurchaseNumber"])}" target="_blank">
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
    <a href="{$linksMaker->makeDocreportsLink("payment", $row["PaymentID"])}" target="_blank">
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
