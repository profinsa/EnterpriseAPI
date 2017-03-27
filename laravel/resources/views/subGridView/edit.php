<!-- grid -->
<div id="grid_content" class="row">
    <div class="table-responsive">
	<form id="itemData">
	    <table id="example23" class="table table-striped table-bordered">
		<thead>
		    <tr>
			<th></th>
			<?php
			//getting data for table
			$rows = $data->getPage($scope["item"]);
			//renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
			if(count($rows)){
			    foreach($rows[0] as $key =>$value)
				if(key_exists($key, $data->gridFields))
				    echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
			}
			?>
		    </tr>
		</thead>
		<tbody>
		    <?php
		    //renders table rows using rows, getted in previous block
		    //also renders buttons like edit, delete of row
		    if(count($rows)){
			foreach($rows as $row){
			    $keyString = '';
			    foreach($data->idFields as $key){
				$keyString .= $row[$key] . "__";
			    }
			    $keyString = substr($keyString, 0, -2);
			    echo "<tr>";
			    echo "<input type=\"hidden\" name=\"id\" value=\"" . $scope["item"] . "\" /><td style=\"text-align:center\">";
			    if($security->can("select"))
				echo "<span style=\"font-size:14pt\" class=\"grid-action-button glyphicon glyphicon-floppy-disk\" aria-hidden=\"true\" onclick=\"saveSubgridItem('" . $keyString . "')\"></span>";
			    if($security->can("delete"))
				echo "<span  style=\"font-size:14pt\" onclick=\"cancelSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-step-backward\" aria-hidden=\"true\"  onclick=\"cancelsaveItem()\"></span>";
			    echo "</td>";
			    foreach($row as $key=>$value)
				if(key_exists($key, $data->gridFields)){
				    echo "<td>\n";
				    switch($data->gridFields[$key]["inputType"]){
					case "text" :
					    //renders text input with label
					    echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
					    if(key_exists("formatFunction", $data->gridFields[$key])){
						$formatFunction = $data->gridFields[$key]["formatFunction"];
						echo $data->$formatFunction($row, "gridFields", $key, $value, false);
					    }
					    else
						echo formatField($data->gridFields[$key], $value);

					    echo"\" " . ( (key_exists("disabledEdit", $data->gridFields[$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->gridFields[$key]) && $scope["mode"] == "new") ? "readonly" : "")
					       .">";
					    break;
					    
					case "datetime" :
					    //renders text input with label
					    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
						 ( (key_exists("disabledEdit", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "new") ? "readonly" : "")
						."></div></div>";
					    break;

					case "checkbox" :
					    //renders checkbox input with label
					    echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
					    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
						 ( (key_exists("disabledEdit", $data->gridFields[$key]) && $scope["mode"] == "edit") || (key_exists("disabledNew", $data->gridFields[$key]) && $scope["mode"] == "new") ? "disabled" : "")
						."></div></div>";
					    break;
					    
					case "dropdown" :
					    //renders select with available values as dropdowns with label
					    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
					    $method = $data->gridFields[$key]["dataProvider"];
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
				    echo "</td>\n";
				}
			    echo "</tr>";
			}
		    }
		    ?>
		</tbody>
	    </table>
	</form>
    </div>
    <div class="dt-buttons-container row col-md-12">
	<br/>
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	    <a class="btn btn-info new-button-action dt-button" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] ?>/new/Main/new">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
    </div>
    <script>
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveSubgridItem(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $public_prefix; ?>/subgrid/<?php  echo $scope["path"]; ?>/update", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      subgridView();
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
     
     function cancelSubgridItem(item){
	 subgridView();
     }
    </script>
</div>
