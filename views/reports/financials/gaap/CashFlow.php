<!-- 
     Name of Page: financial gaap Direct Cash Flow report page

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

     Last Modified: 02.05.2016
     Last Modified by: Nikita Zaharov
   -->

<div id="report" class="row">
    <?php
    $user = $data->getUser();
    $currencySymbol = $data->getCurrencySymbol()["symbol"];
    $tdata = $data->getData();
    //    echo json_encode($tdata);
    ?>
    <div class="col-md-12 col-xs-12">
	<div class="col-md-12 col-xs-12" style="border-bottom: 1px solid black;">
	</div>
	<div class="col-md-12 col-xs-12"  style="margin-top:20px; font-size:12pt; font-weight:bold; text-align: center">
	    <?php echo  $user["company"]->CompanyName; ?>
	</div>
	<div class="col-md-12 col-xs-12"  style="text-align: center">
	    <?php echo  ( $data->type == "Company" ? "All Divisions" : $user["company"]->DivisionID) . " / " . ( $data->type == "Division" || $data->type == "Company" ? "All Departments" : $user["company"]->DepartmentID); ?>
	</div>
	<div class="col-md-12 col-xs-12"  style="margin-top:15px; font-size:12pt; font-weight:bold; text-align: center">
	    <?php echo  $data->title; ?>
	</div>
	<div class="col-md-12 col-xs-12"  style="text-align: center">
	    For the Period Ending <?php echo  $tdata["PeriodEndDate"]; ?>
	</div>
	<div class="col-md-12 col-xs-12" style="margin-top: 20px; border-bottom: 2px solid black;">
	</div>
    </div>
    <div class="col-md-12 col-xs-12">
	<?php
	function negativeStyle($value){
	    if($value < 0)
		return "color:red";
	    else
		return "";
	}
	?>
	<table class="col-md-12 col-xs-12 balance-sheet-table">
	    <tbody>
		<?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
		    <tr><td></td><td></td><td></td><td>Debits</td><td>Credits</td><td>Increase/Decrease in Cash</td><td>Debits</td><td>Credits</td><td>Increase/Decrease in Cash</td></tr>
		<?php else: ?>
		    <tr><td></td><td></td><td></td><td>Debits</td><td>Credits</td><td>Increase/Decrease in Cash</td></tr>
		<?php endif; ?>
		<tr><td colspan="6">Net Cash Flow from Operating Activities:</td></tr>
		<?php
		foreach($tdata["Operating"] as $row){
		    echo "<tr>";
		    //		    if($_GET["itype"] != "Comparative")
		    echo"<td style=\"width:20px\"></td>";
		    echo "<td style=\"width:200px;\">" . $row["FlowTitle"] . "</td><td></td>";
		    if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD")
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . (key_exists("debit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["debit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["debit" . $_GET["itype"]] . "</td>" : "<td></td>" ) . (key_exists("credit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["credit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["credit" . $_GET["itype"]] . "</td>" :  "<td></td>") . "<td></td>";
		    else
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . "<td></td>";
		    echo "</tr>";
		}
		?>
		<tr class="gaap-table-row-spacer"></tr>
 		<tr>
		    <td></td><td></td>
		    <td><span style="margin-left:200px">Total:</span></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingCreditsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingDebitsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["OperatingDebitsTotal" . $_GET["itype"]]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingCreditsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["OperatingCreditsTotal" . $_GET["itype"]]; ?></td>
			<td></td>
		    <?php else: ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["OperatingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingCreditsTotal"]; ?></td>
			<td></td>
		    <?php endif; ?>
		</tr>
		<tr class="gaap-table-row-spacer"></tr>
		<tr><td colspan="2">Net Cash provided by Operating Activities:</td>		
		    <?php if($_GET["itype"] == "Comparative" ||$_GET["itype"] == "Comparative"): ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["OperatingTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingTotal"]; ?></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["OperatingTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["OperatingTotal" . $_GET["itype"]]; ?></td>
		    <?php else: ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["OperatingTotal"]); ?>"><?php echo $currencySymbol . $tdata["OperatingTotal"]; ?></td>
		    <?php endif; ?>
		</tr>

		<tr class="gaap-table-row-spacer"></tr>
		<tr class="gaap-table-row-spacer"></tr>
		
	    	<tr><td colspan="6">Net Cash Flow from Investing Activities:</td></tr>
		<?php
		foreach($tdata["Investing"] as $row){
		    echo "<tr>";
		    //		    if($_GET["itype"] != "Comparative")
		    echo"<td style=\"width:20px\"></td>";
		    echo "<td style=\"width:200px;\">" . $row["FlowTitle"] . "</td><td></td>";
		    if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD")
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . (key_exists("debit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["debit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["debit" . $_GET["itype"]] . "</td>" : "<td></td>" ) . (key_exists("credit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["credit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["credit" . $_GET["itype"]] . "</td>" :  "<td></td>") . "<td></td>";
		    else
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . "<td></td>";
		    echo "</tr>";
		}
		?>
		<tr class="gaap-table-row-spacer"></tr>
 		<tr>
		    <td></td><td></td>
		    <td><span style="margin-left:200px">Total:</span></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingCreditsTotal"]; ?></td>
			<td></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingDebitsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["InvestingDebitsTotal" . $_GET["itype"]]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingCreditsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["InvestingCreditsTotal" . $_GET["itype"]]; ?></td>
			<td></td>
		    <?php else: ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["InvestingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingCreditsTotal"]; ?></td>
			<td></td>
		    <?php endif; ?>
		</tr>
		<tr class="gaap-table-row-spacer"></tr>
		<tr><td colspan="2">Net Cash provided by Investing Activities(Equity):</td>		
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["InvestingTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingTotal"]; ?></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["InvestingTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["InvestingTotal" . $_GET["itype"]]; ?></td>
		    <?php else: ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["InvestingTotal"]); ?>"><?php echo $currencySymbol . $tdata["InvestingTotal"]; ?></td>
		    <?php endif; ?>
		</tr>

	    	<tr class="gaap-table-row-spacer"></tr>
		<tr class="gaap-table-row-spacer"></tr>
		
	    	<tr><td colspan="6">Net Cash Flow from Financing Activities:</td></tr>
		<?php
		foreach($tdata["Financing"] as $row){
		    echo "<tr>";
		    //		    if($_GET["itype"] != "Comparative")
		    echo"<td style=\"width:20px\"></td>";
		    echo "<td style=\"width:200px;\">" . $row["FlowTitle"] . "</td><td></td>";
		    if($_GET["itype"] == "Comparative" || $_GET["itype"] == "Comparative")
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . (key_exists("debit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["debit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["debit" . $_GET["itype"]] . "</td>" : "<td></td>" ) . (key_exists("credit" . $_GET["itype"], $row) ? "<td style=\"" . negativeStyle($row["credit" . $_GET["itype"]]) . "\">" . $currencySymbol . $row["credit" . $_GET["itype"]] . "</td>" :  "<td></td>") . "<td></td>";
		    else
			echo (key_exists("debit", $row) ? "<td style=\"" . negativeStyle($row["debit"]) . "\">" . $currencySymbol . $row["debit"] . "</td>" : "<td></td>" ) . (key_exists("credit", $row) ? "<td style=\"" . negativeStyle($row["credit"]) . "\">" . $currencySymbol . $row["credit"] . "</td>" :  "<td></td>") . "<td></td>";
		    echo "</tr>";
		}
		?>
		<tr class="gaap-table-row-spacer"></tr>
 		<tr>
		    <td></td><td></td>
		    <td><span style="margin-left:200px">Total:</span></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingCreditsTotal"]; ?></td>
			<td></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingDebitsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["FinancingDebitsTotal" . $_GET["itype"]]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingCreditsTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["FinancingCreditsTotal" . $_GET["itype"]]; ?></td>
			<td></td>
		    <?php else: ?>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingDebitsTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingDebitsTotal"]; ?></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["FinancingCreditsTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingCreditsTotal"]; ?></td>
			<td></td>
		    <?php endif; ?>
		</tr>
		<tr class="gaap-table-row-spacer"></tr>
		<tr><td colspan="2">Net Cash provided by Financing Activities:</td>		
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["FinancingTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingTotal"]; ?></td>

			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["FinancingTotal" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["FinancingTotal" . $_GET["itype"]]; ?></td>
		    <?php else: ?>
			<td></td>
			<td></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["FinancingTotal"]); ?>"><?php echo $currencySymbol . $tdata["FinancingTotal"]; ?></td>
		    <?php endif; ?>
		</tr>
		
		<tr class="gaap-table-row-spacer"></tr>
		<tr class="gaap-table-row-spacer"></tr>
		<tr><td colspan="2">Cash at the Beginning of the year</td>		
		    <td></td>
		    <td></td>
		    <td></td>
		    <td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["BeginningYearBalance"]); ?>"><?php echo $currencySymbol . $tdata["BeginningYearBalance"]; ?></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td></td>
			<td></td>
			<td style="border-bottom:1px solid black; <?php echo negativeStyle($tdata["BeginningYearBalance" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["BeginningYearBalance" . $_GET["itype"]]; ?></td>
		    <?php endif; ?>
		</tr>
		<tr><td colspan="2">Net Increase / Decrease in Cash</td>		
		    <td></td>
		    <td></td>
		    <td></td>
		    <td style="<?php echo negativeStyle($tdata["TotalYearBalance"]); ?>"><?php echo $currencySymbol . $tdata["TotalYearBalance"]; ?></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td></td>
			<td></td>
			<td style="<?php echo negativeStyle($tdata["TotalYearBalance" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["TotalYearBalance" . $_GET["itype"]]; ?></td>
		    <?php endif; ?>
		</tr>
		<tr class="gaap-table-row-spacer"></tr>
		<tr><td colspan="2">Cash at the End of the Year</td>		
		    <td></td>
		    <td></td>
		    <td></td>
		    <td style="<?php echo negativeStyle($tdata["EndYearBalance"]); ?>"><?php echo $currencySymbol . $tdata["EndYearBalance"]; ?></td>
		    <?php if($_GET["itype"] == "Comparative" || $_GET["itype"] == "YTD"): ?>
			<td></td>
			<td></td>
			<td style="<?php echo negativeStyle($tdata["EndYearBalance" . $_GET["itype"]]); ?>"><?php echo $currencySymbol . $tdata["EndYearBalance" . $_GET["itype"]]; ?></td>
		    <?php endif; ?>
		</tr>
	    </tbody>
	</table>
    </div>
</div>
