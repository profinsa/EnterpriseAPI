<!--
     Name of Page: view

     Method: renders content of screen in view mode. 

     Date created: Nikita Zaharov, 10.05.2016

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

     Last Modified: 11.05.2016
     Last Modified by: Nikita Zaharov
   -->
<!-- view -->
<div id="row_viewer">
    <ul class="nav nav-tabs">
	<?php
	//render tabs like Main, Current etc
	//uses $data(charOfAccounts model) as dictionaries which contains list of tab names
	foreach($data->editCategories as $key =>$value)
	    echo "<li role=\"presentation\"". ( $scope->category == $key ? " class=\"active\"" : "")  ."><a href=\"index.php#/?page=" . $app->page . "&action=" . $scope->action .  "&mode=view&category=" . $key . "&item=" . $scope->item . "\">" . $translation->translateLabel($key) . "</a></li>";
	?>
    </ul>
    <div class="table-responsive">
	<?php
	$finitem = $data->getEditItem($scope->item, $scope->category);
	$vendor = $data->getVendorInfo($scope->item, "Main");
//	echo json_encode($vendor);
	function getRowValue($scope, $data, $key, $value){
	    switch($data->editCategories[$scope->category][$key]["inputType"]){
		case "checkbox" :
		    return "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
		    break;
		case "timestamp" :
		case "datetime" :
		    return date("m/d/y", strtotime($value));
		    break;
		case "text":
		case "dropdown":
		    if(key_exists("formatFunction", $data->editCategories[$scope->category][$key])){
			$formatFunction = $data->editCategories[$scope->category][$key]["formatFunction"];
			return $data->$formatFunction($finitem, "editCategories", $key, $value, false);
		    }
		    else
			return formatField($data->editCategories[$scope->category][$key], $value);						    break;
	    }
	}

	function renderGrouppedColumns($scope, $translation, $data, $columns, $columnsOnRow, $finitem){
	    $pairCount = 0;
	    //rendering four columns table
	    foreach($columns as $key){
		if($pairCount == $columnsOnRow){
		    echo "</tr>";
		    $pairCount = 0;
		    break;
		}
		if($pairCount == 0)
		    echo "<tr>";
		if(key_exists($key, $data->editCategories[$scope->category])){
		    echo "<td style=\"text-align:left\">" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
		    echo getRowValue($scope, $data, $key, $finitem[$key]);
		    echo "</td>";
		}
		$pairCount++;
	    }
	    if($pairCount != $columnsOnRow)
		echo "</tr>";
	}
	?>
	<div class="col-md-6 col-xs-6" style="margin-top:20px;">
	    <table class="table">
		<tbody id="row_viewer_tbody">
		    <?php
		    //renders table, contains record data using getEditItem from model
		    echo  "<tr><td><b>" . $translation->translateLabel($data->columnNames["VendorID"]) . "</b></td><td><b>" . $vendor["VendorID"] . "</b></td>";
		    echo  "<tr><td><b>" . $translation->translateLabel($data->columnNames["VendorName"]) . "</b></td><td><b>" . $vendor["VendorName"] . "</b></td>";
		    echo  "<tr><td>" . $translation->translateLabel($data->columnNames["VendorPhone"]) . "</td><td>" . $vendor["VendorPhone"] . "</td>";
		    echo  "<tr><td>" . $translation->translateLabel($data->columnNames["VendorEmail"]) . "</td><td><a href=\"mailto:{$vendor["VendorEmail"]}\">{$vendor["VendorEmail"]}</a></td>";
		    echo  "<tr><td><b>" . $translation->translateLabel($data->columnNames["AvailableCredit"]) . "</b></td><td><b>" . getRowValue($scope, $data, "AvailableCredit", $finitem["AvailableCredit"]) . "</b></td>";
		    ?>
		</tbody>
	    </table>
	</div>
	<div class="col-md-12 col-xs-12" style="margin-top:20px;">
	    <table class="table">
		<tbody id="row_viewer_tbody">
		    <?php
		    $columns = [
			"LastPurchaseDate",
			"PurchaseYTD",
			"PurchaseLastYear",
			"PurchaseLifetime"
		    ];
		    renderGrouppedColumns($scope, $translation, $data, $columns, 4, $finitem);
		    ?>
		</tbody>
	    </table>
	</div>
	<div class="col-md-12 col-xs-12" style="margin-top:20px;">
	    <table class="table">
		<tbody id="row_viewer_tbody">
		    <?php
		    //renders table, contains record data using getEditItem from model
		    $columns = [
			"LateDays",
			"AverageDaytoPay",
			"LastPaymentDate",
			"LastPaymentAmount",
			"HighestCredit",
			"HighestBalance",
			"AvailableCredit",
			"PromptPerc",
			"BookedPurchaseOrders",
			"AdvertisingDollars",
			"TotalAP",
			"CurrentAPBalance",
		    ];
		    $pairCount = 0;
		    //rendering four columns table
		    foreach($columns as $key){
			if($pairCount == 2){
			    echo "</tr>";
			    $pairCount = 0;
			}
			if($pairCount == 0)
			    echo "<tr>";
			if(key_exists($key, $data->editCategories[$scope->category])){
			    echo "<td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
			    echo getRowValue($scope, $data, $key, $finitem[$key]);
			    echo "</td>";
			}
			$pairCount++;
		    }
		    if($pairCount != 2)
			echo "<td></td><td></td>";
		    echo "</tr>";
		    ?>
		</tbody>
	    </table>
	</div>
	<!-- Chart -->
	<div class="col-md-12 col-xs-12" style="margin-top:20px;">
	    <div id="morris-chart" class="ecomm-donute"  style="height: 300px;"></div>
	</div>
	
	<div class="col-md-12 col-xs-12" style="margin-top:40px;">
	    <table class="table">
		<tbody id="row_viewer_tbody">
		    <?php
		    $columns = [
			"PaymentsLastYear",
			"PaymentsLifetime",
			"PaymentsYTD"
		    ];
		    renderGrouppedColumns($scope, $translation, $data, $columns, 3, $finitem);
                    $columns = [
			"DebitMemos",
			"LastDebitMemoDate",
			"DebitMemosYTD",
			"DebitMemosLastYear",
			"DebitMemosLifetime"
		    ];
		    renderGrouppedColumns($scope, $translation, $data, $columns, 5, $finitem);
		    $columns = [
			"VendorReturns",
			"LastReturnDate",
			"ReturnsYTD",
			"ReturnsLastYear",
			"ReturnsLifetime"
		    ];
		    renderGrouppedColumns($scope, $translation, $data, $columns, 5, $finitem);
		    ?>
		</tbody>
	    </table>
	    <?php
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "editFooter.php"))
		require __DIR__ . "/../" . $PartsPath . "editFooter.php";
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
		require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
	    ?> 
	</div>
	<div class="pull-right">
	    <!--
		 buttons Edit and Cancel
		 for translation uses translation model
		 for category(which tab is activated) uses $scope of controller
	       -->
	    <?php if($security->can("update")): ?>
		<a class="btn btn-info waves-effect waves-light m-r-10" href="index.php#/?page=<?php echo  $app->page .  "&action=" . $scope->action;  ?>&mode=edit&category=<?php  echo $scope->category . "&item=" . $scope->item ; ?>">
		    <?php echo $translation->translateLabel("Edit"); ?>
		</a>
 		<?php 
		if(file_exists(__DIR__ . "/../" . $PartsPath . "editActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "editActions.php";
		if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
		?>
	    <?php endif; ?>
	    <a class="btn btn-inverse waves-effect waves-light" href="index.php#/?page=<?php echo $app->page . "&action=" . $scope->action; ?>&mode=grid">
		<?php echo $translation->translateLabel("Cancel"); ?>
	    </a>
	</div>
    </div>
</div>
<script>
 Morris.Bar({
     element : 'morris-chart',
     data: [
	 {
	     y : "Over 180",
	     a : "<?php echo $finitem["Over180"] ? $finitem["Over180"] : 0 ; ?>"
	 },
	 {
	     y : "Over 150",
	     a : "<?php echo $finitem["Over150"] ? $finitem["Over150"] : 0 ; ?>"
	 },
	 {
	     y : "Over 120",
	     a : "<?php echo $finitem["Over120"] ? $finitem["Over120"] : 0 ; ?>"
	 },
	 {
	     y : "Over 90",
	     a : "<?php echo $finitem["Over90"] ? $finitem["Over90"] : 0 ; ?>"
	 },
	 {
	     y : "Over 60",
	     a : "<?php echo $finitem["Over60"] ? $finitem["Over60"] : 0 ; ?>"
	 },
	 {
	     y : "Over 30",
	     a : "<?php echo $finitem["Over30"] ? $finitem["Over30"] : 0 ; ?>"
	 },
	 {
	     y : "Under 30",
	     a : "<?php echo $finitem["Under30"] ? $finitem["Under30"] : 0 ; ?>"
	 }
     ],
     xkey: 'y',
     ykeys: ['a'],
     labels: ['Total'],
     fillOpacity: 0.6,
     hideHover: 'auto',
     behaveLikeLine: true,
     resize: true,
     pointFillColors: ['#8b0000', '#ff0000', '#ff8c00', '#ffa500', '#ffcc00', '#ffff00', '#00ff00'],
     pointStrokeColors: ['black'],
     lineColors:['gray','red'],
     barColors: function(row, series, type){
	 switch(row.label){
	     case "Over 180" :
		 return '#8b0000';
	     case "Over 150" :
		 return '#ff0000';
	     case "Over 120" :
		 return '#E18700';
	     case "Over 90" :
		 return '#ffa500';
	     case "Over 60" :
		 return '#ffcc00';
	     case "Over 30" :
		 return '#ffff00';
	     case "Under 30" :
		 return '#00ff00';
 	 }
	 return "black";
     }
 });
</script>
