<!--
     Name of Page: view

     Method: renders content of screen in view mode. 

     Date created: Nikita Zaharov, 09.03.2016

     Use: used by views/gridView.php for rendering content in view mode
     Data displayed as simple two column table with edit and cancel buttons

     Input parameters:

     Output parameters:
     html

     Called from:
     views/gridView.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 15.03.2016
     Last Modified by: Nikita Zaharov
   -->
<div id="row_viewer">
    <ul class="nav nav-tabs">
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php?page=" . $app->page . "&action=" . $scope->action .  "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
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
			    echo formatField($data->editCategories[$scope->category][$key], $value);			    
			    break;
		    }
		    echo "</td></tr>";
		}
		?>
	    </tbody>
	</table>
    </div>
    <div class="pull-right">
	<!--
	     buttons Edit and Cancel
	     for translation uses translation model
	     for category(which tab is activated) uses $scope of controller
	   -->
	<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php?page=<?php echo  $app->page .  "&action=" . $scope->action;  ?>&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
	    <?php echo $translation->translateLabel("Edit"); ?>
	</a>
	<a class="btn btn-inverse waves-effect waves-light" href="index.php?page=<?php echo $app->page . "&action=" . $scope->action; ?>&mode=grid">
	    <?php echo $translation->translateLabel("Cancel"); ?>
	</a>
    </div>
</div>
