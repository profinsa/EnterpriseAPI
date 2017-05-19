<table id="example23" class="table table-striped table-bordered">
    <thead>
	<tr>
	    <th></th>
	    <?php
	    //getting data for table
	    //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
	    //we use first row of data for column rendering, each row is object with columnname=>value pairs
	    if(count($rows)){
		foreach($rows[0] as $key =>$value)
		    if(key_exists($key, $gridFields))
			echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
	    }
	    ?>
	</tr>
    </thead>
    <tbody>
	<?php
	$embeddedgridFields = property_exists($data, "embeddedgridFields") ? $data->embeddedgridFields : $data->transactionsFields;
	//renders table rows using rows, getted in previous block with $data->getPage()
	//also renders buttons like edit, delete of row
	if(count($rows)){
	    $current_row = 0;
	    foreach($rows as $row){
		//creating keyString - it is string, contains all keys of table. It used with combination with id of row 
		$keyString = '';
		//			    foreach($data->gridIdFields as $key){
		//				$keyString .= $row[$key] . "__";
		//			    }
		//			    $keyString = substr($keyString, 0, -2);
		
		echo "<tr>";
		/*
		   this column contains row actions like edit, remove, print etc.
		   Each action may be any html code. For now usually we have two type actions:
		   - action link
		   just link, no javascript login. Example - edit action is just link to edit page. Link contains $keyString for accurate pointing to edited item
		   - javascript action
		   some code react on click and does job. Example - delete button. In end of this file we have
		   ngridDeleteItem function which called on click and just does XHR delete request and reload
		   page content after receiving result
		 */
		echo "<td>";
		if(key_exists("TransactionType", $row) && key_exists("TransactionNumber", $row)){
		    echo "<a href=\"";
		    echo $drill->getViewHrefByTransactionNumberAndType($row["TransactionNumber"], $row["TransactionType"]);
		    echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
		}

		if(function_exists("makeRowActions")){
		    makeRowActions($public_prefix, $scope, $row, $embeddedgridContext);
		}
		/*
		   Each grid page(each screen) can have own row actions.
		   Like actions above it is just a html. It can have javascript or not
		   $PartsPath is path part what depends of current screen on which the user is located
		   For example, we want to add some actions to Account Receivable -> Order Processing -> View Orders
		   then we need create file gridRowActions on that path: resources/view/EnterpriseASPAR/OrderProcessing/OrderHeaderList/gridRowActions.php and add to it some html
		 */
		//including custom row actions
		if(file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php"))
		    require __DIR__ . "/../" . $PartsPath . "gridRowActions.php";

		echo "</td>";

		/*
		   Output values. Each value just a text inside td.
		   Value can be formatted if it needed by its type. For example datetime prints as month/day/year
		   Also here is the formatting using formatFunction. This feature used by formatting Currency fields
		 */
		foreach($row as $key=>$value)
		    if(key_exists($key, $gridFields)){
			echo "<td>\n";
			switch($gridFields[$key]["inputType"]){
			    case "checkbox" :
				echo $value ? "True" : "False";
				break;
			    case "timestamp" :
			    case "datetime" :
				echo date("m/d/y", strtotime($value));
				break;
			    case "text":
			    case "dropdown":
				switch($key){
				    case "CustomerID" :
					echo $drill->getLinkByField($key,$value);
					break;
				    case "VendorID" :
					echo $drill->getLinkByField($key,$value);
					break;
				    case "OrderNumber" :
					echo $drill->getReportLinkByOrderNumber($value, $scope["pathPage"]);
					break;
				    case "InvoiceNumber" :
					echo $drill->getReportLinkByInvoiceNumber($value, $scope["pathPage"]);
					break;
				    case "TransactionNumber" :
					if(key_exists("TransactionType", $row))
					    echo $drill->getReportLinkByTransactionNumberAndType($value, $row["TransactionType"]);
					else
					    echo $value;
					break;
				    case "CVID" :
					if(key_exists("TransactionType", $row))
					    echo $drill->getLinkByCVID($row["TransactionType"], $value);
					else
					    echo $value;
					break;
				    default:
					if(key_exists("formatFunction", $embeddedgridFields[$key])){
					    $formatFunction = $embeddedgridFields[$key]["formatFunction"];
					    echo $data->$formatFunction($row, "gridFields", $key, $value, false);
					}
					else
					    echo formatField($embeddedgridFields[$key], $value);
					break;
				}
			}
			echo "</td>\n";
		    }
		echo "</tr>";
		$current_row++;
	    }
	}
	?>
    </tbody>
</table>
<script>
 //"https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"
 //inlined for fast
 /*!
    DataTables Bootstrap 3 integration
    В©2011-2015 SpryMedia Ltd - datatables.net/license
  */
 (function(b){"function"===typeof define&&define.amd?define(["jquery","datatables.net"],function(a){return b(a,window,document)}):"object"===typeof exports?module.exports=function(a,d){a||(a=window);if(!d||!d.fn.dataTable)d=require("datatables.net")(a,d).$;return b(d,a,a.document)}:b(jQuery,window,document)})(function(b,a,d,m){var f=b.fn.dataTable;b.extend(!0,f.defaults,{dom:"<'row'<'col-sm-6'l><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",renderer:"bootstrap"});b.extend(f.ext.classes,
																																																														     {sWrapper:"dataTables_wrapper form-inline dt-bootstrap",sFilterInput:"form-control input-sm",sLengthSelect:"form-control input-sm",sProcessing:"dataTables_processing panel panel-default"});f.ext.renderer.pageButton.bootstrap=function(a,h,r,s,j,n){var o=new f.Api(a),t=a.oClasses,k=a.oLanguage.oPaginate,u=a.oLanguage.oAria.paginate||{},e,g,p=0,q=function(d,f){var l,h,i,c,m=function(a){a.preventDefault();!b(a.currentTarget).hasClass("disabled")&&o.page()!=a.data.action&&o.page(a.data.action).draw("page")};
																																																															 l=0;for(h=f.length;l<h;l++)if(c=f[l],b.isArray(c))q(d,c);else{g=e="";switch(c){case "ellipsis":e="&#x2026;";g="disabled";break;case "first":e=k.sFirst;g=c+(0<j?"":" disabled");break;case "previous":e=k.sPrevious;g=c+(0<j?"":" disabled");break;case "next":e=k.sNext;g=c+(j<n-1?"":" disabled");break;case "last":e=k.sLast;g=c+(j<n-1?"":" disabled");break;default:e=c+1,g=j===c?"active":""}e&&(i=b("<li>",{"class":t.sPageButton+" "+g,id:0===r&&"string"===typeof c?a.sTableId+"_"+c:null}).append(b("<a>",{href:"#",
																																																																																																																													      "aria-controls":a.sTableId,"aria-label":u[c],"data-dt-idx":p,tabindex:a.iTabIndex}).html(e)).appendTo(d),a.oApi._fnBindAction(i,{action:c},m),p++)}},i;try{i=b(h).find(d.activeElement).data("dt-idx")}catch(v){}q(b(h).empty().html('<ul class="pagination"/>').children("ul"),s);i!==m&&b(h).find("[data-dt-idx="+i+"]").focus()};return f});
</script>
