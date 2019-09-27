<!-- 
     Name of Page: OrderHeaderDetail view

     Method: this view for OrderHeaderDetail in the edit mode

     Date created: //2017

     Use: this view used for view mode. Renders all ui interface including Detail actions but only in the edit mode

     Input parameters:
     $scope: common information object
     $data : model

     Output parameters:
     html
     
     Called from:
     Grid Controller

     Calls:
     model

     Last Modified: 27/09/2019
     Last Modified by: Zaharov Nikita
-->

<?php

    $GLOBALS["dialogChooserTypes"] = [];
    $GLOBALS["dialogChooserInputs"] = [];

    function renderDetailInput($ascope, $data, $category, $item, $key, $value){
	switch($data->editCategories[$category][$key]["inputType"]){
	    case "text" :
		//renders text input with label
		echo "<input style=\"display:inline\" type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" onchange=\"fillSameInputs('" . $value . "', '" . $key . "', this);\" class=\"form-control $key\" value=\"";
		if(key_exists("formatFunction", $data->editCategories[$category][$key])){
		    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
		    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
		}
		else
		    echo formatField($data->editCategories[$category][$key], $value);

		echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
	       .">";
		break;

//	    case "timestamp" :
	    case "datetime" :
//		echo $value;
		//renders text input with label
		echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime $key\" value=\"" . ($value == 'now' || $value == "0000-00-00 00:00:00" || $value == "CURRENT_TIMESTAMP" || !$value ? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
		     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
		    .">";
		break;

	    case "checkbox" :
		//renders checkbox input with label
		echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
		echo "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control $key\" value=\"1\" " . ($value ? "checked" : "") ." " .
		     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit") || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "disabled" : "")
		    .">";
		break;
		
	    case "dialogChooser":
		$dataProvider = $data->editCategories[$category][$key]["dataProvider"];
		if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"])){
		    $GLOBALS["dialogChooserTypes"][$dataProvider] = $data->editCategories[$category][$key];
		    $GLOBALS["dialogChooserTypes"][$dataProvider]["fieldName"] = $key;
		}
		$GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
		echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control $key\" value=\"$value\">";
		break;

	    case "dropdown" :
		//renders select with available values as dropdowns with label
		echo "<select class=\"form-control $key\" name=\"" . $key . "\" id=\"" . $key . "\">";
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

    function renderRow($translation, $ascope, $data, $category, $item, $key, $value){
	if($key != "loadFrom"){
	    $translatedFieldName = $translation->translateLabel(
		key_exists("title", $data->editCategories[$category][$key]) ?
		$data->editCategories[$category][$key]["title"] :
		(key_exists($key, $data->columnNames) ?
		 $data->columnNames[$key] :
		 $key));
	    echo "<div class=\"form-group col-md-12 col-xs-12\"><label class=\"col-md-6 col-xs-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6 col-xs-6\">";
	    renderDetailInput($ascope, $data, $category, $item, $key, $value);
	    echo "</div></div>";
	}
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
<div id="row_editor" class="row">
    <form id="itemData" class="form-material form-horizontal m-t-30 col-md-12 col-xs-12">
	<input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
	<input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />
	
	<div class="order-entry-header">
	    <?php
		
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
				<?php renderDetailInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
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
				    <?php renderDetailInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
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
			echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#" . makeId($key) . "\" aria-controls=\"". makeId($key) . "\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
		?>
	    </ul>
	    <br/>
	    <div class="tab-content">
		<?php foreach($data->editCategories as $key =>$value):  ?>
		    <?php if($key != '...fields'): ?>
			<div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo makeId($key); ?>">
			    <?php
				//getting record.
				$item = $ascope["mode"] == 'edit' ? $data->getEditItem($ascope["item"], $key) :
					$data->getNewItem($ascope["item"], $key);
				//				echo json_encode($item, JSON_PRETTY_PRINT);
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
			</div>
		    <?php endif; ?>
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
				    <?php renderDetailInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
				</td>
			    <?php endforeach; ?>
			</tr>
		    </tbody>
		</table>
	    </div>
	<?php endif; ?>

	<!-- Detail table -->
	<?php
	    if(property_exists($data, "detailTable"))
    		require __DIR__ . "/components/detailGrid.php";
	?>

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
				    <?php if(count($row) > 2): ?>
					<div class="pull-right"><b><?php echo $translation->translateLabel($row[3]); ?>: </b></div>
				    <?php endif; ?>
				</td>
				<td>
				    <?php if(count($row) > 2): ?>
					<?php renderDetailInput($ascope, $data, "...fields", $headerItem, $row[2], $headerItem[$row[2]]); ?>
				    <?php endif; ?>
				</td>
				<?php if($row[0] == "Shipped"): ?>
				    <td>
					<div><b><?php echo $translation->translateLabel("Trk #"); ?> </b></div>
				    </td>
				    <td>
					<?php renderDetailInput($ascope, $data, "...fields", $headerItem, "TrackingNumber", $headerItem["TrackingNumber"]); ?>
				    </td>
				<?php elseif($row[0] == "Invoiced"): ?>
				    <td>
					<div><b><?php echo $translation->translateLabel("Inv #"); ?> </b></div>
				    </td>
				    <td>
					<?php renderDetailInput($ascope, $data, "...fields", $headerItem, "InvoiceNumber", $headerItem["InvoiceNumber"]); ?>
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
					<?php renderDetailInput($ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
				    <?php else: ?>
					<input type="hidden" name="<?php echo $key; ?>" value="<?php echo $headerItem[$value]; ?>">
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
	    if(file_exists(__DIR__ . "/../../" . $PartsPath . "editFooter.php"))
		require __DIR__ . "/../../../" . $PartsPath . "editFooter.php";
	    if(file_exists(__DIR__ . "/../../" . $PartsPath . "vieweditFooter.php"))
		require __DIR__ . "/../../../" . $PartsPath . "vieweditFooter.php";
	?>

	<div class="row col-md-12 col-xs-12">
	    <div  style="margin-top:10px" class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		-->
		<?php if($security->can("update") &&
			 (property_exists($data, "modes") &&
			  in_array("edit", $data->modes) ||
			  !property_exists($data, "modes"))): ?>
		    <a class="btn btn-info" onclick="<?php echo ($ascope["mode"] == "edit" ? "saveItem()" : "createItem()"); ?>">
			<?php echo $translation->translateLabel("Save"); ?>
		    </a>
		<?php endif; ?>
                <?php if(property_exists($data, "docType")): ?>
                    <?php if($ascope["mode"] == "edit"): ?>
                        <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="saveItemAndPrint()">
                            <?php
                                echo $translation->translateLabel("Save & Print");
                            ?>
                        </a>
                    <?php endif; ?>
                    <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailPrint(context.item)">
                        <?php
                            echo $translation->translateLabel("Print");
                        ?>
                    </a>

                    <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailEmail(context.item)">
                        <?php
                            echo $translation->translateLabel("Email");
                        ?>
                    </a>
                <?php endif; ?>
		<?php 
		    if(file_exists(__DIR__ . "/../../../" . $PartsPath . "editActions.php"))
			require __DIR__ . "/../../../" . $PartsPath . "editActions.php";
		    if(file_exists(__DIR__ . "/../../../" . $PartsPath . "vieweditActions.php"))
			require __DIR__ . "/../../../" . $PartsPath . "vieweditActions.php";
		?>
		<a class="btn btn-info" href="<?php echo $ascope["mode"] != "new" ? $linksMaker->makeGridItemView($ascope["path"], $ascope["item"])  : $linksMaker->makeGridItemViewCancel($ascope["path"]) ; ?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
	</div>
    </form>

    <script>
     function fillSameInputs(value, key, event) {
         var elements = $('input[name=' + key + ']');
         var elementsKeys = Object.keys(elements);


         for (var k = 0; k < elementsKeys.length; k++) {
             $(elements[elementsKeys[k]]).val(event.value);
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
                     var dataType = dataObject.dbType.replace(/\(.*/,'');
                     var dataLength;
                     var re = /\((.*)\)/;
                     
                     if (dataType !== 'datatime' && dataType !== 'timestamp') {
                         if (dataObject.required && !itemDataArray[i].value) {
                             validationError = true;
                             validationErrorMessage = 'cannot be empty.';
                             $('#' + itemDataArray[i].name).css('border', '1px solid red');
                         } else {
                             $('#' + itemDataArray[i].name).css('border', 'none');
                             switch (dataType) {
                                 case 'decimal':
                                     if (itemDataArray[i].value && !isDecimal(itemDataArray[i].value)) {
                                         var elements = $('input[name=' + itemDataArray[i].name + ']');
                                         var elementsKeys = Object.keys(elements);


                                         for (var k = 0; k < elementsKeys.length; k++) {
                                             $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                         }
                                         validationError = true;
                                         validationErrorMessage = 'must contain a number.';
                                     }
                                     break;
				 case 'smallint':
                                 case 'bigint':
                                 case 'int':
                                 case 'float':
                                     if (itemDataArray[i].value && !isNumeric(itemDataArray[i].value)) {
                                         var elements = $('input[name=' + itemDataArray[i].name + ']');
                                         var elementsKeys = Object.keys(elements);


                                         for (var k = 0; k < elementsKeys.length; k++) {
                                             $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                         }
                                         validationError = true;
                                         validationErrorMessage = 'must contain a number.';
                                     }
                                     break;
                                 case 'char':
                                     if (itemDataArray[i].value.length > 1) {
                                         var elements = $('input[name=' + itemDataArray[i].name + ']');
                                         var elementsKeys = Object.keys(elements);


                                         for (var k = 0; k < elementsKeys.length; k++) {
                                             $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                         }
                                         validationError = true;
                                         validationErrorMessage = 'cannot contain more than 1 character.';
                                     }
                                     break;
                                 case 'varchar':
                                     dataLength = dataObject.dbType.match(re)[1];

                                     if (itemDataArray[i].value.length > dataLength) {
                                         var elements = $('input[name=' + itemDataArray[i].name + ']');
                                         var elementsKeys = Object.keys(elements);


                                         for (var k = 0; k < elementsKeys.length; k++) {
                                             $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                         }
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
     
     //handler of save button if we in new mode. Just doing XHR request to save data
     function createItem(){
         var itemData = $("#itemData");

         if (validateForm(itemData)) {
             $.post("<?php echo $linksMaker->makeGridItemNew($ascope["path"]); ?>", itemData.serialize(), null, 'json')
              .success(function(data) {
                  console.log('ok');
                  window.location = "<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>";
              })
              .error(function(err){
                  console.log('wrong');
              });
         }
     }
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveItem(cb){
         var itemData = $("#itemData");
         if (validateForm(itemData)) {
             $.post("<?php echo $linksMaker->makeGridItemSave($ascope["path"]); ?>", itemData.serialize(), null, 'json')
              .success(function(data) {
                  if(cb)
                      cb();
                  else
                      window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]); ?>";
              })
              .error(function(err){
                  console.log('wrong');
              });
         }
     }

     function saveItemAndPrint(){
         saveItem(function(){
             callDetailPrint(context.item, function(){
                 window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]); ?>";
             });
         });
     }

    </script>
</div>

<?php require __DIR__ . "/../../../dialogChooser.php"; ?>
