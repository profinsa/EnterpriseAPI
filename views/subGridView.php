<!--
     Name of Page: subgridView

     Method: renders whole page. 

     Date created: Nikita Zaharov, 23.02.2016

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

     Last Modified: 30.03.2016
     Last Modified by: Nikita Zaharov
   -->

<!-- Page Content -->
<div class="" style="margin-top:20px;">
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
    <?php require "format.php"; ?>
    <?php if($scope->mode == 'subgrid'): ?>
	<?php require "subGridView/subgrid.php"; ?>
    <?php elseif($scope->mode == 'edit' || $scope->mode == 'new'): ?>
	<?php require "subGridView/edit.php"; ?>
     <?php endif; ?>
</div>
<script language="javascript" type="text/javascript">
 
 <?php  if(!key_exists("partial", $_GET)):?>
 $(document).ready(function(){
 <?php endif; ?>
     $.ajaxSetup({
	 headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
     });
     var table = $('#example23').DataTable( {
	 dom : "<'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i>>"
	 //	 buttons: [
	 //	     'copy', 'csv', 'excel', 'pdf', 'print'
	 //	 ]
     });

     //   var buttons = $('.dt-buttons-container');
     //   var dtbuttons = table.buttons().container();
     // dtbuttons.prepend($(".new-button-action"));
     //  dtbuttons.addClass("col-md-12");
     //  buttons.append(dtbuttons);
     
     //    $('.dt-button').addClass("btn btn-info");
     //  $('.dt-button').css("margin-left", "3px");
     // $('.dt-button').removeClass("dt-button buttons-html5");

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
     <?php  if(!key_exists("partial", $_GET)):?>
 });
     <?php endif; ?>
 
 jQuery('.fdatetime').datepicker({
     autoclose : true,
     orientation : "bottom",
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
