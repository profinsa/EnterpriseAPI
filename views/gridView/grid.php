<!--
     Name of Page: grid

     Method: renders content of screen in grid mode. 

     Date created: Nikita Zaharov, 09.03.2016

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

     Last Modified: 07.25.2016
     Last Modified by: Nikita Zaharov
-->

<div id="grid_content" class="row">
    <h3 class="box-title m-b-0"><?php echo $data->dashboardTitle ?></h3>
    <p class="text-muted m-b-30"><?php echo $data->dashboardTitle ?></p>
    <div class="table-responsive">
	<script>
	 <?php
	 //getting data for table
	 $rows = $data->getPage($ascope["item"]);
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
			echo "<td style=\"width:100%\">";
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
		?>
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
    </script>
</div>

