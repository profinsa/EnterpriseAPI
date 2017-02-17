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
		 Name of Page: bankAccounts view

		 Method: renders whole page. 

		 Date created: Nikita Zaharov, 17.02.2016

		 Use: used by controllers/GeneralLedger/bankAccounts.php for rendering page
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
		 controllers/GeneralLedger/bankAccounts.php

		 Calls:
		 translation model
		 banckAccounts model
		 app as model

		 Last Modified: 17.02.2016
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
				 main screen of GeneralLedger/banckAccounts.
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
				    <h3 class="box-title m-b-0"><?php echo $scope->dashboardTitle ?></h3>
				    <p class="text-muted m-b-30"><?php echo $scope->dashboardTitle ?></p>
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
							echo "<a href=\"index.php?page=" . $app->page . "&mode=view&category=Main&item=" . $row[$data->idField] ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
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
					<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=<?php echo  $app->page; ?>&mode=new&category=Main">
					    <?php echo $translation->translateLabel("New"); ?>
					</a>
				    </div>
				    <script>
				     //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
				     function deleteItem(item){
					 if(confirm("Are you sure?")){
					     var itemData = $("#itemData");
					     $.getJSON("index.php?page=<?php  echo $app->page; ?>&delete=true&id=" + item)
					      .success(function(data) {
						  window.location = "index.php?page=<?php  echo $app->page; ?>";
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
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=" . $app->page . "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
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
						foreach($item as $key =>$value)
						    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>" . $value . "</td></tr>";
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
					<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=<?php echo  $app->page;  ?>&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
					    <?php echo $translation->translateLabel("Edit"); ?>
					</a>
					<a class="btn btn-inverse waves-effect waves-light" href="index.php?page=<?php echo $app->page; ?>&mode=grid">
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
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=" . $app->page . "&mode=" . $scope->mode ."&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
					?>
				    </ul>
				    <form id="itemData" class="form-material form-horizontal m-t-30">
					<input type="hidden" name="id" value="<?php echo $scope->item; ?>" />
					<input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
		            <?php
			    //getting record.
			    $item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $scope->category) :
						    $data->getNewItem($scope->item, $scope->category);
			    //fields which displayed with disabled inputs
			    $disabledFields = [
				"BankID" => true,
			    ];
			    //used as translated field name
			    $translatedFieldName = '';
			    
			    foreach($item as $key =>$value){
				$translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
				if($key == "GLAccountType"){
				    //renders select with available values for GLAccountType
				    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
				    $types = $data->getGLAccountTypes();
				    echo "<option>" . $value . "</option>";
				    foreach($types as $type)
					if($type["GLAccountType"]!= $value)
					    echo "<option>" . $type["GLAccountType"] . "</option>";
				    echo"</select></div></div>";
				}else{
				    //renders input for any other field
				    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"" . $value ."\" " . (key_exists($key, $disabledFields) && $scope->mode == "edit" ? "disabled" : "") ."></div></div>";
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
					    <a class="btn btn-inverse waves-effect waves-light" href="index.php?page=<?php echo $app->page . ( $scope->mode != "new" ? "&mode=view&category=" . $scope->category . "&item=" . $scope->item : "") ; ?>">
						<?php echo $translation->translateLabel("Cancel"); ?>
					    </a>
					</div>
				    </form>
				    <script>
				     //handler of save button if we in new mode. Just doing XHR request to save data
				     function createItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=<?php  echo $app->page; ?>&new=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=<?php  echo $app->page; ?>";
					  })
					  .error(function(err){
					      console.log('wrong');
					  });
				     }
				     //handler of save button if we in edit mode. Just doing XHR request to save data
				     function saveItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=<?php  echo $app->page; ?>&update=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=<?php  echo $app->page; ?>&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>";
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
	    <script src="dependencies/plugins/bower_components/datatables/jquery.dataTables.min.js"></script>

	    <!-- start - This is for export functionality only -->
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
	    <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
	    <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
	    <!-- end - This is for export functionality only -->

	    <script>
	     $(document).ready(function(){
		 $('#myTable').DataTable();
		 $(document).ready(function() {
		     var table = $('#example').DataTable({
			 "columnDefs": [
			     { "visible": false, "targets": 2 }
			 ],
			 "order": [[ 2, 'asc' ]],
			 "displayLength": 25,
			 "drawCallback": function ( settings ) {
			     var api = this.api();
			     var rows = api.rows( {page:'current'} ).nodes();
			     var last=null;

			     api.column(2, {page:'current'} ).data().each( function ( group, i ) {
				 if ( last !== group ) {
				     $(rows).eq( i ).before(
					 '<tr class="group"><td colspan="5">'+group+'</td></tr>'
				     );

				     last = group;
				 }
			     } );
			 }
		     } );

		     // Order by the grouping
		     $('#example tbody').on( 'click', 'tr.group', function () {
			 var currentOrder = table.order()[0];
			 if ( currentOrder[0] === 2 && currentOrder[1] === 'asc' ) {
			     table.order( [ 2, 'desc' ] ).draw();
			 }
			 else {
			     table.order( [ 2, 'asc' ] ).draw();
			 }
		     });
		 });
	     });
	     $('#example23').DataTable( {
		 dom: 'Bfrtip',
		 buttons: [
		     'copy', 'csv', 'excel', 'pdf', 'print'
		 ]
	     });

	    </script>
	    <!--Style Switcher -->
	    <script src="dependencies/plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>
	    <?php
	    require './views/footer.php';
	    ?>
    </body>
</html>
