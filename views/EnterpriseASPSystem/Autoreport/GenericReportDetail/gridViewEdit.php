<div id="row_editor" class="row">
    <div style="margin-top:10px;"></div>
    <div class="col-md-12">
	<div class="col-md-7">
	    <select id="report-type" style="width: 400px;" onchange="onChangeReport(event);">
	    </select>
	</div>
	<div class="col-md-5">
	    <div class=" pull-right">
		<a class="btn btn-info" href="javascript:reportConfigurationSave();">Save Report As</a>
		<a class="btn btn-info" href="javascript:reportConfigurationDelete();">Delete Saved Report</a>
	    </div>
	</div>
    </div>
    <h3 style="margin-top:20px;">
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
		<tbody id="table-body">
		</tbody>
	    </table>
	</form>
    </div>

    <h3 class="pull-left col-md-12" style="margin-top:20px;">
	<?php echo $translation->translateLabel("Run Report");?>
    </h3>
    <div class="col-md-12">
	<a id="getreportexplorer" class="btn btn-info" href="#" target="_blank">Reports Explorer</a>
	<a id="getreportscreen" class="btn btn-info" href="#" target="_blank">Screen</a>
	<a id="getreportpdf" class="btn btn-info" href="#" target="_blank">PDF</a>
	<a id="getreporttext"  class="btn btn-info" href="#" target="_blank">CSV</a>
	<a id="getreportexcel" class="btn btn-info" href="#" target="_blank">Excel</a>
	<a id="getreportcopy" class="btn btn-info" href="#" target="_blank">Copy</a>
	<a id="getreportchart" class="btn btn-info" href="#" target="_blank">Chart</a>
    </div>
