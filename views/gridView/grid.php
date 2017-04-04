<!--
     Name of Page: grid

     Method: renders content of screen in grid mode. 

     Date created: Nikita Zaharov, 09.03.2016

     Use: used by views/gridView.php for rendering content in grid mode
     Data displayed as table. Each row is item and create and delete actions.

     Input parameters:

     Output parameters:
     html

     Called from:
     views/gridView.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 24.03.2016
     Last Modified by: Nikita Zaharov
   -->

<div id="grid_content" class="row">
    <h3 class="box-title m-b-0"><?php echo $data->dashboardTitle ?></h3>
    <p class="text-muted m-b-30"><?php echo $data->dashboardTitle ?></p>
    <div class="table-responsive">
	<script>
	 <?php
	 $rows = $data->getPage(1);
	 echo "var gridItems = " . json_encode($rows) . ";";
	 ?>
	</script>
	<table id="example23" class="table table-striped">
	    <thead>
		<tr>
		    <?php
		    if(property_exists($data, "features") && in_array("selecting", $data->features))
			echo "<th></th>";
		    ?>
		    <th></th>
		    <?php
		    //getting data for table
		    $rows = $data->getPage(1);
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
			    echo "<a href=\"index.php#/?page=" . $app->page . "&action=" . $scope->action . "&mode=view&category=Main&item=" . $keyString ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
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
    <div>
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php#/?page=<?php echo  $app->page; ?>&action=<?php echo $scope->action ?>&mode=new&category=Main">
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
	 console.log(JSON.stringify(gridItemsSelected));
     }
     
     //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function gridDeleteItem(item){
	 if(confirm("Are you sure?")){
	     var itemData = $("#itemData");
	     $.getJSON("index.php?page=<?php  echo $app->page . "&action=" . $scope->action ;  ?>&delete=true&id=" + item)
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

