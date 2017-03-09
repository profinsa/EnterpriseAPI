<!DOCTYPE html>  
<html lang="en">
    <?php
    require './views/header.php';
    ?>
    <body>
	
	<!-- Preloader -->
	<div class="preloader">
	    <div class="cssload-speeding-wheel"></div>
	</div>
	<div id="wrapper">
	    <?php
	    require './views/nav/top.php';
	    ?>
	    <?php
	    require './views/nav/left.php';
	    ?>
	    <!--
		 Name of Page: gridView

		 Method: renders whole page. 

		 Date created: Nikita Zaharov, 20.02.2016

		 Use: used by controllers/GeneralLedger/*.php for rendering page
		 Page may renders in four modes:
	         + grid
		 data is displayed in table mode
		 + view
		 one record from table displayed showed more detail with categorized tabs
		 + edit
		 same as previous, but record displayed not as text as inputs for edit
		 + new
		 same as previous, but with default values and record inserted, not updated

		 Input parameters:

		 Output parameters:
		 html

		 Called from:
		 controllers/GeneralLedger/*.php

		 Calls:
		 translation model
		 grid model
		 app as model

		 Last Modified: 06.03.2016
		 Last Modified by: Nikita Zaharov
	       -->

	    <!-- Page Content -->
	    <div id="page-wrapper">
		<div class="container-fluid">
		    <?php
		    require './views/uiItems/dashboard.php';
		    ?>
		    <div class="col-sm-12">
			<div class="white-box">
			    <!--
				 This is conditional page generation.
				 Contains four pages:
				 + grid
				 main screen of GeneralLedger/*.
				 contains table and buttons for edit and delete rows
				 + new
				 page is showed after click new on grid screen.
				 + view
				 page is showed after click edit on grid screen.
				 contains tabs with fields and values
				 + edit
				 page is showed after click edit on view screen.
				 contains tabs with fileds and values. Values is available for changing.
			       -->
			    
			    <!-- grid -->
			    <?php if($scope->mode == 'grid'): ?>
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
				
			    <!-- view -->
			    <?php elseif($scope->mode == 'view'): ?>
				<div id="row_viewer">
				    <ul class="nav nav-tabs">
					<?php
					//render tabs like Main, Current etc
					//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
					foreach($data->editCategories as $key =>$value)
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=" . $app->page . "&action=" . $scope->action .  "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
					?>
				    </ul>
				    <div class="table-responsive">
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
						    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
						    switch($data->editCategories[$scope->category][$key]["inputType"]){
							case "checkbox" :
							    echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
							    break;
							case "text":
							case "timestamp" :
							case "datepicker" :
							case "dropdown":
							    echo $value;
							    break;
						    }
						    echo "</td></tr>";
						}
						?>
					    </tbody>
					</table>
				    </div>
				    <div class="pull-right">
					<!--
					     buttons Edit and Cancel
					     for translation uses translation model
					     for category(which tab is activated) uses $scope of controller
					   -->
					<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=<?php echo  $app->page .  "&action=" . $scope->action;  ?>&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
					    <?php echo $translation->translateLabel("Edit"); ?>
					</a>
					<a class="btn btn-inverse waves-effect waves-light" href="index.php?page=<?php echo $app->page . "&action=" . $scope->action; ?>&mode=grid">
					    <?php echo $translation->translateLabel("Cancel"); ?>
					</a>
				    </div>
				</div>
			    <!-- edit and new -->
			    <?php elseif($scope->mode == 'edit' || $scope->mode == 'new'): ?>
				<div id="row_editor">
				    <ul class="nav nav-tabs">
					<?php  
					//render tabs like Main, Current etc
					//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
					foreach($data->editCategories as $key =>$value)
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=" . $app->page . "&action=" . $scope->action .  "&mode=" . $scope->mode ."&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
					?>
				    </ul>
				    <form id="itemData" class="form-material form-horizontal m-t-30">
					<input type="hidden" name="id" value="<?php echo $scope->item; ?>" />
					<input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
		            <?php
			    //getting record.
			    $item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $scope->category) :
						    $data->getNewItem($scope->item, $scope->category);
			    //used as translated field name
			    $translatedFieldName = '';
			    
			    foreach($item as $key =>$value){
				$translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
				switch($data->editCategories[$scope->category][$key]["inputType"]){
					
				    case "text" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"" . $value ."\" " .
					     ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "readonly" : "")
					    ."></div></div>";
					break;
					
				    case "datepicker" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatepicker\" value=\"" . ($value == 'now'? date("m/d/y") : $value) ."\" " .
					     ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "readonly" : "")
					    ."></div></div>";
					break;

				    case "checkbox" :
					//renders checkbox input with label
					echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
					     ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit") || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "disabled" : "")
					    ."></div></div>";
					break;
					
				    case "dropdown" :
					//renders select with available values as dropdowns with label
					echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
					$method = $data->editCategories[$scope->category][$key]["dataProvider"];
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
			    ?>
					<div class="pull-right">
					    <!--
						 renders buttons translated Save and Cancel using translation model
					       -->
					    <a class="btn btn-info waves-effect waves-light m-r-10" onclick="<?php echo ($scope->mode == "edit" ? "saveItem()" : "createItem()"); ?>">
						<?php echo $translation->translateLabel("Save"); ?>
					    </a>
					    <a class="btn btn-inverse waves-effect waves-light" href="index.php?page=<?php echo $app->page . "&action=" . $scope->action .  ( $scope->mode != "new" ? "&mode=view&category=" . $scope->category . "&item=" . $scope->item : "") ; ?>">
						<?php echo $translation->translateLabel("Cancel"); ?>
					    </a>
					</div>
				    </form>
				    <script>
				     //handler of save button if we in new mode. Just doing XHR request to save data
				     function createItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=<?php  echo $app->page . "&action=" . $scope->action; ?>&new=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=<?php  echo $app->page . "&action=" . $scope->action; ?>";
					  })
					  .error(function(err){
					      console.log('wrong');
					  });
				     }
				     //handler of save button if we in edit mode. Just doing XHR request to save data
				     function saveItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=<?php  echo $app->page .  "&action=" . $scope->action; ?>&update=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=<?php  echo $app->page .  "&action=" . $scope->action; ?>&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>";
					  })
					  .error(function(err){
					      console.log('wrong');
					  });
				     }
				    </script>
				</div>
			</div>
			    <?php endif; ?>
		    </div>
		</div>
	    </div>
	    <!-- /#wrapper -->
	    <script src="dependencies/assets/js/custom.min.js"></script>
	    <!-- <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"</script> -->
	    <script src="dependencies/plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
	    <script src="dependencies/plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>

	    <!-- start - This is for export functionality only -->
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
	    <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
	    <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
	    <!-- end - This is for export functionality only -->

	    <style>
	     .grid-length label{
		 margin-top : 7px;
		 text-align : center !important;
	     }
	    </style>
	    <script>
	     $('#example23').DataTable( {
		 dom : "Bfrt<\"grid-footer row col-md-12\"<\"col-md-3 grid-length\"l><\"col-md-3\"i><\"col-md-6\"p>>",
		 buttons: [
		     'copy', 'csv', 'excel', 'pdf', 'print'
		 ]
	     });

	     jQuery('.fdatepicker').datepicker();

	    </script>
	    <!--Style Switcher 
	    <script src="dependencies/plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>-->
	    <?php
	    require './views/footer.php';
	    ?>
    </body>
</html>
