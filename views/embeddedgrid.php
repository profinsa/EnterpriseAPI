<?php

    require_once  './views/gridView/blocks/common.php';
?>

<table id="example23" class="<?php echo isset($embeddedGridClasses) ? $embeddedGridClasses : ""; ?> datatable table table-striped table-bordered">
    <thead>
        <tr>
            <?php
	        if (count($rows) > 0){
		    if(property_exists($data, "detailPages") && key_exists($ascope["category"], $data->detailPages) && key_exists("hideRowActions", $data->detailPages[$ascope["category"]]));
		    else
			echo "<th></th>";
		} else if(count($rows) == 0) {
		    echo "<th></th>";
		}
	        //getting data for table
	        //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
	        //we use first row of data for column rendering, each row is object with columnname=>value pairs
	        if(count($rows)){
		    foreach($rows[0] as $key =>$value)
		    if(key_exists($key, $gridFields))
			echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
		}
	    ?>
        </tr>
    </thead>
    <tbody>
	<?php
	    if(!isset($embeddedgridFields))
	        $embeddedgridFields = property_exists($data, "embeddedgridFields") ? $data->embeddedgridFields : $data->transactionsFields;
	    //renders table rows using rows, getted in previous block with $data->getPage()
	    //also renders buttons like edit, delete of row
	    if(count($rows)){
	        $current_row = 0;
	        foreach($rows as $row){
		    //creating keyString - it is string, contains all keys of table. It used with combination with id of row
		    $keyString = '';
		    //			    foreach($data->gridIdFields as $key){
		    //				$keyString .= $row[$key] . "__";
		    //			    }
		    //			    $keyString = substr($keyString, 0, -2);

		    echo "<tr>";
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
		    if (property_exists($data, "detailPages")&& key_exists($ascope["category"], $data->detailPages) && key_exists("hideRowActions", $data->detailPages[$ascope["category"]]));
		    else {
			echo "<td>";
			if(key_exists("TransactionType", $row) && key_exists("TransactionNumber", $row)){
			    echo "<a href=\"";
			    echo $drill->getViewHrefByTransactionNumberAndType($row["TransactionNumber"], $row["TransactionType"]);
			    echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
			}

			if(function_exists("makeRowActions")){
			    makeRowActions($linksMaker, $data, $ascope, $row, $embeddedgridContext);
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
		    foreach($row as $key=>$value)
		    if(key_exists($key, $gridFields)){
			echo "<td>\n";
                        $columnDef = $gridFields[$key];
                        $column = $key;
			if(key_exists("editable", $columnDef) && $columnDef["editable"])
			    echo renderInput($ascope, $data, $gridFields, $columnDef, $column, $row[$column], $keyString, $current_row);
			else
			    echo renderGridValue($linksMaker, $ascope, $data, $gridFields, $drill, $row, $column, $row[$column]);
			echo "</td>\n";
		    }
		    echo "</tr>";
		    $current_row++;
	        }
	    }
	?>
    </tbody>
</table>

<script>
 <?php
     echo "var gridItems = " . json_encode($rows) . ";";
 ?>
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
     //console.log(JSON.stringify(gridItems[row], null, 3));
     /*	 $.post("", obj)
	.success(function(data) {
	onlocation(window.location);
	})
	.error(function(err){
	console.log('wrong');
	});*/
 }
</script>
