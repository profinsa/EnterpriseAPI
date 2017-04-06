<div class="container-fluid">
    <?php
    require 'uiItems/dashboard.php';
    ?>
    <!--row -->
    <div class="row">
	<?php
	$companyStatus = $data->CompanyAccountsStatus();
	?>
	<div class="col-sm-8">
	    <div class="white-box">
		<h3 class="box-title m-b-0">Company Status</h3>
		<p class="text-muted">this is the sample data</p>
		<div class="table-responsive">
		    <table class="table">
			<thead>
			    <tr>
				<th>Account Type</th>
				<th>Account Name</th>
				<th>Account Totals</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($companyStatus as $row)
				echo "<tr><td>" . $row->GLAccountType . "</td><td>" . $row->GLAccountName . "</td><td>" . $row->Totals . "</td></tr>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>
	
	<?php
	$collectionAlerts = $data->CollectionAlerts();
	?>
	<div class="col-sm-4">
	    <div class="white-box">
		<h3 class="box-title m-b-0">Collections Alerts</h3>
		<p class="text-muted">this is the sample data</p>
		<div class="table-responsive">
		    <table class="table table-hover">
			<thead>
			    <tr>
				<th>Customer ID</th>
				<th>Overdue</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($collectionAlerts as $row)
				echo "<tr><td>" . $row->CustomerID . "</td><td>" . $row->Overdue . "</td></tr>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>

	<?php
	$systemWideMessages = $data->CompanySystemWideMessage();
	?>
	<div class="col-sm-8">
	    <div class="white-box">
		<h3 class="box-title m-b-0">System Wide Messages</h3>
		<!-- 	<p class="text-muted">this is the sample data</p> -->
		<div class="table-responsive">
		    <table class="table">
 			<thead>
			    <tr>
				<th>Message</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($systemWideMessages as $row)
				echo "<tr><td>" . $row->SystemMessage . "</td>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>

	<?php
	$todaysTasks = $data->TodaysTasks();
	?>
	<div class="col-sm-4">
	    <div class="white-box">
		<h3 class="box-title m-b-0">Todays Tasks</h3>
		<p class="text-muted">this is the sample data</p>
		<div class="table-responsive">
		    <table class="table table-hover">
			<thead>
			    <tr>
				<th>Due Date</th>
				<th>Task</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($todaysTasks as $row)
				echo "<tr><td>" . $row->DueDate . "</td><td>" . $row->Task . "</td></tr>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>

	<?php
	$topOrdersReceipts = $data->TopOrdersReceipts();
	?>
	<div class="col-sm-8">
	    <div class="white-box">
		<h3 class="box-title m-b-0">Top 5 Open Orders & Receivings</h3>
		<p class="text-muted">this is the sample data</p>
		<div class="table-responsive">
		    <table class="table">
			<thead>
			    <tr>
				<th>Order Number</th>
				<th>Customer</th>
				<th>Ship Date</th>
				<th>Amount</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($topOrdersReceipts as $row)
				echo "<tr><td>" . $row->OrderNumber . "</td><td>" . $row->CustomerID . "</td><td>" . $row->OrderShipDate . "</td><td>" . $row->OrderTotal . "</td></tr>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>
	
	<?php
	$leadFollowUp = $data->LeadFollowUp();
	?>
	<div class="col-sm-4">
	    <div class="white-box">
		<h3 class="box-title m-b-0">Follow Up Today</h3>
		<p class="text-muted">this is the sample data</p>
		<div class="table-responsive">
		    <table class="table table-hover">
			<thead>
			    <tr>
				<th>Lead ID</th>
				<th>Email</th>
			    </tr>
			</thead>
			<tbody>
			    <?php
			    foreach($leadFollowUp as $row)
				echo "<tr><td>" . $row->LeadID . "</td><td>" . $row->LeadEmail . "</td></tr>";
			    ?>
			</tbody>
		    </table>
		</div>
	    </div>
	</div>

	<?php
	//require
	//	echo json_encode($data->CompanyAccountsStatus());
	//	echo "<br/>";
//	echo json_encode($data->CollectionAlerts());
	echo "<br/>";
	echo "CompanyDailyActivity" .  json_encode($data->CompanyDailyActivity());
	echo "<br/>";
	echo "<br/>";
	echo "CompanyIncomeStatement" . json_encode($data->CompanyIncomeStatement());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";
/*	echo "Company System Wide Message" . json_encode($data->CompanySystemWideMessage());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";
	echo "InventoryLowStockAlert" . json_encode($data->InventoryLowStockAlert());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";
	echo "TodayTasks" . json_encode($data->TodaysTasks());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";
	echo "LeadFollowUp" . json_encode($data->LeadFollowUp());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";*/
	echo "TopOrdersReceipts" . json_encode($data->TopOrdersReceipts());
	?>
    </div>
</div>
