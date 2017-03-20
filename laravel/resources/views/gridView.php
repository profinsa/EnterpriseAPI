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

     Last Modified: 20.03.2016
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
    <?php require "format.php"; ?>
    <?php if($scope["mode"] == 'grid'): ?>
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
				if($user["accesspermissions"]["GLEdit"])
				    echo "<a href=\"" . $public_prefix ."/index#/grid/" . $scope["path"] . "/view/Main/" . $keyString ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
				if($user["accesspermissions"]["GLDelete"])
				    echo "<span onclick=\"deleteItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
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
		<?php if(property_exists($data, "modes") && in_array("new", $data->modes)): ?>
		<a class="btn btn-info new-button-action dt-button" href="<?php echo $public_prefix; ?>/index#/grid/<?php echo $scope["path"] ?>/new/Main/new">
		    <?php echo $translation->translateLabel("New"); ?>
		</a>
		<?php endif; ?>
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
			    if(key_exists($key, $data->editCategories[$scope["category"]])){
				echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
				switch($data->editCategories[$scope["category"]][$key]["inputType"]){
				    case "checkbox" :
					echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
					break;
				    case "timestamp" :
				    case "datetime" :
					echo date("m/d/y", strtotime($value));
					break;
				    case "text":
				    case "dropdown":
					if(key_exists("formatFunction", $data->editCategories[$scope["category"]][$key])){
					    $formatFunction = $data->editCategories[$scope["category"]][$key]["formatFunction"];
					    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
					}
					else
					    echo formatField($data->editCategories[$scope["category"]][$key], $value);						    break;
				}
				echo "</td></tr>";
			    }
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
		    if(key_exists($key, $data->editCategories[$scope["category"]])){
			switch($data->editCategories[$scope["category"]][$key]["inputType"]){
			    case "text" :
				//renders text input with label
				echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
				if(key_exists("formatFunction", $data->editCategories[$scope["category"]][$key])){
				    $formatFunction = $data->editCategories[$scope["category"]][$key]["formatFunction"];
				    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
				}
				else
				    echo formatField($data->editCategories[$scope["category"]][$key], $value);

				echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope["category"]][$key]) && $scope["mode"] == "new") ? "readonly" : "")
				    ."></div></div>";
				break;
				
			    case "datetime" :
				//renders text input with label
				echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
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
<script>
 //"https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"
 //inlined for fast
 /*!
    DataTables Bootstrap 3 integration
    В©2011-2015 SpryMedia Ltd - datatables.net/license
  */
 (function(b){"function"===typeof define&&define.amd?define(["jquery","datatables.net"],function(a){return b(a,window,document)}):"object"===typeof exports?module.exports=function(a,d){a||(a=window);if(!d||!d.fn.dataTable)d=require("datatables.net")(a,d).$;return b(d,a,a.document)}:b(jQuery,window,document)})(function(b,a,d,m){var f=b.fn.dataTable;b.extend(!0,f.defaults,{dom:"<'row'<'col-sm-6'l><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",renderer:"bootstrap"});b.extend(f.ext.classes,
    {sWrapper:"dataTables_wrapper form-inline dt-bootstrap",sFilterInput:"form-control input-sm",sLengthSelect:"form-control input-sm",sProcessing:"dataTables_processing panel panel-default"});f.ext.renderer.pageButton.bootstrap=function(a,h,r,s,j,n){var o=new f.Api(a),t=a.oClasses,k=a.oLanguage.oPaginate,u=a.oLanguage.oAria.paginate||{},e,g,p=0,q=function(d,f){var l,h,i,c,m=function(a){a.preventDefault();!b(a.currentTarget).hasClass("disabled")&&o.page()!=a.data.action&&o.page(a.data.action).draw("page")};
    l=0;for(h=f.length;l<h;l++)if(c=f[l],b.isArray(c))q(d,c);else{g=e="";switch(c){case "ellipsis":e="&#x2026;";g="disabled";break;case "first":e=k.sFirst;g=c+(0<j?"":" disabled");break;case "previous":e=k.sPrevious;g=c+(0<j?"":" disabled");break;case "next":e=k.sNext;g=c+(j<n-1?"":" disabled");break;case "last":e=k.sLast;g=c+(j<n-1?"":" disabled");break;default:e=c+1,g=j===c?"active":""}e&&(i=b("<li>",{"class":t.sPageButton+" "+g,id:0===r&&"string"===typeof c?a.sTableId+"_"+c:null}).append(b("<a>",{href:"#",
    "aria-controls":a.sTableId,"aria-label":u[c],"data-dt-idx":p,tabindex:a.iTabIndex}).html(e)).appendTo(d),a.oApi._fnBindAction(i,{action:c},m),p++)}},i;try{i=b(h).find(d.activeElement).data("dt-idx")}catch(v){}q(b(h).empty().html('<ul class="pagination"/>').children("ul"),s);i!==m&&b(h).find("[data-dt-idx="+i+"]").focus()};return f});
</script>
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
     dtbuttons.prepend($(".new-button-action"));
     dtbuttons.addClass("col-md-12");
     buttons.append(dtbuttons);
     
     $('.dt-button').addClass("btn btn-info");
     $('.dt-button').css("margin-left", "3px");
     $('.dt-button').removeClass("dt-button buttons-html5");

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
 
 jQuery('.fdatetime').datepicker({
     autoclose : true,
     orientation : "bottom",
     format: {
	 toDisplay: function (date, format, language) {
	     //console.log(date,' eee');
	     var d = new Date(date);
	     return (d.getMonth() + 1) + 
		   "/" +  d.getDate() +
		   "/" +  d.getFullYear();
	 },
	 toValue: function (date, format, language) {
	     var d = new Date(date);
	     return (d.getMonth() + 1) + 
		   "/" +  d.getDate() +
		   "/" +  d.getFullYear();
	 }
     }
 });
</script>
