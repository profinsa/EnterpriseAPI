<div class="container-fluid">
    <?php
    require __DIR__ . '/../uiItems/dashboard.php';
    require __DIR__ . '/../format.php';
    ?>
    
    <?php
    $companyStatus = $data->CompanyAccountsStatus();
    ?>
    <div class="row">
	<?php
	$systemWideMessages = $data->CompanySystemWideMessage();
	?>
	<div class="col-md-12 col-xs-12">
	    <div class="white-box">
		<h3 class="box-title m-b-0"><?php echo $translation->translateLabel("System Wide Messages"); ?></h3>
		<!-- 	<p class="text-muted">this is the sample data</p> -->
		<div class="table-responsive">
		    <table class="table">
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
    </div>
    <!--row -->
    <div class="row">
	<div class="col-md-8">
	    <div>
		<div class="white-box">
		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Company Status"); ?></h3>
		    <!-- 		    <p class="text-muted">this is the sample data</p> --> 
		    <div class="table-responsive">
			<table class="table">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Account Type"); ?></th>
				    <th><?php echo $translation->translateLabel("Account Name"); ?></th>
				    <th><?php echo $translation->translateLabel("Account Totals"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($companyStatus as $row)
				echo "<tr><td>" . $row->GLAccountType . "</td><td>" . $drill->getLinkByAccountNameAndAccountType($row->GLAccountName,$row->GLAccountType)  . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Totals) . "</td></tr>";
				?>
			    </tbody>
			</table>
		    </div>
		</div>
	    </div>
	    <div>
		<div class="white-box">
		    <h3 class="box-title"><?php echo $translation->translateLabel("Company Status"); ?></h3>
		    <div id="morris-donut-chart" class="ecomm-donute" style="height: 317px;"></div>
		    <ul class="list-inline m-t-30 text-center">
			<?php
			$colors = ["#0074D9", "#FF4136", "#2ECC40", "#FF851B", "#7FDBFF", "#B10DC9", "#FFDC00", "#001f3f", "#39CCCC", "#01FF70", "#85144b", "#F012BE", "#3D9970", "#111111", "#AAAAAA"];
			while (true) {
			    $colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
			    if(count($colors) == 10000)
				break;
			}
			$colorInd = 0;
			
			foreach($companyStatus as $row)
			echo "<li class=\"p-r-20\"><h5 class=\"text-muted\"><i class=\"fa fa-circle\" style=\"color: " . $colors[$colorInd++] . ";\"></i>" . $row->GLAccountName  ."</h5><h4 class=\"m-b-0\">" . formatField(["format"=>"{0:n}"], $row->Totals) . "</h4></li>";

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
		     echo "{ label : \"" . $row->GLAccountName . "\", value : \"" .  $row->Totals . "\"},";
		     ?>
		 ],
		 resize: true,
		 colors: <?php echo json_encode($colors); ?>
	     });
	    </script>
	    
	    <div>
		<?php
		$companyDailyActivity = $data->CompanyDailyActivity();
		?>
		<div>
		    <div class="white-box">
			<h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today's Activity"); ?></h3>
			<!-- 		    <p class="text-muted">this is the sample data</p> --> 
			<div class="table-responsive">
			    <table class="table">
				<thead>
				    <tr>
					<th><?php echo $translation->translateLabel("New Quotes"); ?></th>
					<th><?php echo $translation->translateLabel("Quote Totals"); ?></th>
				    </tr>
				</thead>
				<tbody>
				    <?php
				    foreach($companyDailyActivity["quotes"] as $row)
				    echo "<tr><td width=\"50%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewQuotes") . "&filter=last24\">{$row->Quotes}</a>" . "</td><td width=\"50%\">" . formatField(["format"=>"{0:n}"], $row->QuoteTotals) . "</td></tr>";
				    ?>
				</tbody>
			    </table>
			</div>
			<div class="table-responsive">
			    <table class="table">
				<thead>
				    <tr>
					<th><?php echo $translation->translateLabel("New Orders"); ?></th>
					<th><?php echo $translation->translateLabel("Order Totals"); ?></th>
				    </tr>
				</thead>
				<tbody>
				    <?php
				    foreach($companyDailyActivity["orders"] as $row)
				    echo "<tr><td width=\"50%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=last24\">{$row->Orders}</a>" . "</td><td width=\"50%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotals) . "</td></tr>";
				    ?>
				</tbody>
			    </table>
			</div>
			<div class="table-responsive">
			    <table class="table">
				<thead>
				    <tr>
					<th><?php echo $translation->translateLabel("Shipments Today"); ?></th>
					<th><?php echo $translation->translateLabel("Shipment Totals"); ?></th>
				    </tr>
				</thead>
				<tbody>
				    <?php
				    foreach($companyDailyActivity["shipments"] as $row)
				    echo "<tr><td width=\"50%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=shiptoday\">{$row->Shipments}</a>" . "</td><td width=\"50%\">" . formatField(["format"=>"{0:n}"], $row->ShipTotals) . "</td></tr>";
				    ?>
				</tbody>
			    </table>
			</div>
			<div class="table-responsive">
			    <table class="table">
				<thead>
				    <tr>
					<th><?php echo $translation->translateLabel("New Purchases"); ?></th>
					<th><?php echo $translation->translateLabel("Purchase Totals"); ?></th>
				    </tr>
				</thead>
				<tbody>
				    <?php
				    foreach($companyDailyActivity["purchases"] as $row)
				    echo "<tr><td width=\"50%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=last24\">{$row->Purchases}</a>" . "</td><td width=\"50%\">" . formatField(["format"=>"{0:n}"], $row->PurchaseTotals) . "</td></tr>";
				    ?>
				</tbody>
			    </table>
			</div>
			<div class="table-responsive">
			    <table class="table">
				<thead>
				    <tr>
					<th><?php echo $translation->translateLabel("Receivings Today"); ?></th>
					<th><?php echo $translation->translateLabel("Receipt Totals"); ?></th>
				    </tr>
				</thead>
				<tbody>
				    <?php
				    foreach($companyDailyActivity["receivings"] as $row)
				    echo "<tr><td width=\"50%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=receivedtoday\">{$row->Receivings}</a>" . "</td><td width=\"50%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotals) . "</td></tr>";
				    ?>
				</tbody>
			    </table>
			</div>
		    </div>
		</div>
	    </div>

	    <?php
	    $topOrdersReceipts = $data->TopOrdersReceipts();
	    ?>
	    <div>
		<div class="white-box">
		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top 5 Open Orders & Receivings"); ?></h3>
		    <!--  <p class="text-muted">this is the sample data</p> -->
		    <div class="table-responsive">
			<table class="table">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Order Number"); ?></th>
				    <th><?php echo $translation->translateLabel("Customer"); ?></th>
				    <th><?php echo $translation->translateLabel("Ship Date"); ?></th>
				    <th><?php echo $translation->translateLabel("Amount"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($topOrdersReceipts["orders"] as $row)
				echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsReceivable/OrderScreens/ViewOrders", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->OrderNumber}") . "\">{$row->OrderNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("CustomerID", $row->CustomerID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->OrderShipDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotal) . "</td></tr>";
				?>
			    </tbody>
			</table>
		    </div>
		    <div class="table-responsive">
			<table class="table">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Receiving"); ?></th>
				    <th><?php echo $translation->translateLabel("Vendor"); ?></th>
				    <th><?php echo $translation->translateLabel("Arrival Date"); ?></th>
				    <th><?php echo $translation->translateLabel("Amount"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($topOrdersReceipts["purchases"] as $row)
				echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsPayable/PurchaseProcessing/ViewPurchases", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->PurchaseNumber}") . "\">{$row->PurchaseNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("VendorID", $row->VendorID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->PurchaseDueDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotal) . "</td></tr>";
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
		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Collections Alerts"); ?></h3>
		    <!-- <p class="text-muted">this is the sample data</p> -->
		    <div class="table-responsive">
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Customer ID"); ?></th>
				    <th><?php echo $translation->translateLabel("Overdue"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($collectionAlerts as $row)
				echo "<tr><td>" . $drill->getLinkByField("CustomerID", $row->CustomerID) . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Overdue) . "</td></tr>";
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
		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today Tasks"); ?></h3>
		    <!-- <p class="text-muted">this is the sample data</p> -->
		    <div class="table-responsive">
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Due Date"); ?></th>
				    <th><?php echo $translation->translateLabel("Task"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($todaysTasks as $row)
				echo "<tr><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . date("m/d/y", strtotime($row->DueDate)) . "</a></td><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . $row->Task . "</a></td></tr>";
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
		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Follow Up Today"); ?></h3>
		    <!-- <p class="text-muted">this is the sample data</p> -->
		    <div class="table-responsive">
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Lead ID"); ?></th>
				    <th><?php echo $translation->translateLabel("Email"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($leadFollowUp as $row){
				    $keyString = "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->LeadID}";
				    echo "<tr><td><a href=\"". $linksMaker->makeGridItemView("CRMHelpDesk/CRM/ViewLeads", $keyString)  . "\">" . $row->LeadID . "</a></td><td>" . $row->LeadEmail . "</td></tr>";
				}
				?>
			    </tbody>
			</table>
		    </div>
		</div>
	    </div>
	</div>
    </div>
</div>
