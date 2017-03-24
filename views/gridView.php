<!--
     Name of Page: gridView

     Method: renders whole page. 

     Date created: Nikita Zaharov, 20.02.2016

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
     Last Modified: 24.03.2016
     Last Modified by: Nikita Zaharov
   -->
<div class="container-fluid">
    <?php
    require './views/uiItems/dashboard.php';
    ?>
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
	    <!-- grid -->
	    <?php if($scope->mode == 'grid'): ?>
		<?php  require "views/gridView/grid.php";?>
		<!-- view -->
	    <?php elseif($scope->mode == 'view'): ?>
		<?php  require "views/gridView/view.php";?>
		<!-- edit and new -->
	    <?php elseif($scope->mode == 'edit' || $scope->mode == 'new'): ?>
		<?php  require "views/gridView/edit.php";?>
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
 $('#example23').DataTable( {
     dom : "Bfrt<\"grid-footer row col-md-12\"<\"col-md-3 grid-length\"l><\"col-md-3\"i><\"col-md-6\"p>>",
     buttons: [
	 'copy', 'csv', 'excel', 'pdf', 'print'
     ]
 });

 jQuery('.fdatetime').datepicker({
     autoclose : true,
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
