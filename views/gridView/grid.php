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

     Last Modified: 26.06.2019
     Last Modified by: Nikita Zaharov
-->

<?php
    require  './views/gridView/blocks/common.php';
?>

<?php if(!property_exists($data, "features") || !in_array("disabledGridPageUI", $data->features)): ?>
    <div id="grid_content" class="row">
	<?php
            //disabled duplicate header, i don't know for what it is
            //	    if($ascope["interface"] == "default")
            //require __DIR__ . '/../interfaces/' . $ascope["interface"] . '/breadcrumbs.php';
	?>
	<div class="table-responsive">
<?php endif; ?>
<?php
    //getting data for table
    $rows = $data->getPage($ascope["item"]);
?>
<table id="example23" class="table table-striped <?php echo $ascope["interface"] == "simple" ?  "table-bordered" : ""?>">
    <thead>
	<tr>
	    <?php
		if(property_exists($data, "features") && in_array("selecting", $data->features))
		    echo "<th></th>";
		if(!property_exists($data, "modes") || count($data->modes) != 1 || !in_array("grid", $data->modes) || file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php"))
		    echo "<th></th>";
	    ?>
	    <?php
		//renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
		if(count($rows)){
		    foreach($data->gridFields as $key =>$value)
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
			    if(key_exists("editable", $columnDef) && $columnDef["editable"])
				echo renderInput($ascope, $data, $data->gridFields, $columnDef, $column, $row[$column], $keyString, $current_row);
			    else
				echo renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, $column, $row[$column]);
			    echo "</td>\n";
			}
			echo "</tr>";
		    }
		    $current_row++;
		}
	    }
	?>
    </tbody>
</table>
<?php if(!property_exists($data, "features") || !in_array("disabledGridPageUI", $data->features)): ?>
	</div>
	<div class="dt-buttons-container row col-md-12">
	    <?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
		<a class="btn btn-info new-button-action dt-button waves-effect waves-light m-r-10" href="index.php#/?page=<?php echo  $app->page; ?>&action=<?php echo $scope->action ?>&mode=new&category=Main">
		    <?php echo $translation->translateLabel("New"); ?>
		</a>
	    <?php endif; ?>
	    <?php
		if(file_exists(__DIR__ . "/../" . $PartsPath . "gridActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "gridActions.php";
	    ?>
	</div>
<?php endif; ?>
<script>
 <?php
     if(property_exists($data, "features") && in_array("selecting", $data->features))
	 echo "var gridItems = " . json_encode($rows) . ";";
 ?>
 var gridItemsSelected = window.gridItemsSelected = {};
 //select handler, fill out gridViewSelected by rows
 function gridSelectItem(event, item){
     if(event.currentTarget.checked)
         gridItemsSelected[item] = gridItems[item];
     else
	 delete gridItemsSelected[item];
     //console.log(JSON.stringify(gridItemsSelected));
 }

 //hander delete button from rows. Just doing XHR request to delete item and redirect to grid if success
 function gridDeleteItem(keyString){
     if(confirm("Are you sure?")){
	 var itemData = $("#itemData");
	 $.getJSON("index.php?page=<?php  echo $app->page . "&action=" . $scope->action ;  ?>&delete=true&id=" + keyString)
	  .success(function(data) {
	      onlocation(window.location);
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
 }

 var gridItemsChanged = {};
 //handler for item changing
 function gridChangeItem(item, columnName, row){
     var keyAndId = item.id.split("___");
     //	 console.log(item.id);
     var obj = {
	 "id" : keyAndId[0],
	 "category" : "main",
	 "row" : row
     };
     obj[keyAndId[1]] = gridItems[row][columnName] = $(item).val();
     //console.log(JSON.stringify(obj, null, 3));
     /*	 $.post("", obj)
	.success(function(data) {
	onlocation(window.location);
	})
	.error(function(err){
	console.log('wrong');
	});*/
 }
</script>
