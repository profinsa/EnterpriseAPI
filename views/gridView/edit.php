<!--
     Name of Page: edit

     Method: renders content of screen in edit and new mode. 

     Date created: Nikita Zaharov, 09.03.2016

     Use: used by views/gridView.php for rendering content in edit and new mode
     Data displayed as simple two column table with edit and cancel buttons.
     fileld values implemented as inputs;

     Input parameters:

     Output parameters:
     html

     Called from:
     views/gridView.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 05.24.2016
     Last Modified by: Nikita Zaharov
   -->
<?php
if(key_exists("back", $_GET)){
    $backhref = urldecode($_GET["back"]);
    $back = "&back=" . urlencode($_GET["back"]);
}else{
    $backhref = $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]);
    $back = "";
}
?>
<div id="row_editor">
    <div style="background-color:white;">
	<ul class="nav nav-tabs" role="tablist">
	    <?php
	    //render tabs like Main, Current etc
	    //uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	    foreach($data->editCategories as $key =>$value)
		if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
		    echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#$key\" aria-controls=\"$key\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
	    ?>
	</ul>
	<form id="itemData" class="form-material form-horizontal m-t-30">
	    <input type="hidden" name="id" value="<?php echo $scope->item; ?>" />
	    <input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
	    <div class="tab-content">
		<?php foreach($data->editCategories as $key =>$value):  ?>
		    <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo $key ?>">
			<?php
			//getting record.
			$category = $key;
			$item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $category) :
						$data->getNewItem($scope->item, $category);
			//used as translated field name
			$translatedFieldName = '';
			
			foreach($item as $key =>$value){
			    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
			    if(key_exists($key, $data->editCategories[$category])){
				switch($data->editCategories[$category][$key]["inputType"]){
					
				    case "text" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\""; 
					if(key_exists("formatFunction", $data->editCategories[$category][$key])){
					    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
					    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
					}
					else
					    echo formatField($data->editCategories[$category][$key], $value);
					echo "\" " .	 ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "readonly" : "")
					    ."></div></div>";
					break;
				    case "timestamp" :    
				    case "datetime" :
					//renders text input with label
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
					     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "readonly" : "")
					    ."></div></div>";
					break;

				    case "checkbox" :
					//renders checkbox input with label
					echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
					echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
					     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $scope->mode == "edit") || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $scope->mode == "new") ? "disabled" : "")
					    ."></div></div>";
					break;
					
				    case "dropdown" :
					//renders select with available values as dropdowns with label
					echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
					$method = $data->editCategories[$category][$key]["dataProvider"];
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
		    </div>
		<?php endforeach; ?>
	    </div>
	</form>
	<?php
	if(file_exists(__DIR__ . "/../" . $PartsPath . "editFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "editFooter.php";
	if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
	    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	?>
	<div class="row">
	    <div class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info waves-effect waves-light m-r-10" onclick="<?php echo ($scope->mode == "edit" ? "saveItem()" : "createItem()"); ?>">
			<?php echo $translation->translateLabel("Save"); ?>
		    </a>
		    <?php 
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
			require __DIR__ . "/../" . $PartsPath . "editActions.php";
		    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
			require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		    ?>
		<?php endif; ?>
		<a class="btn btn-inverse waves-effect waves-light" href="<?php echo $scope->mode != "new" ? $linksMaker->makeGridItemView($ascope["path"], $ascope["item"]) . $back  : $backhref  ; ?>">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</a>
	    </div>
	</div>
    </div>
    <script>
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
                    console.log(dataObject);
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
                                        $('#' + itemDataArray[i].name).css('border', '1px solid red');
                                        validationError = true;
                                        validationErrorMessage = 'must contain a number.';
                                    }
                                    break;
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

     //handler of save button if we in new mode. Just doing XHR request to save data
	function createItem(){
		var itemData = $("#itemData");

		if (validateForm(itemData)) {
			$.post("<?php echo $linksMaker->makeGridItemNew($ascope["action"]); ?>", itemData.serialize(), null, 'json')
			.success(function(data) {
				console.log('ok');
				window.location = "<?php echo $backhref; ?>";
			})
			.error(function(err){
				console.log('wrong');
			});
		}
	}
	//handler of save button if we in edit mode. Just doing XHR request to save data
	function saveItem(){
		var itemData = $('#itemData');

		if (validateForm(itemData)) {
			$.post("<?php echo $linksMaker->makeGridItemSave($ascope["action"]); ?>", itemData.serialize(), null, 'json')
			.success(function(data) {
				console.log('ok');
				window.location = "<?php echo $linksMaker->makeGridItemView($ascope["path"], $ascope["item"] . $back); ?>";
			})
			.error(function(err){
				console.log('wrong');
			});
		}
     }
    </script>
</div>

