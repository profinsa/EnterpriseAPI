<?php
$GLOBALS["dialogChooserTypes"] = [];
$GLOBALS["dialogChooserInputs"] = [];
?>

<!-- edit and new -->
<?php
if(key_exists("back", $_GET)){
    if(strpos($_GET["back"], "=" . $ascope["path"] . "&") === false){
	$backhref = $_GET["back"] . "&back=" . urlencode($_GET["back"]);
	$back = "&back=" . urlencode($_GET["back"]);
    }else{
	$backhref = $linksMaker->makeGridLink($ascope["path"]);//$linksMaker->makeGridLink($ascope["path"]);
	$back = "&back=" . urlencode($linksMaker->makeGridLink($ascope["path"]));
    }
}else{
    $backhref = $linksMaker->makeGridLink($ascope["path"]);
    $back = "";
}

function makeId($id){
    return preg_replace("/[\s\$\&]+/", "", $id);
}

function makeRowActions($linksMaker, $data, $ascope, $row, $ctx){
    $user = $GLOBALS["user"];
    $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $row[$ctx["detailTable"]["keyFields"][0]] . (count($ctx["detailTable"]["keyFields"]) > 1 ? "__" . $row[$ctx["detailTable"]["keyFields"][1]] : "");
    if(!key_exists("editDisabled", $ctx["detailTable"])){
	echo "<a href=\"" . $linksMaker->makeEmbeddedgridItemViewLink($ctx["detailTable"]["viewPath"], $ascope["path"], $keyString, $ascope["item"]);
	echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
    }
    if(!key_exists("deleteDisabled", $ctx["detailTable"]))
	echo "<a href=\"javascript:;\" onclick=\"embeddedGridDelete('$keyString')\"><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></a>";
}

