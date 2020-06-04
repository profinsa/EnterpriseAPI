<div id="report" class="row">
    <div class="col-md-12 col-xs-12 invoice-table-detail" style="padding:0px">
	<?php
	require "companyheader.php";

	$gridData = $data->getData();
	//	echo json_encode($gridData);
	?>
	<h3 class="col-md-12 col-xs-12" style="margin-top:20px; font-family: Arial; color:black">
	    Aged Payable Summary
	</h3>
	<?php
	$currentGridData = $gridData["summary"];
	require "simpletable.php";
	?>
	<h3 class="col-md-12 col-xs-12" style="margin-top:20px; font-family: Arial; color:black">
	    Aged Payable Totals
	</h3>
	<?php
	$currentGridData = $gridData["totals"];
	require "simpletable.php";
	?>
	<h3 class="col-md-12 col-xs-12" style="margin-top:20px; font-family: Arial; color:black">
	    Aged Payable Details
	</h3>
	<?php
	$currentGridData = $gridData["details"];
	require "simpletable.php";
	?>
    </div>
</div>
