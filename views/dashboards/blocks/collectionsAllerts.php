<?php
    $collectionAlerts = $data->CollectionAlerts();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Collections Alerts"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
	<table class="table table-hover">
	    <thead>
		<tr>
		    <th><?php echo $translation->translateLabel("Customer ID"); ?></th>
		    <th><?php echo $translation->translateLabel("Overdue"); ?></th>
		</tr>
	    </thead>
	    <tbody>
		<?php
		    foreach($collectionAlerts as $row)
		    echo "<tr><td>" . $drill->getLinkByField("CustomerID", $row->CustomerID) . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Overdue) . "</td></tr>";
		?>
	    </tbody>
	</table>
    </div>
</div>

