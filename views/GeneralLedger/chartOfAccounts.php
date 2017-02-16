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
				 Contains three pages:
				 + grid
				 main screen of GeneralLedger/chartOfAccounts.
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
						    $rows = $data->getPage();
						    foreach($rows[0] as $key =>$value)
							echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
						    ?>
						</tr>
					    </thead>
					    <tbody>
						<?php
						foreach($rows as $row){
						    echo "<tr><td>";
						    if($scope->user["accesspermissions"]["GLEdit"])
							echo "<a href=\"index.php?page=GeneralLedger/chartOfAccounts&mode=view&category=Main&item=" . $row["GLAccountNumber"] ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
						    if($scope->user["accesspermissions"]["GLDelete"])
							echo "<span onclick=\"deleteItem('" . $row["GLAccountNumber"] . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
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
					<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=GeneralLedger/chartOfAccounts&mode=new&category=Main">
					    <?php echo $translation->translateLabel("New"); ?>
					</a>
				    </div>
				    <script>
				     function deleteItem(item){
					 if(confirm("Are you sure?")){
					     var itemData = $("#itemData");
					     $.getJSON("index.php?page=GeneralLedger/chartOfAccounts&delete=true&GLAccountNumber=" + item)
					      .success(function(data) {
						  window.location = "index.php?page=GeneralLedger/chartOfAccounts";
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
					foreach($data->editCategories as $key =>$value)
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=GeneralLedger/chartOfAccounts&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
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
						$item = $data->getEditItem($scope->item, $scope->category);
						foreach($item as $key =>$value)
						    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>" . $value . "</td></tr>";
						?>
					    </tbody>
					</table>
				    </div>
				    <div class="pull-right">
					<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=GeneralLedger/chartOfAccounts&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
					    <?php echo $translation->translateLabel("Edit"); ?>
					</a>
					<a class="btn btn-inverse waves-effect waves-light" href="index.php?page=GeneralLedger/chartOfAccounts&mode=grid">
					    <?php echo $translation->translateLabel("Cancel"); ?>
					</a>
				    </div>
				</div>
			    <!-- edit and new -->
			    <?php elseif($scope->mode == 'edit' || $scope->mode == 'new'): ?>
				<div id="row_editor">
				    <ul class="nav nav-tabs">
					<?php  
					foreach($data->editCategories as $key =>$value)
					    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=GeneralLedger/chartOfAccounts&mode=" . $scope->mode ."&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
					?>
				    </ul>
				    <form id="itemData" class="form-material form-horizontal m-t-30">
					<input type="hidden" name="GLAccountNumber" value="<?php echo $scope->item; ?>" />
					<input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
		            <?php
			    $item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $scope->category) :
						    $data->getNewItem($scope->item, $scope->category);
			    $disabledFields = [
				"GLAccountNumber" => true,
				"GLAccountCode" => true
			    ];
			    $translatedFieldName = '';
			    
			    foreach($item as $key =>$value){
				$translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
				if($key == "GLAccountType"){
				    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
				    $types = $data->getGLAccountTypes();
				    echo "<option>" . $value . "</option>";
				    foreach($types as $type)
					if($type["GLAccountType"]!= $value)
					    echo "<option>" . $type["GLAccountType"] . "</option>";
				    echo"</select></div></div>";
				}elseif($key == "GLBalanceType"){
				    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
				    $types = $data->getGLBalanceTypes();
				    echo "<option>" . $value . "</option>";
				    foreach($types as $type)
					if($type["GLBalanceType"]!= $value)
					    echo "<option>" . $type["GLBalanceType"] . "</option>";
				    echo"</select></div></div>";
				}else{
				    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"" . $value ."\" " . (key_exists($key, $disabledFields) && $scope->mode == "edit" ? "disabled" : "") ."></div></div>";
				}
			    }
			    ?>
					<div class="pull-right">
					    <a class="btn btn-info waves-effect waves-light m-r-10" onclick="<?php echo ($scope->mode == "edit" ? "saveItem()" : "createItem()"); ?>">
						<?php echo $translation->translateLabel("Save"); ?>
					    </a>
					    <a class="btn btn-inverse waves-effect waves-light" href="index.php?page=GeneralLedger/chartOfAccounts&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
						<?php echo $translation->translateLabel("Cancel"); ?>
					    </a>
					</div>
				    </form>
				    <script>
				     function createItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=GeneralLedger/chartOfAccounts&new=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=GeneralLedger/chartOfAccounts";
					  })
					  .error(function(err){
					      console.log('wrong');
					  });
				     }
				     function saveItem(){
					 var itemData = $("#itemData");
					 $.post("index.php?page=GeneralLedger/chartOfAccounts&update=true", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      console.log('ok');
					      window.location = "index.php?page=GeneralLedger/chartOfAccounts&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>";
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
