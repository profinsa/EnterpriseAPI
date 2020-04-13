<!-- edit and new -->
<div id="row_editor">
    <ul class="nav nav-tabs">
	<div style="color:red; font-weight:bold" class="pull-right">
	    <?php echo $translation->translateLabel("Closing a period is irreversibile"); ?>
	</div>
	<?php  
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php#/?page=grid&action=" . $scope->action . "&mode=" .  $scope->mode ."&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
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
	$foundUnclosedPeriod = false;
	
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

			echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$scope->category][$key]) && $scope->mode == "edit")  || (key_exists("disabledNew", $data->editCategories[$scope->category][$key]) && $scope->mode == "new") ? "readonly" : "")
			   ."></div></div>";
			break;
			
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
			     ( $value == "1" || $foundUnclosedPeriod ? "disabled" : "")
			    ."></div></div>";
			if($value == "0" && !$foundUnclosedPeriod)
			    $foundUnclosedPeriod = true;
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
	<?php
	if(file_exists(__DIR__ . "/" . "editFooter.php"))
	    require __DIR__ . "/" . "editFooter.php";
	if(file_exists(__DIR__ . "/" . "vieweditFooter.php"))
	    require __DIR__ . "/" . "vieweditFooter.php";
	?>
	
    </form>
</div>
<div class="row">
    <div class="pull-right">
        <!--
	     renders buttons translated Save and Cancel using translation model
        -->
        <?php if($security->can("update")): ?>
	    <?php 
	        if(file_exists(__DIR__ . "/" . "editActions.php"))
		    require __DIR__ . "/" . "editActions.php";
	        if(file_exists(__DIR__ . "/" . "vieweditActions.php"))
		    require __DIR__ . "/" . "vieweditActions.php";
	    ?>
        <?php endif; ?>
        <a class="btn btn-info" href="index.php#/?page=grid&action=<?php echo $scope->action . "&mode=" .  ( $scope->mode != "new" ? "view/" . $scope->category . "&item=" . $scope->item : "&grid" ) ; ?>">
	    <?php echo $translation->translateLabel("Cancel"); ?>
        </a>
    </div>
</div>
