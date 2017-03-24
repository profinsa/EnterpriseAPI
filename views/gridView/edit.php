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

     Last Modified: 09.03.2016
     Last Modified by: Nikita Zaharov
   -->
<div id="row_editor">
    <ul class="nav nav-tabs">
	<?php  
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php#/?page=" . $app->page . "&action=" . $scope->action .  "&mode=" . $scope->mode ."&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <form id="itemData" class="form-material form-horizontal m-t-30">
	<input type="hidden" name="id" value="<?php echo $scope->item; ?>" />
	<input type="hidden" name="category" value="<?php echo $scope->category; ?>" />
	<?php
	//getting record.
	$item = $scope->mode == 'edit' ? $data->getEditItem($scope->item, $scope->category) :
				$data->getNewItem($scope->item, $scope->category);
	//used as translated field name
	$translatedFieldName = '';
	
	foreach($item as $key =>$value){
	    $translatedFieldName = $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key);
	    if(key_exists($key, $data->editCategories[$scope->category])){
		switch($data->editCategories[$scope->category][$key]["inputType"]){
			
		    case "text" :
			//renders text input with label
			echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\""; 
			if(key_exists("formatFunction", $data->editCategories[$scope->category][$key])){
			    $formatFunction = $data->editCategories[$scope->category][$key]["formatFunction"];
			    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
			}
			else
			    echo formatField($data->editCategories[$scope->category][$key], $value);
			echo "\" " .	 ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "readonly" : "")
			   ."></div></div>";
			break;
		    case "timestamp" :    
		    case "datetime" :
			//renders text input with label
			echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime\" value=\"" . ($value == 'now'? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
			     ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "readonly" : "")
			    ."></div></div>";
			break;

		    case "checkbox" :
			//renders checkbox input with label
			echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
			echo "<div class=\"form-group\"><label class=\"col-md-6\" for=\"" . $key ."\">" . $translatedFieldName . "</span></label><div class=\"col-md-6\"><input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
			     ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit") || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "disabled" : "")
			    ."></div></div>";
			break;
			
		    case "dropdown" :
			//renders select with available values as dropdowns with label
			echo "<div class=\"form-group\"><label class=\"col-sm-6\">" . $translatedFieldName . "</label><div class=\"col-sm-6\"><select class=\"form-control\" name=\"" . $key . "\" id=\"" . $key . "\">";
			$method = $data->editCategories[$scope->category][$key]["dataProvider"];
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
	<div class="pull-right">
	    <!--
		 renders buttons translated Save and Cancel using translation model
	       -->
	    <?php if($security->can("update")): ?>
		<a class="btn btn-info waves-effect waves-light m-r-10" onclick="<?php echo ($scope->mode == "edit" ? "saveItem()" : "createItem()"); ?>">
		    <?php echo $translation->translateLabel("Save"); ?>
		</a>
	    <?php endif; ?>
	    <a class="btn btn-inverse waves-effect waves-light" href="index.php#/?page=<?php echo $app->page . "&action=" . $scope->action .  ( $scope->mode != "new" ? "&mode=view&category=" . $scope->category . "&item=" . $scope->item : "") ; ?>">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </form>
    <script>
     //handler of save button if we in new mode. Just doing XHR request to save data
     function createItem(){
	 var itemData = $("#itemData");
	 $.post("index.php?page=<?php  echo $app->page . "&action=" . $scope->action; ?>&new=true", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      console.log('ok');
	      window.location = "index.php#/?page=<?php  echo $app->page . "&action=" . $scope->action; ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
     //handler of save button if we in edit mode. Just doing XHR request to save data
     function saveItem(){
	 var itemData = $("#itemData");
	 $.post("index.php?page=<?php  echo $app->page .  "&action=" . $scope->action; ?>&update=true", itemData.serialize(), null, 'json')
	  .success(function(data) {
	      console.log('ok');
	      window.location = "index.php#/?page=<?php  echo $app->page .  "&action=" . $scope->action; ?>&mode=view&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>";
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
    </script>
</div>
</div>
