<!-- view -->
<div id="row_viewer">
    <ul class="nav nav-tabs">
	<div style="color:red; font-weight:bold" class="pull-right">
	    <?php echo $translation->translateLabel("Closing an year is irreversibile"); ?>
	</div>
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "") . "><a href=\"index.php#/?page=grid&action=" . $scope->action .  "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div class="table-responsive">
	<table class="table">
	    <thead>
		<tr>
		    <th>
			<?php echo $translation->translateLabel("Field"); ?>
		    </th>
		    <th>
			<?php echo $translation->translateLabel("Value"); ?>
		    </th>
		</tr>
	    </thead>
	    <tbody id="row_viewer_tbody">
		<?php
		//renders table, contains record data using getEditItem from model
		$item = $data->getEditItem($scope->item, $scope->category);
		foreach($item as $key =>$value){
		    if(key_exists($key, $data->editCategories[$scope->category])){
			echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
			switch($data->editCategories[$scope->category][$key]["inputType"]){
			    case "checkbox" :
				echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
				break;
			    case "timestamp" :
			    case "datetime" :
				echo date("m/d/y", strtotime($value));
				break;
			    case "text":
			    case "dropdown":
				if(key_exists("formatFunction", $data->editCategories[$scope->category][$key])){
				    $formatFunction = $data->editCategories[$scope->category][$key]["formatFunction"];
				    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
				}
				else
				    echo formatField($data->editCategories[$scope->category][$key], $value);						    break;
			}
			echo "</td></tr>";
		    }
		}
		?>
	    </tbody>
	</table>
    </div>
	<?php
	if(file_exists(__DIR__ . "/" . "viewFooter.php"))
	    require __DIR__ . "/" . "viewFooter.php";
	if(file_exists(__DIR__ . "/" . "vieweditFooter.php"))
	    require __DIR__ . "/" . "vieweditFooter.php";
	?>

    <div style="margin-top:10px" class="pull-right">
	<!--
	     buttons Edit and Cancel
	     for translation uses translation model
	     for category(which tab is activated) uses $scope of controller
	   -->
	<?php if($security->can("update")): ?>
		<?php 
		if(file_exists(__DIR__ . "/" . "viewActions.php"))
		    require __DIR__ . "/" . "viewActions.php";
		if(file_exists(__DIR__ . "/" . "vieweditActions.php"))
		    require __DIR__ . "/" . "vieweditActions.php";
		?>
	<?php endif; ?>
	<a class="btn btn-info" href="index.php#/?page=grid&action=<?php echo $scope->action . "&mode=grid"; ?>">
	    <?php echo $translation->translateLabel("Cancel"); ?>
	</a>
    </div>
</div>