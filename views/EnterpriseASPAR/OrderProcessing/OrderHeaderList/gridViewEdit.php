<!-- 
     Name of Page: OrderHeaderDetail view

     Method: this view for OrderHeaderDetail in the edit mode

     Date created: autogenerated

     Use: this view used for view mode. Renders all ui interface including Detail actions but only in the edit mode

     Input parameters:
     $ascope: common information object
     $data : model

     Output parameters:
     html
     
     Called from:
     Grid Controller

     Calls:
     model

     Last Modified: 05/30/2017
     Last Modified by: Zaharov Nikita
   -->
<?php
function renderRow($translation, $ascope, $data, $category, $item, $key, $value){
    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
    echo "<div class=\"form-group col-md-12 col-xs-12\"><label class=\"col-md-6 col-xs-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6 col-xs-6\">";
    renderInput($ascope, $data, $category, $item, $key, $value);
    echo "</div></div>";
}

function renderViewRow($translation, $data, $fieldsDefinition, $values, $key, $value){
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
<div id="row_editor" style="display:table">
    <form id="itemData" class="form-material form-horizontal m-t-30 col-md-12 col-xs-12">
	<input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
	<input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />
	
	<div class="order-entry-header">
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

	    function renderInput($ascope, $data, $category, $item, $key, $value){
		switch($data->editCategories[$category][$key]["inputType"]){
		    case "text" :
			//renders text input with label
			echo "<input style=\"display:inline\" type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"";
			if(key_exists("formatFunction", $data->editCategories[$category][$key])){
			    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
			    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
			}
			else
			    echo formatField($data->editCategories[$category][$key], $value);

			echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
			   .">";
			break;
			
		    case "datetime" :
			//renders text input with label
			echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
			     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
			    .">";
			break;

		    case "checkbox" :
			//renders checkbox input with label
			echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
			echo "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
			     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit") || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "disabled" : "")
			    .">";
			break;
			
		    case "dropdown" :
			//renders select with available values as dropdowns with label
			echo "<select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
			$method = $data->editCategories[$category][$key]["dataProvider"];
			if(key_exists("dataProviderArgs", $data->editCategories[$category][$key])){
			    $args = [];
			    foreach($data->editCategories[$category][$key]["dataProviderArgs"] as $argname)
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
	    
	    $headerItem = $ascope["mode"] == 'edit' ? $data->getEditItem($ascope["item"], "...fields") :
					     $data->getNewItem($ascope["item"], "...fields" );
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
				<?php renderInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
			    </td>
			<?php endforeach; ?>
		    </tr>
		</tbody>
	    </table>
	    <?php if(property_exists($data, "headTableTwo")): ?>
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
				    <?php renderInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
				</td>
			    <?php endforeach; ?>
			</tr>
		    </tbody>
		</table>
	    <?php endif; ?>
	</div>

	<?php if(key_exists("Main", $data->editCategories) && !property_exists($data, "makeTabs")): ?>
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
	    <div class="tab-content">
		<?php foreach($data->editCategories as $key =>$value):  ?>
		    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo $key ?>">
			<?php
			//getting record.
			$item = $ascope["mode"] == 'edit' ? $data->getEditItem($ascope["item"], $key) :
						   $data->getNewItem($ascope["item"], $key);
			?>
			<?php if($key == "Customer"): ?>
			    <?php
			    $customerInfo = $data->getCustomerInfo($headerItem[property_exists($data, "customerField") ? $data->customerField : "CustomerID"]);
			    $tableItems = makeTableItems($customerInfo, $data->customerFields);
			    $tableCategories = $data->customerFields;
			    $items = $customerInfo;
			    ?>
			    <div class=" col-md-5 col-xs-5">
				<table class="table table-bordered order-entry-main-table ">
				    <tbody id="row_viewer_tbody">
					<?php 
					foreach($tableItems["leftItems"] as $key =>$value)
					    renderViewRow($translation, $data, $tableCategories, $items, $key, $value);
					?>
				    </tbody>
				</table>
			    </div>
			    <div class="col-md-5 col-xs-5">
				<table class="table table-bordered order-entry-main-table">
				    <tbody id="row_viewer_tbody">
					<?php 
					foreach($tableItems["rightItems"] as $key =>$value)
					    renderViewRow($translation, $data, $tableCategories,  $items,$key, $value);
					?>
				    </tbody>
				</table>
			    </div>
			<?php else: ?>
			    <?php
			    $tableCategories = $data->editCategories[$key];
			    $tableItems = makeTableItems($item, $tableCategories);
			    $items = $item;
			    $category = $key;
			    ?>
			    <div class=" col-md-5 col-xs-5">
				<table class="table table-bordered order-entry-main-table ">
				    <tbody id="row_viewer_tbody">
					<?php
					foreach($tableItems["leftItems"] as $key =>$value)
					    renderRow($translation, $ascope, $data, $category, $items, $key, $value);
					?>
				    </tbody>
				</table>
			    </div>
			    <div class="col-md-5 col-xs-5">
				<table class="table table-bordered order-entry-main-table">
				    <tbody id="row_viewer_tbody">
					<?php 
					foreach($tableItems["rightItems"] as $key =>$value)
					    renderRow($translation, $ascope, $data, $category,  $items, $key, $value);
					?>
				    </tbody>
				</table>
			    </div>
			<?php endif; ?>
		    </div>
		<?php endforeach; ?>
	    </div>
	<?php endif; ?>

	<?php if(property_exists($data, "headTableThree")): ?>
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
				    <?php renderInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
				</td>
			    <?php endforeach; ?>
			</tr>
		    </tbody>
		</table>
	    </div>
	<?php endif; ?>

	<!-- Detail table -->
	<div class="table-responsive order-entry-header col-md-12 col-xs-12" style="margin-top:20px;">
	    <?php 
	    $rows = $data->getDetail(key_exists("OrderNumber", $headerItem) ? $headerItem["OrderNumber"] : $headerItem[$data->detailTable["keyFields"][0]]);
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
	 var table = $('.datatable').DataTable( {
	     dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i><'col-sm-7'p>>"
	 });
	 setTimeout(function(){
	     var buttons = $('.subgrid-buttons');
	     var tableFooter = $('.subgrid-table-footer');
	     tableFooter.prepend(buttons);
	 },300);
	</script>

	<?php if(property_exists($data, "footerTable")): ?>
	    <div class="panel panel-default order-entry-header col-md-7 col-xs-12" style="margin-top:20px; padding:5px;">
		<table class="col-md-12 col-xs-12 order-entry-footer-table">
		    <tbody>
			<tr>
			    <td colspan="5">
				<?php
				foreach($data->footerTable["flagsHeader"] as $key=>$value){
				    echo "<div>";
				    formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]);
				    echo $translation->translateLabel($key);
				    echo "</div>";
				}			    
				?>
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
				    <?php renderInput($ascope, $data, "...fields", $headerItem, $row[2], $headerItem[$row[2]]); ?>
				</td>
				<?php if($row[0] == "Shipped"): ?>
				    <td>
					<div><b><?php echo $translation->translateLabel("Trk #"); ?> </b></div>
				    </td>
				    <td>
					<?php renderInput($ascope, $data, "...fields", $headerItem, "TrackingNumber", $headerItem["TrackingNumber"]); ?>
				    </td>
				<?php elseif($row[0] == "Invoiced"): ?>
				    <td>
					<div><b><?php echo $translation->translateLabel("Inv #"); ?> </b></div>
				    </td>
				    <td>
					<?php renderInput($ascope, $data, "...fields", $headerItem, "InvoiceNumber", $headerItem["InvoiceNumber"]); ?>
				    </td>
				<?php endif;  ?>
			    </tr>
			<?php endforeach; ?>
		    </tbody>
		</table>
	    </div>
	    <div class="order-entry-header col-md-5 col-xs-12" style="margin-top:20px;">
		<table class="col-md-12 col-xs-12 order-entry-footer-table order-entry-balance-table">
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
				    <?php if($key != "Tax" && $key != "Total"): ?>
					<?php renderInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
				    <?php else: ?>
					<div class="pull-right"><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?></div>
				    <?php endif; ?>
				</td>
			    </tr>
			<?php endforeach; ?>
		    </tbody>
		</table>
	    </div>
	<?php endif; ?>

	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "editFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "editFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>

	<div class="row">
	    <div  style="margin-top:10px" class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info" onclick="<?php echo ($ascope["mode"] == "edit" ? "saveItem()" : "createItem()"); ?>">
			<?php echo $translation->translateLabel("Save"); ?>
		    </a>
		    <?php 
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
			require __DIR__ . "/../" . $PartsPath . "editActions.php";
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
			require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		    ?>
		<?php endif; ?>
		<a class="btn btn-info" href="<?php echo $ascope["mode"] != "new" ? $linksMaker->makeGridItemView($ascope["path"], $ascope["item"])  : $linksMaker->makeGridItemViewCancel($ascope["path"]) ; ?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
	</div>
    </form>

    <!-- Customer Choose Dialog -->
    <div id="CustomerChooser" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
		<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    <h4 class="modal-title">Customer selecting dialog</h4>
		</div>
		<div class="modal-body">
		    <table class="table" id="customersTable">
			<thead>
			    <th></th>
			    <th>
				<?php echo $translation->translateLabel("Customer ID"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Customer Type"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Account Status"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Name"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Phone"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Login"); ?>
			    </th>
			    <th>
				<?php echo $translation->translateLabel("Password"); ?>
			    </th>
			</thead>
			<tbody>
			    <?php
			    $customers = $data->getCustomers();
			    foreach($customers as $customer){
				echo "<tr><td><a href=\"javascript:editCustomerChoose('{$customer["CustomerID"]}');\" class=\"btn btn-info\">Select</a></td>";
				echo "<td>{$customer["CustomerID"]}</td><td>{$customer["CustomerTypeID"]}</td><td>{$customer["AccountStatus"]}</td><td>{$customer["CustomerName"]}</td><td>{$customer["CustomerPhone"]}</td><td>{$customer["CustomerLogin"]}</td><td>{$customer["CustomerPassword"]}</td></tr>";
			    }
			    ?>
			</tbody>
		    </table>
		</div>
		<div class="modal-footer">
		    <button type="button" class="btn btn-primary" data-dismiss="modal">
			<?php echo $translation->translateLabel("Ok"); ?>
		    </button>
		</div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
     //customer modal oppener
     $('#CustomerID').click(function(){
	 $('#CustomerChooser').modal('show');
	 if(!$.fn.DataTable.isDataTable("#customersTable"))
             $('#customersTable').DataTable({});
     });
     //handler of customer choose button
     function editCustomerChoose(customer){
	 $('#CustomerChooser').modal('hide');
	 $('#CustomerID').val(customer);
     }
     
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
	      window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]); ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }

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
</div>