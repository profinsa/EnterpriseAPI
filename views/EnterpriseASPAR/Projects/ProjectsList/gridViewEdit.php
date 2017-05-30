<!-- edit and new -->
<?php
if(key_exists("back", $_GET)){
    $backhref = urldecode($_GET["back"]);
    $back = "&back=" . urlencode($_GET["back"]);
}else{
    $backhref = $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]);
    $back = "";
}
?>
<div id="row_editor">
    <ul class="nav nav-tabs" role="tablist">
	<?php  
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
    foreach($data->editCategories as $key =>$value)
        if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#".preg_replace("/[\s\&]+/", "", $key)."\" aria-controls=\"". preg_replace("/[\s\&]+/", "", $key) ."\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
    ?>
    </ul>
	<form id="itemData" class="form-material form-horizontal m-t-30">
	    <input type="hidden" name="id" value="<?php echo $scope->item; ?>" />
	    <input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
	    <div class="tab-content">
		<?php foreach($data->editCategories as $key =>$value):  ?>
		    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo preg_replace("/[\s\&]+/", "", $key) ?>">
				<?php if($key == "Project Transactions"): ?>
					<div style="margin-top:10px;"></div>
					<?php
					$item = $data->getEditItem($scope->item, $key);
					$rows = $data->getTransactions($item["CustomerID"], "normal");
					$gridFields = $data->transactionsFields;
					require __DIR__ . "/../../../embeddedgrid.php"; 
					//echo json_encode($rows);
					?>
				<?php elseif($key == "Project Transactions History"): ?>
					<div style="margin-top:10px;"></div>
					<?php
					$item = $data->getEditItem($scope->item, $key);
					$rows = $data->getTransactions($item["CustomerID"], "history");
					$gridFields = $data->transactionsFields;
					require __DIR__ . "/../../../embeddedgrid.php"; 
					//echo json_encode($rows);
					?>
				<?php else: ?>
					<?php
					//getting record.
					$category = $key;
					$item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $category) :
								$data->getNewItem($scope->item, $category);
					//used as translated field name
					$translatedFieldName = '';
					
					foreach($item as $key =>$value){
						$translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
						if(key_exists($key, $data->editCategories[$category])){
						switch($data->editCategories[$category][$key]["inputType"]){
							
							case "text" :
							//renders text input with label
							echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\""; 
							if(key_exists("formatFunction", $data->editCategories[$category][$key])){
								$formatFunction = $data->editCategories[$category][$key]["formatFunction"];
								echo $data->$formatFunction($item, "editCategories", $key, $value, false);
							}
							else
								echo formatField($data->editCategories[$category][$key], $value);
							echo "\" " .	 ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "readonly" : "")
								."></div></div>";
							break;
							case "timestamp" :    
							case "datetime" :
							//renders text input with label
							echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
								( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "readonly" : "")
								."></div></div>";
							break;

							case "checkbox" :
							//renders checkbox input with label
							echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
							echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
								( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit") || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "disabled" : "")
								."></div></div>";
							break;
							
							case "dropdown" :
							//renders select with available values as dropdowns with label
							echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
							$method = $data->editCategories[$category][$key]["dataProvider"];
							$types = $data->$method();
							if($value)
								echo "<option value=\"" . $value . "\">" . (key_exists($value, $types) ? $types[$value]["title"] : $value) . "</option>";
							else
								echo "<option></option>";

							foreach($types as $type)
								if(!$value || $type["value"] != $value)
								echo "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
							echo"</select></div></div>";
							break;
						}
						}
					}
					?>
					<?php endif; ?>
				</div>
			<?php endforeach; ?>
	    </div>
	</form>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "editFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "editFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>
	<div class="row">
	    <div class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info waves-effect waves-light m-r-10" onclick="<?php echo ($scope->mode == "edit" ? "saveItem()" : "createItem()"); ?>">
			<?php echo $translation->translateLabel("Save"); ?>
		    </a>
		    <?php 
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
			require __DIR__ . "/../" . $PartsPath . "editActions.php";
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
			require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		    ?>
		<?php endif; ?>
		<a class="btn btn-inverse waves-effect waves-light" href="<?php echo $scope->mode != "new" ? $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]) . $back  : $backhref  ; ?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
	</div>
    </div>
    <script>
     //handler of save button if we in new mode. Just doing XHR request to save data
     function createItem(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeGridItemNew($ascope["action"]); ?>", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      console.log('ok');
	      window.location = "<?php echo $backhref; ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveItem(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeGridItemSave($ascope["action"]); ?>", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      console.log('ok');
	      window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"] . $back); ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
    </script>
</div>
<script>
 if(!$.fn.DataTable.isDataTable("#example23")){
     $('#example23').DataTable( {
	 dom : "frtlip"
     });
 }
</script>