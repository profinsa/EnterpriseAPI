<?php
/*
     Name of Page: subgrid

     Method: renders subgrid grid. 

     Date created: Nikita Zaharov, 04.03.2017

     Use: used by controllers/GeneralLedger/*.php for rendering page
     Page may renders in four modes:
     + grid
     data is displayed in table mode
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

     Last Modified: 24.07.2019
     Last Modified by: Nikita Zaharov
*/

$GLOBALS["dialogChooserTypes"] = [];
$GLOBALS["dialogChooserInputs"] = [];
?>

<div id="grid_content" class="row">
    <form id="subgridData">
	<?php
        $keyValues = explode("__", $ascope["items"]);
        $keyFields = "";
        foreach($data->idFields as $key){
	    $keyValue = array_shift($keyValues);
	    if($keyValue && $key != "CompanyID" && $key != "DivisionID" && $key != "DepartmentID")
		echo "<input type=\"hidden\" name=\"$key\" value=\"$keyValue\" class=\"$key\"/>";
        }
	?>
	<table id="example23" class="table table-striped table-bordered">
	    <thead>
		<tr>
		    <th></th>
		    <?php
		    //getting data for table
		    $rows = $data->getPage($ascope["items"]);
		    //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
		    foreach($data->gridFields as $key =>$value)
			echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
		    ?>
		</tr>
	    </thead>
	    <tbody>
		<?php
		//renders table rows using rows, getted in previous block
		//also renders buttons like edit, delete of row
		function renderRow($scope, $security, $data, $keyString, $row, $create){
		    if($scope["item"] == $keyString || $create){
			echo "<tr>";
			echo "<td style=\"text-align:center\"><input type=\"hidden\" name=\"id\" value=\"" . $scope["item"] . "\" />";
			if($security->can("select"))
			    echo "<span class=\"grid-action-button glyphicon glyphicon-floppy-disk\" aria-hidden=\"true\" style=\"vertical-align:middle;\" onclick=\"saveSubgridItem('" . $scope["mode"] . "','" . $keyString . "')\"></span>";
			if($security->can("delete"))
			    echo "<span onclick=\"cancelSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\" style=\"vertical-align:middle;\" onclick=\"cancelsaveItem()\"></span>";
			echo "</td>";
			foreach($data->gridFields as $fieldName=>$fieldDesc){
			    $key = $fieldName;
			    $value = $row[$fieldName];
			    echo "<td>\n";
			    switch($data->gridFields[$key]["inputType"]){
				case "text" :
				    //renders text input with label
				    echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control subgrid-input $key\" value=\"";
				    if(key_exists("formatFunction", $data->gridFields[$key])){
					$formatFunction = $data->gridFields[$key]["formatFunction"];
					echo $data->$formatFunction($row, "gridFields", $key, $value, false);
				    }
				    else
					echo formatField($data->gridFields[$key], $value);

				    echo"\" " . ( (key_exists("disabledEdit", $data->gridFields[$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->gridFields[$key]) && $scope["mode"] == "new") ? "readonly" : "")
				       .">";
				    break;
				    
				case "datetime" :
				    //renders text input with label
				    echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime subgrid-input $key\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
                                                     ( (key_exists("disabledEdit", $data->gridFields[$key]) && $scope["mode"] == "edit")  || (key_exists("disabledNew", $data->gridFields[$key]) && $scope["mode"] == "new") ? "readonly" : "")
					.">";
				    break;

				case "checkbox" :
				    //renders checkbox input with label
				    echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
				    echo "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control subgrid-input $key\" value=\"1\" " . ($value ? "checked" : "") ." " .
					 ( (key_exists("disabledEdit", $data->gridFields[$key]) && $scope["mode"] == "edit") || (key_exists("disabledNew", $data->gridFields[$key]) && $scope["mode"] == "new") ? "disabled" : "")
					.">";
				    break;
				    
				case "dialogChooser":
                    $dataProvider = $data->gridFields[$key]["dataProvider"];
                    if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"])){
						$GLOBALS["dialogChooserTypes"][$dataProvider] = $data->gridFields[$key];
						$GLOBALS["dialogChooserTypes"][$dataProvider]["fieldName"] = $key;
                    }
                    $GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
				    echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control subgrid-input $key\" value=\"$value\">";
				    break;
				    
				case "dropdown" :
				    //renders select with available values as dropdowns with label
				    echo "<select class=\"form-control subgrid-input $key\"name=\"" . $key . "\" id=\"" . $key . "\">";
				    $method = $data->gridFields[$key]["dataProvider"];
				    $types = $data->$method();
				    if($value)
					echo "<option value=\"" . $value . "\">" . (key_exists($value, $types) ? $types[$value]["title"] : $value) . "</option>";
				    else
					echo "<option></option>";

				    foreach($types as $type)
					if(!$value || $type["value"] != $value)
					    echo "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
				    echo"</select>";
				    break;
			    }
			    echo "</td>\n";
			}
			echo "</tr>";
		    }else{
			echo "<tr><td>";
			if($security->can("update"))
			    echo "<span onclick=\"changeSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span>";
			if($security->can("delete"))
			    echo "<span onclick=\"deleteSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
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
				    case "dialogChooser" :
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
		if(count($rows)){
		    foreach($rows as $row){
			$keyString = '';
			foreach($data->idFields as $key){
			    $keyString .= $row[$key] . "__";
			}
			$keyString = substr($keyString, 0, -2);
			renderRow($ascope, $security, $data, $keyString, $row, false);
		    }
		}
		if($ascope["mode"] == 'new'){
		    $item =  $data->getNewItem($ascope["item"], $ascope["category"]);
		    renderRow($ascope, $security, $data, false, $item, true);
		}
		?>
	    </tbody>
	</table>
    </form>
    <div class="dt-buttons-container row col-md-12">
	<br/>
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	    <a class="btn btn-info new-button-action dt-button" href="index.php#/grid/<?php echo $ascope["action"] ?>/new/Main/new">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
    </div>
    <script>
     //handler of save button if we in edit or insert mode. Just doing XHR request to save data
     function saveSubgridItem(mode){
	 var itemData = $("#subgridData");
	$.post("index.php?page=subgrid&action=<?php  echo $scope->action; ?>&" + (mode == "edit" ? "update=true" : "new=true"  + "&items=<?php echo $scope->items;  ?>"), itemData.serialize(), null, 'json')
	  .success(function(data) {
	      if(localStorage.getItem("autorecalcLink")){
		  $.post(localStorage.getItem("autorecalcLink"), JSON.parse(localStorage.getItem("autorecalcData")))
		   .success(function(data) {
		       localStorage.removeItem("autorecalcLink");
		       localStorage.removeItem("autorecalcData");
		       onlocation(window.location);
		   })
		   .error(function(err){
		       localStorage.removeItem("autorecalcLink");
		       localStorage.removeItem("autorecalcData");
		       onlocation(window.location);
		   });
	      }else
	      onlocation(window.location);
	      //	      subgridView();
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
     
     function cancelSubgridItem(item){
	 subgridView();
     }
    </script>
</div>

<?php require __DIR__ . "/../dialogChooser.php"; ?>
