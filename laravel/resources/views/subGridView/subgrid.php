<!-- grid -->
<div id="grid_content" class="row">
    <div class="table-responsive">
	<table id="example23" class="table table-striped table-bordered">
	    <thead>
		<tr>
		    <?php if(!property_exists($data, "modes") || in_array("edit", $data->modes)): ?>
			<th></th>
		    <?php endif; ?>
		    <?php
		    //getting data for table
		    $rows = $data->getPage($scope["items"]);
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
			if(!property_exists($data, "modes") || in_array("edit", $data->modes)){
			    echo "<td>";
			    if($security->can("update"))
				echo "<span onclick=\"changeSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span>";
			    if($security->can("delete"))
				echo "<span onclick=\"deleteSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
			    echo "</td>";
			}
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
    <div class="subgrid-buttons col-md-1">
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	    <a class="btn btn-info" onclick="newSubgridItem()">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
    </div>
    <script>
     //adding buttons to table footer
     setTimeout(function(){
	 var buttons = $('.subgrid-buttons');
	 var tableFooter = $('.subgrid-table-footer');
	 tableFooter.prepend(buttons);
     },300);
     //handler new button. Does xhr request and replace grid content
     function newSubgridItem(){
	 var itemData = $("#itemData");
	 $.get("<?php echo $public_prefix; ?>/subgrid/<?php  echo $scope["path"] ;  ?>/new/Main/<?php echo $scope["items"]; ?>/new?partial=true")
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
     
     //handler change button from rows. Does xhr request and replace grid content
     function changeSubgridItem(item){
	 var itemData = $("#itemData");
	 $.get("<?php echo $public_prefix; ?>/subgrid/<?php  echo $scope["path"] ;  ?>/edit/Main/<?php echo $scope["items"]; ?>/" + item + "?partial=true")
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
	      })
	      .error(function(err){
		  console.log('wrong');
	      });
	 }
     }
    </script>
</div>
