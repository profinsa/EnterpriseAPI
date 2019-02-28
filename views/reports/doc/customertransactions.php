<?php
$user = $data->getUser();
$orders = $data->getOrders();
$invoices = $data->getInvoices();
?>
<div id="report" class="row">
    <div class="col-md-12 col-xs-12 invoice-table-detail" style="margin-top:20px; padding:0px">
	<div class="col-md-9 col-xs-9">
	    <table class="col-md-12 col-xs-12">
		<tr>
		    <td rowspan="3" style="width:10%">
			<img src="<?php echo  $user["company"]["CompanyLogoUrl"];?>">
		    </td>
		    <td style="width:60%; font-size:16pt; font-weight:bold;">
			<?php echo  $user["company"]["CompanyName"];?>
		    </td>
		</tr>
		<tr>
		    <td style="width:60%">
			<?php echo  $user["company"]["DivisionID"] . " / " . $user["company"]["DepartmentID"];?>
		    </td>
		</tr>
		<tr>
		    <td style="width:60%">
			Executed By Demo on <?php echo date('m/d/Y'); ?>
		    </td>
		</tr>
	    </table>
	</div>
	<h1 class="col-md-12 col-xs-12" style="font-family: Arial; color:black">
	    Customer Transactions
	</h1>
	<h2 class="col-md-12 col-xs-12" style="font-family: Arial; color:black">
	    Orders
	</h2>
	<table class="col-md-12 col-xs-12">
	    <thead>
		<tr class="row-header">
		    <th>
			Date
		    </th>
		    <th>
			Order No
		    </th>
		    <th>
			Type
		    </th>
		    <th>
			Order Total
		    </th>
		    <th>
			Ship Date
		    </th>
		    <th>
			Tracking Number
		    </th>
		    <th>
			Invoiced
		    </th>
		    <th>
			Invoice Number
		    </th>
		</tr>
	    </thead>
	    <tbody>
		<?php if(count($orders)): ?>
		    <?php 
		    foreach($orders as $row){
			echo "<tr style=\"height:10px;\">";
			echo "<td><a href=\"index.php?page=docreports&type=order&id=" . $row["OrderNumber"]  . "\" target=\"_Blank\">" . $row["OrderDate"] . "</a></td>";
			echo "<td>" . $row["OrderNumber"] . "</td>";
			echo "<td>" . $row["TransactionTypeID"] . "</td>";
			echo "<td>" . $data->getCurrencySymbol()["symbol"] . $row["Total"] . "</td>";
			echo "<td>" . $row["ShipDate"] . "</td>";
			echo "<td>" . $row["TrackingNumber"] . "</td>";
			echo "<td>" . $row["Invoiced"] . "</td>";
			echo "<td>" . $row["InvoiceNumber"] . "</td>";
			echo "</tr>";
		    }
		    ?>
		<?php else: ?>
		    <tr style="height:10px;">
			<td colspan="8" style="text-align:center;">
			    There is no records available.
			</td>
		    </tr>
		<?php endif; ?>
	    </tbody>
	</table>
	<h2 class="col-md-12 col-xs-12" style="font-family: Arial; color:black">
	    Invoices
	</h2>
	<table class="col-md-12 col-xs-12">
	    <thead>
		<tr class="row-header">
		    <th style="width:80px">
			Date
		    </th>
		    <th style="width:80px">
			Order No
		    </th>
		    <th style="width:200px">
			Type
		    </th>
		    <th style="width:200px">
			Order Total
		    </th>
		    <th style="width:200px">
			Ship Date
		    </th>
		    <th style="width:100px">
			Tracking Number
		    </th>
		</tr>
	    </thead>
	    <tbody>
		<?php if(count($invoices)): ?>
		    <?php 
		    foreach($invoices as $row){
			echo "<tr style=\"height:10px;\">";
			echo "<td><a href=\"index.php?page=docreports&type=invoice&id=" . $row["InvoiceNumber"]  . "\" target=\"_Blank\">" . $row["InvoiceDate"] . "</a></td>";
			echo "<td>" . $row["InvoiceNumber"] . "</td>";
			echo "<td>" . $row["TransactionTypeID"] . "</td>";
			echo "<td>" . $data->getCurrencySymbol()["symbol"] . $row["Total"] . "</td>";
			echo "<td>" . $row["ShipDate"] . "</td>";
			echo "<td>" . $row["TrackingNumber"] . "</td>";
			echo "</tr>";
			echo "</tr>";
		    }
		    ?>
		<?php else: ?>
		    <tr style="height:10px;">
			<td colspan="6" style="text-align:center;">
			    There is no records available.
			</td>
		    </tr>
		<?php endif; ?>
	    </tbody>
	</table>
    </div>
</div> 