$dropdownDepends = [];
?>
<div id="row_editor" class="row">
    <ul class="nav nav-tabs" role="tablist">
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#". makeId($key) . "\" aria-controls=\"". makeId($key) . "\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div style="margin-top:10px;"></div>
    <form id="itemData" class="form-material form-horizontal m-t-30">
	<input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
	<input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />
	<div class="tab-content">
	    <?php foreach($data->editCategories as $key =>$value):  ?>
		<div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo makeId($key); ?>">
		    <?php
		    //getting record.
		    $category = $key;
		    $curCategory = $key;
		    $item = $ascope["mode"] == 'edit' ? $data->getEditItem($ascope["item"], $key) :
					      $data->getNewItem($ascope["item"], $category);
		    //used as translated field name
		    $translatedFieldName = '';
		    $leftWidth = property_exists($data, "editCategoriesWidth") ? round(12 / 100 * $data->editCategoriesWidth["left"]) : 6;
		    $rightWidth = property_exists($data, "editCategoriesWidth") ? round(12 / 100 * $data->editCategoriesWidth["right"]) : 6;
		    ?>
		    <?php if(!property_exists($data, "detailPages") ||
			     !key_exists($curCategory, $data->detailPages)||
			     !key_exists("hideFields", $data->detailPages[$curCategory])):?>
			<?php 
			foreach($item as $key =>$value){
			    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
			    if(key_exists($key, $data->editCategories[$category])){
				$disabledEdit =  (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  ||
						 (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ||
						 (key_exists("editPermissions", $data->editCategories[$category][$key]) &&
						  $data->editCategories[$category][$key]["editPermissions"] == "admin" &&
													       !$security->isAdmin())
														   ? "readonly" : "";
				switch($data->editCategories[$category][$key]["inputType"]){
				    case "text" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-$rightWidth\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
					if(key_exists("formatFunction", $data->editCategories[$category][$key])){
					    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
					    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
					}
					else
					    echo formatField($data->editCategories[$category][$key], $value);

					echo"\" $disabledEdit></div></div>";
					break;
					
				    case "datetime" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-$rightWidth\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now' || $value == "0000-00-00 00:00:00" || $value == "CURRENT_TIMESTAMP"? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" $disabledEdit></div></div>";
					break;

				    case "file" :
					echo "<input class=\"file_attachment\" type=\"hidden\" name=\"" . $key . "\" id=\"" . $key . "\" value=\"\" />";
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\" for=\"" . $key . "_attachment" ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-$rightWidth\"><input type=\"file\" id=\"" . $key . "_attachment" ."\" name=\"" . $key . "_attachment" . "\" class=\"form-control\" value=\"";
					echo"\" $disabledEdit></div></div>";
					break;

				    case "checkbox" :
					if($disabledEdit != "")
					    $disabledEdit = "disabled";
					//renders checkbox input with label
					echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-$rightWidth\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." $disabledEdit></div></div>";
					break;

				    case "dialogChooser":
					$dataProvider = $data->editCategories[$category][$key]["dataProvider"];
					if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"]))
					    $GLOBALS["dialogChooserTypes"][$dataProvider] = "hophop";
					$GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-$rightWidth\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"$value\"></div></div>";
					break;
				    case "dropdown" :
					if($disabledEdit != "")
					    $disabledEdit = "disabled";
					//renders select with available values as dropdowns with label
					echo "<div class=\"form-group\"><label class=\"col-md-$leftWidth\">" . $translatedFieldName . "</label><div class=\"col-md-$rightWidth\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\" onchange=\"gridViewEditOnDropdown(event)\" $disabledEdit>";
					$method = $data->editCategories[$category][$key]["dataProvider"];
					if(key_exists("depends", $data->editCategories[$category][$key])){
					    $dropdownDepends[$key] = [
						"depends" =>$data->editCategories[$category][$key]["depends"],
						"data" => $data->$method()
					    ];
					    $types = [];
					}
					else
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
		    <?php endif; ?>
		    <?php if(property_exists($data, "detailPages") && key_exists($curCategory, $data->detailPages)):?>
			<div class="col-md-12 col-xs-12">
			    <?php
			    $getmethod = "get" . makeId($curCategory);
			    $deletemethod = "delete" . makeId($curCategory);
			    $rows = $data->$getmethod(key_exists("OrderNumber", $item) ? $item["OrderNumber"] : $item[$data->detailPages[$curCategory]["keyFields"][0]]);
			    //			echo json_encode($rows);
			    $detailTable = $data->detailPages[$curCategory];
			    $gridFields = $embeddedgridFields = $detailTable["gridFields"];
			    $deleteProcedure = "delete" . makeid($curCategory);
			    $embeddedgridContext = [
				"item" =>$item,
				"detailTable" => $detailTable
			    ];
			    $embeddedGridClasses = $newButtonId = "new" . makeId($curCategory);
			    require __DIR__ . "/../../../embeddedgrid.php"; 
			    ?>
			</div>
			<div id="<?php echo $newButtonId; ?>" class="row col-md-1">
			    <?php if(!key_exists("disableNew", $data->detailPages[$curCategory]) && $ascope["mode"] == "edit"): ?>
				<a class="btn btn-info" href="<?php echo $linksMaker->makeEmbeddedgridItemNewLink($data->detailPages[$curCategory]["viewPath"], $ascope["path"], "new", $ascope["item"]) . "&{$data->detailPages[$curCategory]["newKeyField"]}={$embeddedgridContext["item"][$data->detailPages[$curCategory]["newKeyField"]]}" ?>">
				    <?php echo $translation->translateLabel("New"); ?>
				</a>
			    <?php endif; ?>
			    <?php if(!key_exists("disableNew", $data->detailPages[$curCategory]) && $ascope["mode"] == "new"): ?>
				<a class="btn btn-info" href="javascript:newSubgridItem<?php echo $newButtonId; ?>();">
				    <?php echo $translation->translateLabel("New"); ?>
				</a>
			    <?php endif; ?>
			</div>
			<script>
			 //			 if(!datatableInitialized){
			 datatableInitialized = true;
			 console.log("initializing datatable");
			 var table = $('.<?php echo $newButtonId ?>').DataTable( {
			     dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'#footer<?php echo $newButtonId; ?>.row'<'col-sm-4'i><'col-sm-7'p>>"
			 });
			 //			 }
			 setTimeout(function(){
			     var buttons = $('#<?php echo $newButtonId; ?>');
			     var tableFooter = $('#footer<?php echo $newButtonId; ?>');
			     console.log(tableFooter, buttons);
			     tableFooter.prepend(buttons);
			 },300);
			 function newSubgridItem<?php echo $newButtonId;?>(){
			     createItem(function(request){
				 var insertedData = JSON.parse(request.responseText);
				 var idFields = <?php echo json_encode($data->idFields); ?>, ind, keyString = "";
				 for(ind in idFields){
				     if(keyString == "")
					 keyString = insertedData[idFields[ind]];
				     else
					 keyString += "__" + insertedData[idFields[ind]];
				 }
				 var link = "index.php#/?page=grid&action=<?php echo $data->detailPages[$curCategory]["viewPath"]; ?>&mode=new&category=Main&item=new&back=<?php echo urlencode("index.php#/?page=grid&action={$ascope["path"]}&mode=edit&category=Main&item="); ?>" + keyString + "&<?php echo $data->detailPages[$curCategory]["newKeyField"]; ?>" + "=" + insertedData["<?php echo $data->detailPages[$curCategory]["newKeyField"]; ?>"];
				 window.location = link;
			     });
			 }
			</script>
		    <?php endif; ?>
		</div>
	    <?php endforeach; ?>
	</div>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "editFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "editFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>
	<div class="col-md-12 col-xs-12 row">
	    <div  style="margin-top:10px" class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		   
		<?php if($security->can("update")): ?>
		    <?php
		    if(file_exists(__DIR__ . "/" . "editActions.php"))
			require __DIR__ . "/" . "editActions.php";
		    if(file_exists(__DIR__ . "/" . "vieweditActions.php")) {

				require __DIR__ . "/" . "vieweditActions.php";
			}
		    ?>
		<?php endif; ?>
	    </div>
	</div>
    </form>
    <script>
     var gridDropdownDepends = <?php echo json_encode($dropdownDepends); ?>;
     function gridViewEditOnDropdown(e){
	 if(gridDropdownDepends.hasOwnProperty(e.target.id))
	     return;
	 var ind, dind, depends, dependField;
	 for(ind in gridDropdownDepends){
	     dependsItem = gridDropdownDepends[ind];
	     for(dind in dependsItem.depends){
		 if(!dependsItem.hasOwnProperty("ddata"))
		     dependsItem.ddata = {};
		 if(dependsItem.depends[dind] == e.target.id){
		     dependsItem.ddata[dind] = e.target.value;
		     dependField = ind;
		 }
	     }
	 }
	 var records, rind, html;
	 for(ind in gridDropdownDepends){
	     if(ind == dependField){
		 records = [];
		 dependsItem = gridDropdownDepends[ind].ddata;
		 for(dind in dependsItem){
		     for(rind in gridDropdownDepends[ind].data){
			 if(gridDropdownDepends[ind].data[rind][dind] == dependsItem[dind])
			     records.push(gridDropdownDepends[ind].data[rind]);
		     }
		 }
		 //generating and inserting options
		 _html = '<option></option>';
		 for(rind in records)
		     _html += "<option>" + records[rind].value + "</option>";
		 $("#" + ind).html(_html);
	     }
	 }
     }
     
     function validateForm(itemData) {
         var itemDataArray = itemData.serializeArray();

         var categories = <?php echo json_encode($data->editCategories); ?>;
         var categoriesKeys = Object.keys(categories);
         var columnNames = <?php echo json_encode($data->columnNames); ?>;
         var validationError = false;
         var validationErrorMessage = '';
         var isAlert = false;

         function getDbObject(key) {
             for (var i = 0; i < categoriesKeys.length; i++) {
                 if (categories[categoriesKeys[i]].hasOwnProperty(key)) {
                     return categories[categoriesKeys[i]][key];
                 }
             }

             return null;
         }

         function isNumeric(value) {
             var re = /^-{0,1}\d*\.{0,1}\d+$/;
             return (re.test(value));
         }

         function isDecimal(value) {
             var re = /^-{0,1}\d*\.{0,1}\d+$/;
             return (re.test(value.replace(/,/g,'')));
         }

         for (var i = 0; i < itemDataArray.length; i++) {
             if ((itemDataArray[i].name !== 'category') && (itemDataArray[i].name !== 'id')) {
                 var dataObject = getDbObject(itemDataArray[i].name);

                 if (dataObject) {
		     //                     console.log(dataObject);
                     var dataType = dataObject.dbType.replace(/\(.*/,'');
                     var dataLength;
                     var re = /\((.*)\)/;

		     if(dataObject.hasOwnProperty("autogenerated"))
			 continue;
                     if (dataType !== 'datatime' && dataType !== 'timestamp') {
                         if (dataObject.required && !itemDataArray[i].value && !dataObject.hasOwnProperty("autogenerated")) {
                             validationError = true;
                             validationErrorMessage = 'cannot be empty.';
                             $('#' + itemDataArray[i].name).css('border', '1px solid red');
                         } else {
                             $('#' + itemDataArray[i].name).css('border', 'none');
                             switch (dataType) {
                                 case 'decimal':
                                     if (itemDataArray[i].value && !isDecimal(itemDataArray[i].value)) {
                                         $('#' + itemDataArray[i].name).css('border', '1px solid red');
                                         validationError = true;
                                         validationErrorMessage = 'must contain a number.';
                                     }
                                     break;
				 case 'smallint':
                                 case 'bigint':
                                 case 'int':
                                 case 'float':
                                     if (itemDataArray[i].value && !isNumeric(itemDataArray[i].value)) {
                                         $('#' + itemDataArray[i].name).css('border', '1px solid red');
                                         validationError = true;
                                         validationErrorMessage = 'must contain a number.';
                                     }
                                     break;
                                 case 'char':
                                     if (itemDataArray[i].value.length > 1) {
                                         $('#' + itemDataArray[i].name).css('border', '1px solid red');
                                         validationError = true;
                                         validationErrorMessage = 'cannot contain more than 1 character.';
                                     }
                                     break;
                                 case 'varchar':
                                     dataLength = dataObject.dbType.match(re)[1];

                                     if (itemDataArray[i].value.length > dataLength) {
                                         $('#' + itemDataArray[i].name).css('border', '1px solid red');
                                         validationError = true;
                                         validationErrorMessage = 'cannot contain more than ' + dataLength + ' character(s).';
                                     }
                                     break;
                                 default:
                                     break;
                             }
                         }
                     }

                     if (validationError && !isAlert) {
                         translatedFieldName = columnNames.hasOwnProperty(itemDataArray[i].name) ? columnNames[itemDataArray[i].name] : itemDataArray[i].name;
                         isAlert = true;
                         alert(translatedFieldName + ' field ' + validationErrorMessage);
                     }
                 } else {
                     //todo error handling
                 }
             }
         }

         return !validationError;
     }

     //  handler of save button if we in new mode. Just doing XHR request to save data
     function createItem(cb){
	 var itemData = $("#itemData");

	 if (validateForm(itemData)) {
	     var attachments = $("input[type=file]");

	     var formData = new FormData();

	     for (var i = 0; i < attachments.length; i++) {
		 formData.append('file[]', attachments[i].files[0]);
	     }

	     $.ajax({
		 url : 'upload.php',
		 type : 'POST',
		 data : formData,
		 processData: false,  // tell jQuery not to process the data
		 contentType: false,  // tell jQuery not to set contentType
		 success : function(e) {
                     try{
			 var res = JSON.parse(e).data;
			 var file_attachments = $(".file_attachment");

			 for (var i = 0; i < res.length; i++) {
			     file_attachments.val(res[i]);
			 }
                     }catch(e){}

                     var insertRequest = $.post("<?php echo $linksMaker->makeGridItemNew($ascope["path"]); ?>", itemData.serialize(), null, 'json')
					  .success(function(data) {
					      if(localStorage.getItem("autorecalcLink")){
						  $.post(localStorage.getItem("autorecalcLink"), JSON.parse(localStorage.getItem("autorecalcData")))
						   .success(function(data) {
						       localStorage.removeItem("autorecalcLink");
						       localStorage.removeItem("autorecalcData");
						       if(cb)
							   cb(insertRequest);
						       else
							   window.location = "<?php echo $backhref?>";
						   })
						   .error(function(err){
						       localStorage.removeItem("autorecalcLink");
						       localStorage.removeItem("autorecalcData");
						       window.location = "<?php echo $backhref?>";
						   });
					      } else if(cb)
						  cb(insertRequest);
					      else
						  window.location = "<?php echo $backhref?>";
					  })
						   .error(function(err){
					   console.log('wrong');
				       });
		 }
	     });
	 }
     }
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveItem(){
	 var itemData = $("#itemData");

	 if (validateForm(itemData)) {
	     var attachments = $("input[type=file]");

	     var formData = new FormData();

	     for (var i = 0; i < attachments.length; i++) {
		 formData.append('file[]', attachments[i].files[0]);
	     }

	     $.ajax({
		 url : 'upload.php',
		 type : 'POST',
		 data : formData,
		 processData: false,  // tell jQuery not to process the data
		 contentType: false,  // tell jQuery not to set contentType
		 success : function(e) {
                     try {
			 var res = JSON.parse(e).data;
			 var file_attachments = $(".file_attachment");

			 for (var i = 0; i < res.length; i++) {
			     file_attachments.val(res[i]);
			 }
                     }
                     catch (e){}
                     $.post("<?php echo $linksMaker->makeGridItemSave($ascope["path"]); ?>", itemData.serialize(), null, 'json')
				       .success(function(data) {
					   console.log(localStorage.getItem("autorecalcLink"));
					   if(localStorage.getItem("autorecalcLink")){
					       $.post(localStorage.getItem("autorecalcLink"), JSON.parse(localStorage.getItem("autorecalcData")))
						.success(function(data) {
						    localStorage.removeItem("autorecalcLink");
						    localStorage.removeItem("autorecalcData");
						    window.location = "<?php echo $backhref?>";
						})
						.error(function(err){
						    localStorage.removeItem("autorecalcLink");
						    localStorage.removeItem("autorecalcData");
						    window.location = "<?php echo $backhref?>";
						});
					   }else
					   window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]) . $back ; ?>";
				       })
				       .error(function(err){
					   console.log('wrong');
				       });
		 }
	     });
	 }
     }
    </script>
</div>

<?php require __DIR__ . "/../../../dialogChooser.php"; ?>
