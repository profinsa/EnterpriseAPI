<!DOCTYPE html>  
<html lang="en">
      <?php
      require 'header.php';
      ?>
<body>
<!-- Preloader -->
<div class="preloader">
    <div class="cssload-speeding-wheel"></div>
</div>
<div id="wrapper">
    <?php
    require 'nav/top.php';
    ?>
    <?php
    require 'nav/left.php';
    ?>

    <!-- Page Content -->
    <div id="page-wrapper">
	<div class="container-fluid">
	    <?php
	    require 'uiItems/dashboard.php';
	    ?>
	    <div class="col-sm-12">
		<div class="white-box">
		    <!--
			 This is conditional page generation.
			 Contains three pages:
		         + grid
			 main screen of GeneralLedger/chartOfAccounts.
			 contains table and buttons for edit and delete rows
			 
			 + view
			 page is showed after click edit on grid screen.
			 contains tabs with fields and values
			 + edit
			 page is showed after click edit on view screen.
			 contains tabs with fileds and values. Values is available for changing.
		       -->
		    <?php if($scope->mode == 'grid'): ?>
			<!-- grid -->
			<div id="grid_content" class="row">
			    <h3 class="box-title m-b-0"><?php echo $scope->dashboardTitle ?></h3>
			    <p class="text-muted m-b-30"><?php echo $scope->dashboardTitle ?></p>
			    <div class="table-responsive">
				<table id="example23" class="table table-striped">
				    <thead>
					<tr>
					    <th></th>
					    <?php
					    $rows = $grid->getPage();
					    foreach($rows[0] as $key =>$value)
						echo "<th>" . $translation->translateLabel($grid->columnNames[$key]) . "</th>";
					    ?>
					</tr>
				    </thead>
				    <tbody>
					<?php
					foreach($rows as $row){
					    echo "<tr><td><a href=\"index.php?page=GeneralLedger/chartsOfAccount&mode=view&category=Main&item=" . $row["GLAccountNumber"] ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a><span onclick=\"deleteRow('" . $row["GLAccountNumber"] . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></td>";
					    foreach($row as $value)
						echo "<td>$value</td>";
					    echo "</tr>";
					}
					?>
				    </tbody>
				</table>
			    </div>
			</div>
		    <?php elseif($scope->mode == 'view'): ?>
			<div id="row_viewer">
			    <ul class="nav nav-tabs">
				<?php  
				foreach($grid->editCategories as $key =>$value)
				    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=GeneralLedger/chartsOfAccount&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
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
					$item = $grid->getEditItem($scope->item, $scope->category);
					foreach($item as $key =>$value)
					    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $grid->columnNames) ? $grid->columnNames[$key] : $key) . "</td><td>" . $value . "</td></tr>";
					?>
				    </tbody>
				</table>
			    </div>
			    <div class="pull-right">
				<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=GeneralLedger/chartsOfAccount&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
				    <?php echo $translation->translateLabel("Edit"); ?>
				</a>
				<a class="btn btn-inverse waves-effect waves-light" href="index.php?page=GeneralLedger/chartsOfAccount&mode=grid">
				    <?php echo $translation->translateLabel("Cancel"); ?>
				</a>
			    </div>
			</div>
		    <?php elseif($scope->mode == 'edit'): ?>
			<div id="row_editor">
			    <ul class="nav nav-tabs">
				<?php  
				foreach($grid->editCategories as $key =>$value)
				    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=GeneralLedger/chartsOfAccount&mode=edit&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
				?>
			    </ul>
                            <form id="itemData" class="form-material form-horizontal m-t-30">
				<input type="hidden" name="GLAccountNumber" value="<?php echo $scope->item; ?>" />
				<input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
		                <?php
				$item = $grid->getEditItem($scope->item, $scope->category);
				$disabledFields = [
				    "GLAccountNumber" => true,
				    "GLAccountCode" => true
				];
				$translatedFieldName = '';
				
				$types = $grid->getGLAccountTypes();
				$GLAccountTypeOptions = "";
				foreach($types as $value){
				    if($GLAccountTypeOptions == "")
					$GLAccountTypeOptions = "<option>" . $value["GLAccountType"] . "</option>";
				    else
					$GLAccountTypeOptions .= "<option>" . $value["GLAccountType"] . "</option>";
				}
				
				$types = $grid->getGLBalanceTypes();
				$GLBalanceTypeOptions = "";
				foreach($types as $value){
				    if($GLBalanceTypeOptions == "")
					$GLBalanceTypeOptions = "<option>" . $value["GLBalanceType"] . "</option>";
				    else
					$GLBalanceTypeOptions .= "<option>" . $value["GLBalanceType"] . "</option>";
				}
				
				foreach($item as $key =>$value){
				    $translatedFieldName = $translation->translateLabel(key_exists($key, $grid->columnNames) ? $grid->columnNames[$key] : $key);
				    if($key == "GLAccountType"){
					echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">" . $GLAccountTypeOptions ."</select></div></div>";
				    }elseif($key == "GLBalanceType"){
					echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">" . $GLBalanceTypeOptions ."</select></div></div>";
				    }else{
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"" . $value ."\" " . (key_exists($key, $disabledFields) ? "disabled" : "") ."></div></div>";
				    }
				}
				?>
				<div class="pull-right">
				    <a class="btn btn-info waves-effect waves-light m-r-10" onclick="saveItem()">
					<?php echo $translation->translateLabel("Save"); ?>
				    </a>
				    <a class="btn btn-inverse waves-effect waves-light" href="index.php?page=GeneralLedger/chartsOfAccount&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
					<?php echo $translation->translateLabel("Cancel"); ?>
				    </a>
				</div>
                            </form>
			    <script>
			     function saveItem(){
				 var itemData = $("#itemData");
				 $.post("index.php?page=GeneralLedger/chartsOfAccount&update=true", itemData.serialize(), null, 'json')
				  .success(function(data) {
				      console.log('ok');
				      window.location = "index.php?page=GeneralLedger/chartsOfAccount&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>";
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

	 function deleteRow(number){
	     alert(number);
	 }

	 function editRow(number){
	     document.getElementById('row_editor').style.display = 'none';
	     document.getElementById('grid_content').style.display = 'none';
	     document.getElementById('row_viewer').style.display = 'block';

	     var req = $.getJSON("index.php?page=GeneralLedger/chartsOfAccount&getItem=" + number)
			.success(function(data) {
			    var _html = '', ind;
			    for(ind in data){
				if(!_html.length)
				    _html = '<tr><td>' + ind + '</td><td>' + data[ind] + '</td></tr>';
				else
				    _html += '<tr><td>' + ind + '</td><td>' + data[ind] + '</td></tr>';
			    }
			    document.getElementById('row_viewer_tbody').innerHTML = _html;
			})
			.error(function(err){
			    console.log('something going wrong');
			});
	 }
	</script>
	<!--Style Switcher -->
	<script src="dependencies/plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>
	<?php
	require 'footer.php';
	?>
</body>
</html>
