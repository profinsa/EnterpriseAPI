<!-- view -->
<div id="row_viewer">
    <ul class="nav nav-tabs">
	<?php
	//render tabs like Main, Current etc
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php#/?page=" . $app->page . "&action=" . $scope->action .  "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div class="table-responsive">
	<?php if($scope->category == "Project Transactions"): ?>
	    <div style="margin-top:10px;"></div>
	    <?php
	    $item = $data->getEditItem($scope->item, $scope->category);
	    $rows = $data->getTransactions($item["CustomerID"], "normal");
	    $gridFields = $data->transactionsFields;
	    require __DIR__ . "/../../../embeddedgrid.php"; 
	    // echo json_encode($rows);
	    ?>
	<?php elseif($scope->category == "Project Transactions History"): ?>
	    <div style="margin-top:10px;"></div>
	    <?php
	    $item = $data->getEditItem($scope->item, $scope->category);
	    $rows = $data->getTransactions($item["CustomerID"], "history");
	    $gridFields = $data->transactionsFields;
	    require __DIR__ . "/../../../embeddedgrid.php"; 
	    //echo json_encode($rows);
	    ?>
	<?php else: ?>
	    <table class="table">
		<thead>
		    <tr>
			<th>
			    <?php echo $translation->translateLabel("Field"); ?>
			</th>
			<th>
			    <?php echo $translation->translateLabel("Value"); ?>
			</th>
		    </tr>
		</thead>
		<tbody id="row_viewer_tbody">
		    <?php
		    //renders table, contains record data using getEditItem from model
		    $item = $data->getEditItem($scope->item, $scope->category);
		    foreach($item as $key =>$value){
			if(key_exists($key, $data->editCategories[$scope->category])){
			    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
			    switch($data->editCategories[$scope->category][$key]["inputType"]){
				case "checkbox" :
				    echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
				    break;
				case "timestamp" :
				case "datetime" :
				    echo date("m/d/y", strtotime($value));
				    break;
				case "text":
				case "dropdown":
				    if(key_exists("formatFunction", $data->editCategories[$scope->category][$key])){
					$formatFunction = $data->editCategories[$scope->category][$key]["formatFunction"];
					echo $data->$formatFunction($item, "editCategories", $key, $value, false);
				    }
				    else
					echo formatField($data->editCategories[$scope->category][$key], $value);						    break;
			    }
			    echo "</td></tr>";
			}
		    }
		    ?>
		</tbody>
	    </table>
	<?php endif; ?>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "viewFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "viewFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>

	<div style="margin-top:20px" class="pull-right">
	    <!--
		 buttons Edit and Cancel
		 for translation uses translation model
		 for category(which tab is activated) uses $scope of controller
	       -->
	    <?php if($security->can("update")): ?>
		<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php#/?page=<?php echo  $app->page .  "&action=" . $scope->action;  ?>&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
		    <?php echo $translation->translateLabel("Edit"); ?>
		</a>
		<?php 
		if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "editActions.php";
		if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		?>
	    <?php endif; ?>
	    <a class="btn btn-inverse waves-effect waves-light" href="index.php#/?page=<?php echo $app->page . "&action=" . 	$scope->action; ?>&mode=grid">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </div>
</div>
<script>
 if(!$.fn.DataTable.isDataTable("#example23")){
     $('#example23').DataTable( {
	 dom : "frtlip"
     });
 }
</script>
