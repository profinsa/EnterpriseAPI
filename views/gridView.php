<!--
     Name of Page: gridView

     Method: renders whole page. 

     Date created: Nikita Zaharov, 02.20.2017

     Use: used by controllers/GeneralLedger/*.php for rendering page
     Page may renders in four modes:
     + grid
     data is displayed in table mode
     + view
     one record from table displayed showed more detail with categorized tabs
     + edit
     same as previous, but record displayed not as text as inputs for edit
     + new
     same as previous, but with default values and record inserted, not updated

     Input parameters:

     Output parameters:
     html

     Called from:
     controllers/GeneralLedger/*.php

     Calls:
     translation model
     grid model
     app as model
   -
     Last Modified: 07.02.2019
     Last Modified by: Nikita Zaharov
-->
<?php
    include './views/components/context.php';
    include './views/components/commonJavascript.php';
    include './views/components/common.php';
?>

<script>
 var datatableInitialized = false;
</script>
<div class="container-fluid" style="<?php  echo $ascope["interface"] == "simple" ? "margin-left:0px; margin-right:0px;" : ""; ?>">
    <?php if($ascope["interface"] == "default")
	require __DIR__ . '/views/uiItems/dashboard.php';
    ?>

    <?php if($ascope["interface"] == "simple"): ?>
	<div style="margin-left: 25px; margin-bottom:-25px; margin-top:30px;">
	    <?php require __DIR__ . '/interfaces/' . $ascope["interface"] . '/breadcrumbs.php'; ?>
	</div>
    <?php endif; ?>
    <div class="col-sm-12">
	<div class="white-box">
	    <!--
		 This is conditional page generation.
		 Contains four pages:
		 + grid
		 main screen of GeneralLedger/*.
		 contains table and buttons for edit and delete rows
		 + new
		 page is showed after click new on grid screen.
		 + view
		 page is showed after click edit on grid screen.
		 contains tabs with fields and values
		 + edit
		 page is showed after click edit on view screen.
		 contains tabs with fileds and values. Values is available for changing.
	    -->
	    <!-- formating staff -->
	    <?php require "format.php"; ?>
	    <?php if($scope->mode == 'grid'): ?>
		<?php
		    if(file_exists(__DIR__ . "/" . $PartsPath . "gridViewGrid.php"))
			require __DIR__ . "/" . $PartsPath . "gridViewGrid.php";
		    else
			require "views/gridView/grid.php";
		?>
	    <?php elseif($scope->mode == 'view'): ?>
		<?php
		    if(file_exists(__DIR__ . "/" . $PartsPath . "gridViewView.php"))
			require __DIR__ . "/" . $PartsPath . "gridViewView.php";
		    else if(key_exists($PartsPath, $redirectView) && file_exists(__DIR__ . "/" . $redirectView[$PartsPath]["view"] . "gridViewView.php"))
			require __DIR__ . "/" . $redirectView[$PartsPath]["view"] . "gridViewView.php";
		    else
			require "views/gridView/view.php";
		?>
	    <?php elseif($scope->mode == 'edit' || $scope->mode == 'new'): ?>
		<?php
		    if(file_exists(__DIR__ . "/" . $PartsPath . "gridViewEdit.php"))
			require __DIR__ . "/" . $PartsPath . "gridViewEdit.php";
		    else if(key_exists($PartsPath, $redirectView) && file_exists(__DIR__ . "/" . $redirectView[$PartsPath]["edit"] . "gridViewEdit.php"))
			require __DIR__ . "/" . $redirectView[$PartsPath]["edit"] . "gridViewEdit.php";
		    else
			require "views/gridView/edit.php";
		?>
	    <?php endif; ?>
	</div>
    </div>
</div>

<style>
 .grid-length label{
     margin-top : 7px;
     text-align : center !important;
 }
</style>

<script language="javascript" type="text/javascript">
 <?php if($ascope["interface"] == "default"): ?>
 if(!$.fn.DataTable.isDataTable("#example23")){
     $('#example23').DataTable( {
	 pageLength : gridViewDefaultRowsInGrid,
	 dom : "Bfrt<\"grid-footer row col-md-12\"<\"col-md-3 grid-length\"l><\"col-md-3\"i><\"col-md-6\"p>>",
	 buttons: [
	     'copy', 'csv', 'excel', 'pdf', 'print'
	 ]
     });
 }
 if(!$.fn.DataTable.isDataTable(".datatable")){
     $('.datatable').DataTable( {
	 dom : "frtlip",
     });
 }
 <?php elseif($ascope["interface"] == "simple"): ?>
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
 
 if(!datatableInitialized){
     datatableInitialized = true;
     try{
	 var table = $('#example23').DataTable( {
	     <?php  echo (!property_exists($data, "features") || !in_array("disabledGridPageUI", $data->features) ? "" : "dom : \"tip\","); ?>
	     pageLength : gridViewDefaultRowsInGrid,
	     buttons: [
		 'copy', 'csv', 'excel', 'pdf', 'print'
	     ]
	 });
	 var buttons = $('.dt-buttons-container');
	 var dtbuttons = table.buttons().container();
	 dtbuttons.prepend($(".new-button-action"));
	 dtbuttons.prepend($(".grid-actions-button"));
	 dtbuttons.addClass("col-md-12 pull-right");
	 buttons.append(dtbuttons);
	 
	 $('.dt-button').addClass("btn btn-info");
	 $('.dt-button').css("margin-left", "3px");
	 $('.grid-actions-button').css("margin-left", "3px");
	 $('.dt-button').removeClass("dt-button buttons-html5");

	 // Order by the grouping
	 $('#example tbody').on( 'click', 'tr.group', function () {
	     var currentOrder = table.order()[0];
	     if ( currentOrder[0] === 2 && currentOrder[1] === 'asc' ) {
		 table.order( [ 2, 'desc' ] ).draw();
	     }
	     else {
		 table.order( [ 2, 'asc' ] ).draw();
	     }
	 });
     }catch(e){
	 //just a stub
     }
 }

 <?php endif; ?>
 $('.fdatetime').datepicker({
     autoclose : true,
     orientation : "bottom",
     toggleActive : false,
     format: {
	 toDisplay: function (date, format, language) {
	     //console.log(date,' eee');
	     var d = new Date(date);
	     return (d.getMonth() + 1) + 
		    "/" +  d.getDate() +
		    "/" +  d.getFullYear();
	 },
	 toValue: function (date, format, language) {
	     var d = new Date(date);
	     return (d.getMonth() + 1) + 
		    "/" +  d.getDate() +
		    "/" +  d.getFullYear();
	 }
     }
 }); 
</script>
