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
	//require
	//	echo json_encode($data->CompanyAccountsStatus());
	//	echo "<br/>";
//	echo json_encode($data->CollectionAlerts());
/*	echo "<br/>";
	echo json_encode($data->CompanyDailyActivity());
	echo "<br/>";
	echo json_encode($data->CompanyIncomeStatement());
	echo "<br/>";
	echo json_encode($data->CompanySystemWideMessage());
	echo "<br/>";
	echo json_encode($data->InventoryLowStockAlert());
	echo "<br/>";
	echo json_encode($data->TopOrdersReceipts());*/
	?>
    </div>
</div>
