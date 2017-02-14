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
	    <!-- grid -->
	    <div id="grid_content" class="row">
		<div class="col-sm-12">
		    <div class="white-box">
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
					echo "<tr><td><span onclick=\"editRow(" . $row["GLAccountNumber"] . ")\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span><span onclick=\"deleteRow(" . $row["GLAccountNumber"] . ")\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></td>";
					foreach($row as $value)
					    echo "<td>$value</td>";
					echo "</tr>";
				    }
				    ?>
				</tbody>
			    </table>
			</div>
		    </div>
		</div>
	    </div>
	    <div id="row_viewer" style="display:none">
		<div class="table-responsive">
		    <table id="example23" class="table table-striped">
			<thead>
			    <tr>
				<th></th>
				<?php
				$rows = $grid->getPage();
				foreach($rows[0] as $key =>$value)
				    echo "<th>$key</th>";
				?>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($rows as $row){
				echo "<tr><td><span onclick=\"editRow(" . $row["GLAccountNumber"] . ")\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span><span onclick=\"deleteRow(" . $row["GLAccountNumber"] . ")\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></td>";
				foreach($row as $value)
				    echo "<td>$value</td>";
				echo "</tr>";
			    }
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	    <div id="row_editor" style="display:none">
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
	 }
	</script>
	<!--Style Switcher -->
	<script src="dependencies/plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>
	<?php
	require 'footer.php';
	?>
</body>
</html>
