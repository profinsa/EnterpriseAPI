<!-- grid -->
<div id="grid_content" class="row">
    <div class="table-responsive">
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
			echo "<tr><td>";
			if($security->can("update"))
			    echo "<span onclick=\"changeSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span>";
			if($security->can("delete"))
			    echo "<span onclick=\"deleteSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
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
		    }
		}
		?>
	    </tbody>
	</table>
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
     //handler change button from rows. Does xhr request and replace grid content
     function changeSubgridItem(item){
	 var itemData = $("#itemData");
	 $.get("<?php echo $public_prefix; ?>/subgrid/<?php  echo $scope["path"] ;  ?>/edit/Main/" + item + "?partial=true")
	  .done(function(data){
          //	      setTimeout(function(){
		  $("#subgrid").html(data);
              //    },0);
	  })
	  .error(function(xhr){
	      if(xhr.status == 401)
		  window.location = "<?php echo $public_prefix; ?>/login";
	      else
		  alert("Unable to load page");
	  });
     }
     //handler delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function deleteSubgridItem(item){
	 if(confirm("Are you sure?")){
	     var itemData = $("#itemData");
	     $.getJSON("<?php echo $public_prefix; ?>/subgrid/<?php  echo $scope["path"] ;  ?>/delete/" + item)
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

