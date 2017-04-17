<div class="container-fluid">
    <?php
    require __DIR__ . '/uiItems/dashboard.php';
   // require __DIR__ . '/format.php';
    ?>
    
    <?php
    /*
       Name of Page: autoreports view

       Method: It render main autoreports page

       Date created: Nikita Zaharov, 10.04.2016

       Use: renders autoreports page, contains:
       - parameters table
       - column settings
       - actions to show report

       Input parameters:
       $data: data source

       Output parameters:
       html

       Called from:
       controllers/autoreports

       Calls:
       sql

       Last Modified: 17.04.2016
       Last Modified by: Nikita Zaharov
     */
    $params = $data->getParametersForEnter();
    //echo json_encode($params);

    if(!count($params) || key_exists($params[0]->PARAMETER_NAME, $_GET))
	$columns = $data->getColumns();

    ?>
    
    <div class="col-sm-12 white-box">
	<?php if(count($params)): ?>
	    <h3 class="pull-left col-md-12" style="margin-top:20px;">
		<?php echo $translation->translateLabel("Report Parameters"); ?>
	    </h3>
	    <div class="table-responsive col-md-12">
		<table class="table table-bordered">
		    <thead>
			<tr>
			    <th><?php echo $translation->translateLabel("Parameter Name"); ?></th>
			    <th><?php echo $translation->translateLabel("Value"); ?></th>
			</tr>
		    </thead>
		    <tbody>
			<?php
			foreach($params as $param){
			    echo "<tr><td>" . $param->PARAMETER_NAME . "</td><td><input type=\"text\" onchange=\"autoreportsFillParameter('" . $param->PARAMETER_NAME . "', event);\" value=\"" . (key_exists($param->PARAMETER_NAME, $_GET) ? $_GET[$param->PARAMETER_NAME] : "") . "\"></td></tr>";
			}
			?>
		    </tbody>
		</table>
	    </div>
	    <div class="col-md-12" style="color:blue; border:1px">
		To enter a report Parameter just fill input in Value column!
	    </div>
	    <script>
	     var params = {
		 <?php
		 $strparams = "";
		 foreach($params as $param)
		     $strparams .= $param->PARAMETER_NAME . " : null,";
		 echo substr($strparams, 0, -1);
		 ?>
	     };
	     function autoreportsFillParameter(param, event){
		 params[param] = event.target.value;
		 var filled = 0, plength = 0, ind;
		 for(ind in params){
		     if(params[ind] != null)
			 filled++;
		     plength++;
		 }
		 if(filled == plength){
		     window.location = window.location.href + "&" + $.param(params);
		 }
//		     console.log(JSON.stringify(params, null, 3));
		 console.log(filled, plength);
	     }
	    </script>
	<?php endif; ?>
	<?php if(!$columns): ?>
	    <?php  echo "<h2>" . $translation->translateLabel("No data for report") . "</h2>";?>
	<?php  else:?>
	    <h3 class="pull-left col-md-12" style="margin-top:20px;">
		<?php echo $translation->translateLabel("Report Columns"); ?>
	    </h3>
	    <div class="table-responsive col-md-12">
		<form id="columnform">
		    <table class="table table-bordered">
			<thead>
			    <tr>
				<th></th>
				<th><?php echo $translation->translateLabel("Column Name"); ?></th>
				<th><?php echo $translation->translateLabel("Show"); ?></th>
				<th><?php echo $translation->translateLabel("Total"); ?></th>
				<th><?php echo $translation->translateLabel("Sort Order"); ?></th>
				<th><?php echo $translation->translateLabel("Sort Direction"); ?></th>
				<th><?php echo $translation->translateLabel("Search Operator"); ?></th>
				<th><?php echo $translation->translateLabel("Search Criteria"); ?></th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    $columnsDefaults = [];
			    $colcounter = 0;
			    foreach($columns as $columnname=>$meta){
				$columnsDefaults[$columnname] = [
				    "True",
				    $meta["native_type"] == "NEWDECIMAL" || $meta["native_type"] == "DECIMAL" ? "True" : "False",
				    !$colcounter ? 1 : -1,
				    "ASC",
				    "None",
				    ""
				];
				$colcounter++;
			    }

			    foreach($columnsDefaults as $columnname=>$column){
				echo "<tr><td id=\"" . $columnname . "actions\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\" onclick=\"autoreportsChangeColumn('" . $columnname . "')\"></span></td><td>" . $columnname . "</td><td id=\"" . $columnname . "show\">" . $column[0] . "</td><td id=\"" . $columnname . "total\">" . $column[1] . "</td><td id=\"" . $columnname . "order\">" . $column[2] . "</td><td id=\"" . $columnname . "direction\">" . $column[3] . "</td><td id=\"" . $columnname . "operator\">" . $column[4] . "</td><td id=\"" . $columnname . "criteria\">" . $column[5] . "</td>".  "</tr>";
			    }
			    ?>
			</tbody>
		    </table>
		</form>
	    </div>

	    <h3 class="pull-left col-md-12" style="margin-top:20px;">
		<?php echo $translation->translateLabel("Run Report"); ?>
	    </h3>
	    <div class="col-md-12">
		<a id="getreportexplorer" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=explorer&title=<?php echo $_GET["title"]; ?>" target="_blank">Reports Explorer</a>
		<a id="getreportscreen" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=screen&title=<?php echo $_GET["title"]; ?>" target="_blank">Screen</a>
		<a id="getreportpdf" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=pdf&title=<?php echo $_GET["title"]; ?>" target="_blank">PDF</a>
		<a id="getreporttext"  class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=text&title=<?php echo $_GET["title"]; ?>" target="_blank">CSV</a>
		<a id="getreportexcel" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=excel&title=<?php echo $_GET["title"]; ?>" target="_blank">Excel</a>
		<a id="getreportcopy" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=copy&title=<?php echo $_GET["title"]; ?>" target="_blank">Copy</a>
		<a id="getreportchart" class="btn btn-info" href="index.php?page=autoreports&getreport=<?php echo $source; ?>&type=chart&title=<?php echo $_GET["title"]; ?>" target="_blank">Chart</a>
	    </div>
	    <script>
	     var autoreportsColumns = <?php echo json_encode($columnsDefaults); ?>,
		 currentEditedColumn = false,
		 currentEditedData,
		 editedColumns = {},
		 orderMax = 2;
	     
	     function autoreportsChangeColumn(name){
		 var item, operators = <?php echo json_encode($data->getOperators()); ?>, currentOperator, ind, _html;

		 if(currentEditedColumn)
		     autoreportsChangeColumnBack(currentEditedColumn, currentEditedData);
		 
		 currentEditedColumn = name;

		 currentEditedData = {};
		 item = document.getElementById(name + "actions");
		 currentEditedData.actions = item.innerHTML;
		 item.innerHTML = "<span class=\"grid-action-button glyphicon glyphicon-save\" aria-hidden=\"true\" onclick=\"autoreportsSaveColumn('" + name + "')\"></span><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\" onclick=\"autoreportsCancelColumn('" + name + "')\"></span>"
		 
		 item = document.getElementById(name + "show");
		 currentEditedData.show = item.innerHTML;
		 item.innerHTML = "<input name=\"show\" type=\"checkbox\" " + (item.innerHTML == "True" ? "checked" : "") + "/>";

		 item = document.getElementById(name + "total");
		 currentEditedData.total = item.innerHTML;
		 item.innerHTML = "<input name=\"total\" type=\"checkbox\" " + (item.innerHTML == "True" ? "checked" : "") + "/>";

		 var curOrder = 1;
		 item = document.getElementById(name + "order");
		 currentEditedData.order = item.innerHTML;
		 _html = "<select name=\"order\"> " + (item.innerHTML == "-1" ? "<option>-1</option>" : "<option>" + item.innerHTML + "</option><option>-1</option>");
		 while(curOrder <= orderMax){
		     if(parseInt(item.innerHTML) != curOrder)
			 _html += "<option>" + curOrder + "</option>";
		     curOrder++;
		 }
		 _html += "</select>";
		 item.innerHTML = _html;
		 
		 item = document.getElementById(name + "direction");
		 currentEditedData.direction = item.innerHTML;
		 item.innerHTML = "<select name=\"direction\"> " + (item.innerHTML == "ASC" ? "<option>Ascending</option><option>Descending</option>" : "<option>Descending</option><option>Ascending</option>") + "</select>";

		 item = document.getElementById(name + "operator");
		 currentEditedData.operator = item.innerHTML;
		 currentOperator = item.innerHTML;
		 _html = "<select name=\"operator\">";
		 _html += "<option>" + currentOperator + "</option>";
		 if(currentOperator != "None")
		     _html += "<option>None</option>";
		 for(ind in operators){
		     if(currentOperator != operators[ind])
			 _html += "<option>" + operators[ind] + "</option>";
		 }
		 _html += "</select>";
		 item.innerHTML = _html;
		 
		 item = document.getElementById(name + "criteria");
		 currentEditedData.criteria = item.innerHTML;
		 item.innerHTML = "<input name=\"criteria\" type=\"text\" value=\"" + currentEditedData.criteria + "\"" + " />";
		 editedColumns[name] = currentEditedData;
	     }

	     function autoreportsChangeColumnBack(name, lastvalues){
		 currentEditedColumn = false;
		 var options = {}, ind, formarray;
		 if(lastvalues)
		     options = lastvalues
		 else{
		     formarray = $("#columnform").serializeArray();
		     for(ind in formarray)
			 options[formarray[ind].name] = formarray[ind].value;
		     if(options.hasOwnProperty("show"))
			 options.show = "True";
		     else
			 options.show = "False";
		     if(options.hasOwnProperty("total"))
			 options.total = "True";
		     else
			 options.total = "False";

		     if(options.direction == "Ascending")
			 options.direction = "ASC";
		     else
			 options.direction = "DESC";
		     
		     options.actions = "<span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\" onclick=\"autoreportsChangeColumn('" + name + "')\"></span>";
		 }
		 
		 var optostr = {
		     "None" : "None",
		     ">" : "M",
		     ">=" : "MEQ",
		     "<" : "L",
		     "<=" : "LEQ",
		     "=" : "EQ",
		     "!=" : "NEQ",
		     "LIKE" : "LIKE"
		 }

		 for(ind in options){
		     item = document.getElementById(name + ind);
		     item.innerHTML = options[ind];
		 }

		 options.operator = optostr[options.operator];
		 return options;
	     }

	     var getreportexplorerhref = document.getElementById("getreportexplorer").href;
	     var getreportscreenhref = document.getElementById("getreportscreen").href;
	     var getreportpdfhref = document.getElementById("getreportpdf").href;
	     var getreporttexthref = document.getElementById("getreporttext").href;
	     var getreportexcelhref = document.getElementById("getreportexcel").href;
	     var getreportcopyhref = document.getElementById("getreportcopy").href;
	     var getreportcharthref = document.getElementById("getreportchart").href;
	     
	     function autoreportsSaveColumn(name){
		 if(name){
		     var options = autoreportsChangeColumnBack(name);
		     autoreportsColumns[name] = [options.show, options.total, options.order, options.direction, options.operator, options.criteria];
		     if(parseInt(options.order) == orderMax)
			 orderMax++;
		 }
		 var params = {}, ind;
		 for(ind in autoreportsColumns)
		     params[ind] = autoreportsColumns[ind].join(",");
		 document.getElementById("getreportexplorer").href = getreportexplorerhref + "&" + $.param(params);
		 document.getElementById("getreportscreen").href = getreportscreenhref + "&" + $.param(params);
		 document.getElementById("getreportpdf").href = getreportpdfhref + "&" + $.param(params);
		 document.getElementById("getreporttext").href = getreporttexthref  + "&" + $.param(params);
		 document.getElementById("getreportexcel").href = getreportexcelhref + "&" + $.param(params);
		 document.getElementById("getreportcopy").href = getreportcopyhref + "&" + $.param(params);
		 document.getElementById("getreportchart").href = getreportcharthref + "&" + $.param(params);
	     }
	     autoreportsSaveColumn();

	     function autoreportsCancelColumn(name){
		 autoreportsChangeColumnBack(name, currentEditedData);
	     }

	    </script>
	<?php endif; ?>
    </div>
</div>
