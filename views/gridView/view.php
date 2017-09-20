<?php
if(key_exists("back", $_GET)){
    if(strpos($_GET["back"], "=" . $ascope["path"] . "&") === false){
	$backhref = $_GET["back"] . "&back=" . urlencode($_GET["back"]);
	$back = "&back=" . urlencode($_GET["back"]);
    }else{
	$backhref = $linksMaker->makeGridLink($ascope["path"]);
	$back = "&back=" . urlencode($linksMaker->makeGridLink($ascope["path"]));
    }
}else{
    $backhref = "index.php#/?page=grid&action={$ascope["path"]}&mode=grid&category=Main&item=all";
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
<div id="row_viewer" class="row">
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
	<?php foreach($data->editCategories as $key =>$value):  ?>
	    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo makeId($key); ?>">
		<?php
		$curCategory = $key;
		$item = $data->getEditItem($ascope["item"], $key);
		$leftWidth = property_exists($data, "editCategoriesWidth") ? $data->editCategoriesWidth["left"] : 50;
		$rightWidth = property_exists($data, "editCategoriesWidth") ? $data->editCategoriesWidth["right"] : 50;
		?>
		<div class="table-responsive" style="margin-top:10px;">
		    <?php if(!property_exists($data, "detailPages") ||
			     !key_exists($curCategory, $data->detailPages)||
			     !key_exists("hideFields", $data->detailPages[$curCategory])):?>
			<table class="table">
			    <thead>
				<tr>
				    <th style="width:<?php echo $leftWidth; ?>%">
					<?php echo $translation->translateLabel("Field"); ?>
				    </th>
				    <th style="width:<?php echo $rightWidth; ?>%">
					<?php echo $translation->translateLabel("Value"); ?>
				    </th>
				</tr>
			    </thead>
			    <tbody id="row_viewer_tbody">
				<?php
				//renders table, contains record data using getEditItem from model
				$category = $key;
				foreach($item as $key =>$value){
				    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
				    if(key_exists($key, $data->editCategories[$category]) && key_exists("alwaysEdit", $data->editCategories[$category][$key])){
					switch($data->editCategories[$category][$key]["inputType"]){
                        case "text" :
						//renders text input with label
						echo "<tr><td>$translatedFieldName</td><td><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
						if(key_exists("formatFunction", $data->editCategories[$category][$key])){
						    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
						    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
						}
						else
						    echo formatField($data->editCategories[$category][$key], $value);

						echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
						   ."></td></tr>";
						break;
						
					    case "datetime" :
						//renders text input with label
						echo "<tr><td>$translatedFieldName</td><td><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
						     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
						    ."></td></tr>";
						break;

					    case "checkbox" :
						//renders checkbox input with label
						echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
						echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
						     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit") || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "disabled" : "")
						    ."></div></div>";
						break;
						
					    case "dropdown" :
						//renders select with available values as dropdowns with label
						echo "<tr><td>$translatedFieldName</td><td><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\" onchange=\"gridViewEditOnDropdown(event)\">";
						$method = $data->editCategories[$category][$key]["dataProvider"];
						if(key_exists("depends", $data->editCategories[$category][$key])){
						    $dropdownDepends[$key] = [
							"depends" =>$data->editCategories[$category][$key]["depends"],
							"data" => $data->$method()
						    ];
						    $types = [];
						}else
						$types = $data->$method();
						
						if($value)
						    echo "<option value=\"" . $value . "\">" . (key_exists($value, $types) ? $types[$value]["title"] : $value) . "</option>";
						else
						    echo "<option></option>";

						foreach($types as $type)
						    if(!$value || $type["value"] != $value)
							echo "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
						echo"</select></td></tr>";
						break;
					}
				    }else if(key_exists($key, $data->editCategories[$category])){
					echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
					switch($data->editCategories[$category][$key]["inputType"]){
                        case "file" :
						echo "<img style=\"height:50px;width:auto;max-width:200px\" src=\"uploads/" . $value . "\">";
						break;
					    case "checkbox" :
						echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
						break;
					    case "timestamp" :
					    case "datetime" :
						echo date("m/d/y", strtotime($value));
						break;
					    case "text":
					    case "dialogChooser":
					    case "dropdown":
						if(key_exists("formatFunction", $data->editCategories[$category][$key])){
						    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
						    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
						}
						else
						    echo formatField($data->editCategories[$category][$key], $value);						    break;
					}
					echo "</td></tr>";
				    }
				}
				?>
			    </tbody>
			</table>
		    <?php endif; ?>
		    <?php if(property_exists($data, "detailPages") && key_exists($curCategory, $data->detailPages)):?>
			<?php if(property_exists($data, "detailPagesAsSubgrid")):?>
			    <div id="subgrid" class="col-md-12 col-xs-12">
			    </div>
			    
			    <script>
			     function setRecalc(id){
				 var recalcLink = "<?php echo $linksMaker->makeProcedureLink($ascope["path"], "Recalc"); ?>";
				 //automatic recalc if we back from detail
				 localStorage.setItem("recalclLink", recalcLink);
				 localStorage.setItem("autorecalcLink", recalcLink);
				 localStorage.setItem("autorecalcData", JSON.stringify({
				     "<?php echo $data->idFields[3]; ?>" : id
				 }));
			     }
			     newSubgridItemHook = false;
			     function subgridView(subgridmode, keyString){
				 var detailRewrite = {
				     "ViewGLTransactions" : "LedgerTransactionsDetail"
				 }, ind;
				 var path = new String(window.location);
				 path = path.replace(/#\/\?/, "?");
				 path = path.replace(/page\=grid/, "page=subgrid");
				 path = path.replace(/mode\=view|mode\=edit|mode\=new/, "mode=subgrid");
				 if(keyString){
				     path = path.replace(/mode\=subgrid/, "mode=new");
				     if(path.search(/item\=/) == -1)
					 path += "&item=" + keyString;
				 }
				 
				 for(ind in detailRewrite)
				     path = path.replace(new RegExp(ind), detailRewrite[ind]);
				 $.get(path)
				  .done(function(data){
				      setTimeout(function(){
					  $("#subgrid").html(data);
					  datatableInitialized = true;
					  setTimeout(function(){
					      var buttons = $('.subgrid-buttons');
					      var tableFooter = $('.subgrid-table-footer');
					      tableFooter.prepend(buttons);
					  },300);
				      },0);
				  })
				  .error(function(xhr){
				      // if(xhr.status == 401)
					  //    else
				      //	  alert("Unable to load page");
				  });
			     }
			     subgridView();
			    </script>
			<?php else: ?>
			    <div class="col-md-12 col-xs-12">
				<?php
				$getmethod = "get" . makeId($curCategory);
				$deletemethod = "delete" . makeId($curCategory);
				$rows = $data->$getmethod(key_exists("OrderNumber", $item) ? $item["OrderNumber"] :
							  $item[(key_exists("detailAliases", $data->detailPages[$curCategory]) &&
								 key_exists($data->detailPages[$curCategory]["keyFields"][0], $data->detailPages[$curCategory]["detailAliases"])
								     ? $data->detailPages[$curCategory]["detailAliases"][$data->detailPages[$curCategory]["keyFields"][0]]
							       : $data->detailPages[$curCategory]["keyFields"][0])]);
				//			echo json_encode($rows);
				$detailTable = $data->detailPages[$curCategory];
				$gridFields = $embeddedgridFields = $detailTable["gridFields"];
				$deleteProcedure = "delete" . makeid($curCategory);
				$embeddedgridContext = [
				    "item" =>$item,
				    "detailTable" => $detailTable
				];
				$embeddedGridClasses = $newButtonId = "new" . makeId($curCategory);
				require __DIR__ . "/../embeddedgrid.php"; 
				?>
			    </div>
			    <div id="<?php echo $newButtonId; ?>" class="row col-md-1">
				<?php if(!key_exists("disableNew", $data->detailPages[$curCategory])): ?>
				    <a class="btn btn-info" href="<?php echo $linksMaker->makeEmbeddedgridItemNewLink($data->detailPages[$curCategory]["viewPath"], $ascope["path"], "new", $ascope["item"]) . "&{$data->detailPages[$curCategory]["newKeyField"]}={$embeddedgridContext["item"][$data->detailPages[$curCategory]["newKeyField"]]}" ?>">
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
			    </script>
			<?php endif; ?>
		    <?php endif; ?>
		</div>
	    </div>
	<?php endforeach; ?>
    </div>
    <?php
    if(file_exists(__DIR__ . "/../" . $PartsPath . "viewFooter.php"))
	require __DIR__ . "/../" . $PartsPath . "viewFooter.php";
    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
    ?>

    <div class="col-md-12 col-xs-12 row">
	<div style="margin-top:10px" class="pull-right">
	    <!--
		 buttons Edit and Cancel
		 for translation uses translation model
		 for category(which tab is activated) uses $ascope of controller
	       -->
	    <?php if($security->can("update") && (property_exists($data, "modes")  && in_array("edit", $data->modes) || !property_exists($data, "modes"))): ?>
		<a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemEdit($ascope["path"], $ascope["item"] . $back); ?>">
		    <?php echo $translation->translateLabel("Edit"); ?>
		</a>
	    <?php endif; ?>
	    <?php
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "viewActions.php"))
		require __DIR__ . "/../" . $PartsPath . "viewActions.php";
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
		require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
	    ?>
	    <a class="btn btn-info" href="<?php echo $backhref; ?>">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </div>
</div>
<script>
 var gridDropdownDepends = <?php echo json_encode($dropdownDepends); ?>;
 function gridViewEditOnDropdown(e){
     if(gridDropdownDepends.hasOwnProperty(e.target.id))
	 return;
     var ind, dind, depends;
     for(ind in gridDropdownDepends){
	 dependsItem = gridDropdownDepends[ind];
	 for(dind in dependsItem.depends){
	     if(!dependsItem.hasOwnProperty("ddata"))
		 dependsItem.ddata = {};
	     if(dependsItem.depends[dind] == e.target.id)
		 dependsItem.ddata[dind] = e.target.value;
	 }
     }
     var records, rind, html;
     for(ind in gridDropdownDepends){
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
</script>
