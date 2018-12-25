<!-- edit and new -->
<div id="row_editor">
    <ul class="nav nav-tabs" role="tablist">
	<?php
	    //render tabs like Main, Current etc
	    //uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	    foreach($data->editCategories as $key =>$value)
	    if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#". makeId($key) . "\" aria-controls=\"". makeId($key) . "\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div class="tab-content">
	<?php
	    $item = $data->getEditItem($ascope["item"], "Main");
	?>
	<?php foreach($data->editCategories as $key =>$value):  ?>
	    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo makeId($key); ?>">
		<div class="row">
		    <div class="col-md-9">
			<?php if($key == "Main"): ?>
			    <form id="itemData" class="form-material form-horizontal m-t-30">
				<input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
				<input type="hidden" name="category" value="<?php echo $key; ?>" />
				<?php
				    //getting record.
				    //used as translated field name
				    $translatedFieldName = '';

				    foreach($item as $key =>$value){
					$translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
					if(key_exists($key, $data->editCategories[$ascope["category"]])){
					    switch($data->editCategories[$ascope["category"]][$key]["inputType"]){
						case "text" :
						    //renders text input with label
						    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
						    if(key_exists("formatFunction", $data->editCategories[$ascope["category"]][$key])){
							$formatFunction = $data->editCategories[$ascope["category"]][$key]["formatFunction"];
							echo $data->$formatFunction($item, "editCategories", $key, $value, false);
						    }
						    else
							echo formatField($data->editCategories[$ascope["category"]][$key], $value);

						    echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "view")  || (key_exists("disabledNew", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
						   ."></div></div>";
						    break;
						    
						case "datetime" :
						    //renders text input with label
						    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
							 ( (key_exists("disabledEdit", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "view")  || (key_exists("disabledNew", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
							."></div></div>";
						    break;

						case "checkbox" :
						    //renders checkbox input with label
						    echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
						    echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
							 ( (key_exists("disabledEdit", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "view") || (key_exists("disabledNew", $data->editCategories[$ascope["category"]][$key]) && $ascope["mode"] == "new") ? "disabled" : "")
							."></div></div>";
						    break;
						    
						case "dropdown" :
						    //renders select with available values as dropdowns with label
						    echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
						    $method = $data->editCategories[$ascope["category"]][$key]["dataProvider"];
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
			    </form>
			<?php elseif($key == "Credits"): ?>
			    <script>
			     <?php
 				 $rows = $data->getCreditsPage($ascope["item"]);
				 echo "var gridItems = " . json_encode($rows) . ";";
			     ?>
			    </script>
			    <!-- grid -->
			    <div id="grid_content" class="row">
				<div>
				    <table id="example23" class="table table-striped table-bordered">
					<thead>
					    <tr>
						<?php
						    //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
						    if(count($rows)){
							foreach($rows[0] as $key =>$value)
							if(key_exists($key, $data->debitsFields))
							    echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
						    }
						?>
					    </tr>
					</thead>
					<tbody>
					    <?php
						//renders table rows using rows, getted in previous block
						if(count($rows)){
						    $current_row = 0;
						    foreach($rows as $row){
							//$keyString = '';
							//foreach($data->idFields as $key){
							//  $keyString .= $row[$key] . "__";
							//}
							//$keyString = substr($keyString, 0, -2);
							echo "<tr>";
							foreach($row as $key=>$value)
							if(key_exists($key, $data->debitsFields)){
							    echo "<td>\n";
							    switch($data->debitsFields[$key]["inputType"]){
								case "checkbox" :
								    echo "<input id=\"" . $key . "\" class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " onchange=\"reconciliationSelectItem(event, '" . $current_row . "', 'credit')\" />";
								    break;
								case "timestamp" :
								case "datetime" :
								    echo date("m/d/y", strtotime($value));
								    break;
								case "text":
								case "dropdown":
								    if(key_exists("formatFunction", $data->debitsFields[$key])){
									$formatFunction = $data->debitsFields[$key]["formatFunction"];
									echo $data->$formatFunction($row, "debitsFields", $key, $value, false);
								    }
								    else
									echo formatField($data->debitsFields[$key], $value);
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
				<script>
				</script>
			    </div>
			<?php elseif($key == "Debits"): ?>
			    <script>
			     <?php
 				 $rows = $data->getDebitsPage($ascope["item"]);
				 echo "var gridItems = " . json_encode($rows) . ";";
			     ?>
			    </script>
			    <!-- grid -->
			    <div id="grid_content" class="row">
				<div>
				    <table id="example23" class="table table-striped table-bordered">
					<thead>
					    <tr>
						<?php
						    //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
						    if(count($rows)){
							foreach($rows[0] as $key =>$value)
							if(key_exists($key, $data->debitsFields))
							    echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
						    }
						?>
					    </tr>
					</thead>
					<tbody>
					    <?php
						//renders table rows using rows, getted in previous block
						if(count($rows)){
						    $current_row = 0;
						    foreach($rows as $row){
							//$keyString = '';
							//foreach($data->idFields as $key){
							//  $keyString .= $row[$key] . "__";
							//}
							//$keyString = substr($keyString, 0, -2);
							echo "<tr>";
							foreach($row as $key=>$value)
							if(key_exists($key, $data->debitsFields)){
							    echo "<td>\n";
							    switch($data->debitsFields[$key]["inputType"]){
								case "checkbox" :
								    echo "<input id=\"" . $key . "\" class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " onchange=\"reconciliationSelectItem(event, '" . $current_row . "', 'debit')\" />";
								    break;
								case "timestamp" :
								case "datetime" :
								    echo date("m/d/y", strtotime($value));
								    break;
								case "text":
								case "dropdown":
								    if(key_exists("formatFunction", $data->debitsFields[$key])){
									$formatFunction = $data->debitsFields[$key]["formatFunction"];
									echo $data->$formatFunction($row, "debitsFields", $key, $value, false);
								    }
								    else
									echo formatField($data->debitsFields[$key], $value);
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
				<script>
				</script>
			    </div>
			<?php endif; ?>
		    </div>
		    <script>
		     var gridItemsSelected = window.gridItemsSelected = {};
		     //select handler, fill out gridViewSelected by rows
		     function reconciliationSelectItem(event, item, type){
			 var value = event.currentTarget.checked ? 1 : 0;
			 gridItems[item][event.currentTarget.id] = value;

			 serverProcedureCall(type == 'debit' ? "updateDebitsItem" : "updateCreditsItem", gridItems[item], true);
		     }
		    </script>
		    <div class="col-md-3">
			<div class="table-responsive">
			    <table class="table table-bordered">
				<tbody>
				    <?php
					$balance = $data->getBalance($item);
				    ?>
				    <tr>
					<td><?php echo $translation->translateLabel("Starting Balance"); ?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Book"); ?></td>
					<td><?php echo $balance["Book"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Bank"); ?></td>
					<td><?php echo $balance["Bank"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("+Total Credits"); ?></td>
					<td><?php echo $balance["TotalCredits"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("+Total Debits"); ?></td>
					<td><?php echo $balance["TotalDebits"];?></td>
				    </tr>

				    <tr>
					<td><?php echo $translation->translateLabel("Adj. Book Balance"); ?></td>
					<td><?php echo $balance["AdjBookBalance"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("+DebitsOS"); ?></td>
					<td><?php echo $balance["DebitsOS"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("-CreditsOS"); ?></td>
					<td><?php echo $balance["CreditsOS"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Bank Balance"); ?></td>
					<td><?php echo $balance["BankBalance"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Stmt Balance"); ?></td>
					<td><?php echo $balance["StmtBalance"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Unreconciled"); ?></td>
					<td><?php echo $balance["Unreconciled"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("End Book Balance"); ?></td>
					<td><?php echo $balance["EndBookBalance"];?></td>
				    </tr>

				    <tr>
					<td><?php echo $translation->translateLabel("Credits Cleared"); ?></td>
					<td><?php echo $balance["CreditsCleared"];?></td>
				    </tr>
				    <tr>
					<td><?php echo $translation->translateLabel("Debits Cleared"); ?></td>
					<td><?php echo $balance["DebitsCleared"];?></td>
				    </tr>
				</tbody>
			    </table>
			</div>
		    </div>
		</div>
	    </div>
	<?php endforeach; ?>
    </div>
    <div class="row">
	<?php
	    if(file_exists(__DIR__ . "/" . "editFooter.php"))
		require __DIR__ . "/" . "editFooter.php";
	    if(file_exists(__DIR__ . "/" . "vieweditFooter.php"))
		require __DIR__ . "/" . "vieweditFooter.php";
	?>
	
	<div  style="margin-top:10px" class="pull-right">
	    <!--
		 renders buttons translated Save and Cancel using translation model
	    -->
	    <?php if($security->can("update")): ?>
		<a class="btn btn-info" onclick="<?php echo ($ascope["mode"] == "edit" ? "saveItem()" : "createItem()"); ?>">
		    <?php echo $translation->translateLabel("Save"); ?>
		</a>
		<?php 
		    if(file_exists(__DIR__ . "/". "editActions.php"))
			require __DIR__ . "/". "editActions.php";
		    if(file_exists(__DIR__ . "/" . "vieweditActions.php"))
			require __DIR__ . "/" . "vieweditActions.php";
		?>
	    <?php endif; ?>
	    <a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </div>
    <script>
     //handler of save button if we in new mode. Just doing XHR request to save data
     function createItem(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeGridItemNew($ascope["path"]); ?>", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      console.log('ok');
	      window.location = "<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveItem(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeGridItemSave($ascope["path"]); ?>", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]) ; ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
    </script>
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
     var table = $('#example23').DataTable( {
	 dom : "",
	 "bSort" : false
     });

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
