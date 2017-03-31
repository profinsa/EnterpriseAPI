<!-- grid -->
<div id="grid_content" class="row">
    <div class="table-responsive">
	<script>
	<?php
	$rows = $data->getPage(1);
	echo "var gridItems = " . json_encode($rows) . ";";
	?>
	</script>
	<table id="example23" class="table table-striped table-bordered">
	    <thead>
		<tr>
		    <?php
		    if(property_exists($data, "features") && in_array("selecting", $data->features))
			echo "<th></th>";
		    ?>
		    <th></th>
		    <?php
		    //getting data for table
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
		    $current_row = 0;
		    foreach($rows as $row){
			$keyString = '';
			foreach($data->idFields as $key){
			    $keyString .= $row[$key] . "__";
			}
			$keyString = substr($keyString, 0, -2);
			echo "<tr>";
			if(property_exists($data, "features") && in_array("selecting", $data->features))
			    echo "<td><input type=\"checkbox\" onchange=\"gridSelectItem(event, '" . $current_row . "')\"></td>";
			echo "<td>";
			if($security->can("select"))
			    echo "<a href=\"" . $public_prefix ."/index#/grid/" . $scope["path"] . "/view/Main/" . $keyString ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
			if(!property_exists($data, "modes") || in_array("delete", $data->modes)){
                            if($security->can("delete"))
				echo "<span onclick=\"gridDeleteItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
			}
			echo "</td>";
			foreach($row as $key=>$value)
			    if(key_exists($key, $data->gridFields)){
				echo "<td>\n";
				switch($data->gridFields[$key]["inputType"]){
				    case "checkbox" :
					echo $value ? "True" : "False";
					break;
				    case "timestamp" :
				    case "datetime" :
					echo date("m/d/y", strtotime($value));
					break;
				    case "text":
				    case "dropdown":
					if(key_exists("formatFunction", $data->gridFields[$key])){
					    $formatFunction = $data->gridFields[$key]["formatFunction"];
					    echo $data->$formatFunction($row, "gridFields", $key, $value, false);
					}
					else
					    echo formatField($data->gridFields[$key], $value);
					break;
				}
				echo "</td>\n";
			    }
			echo "</tr>";
			$current_row++;
		    }
		}
		?>
	    </tbody>
	</table>
    </div>
    <div class="dt-buttons-container row col-md-12">
	<br/>
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	    <a class="btn btn-info new-button-action dt-button pull-left" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] ?>/new/Main/new">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "gridActions.php"))
	    require __DIR__ . "/../" . $PartsPath . "gridActions.php";
	?>
    </div>
    <script>
     var gridItemsSelected = window.gridItemsSelected = {};
     //select handler, fill out gridViewSelected by rows
     function gridSelectItem(event, item){
	 if(event.currentTarget.checked)
             gridItemsSelected[item] = gridItems[item];
	 else
	     delete gridItemsSelected[item];
     }
     
     //hanlder delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function gridDeleteItem(item){
	 if(confirm("Are you sure?")){
	     var itemData = $("#itemData");
	     $.getJSON("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/delete/" + item)
	      .success(function(data) {
		  onlocation(window.location);
		  //		  window.location = "<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"]; ?>/grid/Main/all";
	      })
	      .error(function(err){
		  console.log('wrong');
	      });
	 }
     }
    </script>
</div>

