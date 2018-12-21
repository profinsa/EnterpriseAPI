<!--
     Name of Page: grid

     Method: renders content of screen in grid mode. 

     Date created: Nikita Zaharov, 09.03.2017

     Use: used by views/gridView.php for rendering content in grid mode
     Data displayed as table. Each row is item and create and delete actions.

     Input parameters:

     Output parameters:
     html

     Called from:
     views/gridView.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 12.21.2018
     Last Modified by: Nikita Zaharov
-->

<?php
    function myurlencode($keystring) {
	return str_replace("%2F", "+++", urlencode($keystring));
    }

    function renderGridValue($ascope, $data, $drill, $row, $key, $value){
	switch($data->gridFields[$key]["inputType"]){
	    case "checkbox" :
		return $value ? "True" : "False";
		break;
	    case "timestamp" :
	    case "datetime" :
		return date("m/d/y", strtotime($value));
		break;
	    case "text":
	    case "dropdown":
		switch($key){
		    case "CustomerID" :
			return $drill->getLinkByField($key,$value);
			break;
		    case "VendorID" :
			return $drill->getLinkByField($key,$value);
			break;
		    case "OrderNumber" :
			return $drill->getReportLinkByOrderNumber($value, $ascope["pathPage"]);
			break;
		    case "InvoiceNumber" :
			return $drill->getReportLinkByInvoiceNumber($value, $ascope["pathPage"]);
			break;
		    default:
			if(key_exists("formatFunction", $data->gridFields[$key])){
			    $formatFunction = $data->gridFields[$key]["formatFunction"];
			    return $data->$formatFunction($row, "gridFields", $key, $value, false);
			}
			else
			    return formatField($data->gridFields[$key], $value);
			break;
		}
	}
    }

    function renderInput($ascope, $data, $item, $key, $value, $keyString){
	switch($data->gridFields[$key]["inputType"]){
	    case "text" :
		//renders text input with label
		echo "<input style=\"display:inline\" type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this);\" class=\"form-control\" value=\"";
		if(key_exists("formatFunction", $data->gridFields[$key])){
		    $formatFunction = $data->gridFields[$key]["formatFunction"];
		    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
		}
		else
		    echo formatField($data->gridFields[$key], $value);

		echo"\" " . ( (key_exists("disabledEdit", $data->gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $data->gridFields[$key]) && $ascope["mode"] == "new") ? "readonly" : "")
	       .">";
		break;

	    case "datetime" :
		//renders text input with label
		echo "<input type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this);\" class=\"form-control fdatetime\" value=\"" . ($value == 'now' || $value == "0000-00-00 00:00:00" || $value == "CURRENT_TIMESTAMP"? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
		     ( (key_exists("disabledEdit", $data->gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $data->gridFields[$key]) && $ascope["mode"] == "new") ? "readonly" : "")
		    .">";
		break;

	    case "checkbox" :
		//renders checkbox input with label
		echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
		echo "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this);\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
		     ( (key_exists("disabledEdit", $data->gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view")) || (key_exists("disabledNew", $data->gridFields[$key]) && $ascope["mode"] == "new") ? "disabled" : "")
		    .">";
		break;

	    case "dialogChooser":
		$dataProvider = $data->gridFields[$key]["dataProvider"];
		if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"]))
		    $GLOBALS["dialogChooserTypes"][$dataProvider] = "hophop";
		$GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
		echo "<input type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"$value\" onchange=\"gridChangeItem(this);\">";
		break;

	    case "dropdown" :
		//renders select with available values as dropdowns with label
		echo "<select class=\"form-control subgrid-input\" name=\"" . $key . "\" id=\"{$keyString}___" . $key . "\" onchange=\"gridChangeItem(this);\">";
		$method = $data->gridFields[$key]["dataProvider"];
		if(key_exists("dataProviderArgs", $data->gridFields[$key])){
		    $args = [];
		    foreach($data->gridFields[$key]["dataProviderArgs"] as $argname)
		    $args[$argname] = $item[$argname];
		    $types = $data->$method($args);
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
		echo"</select>";
		break;
	}
    }
?>

<div id="grid_content" class="row">
    <h3 class="box-title m-b-0"><?php echo $data->dashboardTitle ?></h3>
    <p class="text-muted m-b-30"><?php echo $data->dashboardTitle ?></p>
    <div class="table-responsive">
	<script>
	 <?php
	     //getting data for table
	     $rows = $data->getPage($ascope["item"]);
	     if(property_exists($data, "features") && in_array("selecting", $data->features))
		 echo "var gridItems = " . json_encode($rows) . ";";
	 ?>
	</script>
	<table id="example23" class="table table-striped">
	    <thead>
		<tr>
		    <?php
			if(property_exists($data, "features") && in_array("selecting", $data->features))
			    echo "<th></th>";
		    ?>
		    <th></th>
		    <?php
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
		    //renders table rows using rows, getted in previous block with $data->getPage()
		    //also renders buttons like edit, delete of row
		    if(count($rows)){
			$current_row = 0;
			foreach($rows as $row){
			    //creating keyString - it is string, contains all keys of table. It used with combination with id of row 
			    $keyString = '';
			    foreach($data->idFields as $key){
				$keyString .= $row[$key] . "__";
			    }
			    $keyString = substr($keyString, 0, -2);

			    //including custom row renderer
			    if(file_exists(__DIR__ . "/../" . $PartsPath . "gridRowCustom.php"))
				require __DIR__ . "/../" . $PartsPath . "gridRowCustom.php";
			    else {
				echo "<tr>";
				//disabling or enabling selecting feature in grid(used by grid actions, for example in General Ledger-> Ledger -> Transactions Closed for selecting transactions and click on Copy Selected to History)
				//this feature enabled in data model, if model has features propery
				if(property_exists($data, "features") && in_array("selecting", $data->features))
				    echo "<td><input type=\"checkbox\" onchange=\"gridSelectItem(event, '" . $current_row . "')\"></td>";
				/*
				   this column contains row actions like edit, remove, print etc.
				   Each action may be any html code. For now usually we have two type actions:
				   - action link
				   just link, no javascript login. Example - edit action is just link to edit page. Link contains $keyString for accurate pointing to edited item
				   - javascript action
				   some code react on click and does job. Example - delete button. In end of this file we have
				   ngridDeleteItem function which called on click and just does XHR delete request and reload
				   page content after receiving result
				 */
				if(!property_exists($data, "modes") || count($data->modes) != 1 || !in_array("grid", $data->modes) || file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php")){
				    echo "<td>";
				    //edit action, just link on edit page. Showed if user has select permission
				    if($security->can("select") && (!property_exists($data, "modes") || in_array("view", $data->modes)))
					echo "<a href=\"" . (property_exists($data, "onlyEdit") ? $linksMaker->makeGridItemEdit($ascope["path"], urlencode($keyString)) : $linksMaker->makeGridItemView($ascope["path"], urlencode($keyString))) ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
				    /*delete action, call javascript function with keyString as parameter then function call XHR 
				       delete request on server
				       It is showed only if not disabled by modes property of data model and user has delete permission
				     */
				    if(!property_exists($data, "modes") || in_array("delete", $data->modes)){
					if($security->can("delete"))
					    echo "<span onclick=\"gridDeleteItem('" . myurlencode($keyString) . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
				    }

				    /*
				       Each grid page(each screen) can have own row actions.
				       Like actions above it is just a html. It can have javascript or not
				       $PartsPath is path part what depends of current screen on which the user is located
				       For example, we want to add some actions to Account Receivable -> Order Processing -> View Orders
				       then we need create file gridRowActions on that path: resources/view/EnterpriseASPAR/OrderProcessing/OrderHeaderList/gridRowActions.php and add to it some html
				     */
				    //including custom row actions
				    if(file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php"))
					require __DIR__ . "/../" . $PartsPath . "gridRowActions.php";

				    echo "</td>";
				}
				/*
				   Output values. Each value just a text inside td.
				   Value can be formatted if it needed by its type. For example datetime prints as month/day/year
				   Also here is the formatting using formatFunction. This feature used by formatting Currency fields
				 */
				foreach($data->gridFields as $column =>$columnDef){
				    echo "<td>\n";
				    echo renderGridValue($ascope, $data, $drill, $row, $column, $row[$column]);
				    echo "</td>\n";
				}
				echo "</tr>";
			    }
			    $current_row++;
			}
		    }
		?>
		<!-- 		<?php
				    //renders table rows using rows, getted in previous block
				    //also renders buttons like edit, delete of row
				    if(count($rows)){
				    $current_row = 0;
				    foreach($rows as $row){
				    $keyString = '';
				    foreach($data->idFields as $key){
				    $keyString .= $row[$key] . "__";
				    }
				    $keyString = substr($keyString, 0, -2);
				    echo "<tr>";
				    //disabling or enabling selecting feature in grid(used by grid actions, for example in General Ledger-> Ledger -> Transactions Closed for selecting transactions and click on Copy Selected to History)
				    //this feature enabled in data model, if model has features propery
				    if(property_exists($data, "features") && in_array("selecting", $data->features))
				    echo "<td><input type=\"checkbox\" onchange=\"gridSelectItem(event, '" . $current_row . "')\"></td>";
				    echo "<td>";
				    /*
				    this column contains row actions like edit, remove, print etc.
				    Each action may be any html code. For now usually we have two type actions:
				    - action link
				    just link, no javascript login. Example - edit action is just link to edit page. Link contains $keyString for accurate pointing to edited item
				    - javascript action
				    some code react on click and does job. Example - delete button. In end of this file we have
				    ngridDeleteItem function which called on click and just does XHR delete request and reload
				    page content after receiving result
				    */
				    if($security->can("select") && (!property_exists($data, "modes") || in_array("view", $data->modes)))
				    echo "<a href=\"index.php#/?page=" . $app->page . "&action=" . $scope->action . "&mode=view&category=Main&item=" . $keyString ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
				    /*delete action, call javascript function with keyString as parameter then function call XHR 
				    delete request on server
				    It is showed only if not disabled by modes property of data model and user has delete permission
				    */
				    if(!property_exists($data, "modes") || in_array("delete", $data->modes)){
				    if($security->can("delete"))
				    echo "<span onclick=\"gridDeleteItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
				    }
				    /*
				    Each grid page(each screen) can have own row actions.
				    Like actions above it is just a html. It can have javascript or not
				    $PartsPath is path part what depends of current screen on which the user is located
				    For example, we want to add some actions to Account Receivable -> Order Processing -> View Orders
				    then we need create file gridRowActions on that path: resources/view/EnterpriseASPAR/OrderProcessing/OrderHeaderList/gridRowActions.php and add to it some html
				    */
				    //including custom row actions
				    if(file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php"))
				    require __DIR__ . "/../" . $PartsPath . "gridRowActions.php";

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
				    switch($key){
				    case "CustomerID" :
				    echo $drill->getLinkByField($key,$value);
				    break;
				    case "VendorID" :
				    echo $drill->getLinkByField($key,$value);
				    break;
				    case "OrderNumber" :
				    echo $drill->getReportLinkByOrderNumber($value, $page);
				    break;
				    case "InvoiceNumber" :
				    echo $drill->getReportLinkByInvoiceNumber($value, $page);
				    break;
				    default:
				    if(key_exists("formatFunction", $data->gridFields[$key])){
				    $formatFunction = $data->gridFields[$key]["formatFunction"];
				    echo $data->$formatFunction($row, "gridFields", $key, $value, false);
				    }
				    else
				    echo formatField($data->gridFields[$key], $value);
				    break;
				    }
				    }
				    echo "</td>\n";
				    }
				    echo "</tr>";
				    $current_row++;
				    }
				    }
				    ?> -->
	    </tbody>
	</table>
    </div>
    <div>
	<?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
	    <a class="btn btn-info waves-effect waves-light m-r-10" href="index.php#/?page=<?php echo  $app->page; ?>&action=<?php echo $scope->action ?>&mode=new&category=Main">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
	<?php
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "gridActions.php"))
		require __DIR__ . "/../" . $PartsPath . "gridActions.php";
	?>
    </div>
    <script>
     var gridItemsSelected = window.gridItemsSelected = {};
     //select handler, fill out gridViewSelected by rows
     function gridSelectItem(event, item){
	 if(event.currentTarget.checked)
             gridItemsSelected[item] = gridItems[item];
	 else
	     delete gridItemsSelected[item];
	 console.log(JSON.stringify(gridItemsSelected));
     }
     
     //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function gridDeleteItem(item){
	 if(confirm("Are you sure?")){
	     var itemData = $("#itemData");
	     $.getJSON("index.php?page=<?php  echo $app->page . "&action=" . $scope->action ;  ?>&delete=true&id=" + item)
	      .success(function(data) {
		  onlocation(window.location);
	      })
	      .error(function(err){
		  console.log('wrong');
	      });
	 }
     }

     //handler for item changing
     function gridChangeItem(item){
	 var keyAndId = item.id.split("___");
	 //	 console.log(item.id);
	 var obj = {
	     "id" : keyAndId[0],
	     "category" : "main"
	 };
	 obj[keyAndId[1]] = $(item).val();	    
/*	 $.post("", obj)
	  .success(function(data) {
	      onlocation(window.location);
	  })
	  .error(function(err){
	      console.log('wrong');
	  });*/
     }
    </script>
</div>

