<?php
    $lowInventory = $data->itemGetCriticalyLowInventory();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Critically Low Inventory Report"); ?></h3>
    <div class="table-responsive">
	<table class="table">
	    <thead>
		<tr>
		    <th><?php echo $translation->translateLabel("Item ID"); ?></th>
		    <th><?php echo $translation->translateLabel("Warehouse ID"); ?></th>
		    <th><?php echo $translation->translateLabel("Warehouse Bin"); ?></th>
		    <th><?php echo $translation->translateLabel("Qty Committed"); ?></th>
		    <th><?php echo $translation->translateLabel("Qty On Hand"); ?></th>
		    <th><?php echo $translation->translateLabel("Qty On Order"); ?></th>
		</tr>
	    </thead>
	    <tbody>
		<?php
		    foreach($lowInventory as $row)
		    echo "<tr><td><a href=\"" . $linksMaker->makeGridItemView("Inventory/ItemsStock/ViewInventoryOnHand", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->ItemID}__{$row->WarehouseID}__{$row->WarehouseBinID}") . "\">{$row->ItemID}</a>" . "</td><td>{$row->WarehouseID}</td><td>{$row->WarehouseBinID}</td><td>{$row->QtyCommitted}</td><td>{$row->QtyOnHand}</td><td>{$row->QtyOnOrder}</td></tr>";
		?>
	    </tbody>
	</table>
    </div>
</div>
