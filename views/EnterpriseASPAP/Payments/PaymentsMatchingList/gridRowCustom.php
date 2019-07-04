<?php
    $hpurchaseNumber = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "PurchaseNumber", $row["PurchaseNumber"]);
    $hvendorID = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "VendorID", $row["VendorID"]);
    $htotal = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "Total", $row["Total"]);
    $hreceivingNumber = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "RecivingNumber", $row["RecivingNumber"]);
    $hamountPaid = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "AmountPaid", $row["AmountPaid"]);
    $hpaymentID = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "PaymentID", $row["PaymentID"]);
    //    $hinvoiceNumber = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "InvoiceNumber", $row["InvoiceNumber"]);
    $hamount = renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, "Amount", $row["Amount"]);
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
  <td>
    <a href="{$linksMaker->makeDocreportsLink("purchaseorder", $row["PurchaseNumber"])}" target="_blank">
      <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
    </a>
  </td>
  <td>$hpurchaseNumber</td>
  <td>$hvendorID</td>
  <td>{$row["CurrencyID"]}</td>
  <td>$htotal</td>
  <td>
    $docreportsReceiving
  </td>
  <td>$hreceivingNumber</td>
  <td>{$row["CurrencyID"]}</td>
  <td>$hamountPaid</td>
  <td>
    <a href="{$linksMaker->makeDocreportsLink("payment", $row["PaymentID"])}" target="_blank">
      <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
    </a>
  </td>
  <td>$hpaymentID</td>
  <td>{$row["CurrencyID"]}</td>
  <td>$hamount</td>
</tr>
EOF;
    //  <td>$hinvoiceNumber</td>

    echo $_html;
?>
