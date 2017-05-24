<!-- 
     Name of Page: OrderHeaderDetail view

     Method: this view for OrderHeaderDetail in the view mode

     Date created: autogenerated

     Use: this view used for view mode. Renders all ui interface including Detail actions but only in the view mode

     Input parameters:
     $scope: common information object
     $data : model

     Output parameters:
     html
     
     Called from:
     Grid Controller

     Calls:
     model

     Last Modified: 05/24/2017
     Last Modified by: Zaharov Nikita
   -->
<div id="row_viewer" style="display:table">
    <div class="order-entry-header">
	<?php
	$headerItem = $data->getEditItem($ascope["item"], "...fields");
	?>
	<table class="col-md-12 col-xs-12 table">
	    <tbody>
		<tr class="row-header">
		    <?php foreach($data->headTableOne as $key=>$value): ?>
			<td>
			    <?php echo $translation->translateLabel($key); ?>   
			</td>
		    <?php endforeach; ?>
		</tr>
		<tr>
		    <?php foreach($data->headTableOne as $key=>$value): ?>
			<td>
			    <?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?>
			</td>
		    <?php endforeach; ?>
		</tr>
	    </tbody>
	</table>
	<table class="col-md-12 col-xs-12 table">
	    <tbody>
		<tr class="row-header">
		    <?php foreach($data->headTableTwo as $key=>$value): ?>
			<td>
			    <?php echo $translation->translateLabel($key); ?>   
			</td>
		    <?php endforeach; ?>
		</tr>
		<tr>
		    <?php foreach($data->headTableTwo as $key=>$value): ?>
			<td>
			    <?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?>
			</td>
		    <?php endforeach; ?>
		</tr>
	    </tbody>
	</table>
    </div>
    
    <ul class="nav nav-pills" role="tablist">
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#$key\" aria-controls=\"$key\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <br/>
    <!-- renders tables, contains record data using getEditItem from model  -->
    <?php
    function formatValue($data, $fieldsDefinition, $values, $key, $value){
	switch($fieldsDefinition[$key]["inputType"]){
	    case "checkbox" :
		echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
		break;
	    case "timestamp" :
	    case "datetime" :
		echo date("m/d/y", strtotime($value));
		break;
	    case "text":
	    case "dropdown":
		if(key_exists("formatFunction", $fieldsDefinition[$key])){
		    $formatFunction = $fieldsDefinition[$key]["formatFunction"];
		    echo $data->$formatFunction($values, "editCategories", $key, $value, false);
		}
		else
		    echo formatField($fieldsDefinition[$key], $value);
		break;
	}
    }
    function renderRow($translation, $data, $fieldsDefinition, $values, $key, $value){
	echo "<tr><td class=\"title\">" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
	echo formatValue($data, $fieldsDefinition, $values, $key, $value);
	echo "</td></tr>";
    }

    function makeTableItems($values, $fieldsDefinition){
	$leftItems = [];
	$rightItems = [];
	
	$itemsHalf = 0;
	$itemsCount = 0;
	foreach($values as $key =>$value){
	    if(key_exists($key, $fieldsDefinition))
		$itemsCount++;
	}
	$itemsHalf = $itemsCount/2;

	$itemsCount = 0;
	foreach($values as $key =>$value){
	    if(key_exists($key, $fieldsDefinition)){
		if($itemsCount < $itemsHalf)
		    $leftItems[$key] = $value;
		else 
		    $rightItems[$key] = $value;
		$itemsCount++;
	    }
	}
	return [
	    "leftItems" => $leftItems,
	    "rightItems" => $rightItems
	];
    }
    ?>
    <div class="tab-content">
	<?php foreach($data->editCategories as $key =>$value):  ?>
	    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo $key ?>">
		<?php
		$item = $data->getEditItem($ascope["item"], $key);
		if($key == "Customer"){
		    $customerInfo = $data->getCustomerInfo($headerItem[property_exists($data, "customerField") ? $data->customerField : "CustomerID"]);
		    $tableItems = makeTableItems($customerInfo, $data->customerFields);
		    $tableCategories = $data->customerFields;
		    $items = $customerInfo;
		}
		else {
		    $tableCategories = $data->editCategories[$key];
		    $tableItems = makeTableItems($item, $tableCategories);
		    $items = $item;
		}
		?>
		<div class="table-responsive col-md-12 col-xs-12 row">
		    <div class=" col-md-5 col-xs-5">
			<table class="table table-bordered order-entry-main-table ">
			    <tbody id="row_viewer_tbody">
				<?php 
				foreach($tableItems["leftItems"] as $key =>$value)
				    renderRow($translation, $data, $tableCategories, $items, $key, $value);
				?>
			    </tbody>
			</table>
		    </div>
		    <div class="col-md-5 col-xs-5">
			<table class="table table-bordered order-entry-main-table">
			    <tbody id="row_viewer_tbody">
				<?php 
				foreach($tableItems["rightItems"] as $key =>$value)
				    renderRow($translation, $data, $tableCategories,  $items,$key, $value);
				?>
			    </tbody>
			</table>
		    </div>
		</div>
	    </div>
	<?php endforeach; ?>
    </div>
    <div class="order-entry-header col-md-12 col-xs-12">
	<table class="table">
	    <tbody>
		<tr class="row-header">
		    <?php foreach($data->headTableThree as $key=>$value): ?>
			<td>
			    <?php echo $translation->translateLabel($key); ?>   
			</td>
		    <?php endforeach; ?>
		</tr>
		<tr>
		    <?php foreach($data->headTableThree as $key=>$value): ?>
			<td>
			    <?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?>
			</td>
		    <?php endforeach; ?>
		</tr>
	    </tbody>
	</table>
    </div>

    <!-- Detail table -->
    <div class="table-responsive order-entry-header col-md-12 col-xs-12" style="margin-top:20px;">
	<?php 
	$rows = $data->getDetail($headerItem["OrderNumber"]);
	$gridFields = $data->embeddedgridFields;
	$embeddedgridContext = $headerItem;
	function makeRowActions($linksMaker, $data, $ascope, $row, $embeddedgridContext){
            $user = $GLOBALS["user"];
            $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $row[$data->detailTable["keyFields"][0]] . "__" . $row[$data->detailTable["keyFields"][1]];
	    echo "<a href=\"" . $linksMaker->makeEmbeddedgridItemViewLink($data->detailTable["viewPath"], $ascope["path"], $keyString, $ascope["item"]);
	    echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
	    echo "<a href=\"javascript:;\" onclick=\"orderDetailDelete('$keyString')\"><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></a>";
	}
	require __DIR__ . "/../../../embeddedgrid.php"; 
	?>
    </div>
    <div class="subgrid-buttons row col-md-1">
	<?php if(!key_exists("disableNew", $data->detailTable)): ?>
	    <a class="btn btn-info" href="<?php echo $linksMaker->makeEmbeddedgridItemNewLink($data->detailTable["viewPath"], $ascope["path"], "new", $ascope["item"]) . "&{$data->detailTable["newKeyField"]}={$embeddedgridContext[$data->detailTable["newKeyField"]]}" ?>">
		<?php echo $translation->translateLabel("New"); ?>
	    </a>
	<?php endif; ?>
    </div>
    <script>
     var table = $('#example23').DataTable( {
	 dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i><'col-sm-7'p>>"
     });
     setTimeout(function(){
	 var buttons = $('.subgrid-buttons');
	 var tableFooter = $('.subgrid-table-footer');
	 tableFooter.prepend(buttons);
     },300);
    </script>

    <div class="panel panel-default order-entry-header col-md-8 col-xs-12" style="margin-top:20px; border:1px solid gray;">
	<table class="col-md-12 col-xs-12 order-entry-flagsanddates-table">
	    <tbody>
		<tr>
		    <td>
			<?php
			foreach($data->footerTable["flagsHeader"] as $key=>$value){
			    formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]);
			    echo $translation->translateLabel($key);
			}			    
			?>
		    </td>
		    <td>
		    </td>
		</tr>
		<?php foreach($data->footerTable["flags"] as $row): ?>
		    <tr>
			<td>
			    <div><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $row[0], $headerItem[$row[0]]); ?><?php echo $translation->translateLabel($row[1]); ?></div>
			</td>
			<td class="date-title">
			    <div class="pull-right"><b><?php echo $translation->translateLabel($row[3]); ?>: </b></div>
			</td>
			<td>
			    <?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $row[2], $headerItem[$row[2]]); ?>
			</td>
			<td>
			    <?php if($row[0] == "Shipped"): ?>
				<div><b><?php echo $translation->translateLabel("Trk #"); ?> </b><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, "TrackingNumber", $headerItem["TrackingNumber"]); ?></div>
			    <?php elseif($row[0] == "Invoiced"): ?>
				<div><b><?php echo $translation->translateLabel("Inv #"); ?> </b><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, "InvoiceNumber", $headerItem["InvoiceNumber"]); ?></div>
			    <?php endif;  ?>
			</td>
		    </tr>
		<?php endforeach; ?>
	    </tbody>
	</table>
    </div>
    <div class="order-entry-header col-md-4 col-xs-12" style="margin-top:20px;">
	<table class="order-entry-balance-table col-md-12 col-xs-12">
	    <tbody>
		<?php foreach($data->footerTable["totalFields"] as $key=>$value): ?>
		    <tr>
			<td>
			    <?php if($key == "Shipping"):?>
				<div><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, "TaxFreight", $headerItem["TaxFreight"]); ?><?php echo $translation->translateLabel("Tax Freight"); ?></div>
			    <?php endif; ?>
			</td>
			<td>
			    <b><?php echo $translation->translateLabel($key); ?>: </b>
			</td>
			<td>
			    <div class="pull-right"><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?></div>
			</td>
		    </tr>
		<?php endforeach; ?>
	    </tbody>
	</table>
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
	    <?php if($security->can("update")): ?>
		<a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemEdit($ascope["path"], $ascope["item"]); ?>">
		    <?php echo $translation->translateLabel("Edit"); ?>
		</a>
		<?php
		if(file_exists(__DIR__ . "/../" . $PartsPath . "viewActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "viewActions.php";
		if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		?>
	    <?php endif; ?>
	    <a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </div>
</div>
<script>
 //handler delete button from rows. Just doing XHR request to delete item and redirect to grid if success
 function orderDetailDelete(item){
     if(confirm("Are you sure?")){
	 $.post("<?php echo $linksMaker->makeEmbeddedgridItemDeleteLink($ascope["path"], $ascope["item"]);?>" + item, {})
	  .success(function(data) {
	      onlocation(window.location);
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
 }
</script>
