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

     Last Modified: 09.03.2016
     Last Modified by: Nikita Zaharov
   -->

<div id="grid_content" class="row">
    <h3 class="box-title m-b-0"><?php echo $data->dashboardTitle ?></h3>
    <p class="text-muted m-b-30"><?php echo $data->dashboardTitle ?></p>
    <div class="table-responsive">
	<table id="example23" class="table table-striped">
	    <thead>
		<tr>
		    <th></th>
		    <?php
		    //getting data for table
		    $rows = $data->getPage(1);
		    //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
		    foreach($rows[0] as $key =>$value)
			echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
		    ?>
		</tr>
	    </thead>
	    <tbody>
		<?php
		//renders table rows using rows, getted in previous block
		//also renders buttons like edit, delete of row
		foreach($rows as $row){
		    echo "<tr><td>";
		    if($scope->user["accesspermissions"]["GLEdit"])
			echo "<a href=\"index.php?page=" . $app->page . "&action=" . $scope->action . "&mode=view&category=Main&item=" . $row[$data->idField] ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
		    if($scope->user["accesspermissions"]["GLDelete"])
			echo "<span onclick=\"deleteItem('" . $row[$data->idField] . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
		    echo "</td>";
		    foreach($row as $value)
			echo "<td>$value</td>";
		    
		    echo "</tr>";
		}
		?>
	    </tbody>
	</table>
    </div>
    <div>
	<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=<?php echo  $app->page; ?>&action=<?php echo $scope->action ?>&mode=new&category=Main">
	    <?php echo $translation->translateLabel("New"); ?>
	</a>
    </div>
    <script>
     //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function deleteItem(item){
	 if(confirm("Are you sure?")){
	     var itemData = $("#itemData");
	     $.getJSON("index.php?page=<?php  echo $app->page . "&action=" . $scope->action ;  ?>&delete=true&id=" + item)
	      .success(function(data) {
		  window.location = "index.php?page=<?php  echo $app->page .  "&action=" . $scope->action; ?>";
	      })
	      .error(function(err){
		  console.log('wrong');
	      });
	 }
     }
    </script>
</div>

