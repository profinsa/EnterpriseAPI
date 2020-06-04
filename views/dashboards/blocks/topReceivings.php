<?php
    $topOrdersReceipts = $data->TopOrdersReceipts();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top Five Pending Recevings"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
	<table class="table">
	    <thead>
		<tr>
		    <th><?php echo $translation->translateLabel("Receiving"); ?></th>
		    <th><?php echo $translation->translateLabel("Vendor"); ?></th>
		    <th><?php echo $translation->translateLabel("Arrival Date"); ?></th>
		    <th><?php echo $translation->translateLabel("Amount"); ?></th>
		</tr>
	    </thead>
	    <tbody>
		<?php
		    foreach($topOrdersReceipts["purchases"] as $row)
		    echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsPayable/PurchaseProcessing/ViewPurchases", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->PurchaseNumber}") . "\">{$row->PurchaseNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("VendorID", $row->VendorID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->PurchaseDueDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotal) . "</td></tr>";
		?>
	    </tbody>
	</table>
    </div>
</div>

