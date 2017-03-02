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

     Last Modified: 02.03.2016
     Last Modified by: Nikita Zaharov
   -->

<!-- Page Content -->
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

    <?php if($scope["mode"] == 'grid'): ?>
	<link href="https://cdn.datatables.net/1.10.13/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>

	<!-- grid -->
	<div id="grid_content" class="row">
	    <div class="table-responsive">
		<table id="example23" class="table table-striped table-bordered">
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
			    if($user["accesspermissions"]["GLEdit"])
				echo "<a href=\"" . $public_prefix ."/index#/grid/" . $scope["path"] . "/view/Main/" . $row[$data->idField] ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
			    if($user["accesspermissions"]["GLDelete"])
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
	    <div class="dt-buttons-container row col-md-12">
		<br/>
		<div class="col-md-2 new-button-action">
		    <a class="btn btn-info" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] ?>/new/Main/new">
			<?php echo $translation->translateLabel("New"); ?>
		    </a>
		</div>
	    </div>
	    <script>
	     //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
	     function deleteItem(item){
		 if(confirm("Are you sure?")){
		     var itemData = $("#itemData");
		     $.getJSON("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/delete/" + item)
		      .success(function(data) {
			  window.location = "<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"]; ?>/grid/Main/all";
		      })
		      .error(function(err){
			  console.log('wrong');
		      });
		 }
	     }
	    </script>
	</div>
	
    <?php elseif($scope["mode"] == 'view'): ?>
	<!-- view -->
	<div id="row_viewer">
	    <ul class="nav nav-tabs">
		<?php
		//render tabs like Main, Current etc
		//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
		foreach($data->editCategories as $key =>$value)
		    echo "<li role=\"presentation\"". ( $scope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"" . $public_prefix ."/index#/grid/" . $scope["path"] .  "/view/" . $key . "/" . $scope["item"] . "\">" . $translation->translateLabel($key) . "</a></li>";
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
			$item = $data->getEditItem($scope["item"], $scope["category"]);
			foreach($item as $key =>$value){
			    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
			    switch($data->editCategories[$scope["category"]][$key]["inputType"]){
				case "checkbox" :
				    echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
				    break;
				case "text":
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
		<a class="btn btn-info" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo  $scope["path"];  ?>/edit/<?php  echo $scope["category"] . "/" . $scope["item"] ; ?>">
		    <?php echo $translation->translateLabel("Edit"); ?>
		</a>
		<a class="btn btn-info" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] . "/grid/Main/all"; ?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
	</div>
    <?php elseif($scope["mode"] == 'edit' || $scope["mode"] == 'new'): ?>
	<!-- edit and new -->
	<div id="row_editor">
	    <ul class="nav nav-tabs">
		<?php  
		//render tabs like Main, Current etc
		//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
		foreach($data->editCategories as $key =>$value)
		    echo "<li role=\"presentation\"". ( $scope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"" . $public_prefix . "/index#/grid/" . $scope["path"] . "/" .  $scope["mode"] ."/" . $key . "/" . $scope["item"] . "\">" . $translation->translateLabel($key) . "</a></li>";
		?>
	    </ul>
	    <form id="itemData" class="form-material form-horizontal m-t-30">
		<?php echo csrf_field(); ?>
		<input type="hidden" name="id" value="<?php echo $scope["item"]; ?>" />
		<input type="hidden" name="category" value="<?php echo $scope["category"]; ?>" />
		<?php
		//getting record.
		$item = $scope["mode"] == 'edit' ? $data->getEditItem($scope["item"], $scope["category"]) :
					  $data->getNewItem($scope["item"], $scope["category"]);
		//used as translated field name
		$translatedFieldName = '';
		
		foreach($item as $key =>$value){
		    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
		    switch($data->editCategories[$scope["category"]][$key]["inputType"]){
			case "text" :
			    //renders text input with label
			    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"" . $value ."\" " .
				 ( (key_exists("disabledEdit", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "new") ? "readonly" : "")
				."></div></div>";
			    break;
			    
			case "datepicker" :
			    //renders text input with label
			    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatepicker\" value=\"" . $value ."\" " .
				 ( (key_exists("disabledEdit", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "new") ? "readonly" : "")
				."></div></div>";
			    break;

			case "checkbox" :
			    //renders checkbox input with label
			    echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
			    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
				 ( (key_exists("disabledEdit", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "edit") || (key_exists("disabledNew", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "new") ? "disabled" : "")
				."></div></div>";
			    break;
			    
			case "dropdown" :
			    //renders select with available values as dropdowns with label
			    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
			    $method = $data->editCategories[$scope["category"]][$key]["dataProvider"];
			    $types = $data->$method();
			    //
			    echo json_encode($types) . 'eeeee'. $value;
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
		    <a class="btn btn-info" onclick="<?php echo ($scope["mode"] == "edit" ? "saveItem()" : "createItem()"); ?>">
			<?php echo $translation->translateLabel("Save"); ?>
		    </a>
		    <a class="btn btn-info" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] . "/" .  ( $scope["mode"] != "new" ? "view/" . $scope["category"] . "/" . $scope["item"] : "grid/Main/all" ) ; ?>">
			<?php echo $translation->translateLabel("Cancel"); ?>
		    </a>
		</div>
	    </form>
	    <script>
	     //handler of save button if we in new mode. Just doing XHR request to save data
	     function createItem(){
		 var itemData = $("#itemData");
		 $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] . "/insert" ?>", itemData.serialize(), null, 'json')
		  .success(function(data) {
		      console.log('ok');
		      window.location = "<?php echo $public_prefix; ?>/index#/grid/<?php  echo $scope["path"] . "/grid/Main/all"; ?>";
		  })
		  .error(function(err){
		      console.log('wrong');
		  });
	     }
	     //handler of save button if we in edit mode. Just doing XHR request to save data
	     function saveItem(){
		 var itemData = $("#itemData");
		 $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"]; ?>/update", itemData.serialize(), null, 'json')
		  .success(function(data) {
		      console.log('ok');
		      window.location = "<?php echo $public_prefix; ?>/index#/grid/<?php  echo $scope["path"];  ?>/view/<?php  echo $scope["category"] . "/" . $scope["item"] ; ?>";
		  })
		  .error(function(err){
		      console.log('wrong');
		  });
	     }
	    </script>
	</div>
    <?php endif; ?>
</div>

<script language="javascript" type="text/javascript">
 <?php  if(!key_exists("partial", $_GET)):?>
 $(document).ready(function(){
 <?php endif; ?>
     console.log('loaded');
     $.ajaxSetup({
	 headers: { 'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content') }
     });
     var table = $('#example23').DataTable( {
	 buttons: [
	     'copy', 'csv', 'excel', 'pdf', 'print'
	 ]
     });

     var buttons = $('.dt-buttons-container');
     var dtbuttons = table.buttons().container();
     dtbuttons.addClass("col-md-4");
     buttons.append(dtbuttons);
     
     $('.dt-button').addClass("btn btn-info");
     $('.dt-button').css("margin-left", "3px");
     $('.dt-button').removeClass("dt-button buttons-html5");

     /*     var table = $('#example').DataTable({
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
	} );*/

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
     <?php  if(!key_exists("partial", $_GET)):?>
 });
     <?php endif; ?>
 
 jQuery('.fdatepicker').datepicker();
</script>
