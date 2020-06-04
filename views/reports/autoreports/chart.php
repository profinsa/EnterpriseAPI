<h3 class="col-md-12">
    <?php echo $_GET["title"]; ?>
</h3>
<?php
$allcolumns = $data->getColumns();
$columns = [];
//echo json_encode($allcolumns);
foreach($allcolumns as $key=>$column)
    if($column["native_type"] == "NEWDECIMAL"|| $column["native_type"] == "DECIMAL" || $column["native_type"] == "SHORT"|| $column["native_type"] == "LONG" || $column["native_type"] == "LONGLONG")
	$columns[$key] = $column;

//echo "<br/>" . json_encode($columns);
?>
<?php if(!count($columns)): ?>
    <h3>
	Report has no numerical columns
    </h3>
<?php else: ?>
    <?php
    $chartData = $data->getData(true);
    $choosedDataColumn = "";
    $choosedLabelColumn = "";
    $choosedChartType = "pie";
    if(key_exists("dataColumn", $_GET))
	$choosedDataColumn = $_GET["dataColumn"];
    if(key_exists("labelColumn", $_GET))
	$choosedLabelColumn = $_GET["labelColumn"];
    if(key_exists("chartType", $_GET))
	$choosedChartType = $_GET["chartType"];

    $colors = array();
    while (true) {
	$colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
	if(count($colors) == 10000)
	    break;
    }
    ?>
    <div class="col-md-12">
	
	<div class="row" style="margin-left:20px; margin-top:10px">
	    <form class="form-inline">
		<div class="form-group">
		    <label for="bycolumn">Column Name</label>
		    <select id="bycolumn" onchange="chooseColumnName(event);">
			<?php
			if($choosedLabelColumn != "")
			    echo "<option>" . $choosedLabelColumn . "</option>";
			
			foreach($allcolumns as $key=>$column)
			    if($key != $choosedLabelColumn && key_exists($key, $chartData[0]))
				echo "<option>" . $key . "</option>";

			foreach($allcolumns as $key=>$column){
			    if($choosedLabelColumn == "" && key_exists($key, $chartData[0])){
				$choosedLabelColumn = $key;
				break;
			    }
			}
			?>
		    </select>
		</div>
		<div class="form-group">
		    <label for="byvalue">Column Value</label>
		    <select id="byvalue" onchange="chooseDataColumn(event);">
			<?php
			if($choosedDataColumn != "")
			    echo "<option>" . $choosedDataColumn . "</option>";
			
			foreach($columns as $key=>$column){
			    if($key != $choosedDataColumn && key_exists($key, $chartData[0]))
				echo "<option>" . $key . "</option>";
			}
			foreach($columns as $key=>$column){
			    if($choosedDataColumn == "" && key_exists($key, $chartData[0])){
				$choosedDataColumn = $key;
				break;
			    }
			}
			?>
		    </select>
		</div>
		<div class="radio">
		    <label>
			<input type="radio" name="charttype" value="pie" <?php echo $choosedChartType == "pie" ? "checked" : ""; ?> onchange="chooseChartType(event);">
			Pie
		    </label>
		</div>
		<div class="radio">
		    <label>
			<input type="radio" name="charttype" value="bar" <?php echo $choosedChartType == "bar" ? "checked" : ""; ?> onchange="chooseChartType(event);">
			Bar
		    </label>
		</div>
	    </form>
	</div>
	<div>
	    <div class="white-box row">
		<div id="morris-chart" class="ecomm-donute col-md-6"  style="height: 500px;"></div>
		<div class="col-md-6">
		    <ul class="list-inline m-t-30 text-center">
			<?php
			$colorInd = 0;
			//
			foreach($chartData as $row){
			    if(!$row[$choosedDataColumn] || $row[$choosedDataColumn] == "" && !isset($row[$choosedDataColumn]))
				$row[$choosedDataColumn] = "0.00";
			    echo "<li class=\"p-r-20\"><h5 class=\"text-muted\" style=\"color: " . $colors[$colorInd++] . ";\"><i class=\"fa fa-circle\" ></i>" . $row[$choosedLabelColumn]  ."</h5><h4 class=\"m-b-0\">" . $row[$choosedDataColumn] . "</h4></li>";
			}

			?>
		    </ul>
		</div>
	    </div>
	</div>
	<script>
	 <?php if($choosedChartType == "pie"): ?>
	 Morris.Donut({
	     element: 'morris-chart',
	     data: [
		 <?php
		 foreach($chartData as $row)
		     if($row[$choosedDataColumn])
			 echo "{ label : \"" . ($row[$choosedLabelColumn] ? $row[$choosedLabelColumn] : "Noname") . "\", value : \"" .  str_replace(",", "", $row[$choosedDataColumn]) . "\"},";
		 ?>
	     ],
	     resize: true,
	     colors: <?php echo json_encode($colors) ?>
	 });
	 <?php elseif($choosedChartType == "bar"): ?>
	 Morris.Bar({
	     element : 'morris-chart',
	     data: [
		 <?php
		 foreach($chartData as $row)
		     if($row[$choosedDataColumn])
			 echo "{ y : \"" . $row[$choosedLabelColumn] . "\", a : \"" .  str_replace(",", "", $row[$choosedDataColumn]) . "\"},";
		 ?>
	     ],
	     xkey: 'y',
	     ykeys: ['a'],
	     labels: ['Total'],
	     fillOpacity: 0.6,
	     hideHover: 'auto',
	     behaveLikeLine: true,
	     resize: true,
	     pointFillColors: <?php echo json_encode($colors) ?>,//['#ffffff'],
	     pointStrokeColors: ['black'],
	     lineColors:['gray','red'],
	     barColors: <?php echo json_encode($colors) ?>
	 });
	 <?php endif; ?>
	 function chooseColumnName(event){
	     var name = event.target.value, path = window.location.href, match;
	     if(path.match(/labelColumn/))
		 path = path.replace(/labelColumn\=\w+/, "labelColumn=" + name);
	     else
		 path += "&labelColumn=" + name;
	     window.location = path;
	 }
	 
	 function chooseDataColumn(event){
	     var name = event.target.value, path = window.location.href, match;
	     if(path.match(/dataColumn/))
		 path = path.replace(/dataColumn\=\w+/, "dataColumn=" + name);
	     else
		 path += "&dataColumn=" + name;
	     window.location = path;
	 }

	 function chooseChartType(event){
	     var name = event.target.value, path = window.location.href, match;
	     if(path.match(/chartType/))
		 path = path.replace(/chartType\=\w+/, "chartType=" + name);
	     else
		 path += "&chartType=" + name;
	     window.location = path;
	 }
	</script>
    </div>
<?php endif ?>
