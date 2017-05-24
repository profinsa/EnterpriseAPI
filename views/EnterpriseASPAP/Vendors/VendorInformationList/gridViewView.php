<!-- view -->
<?php
if(key_exists("back", $_GET)){
    $backhref = urldecode($_GET["back"]);
    $back = "&back=" . urlencode($_GET["back"]);
}else{
    $backhref = $linksMaker->makeGridItemViewCancel($ascope["path"]);
    $back = "";
}
?>
<div id="row_viewer">
    <ul class="nav nav-tabs" role="tablist">
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#".preg_replace("/[\s\&]+/", "", $key)."\" aria-controls=\"". preg_replace("/[\s\&]+/", "", $key) ."\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div class="tab-content">
	<?php foreach($data->editCategories as $key =>$value):  ?>
	    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo preg_replace("/[\s\&]+/", "", $key) ?>">
			<?php if($key == "Vendor Transactions"): ?>
				<div style="margin-top:10px;"></div>
				<?php
				$item = $data->getEditItem($scope->item, $key);
				$rows = $data->getTransactions($item["VendorID"], "normal");
				$gridFields = $data->transactionsFields;
				require __DIR__ . "/../../../embeddedgrid.php"; 
				//echo json_encode($rows);
				?>
			<?php elseif($key == "Vendor Transactions History"): ?>
				<div style="margin-top:10px;"></div>
				<?php
				$item = $data->getEditItem($scope->item, $key);
				$rows = $data->getTransactions($item["VendorID"], "history");
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
					$item = $data->getEditItem($scope->item, $key);
					$category = $key;
					foreach($item as $key =>$value){
						if(key_exists($key, $data->editCategories[$category])){
						echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
						switch($data->editCategories[$category][$key]["inputType"]){
							case "checkbox" :
							echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
							break;
							case "timestamp" :
							case "datetime" :
							echo date("m/d/y", strtotime($value));
							break;
							case "text":
							case "dropdown":
							if(key_exists("formatFunction", $data->editCategories[$category][$key])){
								$formatFunction = $data->editCategories[$category][$key]["formatFunction"];
								echo $data->$formatFunction($item, "editCategories", $key, $value, false);
							}
							else
								echo formatField($data->editCategories[$category][$key], $value);		    
							break;
						}
						echo "</td></tr>";
						}
					}
					?>
					</tbody>
				</table>
			<?php endif; ?>
		</div>
	<?php endforeach; ?>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "viewFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "viewFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>
	<div class="row">
	    <div class="pull-right">
		<!--
		     buttons Edit and Cancel
		     for translation uses translation model
		     for category(which tab is activated) uses $scope of controller
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info waves-effect waves-light m-r-10" href="<?php echo $linksMaker->makeGridItemEdit($scope->action, $scope->item) . $back;?>">
			<?php echo $translation->translateLabel("Edit"); ?>
		    </a>
 		    <?php 
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
			require __DIR__ . "/../" . $PartsPath . "editActions.php";
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
			require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		    ?>
		<?php endif; ?>
		<a class="btn btn-inverse waves-effect waves-light" href="<?php echo $backhref?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
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
