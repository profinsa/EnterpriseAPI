<div class="container-fluid">
    <?php
    require 'uiItems/dashboard.php';
    ?>
    
    <?php
    $companyStatus = $data->CompanyAccountsStatus();
    ?>
    <div class="row">
    </div>
    <!--row -->
    <div class="row">
	<div class="col-md-8">
            <div>
		<div class="white-box">
		    <h3 class="box-title">Company Status</h3>
		    <div id="morris-donut-chart" class="ecomm-donute" style="height: 317px;"></div>
		    <ul class="list-inline m-t-30 text-center">
			<?php
			$colors = ["#fb9678", "#01c0c8", "#4F5467"];
			$colorInd = 0;
			
			foreach($companyStatus as $row)
			    echo "<li class=\"p-r-20\"><h5 class=\"text-muted\"><i class=\"fa fa-circle\" style=\"color: " . $colors[$colorInd++] . ";\"></i>" . $row->GLAccountName  ."</h5><h4 class=\"m-b-0\">" . $row->Totals . "</h4></li>";

			?>
		    </ul>
		</div>
	    </div>
	    <script> 
	     Morris.Donut({
		 element: 'morris-donut-chart',
		 data: [
		     <?php
		     foreach($companyStatus as $row)
			 echo "{ label : \"" . $row->GLAccountName . "\", value : \"" . $row->Totals . "\"},";
		     ?>
		 ],
		 resize: true,
		 colors:['#fb9678', '#01c0c8', '#4F5467']
	     });
	    </script>

	    <div>
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
	    $systemWideMessages = $data->CompanySystemWideMessage();
	    ?>
	    <div>
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
	    $topOrdersReceipts = $data->TopOrdersReceipts();
	    ?>
	    <div>
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
	    
	</div>
	<div class="col-md-4">
	    <?php
	    $collectionAlerts = $data->CollectionAlerts();
	    ?>
	    <div>
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
	    $todaysTasks = $data->TodaysTasks();
	    ?>
	    <div>
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
	    $leadFollowUp = $data->LeadFollowUp();
	    ?>
	    <div>
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
	</div>

	<?php
	//require
	//	echo json_encode($data->CompanyAccountsStatus());
	//	echo "<br/>";
	//	echo json_encode($data->CollectionAlerts());
/*	echo "<br/>";
	echo "CompanyDailyActivity" .  json_encode($data->CompanyDailyActivity());
	echo "<br/>";
	echo "<br/>";
	echo "CompanyIncomeStatement" . json_encode($data->CompanyIncomeStatement());
	echo "<br/>";
	echo "<br/>";
	echo "<br/>";
		echo "Company System Wide Message" . json_encode($data->CompanySystemWideMessage());
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
	   echo "<br/>";
	echo "TopOrdersReceipts" . json_encode($data->TopOrdersReceipts());*/
	?>
    </div>
</div>
