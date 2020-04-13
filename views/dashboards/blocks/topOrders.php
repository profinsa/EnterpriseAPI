<?php
    $topOrdersReceipts = $data->TopOrdersReceipts();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top Five Open Orders"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
	<table class="table">
	    <thead>
		<tr>
		    <th><?php echo $translation->translateLabel("Order Number"); ?></th>
		    <th><?php echo $translation->translateLabel("Customer"); ?></th>
		    <th><?php echo $translation->translateLabel("Ship Date"); ?></th>
		    <th><?php echo $translation->translateLabel("Amount"); ?></th>
		</tr>
	    </thead>
	    <tbody>
		<?php
		    foreach($topOrdersReceipts["orders"] as $row)
		    echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsReceivable/OrderScreens/ViewOrders", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->OrderNumber}") . "\">{$row->OrderNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("CustomerID", $row->CustomerID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->OrderShipDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotal) . "</td></tr>";
		?>
	    </tbody>
	</table>
    </div>
</div>