</div>
<script>
 var autoreportsColumns = [];
 var currentEditedColumn = false;
 var currentEditedData;
 var editedColumns = {};
 var orderMax = 2;
 var reportTypes = [];
 var header = <?php echo json_encode($_GET, JSON_PRETTY_PRINT);?>;
 var columnsDefaults = {};

 var getreportexplorerhref = document.getElementById("getreportexplorer").href;
 var getreportscreenhref = document.getElementById("getreportscreen").href;
 var getreportpdfhref = document.getElementById("getreportpdf").href;
 var getreporttexthref = document.getElementById("getreporttext").href;
 var getreportexcelhref = document.getElementById("getreportexcel").href;
 var getreportcopyhref = document.getElementById("getreportcopy").href;
 var getreportcharthref = document.getElementById("getreportchart").href;

 function autoreportsFillParameter(param, event){
     var params = {};

     var data = reportTypes[$('#report-type option:selected').text()]["params"];

     var keys = Object.keys(data);

     for (var i = 0; i < keys.length; i++) {
	 params[data[keys[i]].PARAMETER_NAME] = null;
     }

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
     //     console.log(filled, plength);
 }

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

 function autoreportsSaveColumn(name){
     if(name){
	 var options = autoreportsChangeColumnBack(name);
	 autoreportsColumns[name] = [options.show, options.total, options.order, options.direction, options.operator, options.criteria];
	 if(parseInt(options.order) == orderMax) {
	     orderMax++;
	 }
     }

     var params = {}, ind;
     for(ind in autoreportsColumns) {
	 params[ind] = autoreportsColumns[ind].join(",");
     }

     //     console.log(JSON.stringify(autoreportsColumns, null, 3));
     
     document.getElementById("getreportexplorer").href = getreportexplorerhref + "&" + $.param(params);
     document.getElementById("getreportscreen").href = getreportscreenhref + "&" + $.param(params);
     document.getElementById("getreportpdf").href = getreportpdfhref + "&" + $.param(params);
     document.getElementById("getreporttext").href = getreporttexthref  + "&" + $.param(params);
     document.getElementById("getreportexcel").href = getreportexcelhref + "&" + $.param(params);
     document.getElementById("getreportcopy").href = getreportcopyhref + "&" + $.param(params);
     document.getElementById("getreportchart").href = getreportcharthref + "&" + $.param(params);
 }

 function autoreportsCancelColumn(name){
     autoreportsChangeColumnBack(name, currentEditedData);
 }

 var updatePage = function () {
     var _html = '';
     var reportTitle = $('#report-type option:selected').text();
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getParametersForEnter"); ?>",{
	 "reportName" : reportTypes[reportTitle]["reportName"]
     })
      .success(function(data) {
	  autoreportsColumns = {};
	  currentEditedColumn = false;
	  currentEditedData;
	  editedColumns = {};
	  orderMax = 2;

	  reportTypes[$('#report-type option:selected').text()]["params"] = data;
	  if (!data.length || header[data[0].PARAMETER_NAME]) {
	      // getColumns
	      $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getColumns"); ?>",{
		  "reportName" : reportTypes[reportTitle]["reportName"]
	      })
	       .success(function(data) {
		   reportTypes[reportTitle]["columns"] = data;

		   columnsDefaults = {};
		   var ind;
		   var savedReports = localStorage.getItem("reportsEngineSavedReports");
		   if(savedReports && (savedReports = JSON.parse(savedReports)) && savedReports[reportTitle]){
		       columnsDefaults = savedReports[reportTitle];
		       //console.log(savedReports, reportTitle);
		       autoreportsColumns = {};
		       for(ind in columnsDefaults)
			   autoreportsColumns[ind] =[
			       columnsDefaults[ind].show,
			       columnsDefaults[ind].total,
			       columnsDefaults[ind].order,
			       columnsDefaults[ind].direction,
			       columnsDefaults[ind].operator,
			       columnsDefaults[ind].criteria,
			   ];
		   }else {
		       for(ind in data){
			   columnsDefaults[ind] = {
			       show : "True",
			       total : data[ind]["native_type"] == "NEWDECIMAL" || data[ind]["native_type"] == "DECIMAL" ? "True" : "False",
			       order : !ind ? 1 : -1,
			       direction : "ASC",
			       operator : "None",
			       criteria : ""
			   };
		       }
		   }
		   _html = '';
		   for(ind in columnsDefaults){
		       _html += "<tr><td id=\"" + ind + "actions\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\" onclick=\"autoreportsChangeColumn('" + ind + "')\"></span></td><td>" + ind + "</td><td id=\"" + ind + "show\">" + columnsDefaults[ind].show + "</td><td id=\"" + ind + "total\">" + columnsDefaults[ind].total + "</td><td id=\"" + ind + "order\">" + columnsDefaults[ind].order + "</td><td id=\"" + ind + "direction\">" + columnsDefaults[ind].direction + "</td><td id=\"" + ind + "operator\">" + columnsDefaults[ind].operator + "</td><td id=\"" + ind + "criteria\">" + columnsDefaults[ind].criteria + "</td></tr>";
		   }
		   $("#table-body").html(_html);

		   var reportName = reportTypes[$('#report-type option:selected').text()]["reportName"];
		   document.getElementById("getreportexplorer").href = linksMaker.makeAutoreportsViewLink("explorer", reportName , "", reportTitle, "");
		   document.getElementById("getreportscreen").href = linksMaker.makeAutoreportsViewLink("screen", reportName , "", reportTitle, "");
		   document.getElementById("getreportpdf").href = linksMaker.makeAutoreportsViewLink("pdf", reportName , "", reportTitle, "");
		   document.getElementById("getreporttext").href = linksMaker.makeAutoreportsViewLink("text", reportName , "", reportTitle, "");
		   document.getElementById("getreportexcel").href = linksMaker.makeAutoreportsViewLink("excel", reportName , "", reportTitle, "");
		   document.getElementById("getreportcopy").href = linksMaker.makeAutoreportsViewLink("copy", reportName , "", reportTitle, "");
		   document.getElementById("getreportchart").href = linksMaker.makeAutoreportsViewLink("chart", reportName , "", reportTitle, "");

		   getreportexplorerhref = document.getElementById("getreportexplorer").href;
		   getreportscreenhref = document.getElementById("getreportscreen").href;
		   getreportpdfhref = document.getElementById("getreportpdf").href;
		   getreporttexthref = document.getElementById("getreporttext").href;
		   getreportexcelhref = document.getElementById("getreportexcel").href;
		   getreportcopyhref = document.getElementById("getreportcopy").href;
		   getreportcharthref = document.getElementById("getreportchart").href;
		   autoreportsSaveColumn();
	       })
	       .error(function(err){
		   alert('Something goes wrong');
	       });
	  } else {
	      reportTypes[$('#report-type option:selected').text()]["columns"] = false;
	  }
      })
      .error(function(err){
	  alert('Something goes wrong');
      });		
 }

 function onChangeReport(event){
     // console.log($('#report-type').val());
     // console.log($('#report-type option:selected').text());
     updatePage();
 }

 function reportConfigurationSave(){
     //    console.log(JSON.stringify(columnsDefaults, null, 3));
     var reportTitle = $('#report-type option:selected').text(), ind, dataToSave =  {};     
     for(ind in columnsDefaults){
	 dataToSave[ind] = {
	     show : $("#" + ind + "show").html(),
	     total : $("#" + ind + "total").html(),
	     order : $("#" + ind + "order").html(),
	     direction : $("#" + ind + "direction").html(),
	     operator : $("#" + ind + "operator").html(),
	     criteria : $("#" + ind + "criteria").html()
	 }
     }
     //     console.log(JSON.stringify(dataToSave, null, 3));
     var savedReports = localStorage.getItem("reportsEngineSavedReports");
     if(savedReports)
	 savedReports = JSON.parse(savedReports);
     else
	 savedReports = {};

     savedReports[reportTitle] = dataToSave;
     localStorage.setItem("reportsEngineSavedReports", JSON.stringify(savedReports));
     //	 dataToSave
     //     console.log('saving');
 }

 function reportConfigurationDelete(){
     var reportTitle = $('#report-type option:selected').text();     
     var savedReports = localStorage.getItem("reportsEngineSavedReports");
     if(savedReports){
	 savedReports = JSON.parse(savedReports);
	 savedReports[reportTitle] = undefined;
	 localStorage.setItem("reportsEngineSavedReports", JSON.stringify(savedReports));
     }
     //   console.log('deleting');
 }

 // console.log($('#report-type').val());
 // console.log($('#report-type option:selected').text());
 
 $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getReportTypes"); ?>",{})
  .success(function(data) {
      console.log(data);
      reportTypes = data;
      var ind, _html = '';
      for(ind in reportTypes) {
	  _html += "<option value=\"" + reportTypes[ind]["link"] + "\">";
	  _html += reportTypes[ind]["label"];
	  _html += "</option>";     
      }
      $("#report-type").html(_html);
      updatePage();
  });
</script>

