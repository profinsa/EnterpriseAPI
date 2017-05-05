<!-- 
Name of Page: financial gaap Trial Balance report page

Method: render report page

Date created: Nikita Zaharov, 02.05.2016

Use: this model used for 
- for loading data using stored procedures

Input parameters:
data - datasource

Output parameters:
- just render page

Called from:
controllers/financials

Calls:
datasource

Last Modified: 03.05.2016
Last Modified by: Nikita Zaharov
   -->

<div id="report" class="row">
    <?php
    $user = $data->getUser();
    $currencySymbol = $data->getCurrencySymbol()["symbol"];
    $tdata = $data->getData();
  //  echo json_encode($tdata);
    ?>
    <div class="col-md-offset-1 col-md-10 col-xs-12">
	<div class="col-md-12 col-xs-12" style="border-bottom: 1px solid black;">
	</div>
	<div class="col-md-12 col-xs-12"  style="margin-top:20px; font-size:12pt; font-weight:bold; text-align: center">
	    <?php echo  $user["company"]->CompanyName;?>
	</div>
	<div class="col-md-12 col-xs-12"  style="text-align: center">
	    <?php echo  ( $data->type == "Company" ? "All Divisions" : $user["company"]->DivisionID) . " / " . ( $data->type == "Division" || $data->type == "Company" ? "All Departments" : $user["company"]->DepartmentID);?>
	</div>
	<div class="col-md-12 col-xs-12"  style="margin-top:15px; font-size:12pt; font-weight:bold; text-align: center">
	    <?php echo  $data->title;?>
	</div>
	<div class="col-md-12 col-xs-12"  style="text-align: center">
	    For the Period Ending <?php echo  $tdata["PeriodEndDate"];?>
	</div>
	<div class="col-md-12 col-xs-12" style="margin-top: 20px; border-bottom: 2px solid black;">
	</div>
    </div>
    <div class="col-md-offset-1 col-md-10 col-xs-12">
	<?php
	function negativeStyle($value){
	    if($value < 0)
		return "color:red";
	    else
		return "";
	}
//	echo json_encode($tdata);
	?>
	<table class="col-md-12 col-xs-12 balance-sheet-table">
	    <tbody>
		<?php
		foreach($tdata["Debit"] as $row)
		    echo "<tr><td colspan=\"3\">" . $drill->getLinkByAccountNameAndBalance($row["GLAccountName"], $row["GLAccountBalanceOriginal"]) . "</td><td>" . $currencySymbol .$row["GLAccountBalance"] . "</td><td></td><td></td>" . ($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD" ? "<td></td><td>" . $currencySymbol .$row["GLAccountBalance" . $_GET["itype"]] . "</td><td></td><td></td>" : "") . "</tr>"; 
		foreach($tdata["Credit"] as $row)
		    echo "<tr><td colspan=\"3\">" . $drill->getLinkByAccountNameAndBalance($row["GLAccountName"], $row["GLAccountBalanceOriginal"]) . "</td><td></td><td></td><td>" . $currencySymbol . $row["GLAccountBalance"] . "</td>" . ($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD" ? "<td></td><td></td><td></td><td>" . $currencySymbol .$row["GLAccountBalance" . $_GET["itype"]] . "</td>" : "") . "</tr>"; 
		?>
		<tr><td colspan="3"></td><td style="border-top:1px solid black; border-bottom:3px double black;"><?php echo $currencySymbol . $tdata["DebitTotal"]; ?></td><td></td><td style="border-top:1px solid black; border-bottom:3px double black;"><?php echo $currencySymbol . $tdata["CreditTotal"]; ?></td><?php echo ($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD" ? "<td></td><td style=\"border-top:1px solid black; border-bottom:3px double black;\">" . $currencySymbol .$tdata["DebitTotal" . $_GET["itype"]] . "</td><td></td><td style=\"border-top:1px solid black; border-bottom:3px double black;\">" . $currencySymbol .$tdata["CreditTotal" . $_GET["itype"]] . "</td>" : ""); ?></tr>
	    </tbody>
	</table>
	<div class="col-md-12 col-xs-12" style="margin-top: 20px; border-bottom: 2px solid black;">
	</div>
    </div>
</div>
