<!-- 
     Name of Page: financials gaap Balance Sheet report page

     Method: render report page

     Date created: Nikita Zaharov, 27.04.2017

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

     Last Modified: 18.08.2019
     Last Modified by: Nikita Zaharov
   -->
<div id="report" class="row">
    <?php
	$user = $data->getUser();
	$currencySymbol = $data->getCurrencySymbol()["symbol"];
	$tdata = $data->getData();
	//echo json_encode($tdata);
	$typesToProc = [
		"Standard" => "",
		"Company" => "Company",
		"Division" => "Division",
		"Period" => "Period",
		"DivisionPeriod" => "PeriodDivision",
		"CompanyPeriod" => "PeriodCompany"
	];

	$params = '';

	if(preg_match('/Period/', $_GET["vtype"], $numberParts))
		$params .= "'" . $_GET["year"] . "', '" . $_GET["period"] . "', ";

	$proc = "CALL RptGLBalanceSheet" . $typesToProc[$_GET["vtype"]] . ( $_GET["itype"] == "Standard" ? "" : $_GET["itype"]) . "Drills('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', " . $params . "@PeriodEndDate, @ret)";
    ?>
    <div class="col-md-12 col-xs-12">
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
    <div class="col-md-12 col-xs-12">
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
		<tr><td colspan="6">ASSET</td></tr>
		<?php
		foreach($tdata["Asset"] as $row){
		    echo "<tr>";
		    //		    if($_GET["itype"] != "Comparative")
		    echo"<td style=\"width:100px\"></td>";
		    echo "<td>" . ($data->type == "Company" ? $row["DivisionID"] . "&nbsp - &nbsp" : "") . ($data->type == "Division" || $data->type == "Company" ? $row["DepartmentID"] . "&nbsp - &nbsp" : "") . $drill->getLinkByAccountNameAndBalanceForTrial($row["GLAccountName"], $row["GLAccountBalanceOriginal"], $proc) . "</td>";
		    if($_GET["itype"] == "Comparative")
			echo "<td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td><td>" .  $row["GLAccountBalanceComparative"] ."</td>";
		    else
			echo "<td></td><td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td>";
		    echo "<td></td></tr>";
		}
		?>
 		<tr>
		    <td></td>
		    <td><span style="margin-left:200px">Total Assets</span></td>
		    <?php if($_GET["itype"] == "Comparative"): ?>
			<td style="border-top:1px solid black"></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["AssetTotal"]); ?>"><?php echo $currencySymbol . $tdata["AssetTotal"]; ?></td>
			<td style="border-top:1px solid black"></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["AssetTotalComparative"]); ?>"><?php echo $currencySymbol . $tdata["AssetTotalComparative"]; ?></td>
		    <?php else: ?>
			<td></td>
			<td style="border-top:1px solid black"></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["AssetTotal"]); ?>"><?php echo $currencySymbol . $tdata["AssetTotal"]; ?></td>
		    <?php endif ?>
		</tr>

		<tr>
		    <td colspan="6"  style="padding-top:20px;">LIABILITIES</td>
		</tr>
		<?php
		foreach($tdata["Liability"] as $row){
		    echo "<tr><td style=\"width:100px\"></td><td>" . ($data->type == "Company" ? $row["DivisionID"] . "&nbsp - &nbsp" : "") . ($data->type == "Division" || $data->type == "Company" ? $row["DepartmentID"] . "&nbsp - &nbsp" : "") . $drill->getLinkByAccountNameAndBalanceForTrial($row["GLAccountName"], $row["GLAccountBalanceOriginal"], $proc) . "</td>";
		    if($_GET["itype"] == "Comparative")
			echo "<td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td><td>" .  $row["GLAccountBalanceComparative"] ."</td>";
		    else
			echo "<td></td><td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td>";
		    echo "<td></td></tr>";
		}
		?>
		<tr>
		    <td></td>
		    <td><span style="margin-left:200px">Total Liabilities</span></td>
		    <?php if($_GET["itype"] == "Comparative"): ?>
			<td style="border-top:1px solid black"></td>
			<td style="<?php echo negativeStyle($tdata["LiabilityTotal"]); ?>"><?php echo $currencySymbol . $tdata["LiabilityTotal"]; ?></td>
			<td style="border-top:1px solid black"></td>
			<td style="<?php echo negativeStyle($tdata["LiabilityTotalComparative"]); ?>"><?php echo $currencySymbol . $tdata["LiabilityTotalComparative"]; ?></td>
		    <?php else: ?>
			<td></td>
			<td style="border-top:1px solid black"></td>
			<td></td>
			<td style="<?php echo negativeStyle($tdata["LiabilityTotal"]); ?>"><?php echo $currencySymbol . $tdata["LiabilityTotal"]; ?></td>
		    <?php endif ?>
		</tr>

	    	<tr>
		    <td colspan="6"  style="padding-top:20px;">EQUITY</td>
		</tr>
		<?php
		    foreach($tdata["Equity"] as $row){
			echo "<tr><td style=\"width:100px\"></td><td>" . ($data->type == "Company" && key_exists("DivisionID", $row) ? $row["DivisionID"] . "&nbsp - &nbsp" : "") . (($data->type == "Division" || $data->type == "Company")  && key_exists("DepartmentID", $row) ? $row["DepartmentID"] . "&nbsp - &nbsp" : "") . (key_exists("GLAccountBalanceOriginal", $row) ? $drill->getLinkByAccountNameAndBalanceForTrial($row["GLAccountName"], $row["GLAccountBalanceOriginal"], $proc) : "") . "</td>";
			if($_GET["itype"] == "Comparative")
			    echo "<td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td><td>" .  $row["GLAccountBalanceComparative"] ."</td>";
			else
			    echo "<td></td><td style=\"" . negativeStyle($row["GLAccountBalance"]) . "\">" . $currencySymbol . $row["GLAccountBalance"] . "</td><td></td>";
			echo "<td></td></tr>";
		    }
		?>
		<tr>
		    <td></td>
		    <td><span style="margin-left:200px">Total Equity</span></td>
		    <?php if($_GET["itype"] == "Comparative"): ?>
			<td style="border-top:1px solid black" ></td>
			<td style="<?php echo negativeStyle($tdata["EquityTotal"]); ?>"><?php echo $currencySymbol . $tdata["EquityTotal"]; ?></td>
			<td style="border-top:1px solid black"></td>
			<td style="<?php echo negativeStyle($tdata["EquityTotalComparative"]); ?>"><?php echo $currencySymbol . $tdata["EquityTotalComparative"]; ?></td>
		    <?php else: ?>
			<td></td>
			<td style="border-top:1px solid black"></td>
			<td></td>
			<td style="<?php echo negativeStyle($tdata["EquityTotal"]); ?>"><?php echo $currencySymbol . $tdata["EquityTotal"]; ?></td>
		    <?php endif ?>
		</tr>
	    	<tr>
		    <?php if($_GET["itype"] == "Comparative"): ?>
			<td colspan="3"  style="padding-top:20px;">TOTAL LIABILITIES & EQUITY</td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["LiabilityEquityTotal"]); ?>"><?php echo $currencySymbol . $tdata["LiabilityEquityTotal"]; ?></td>
			<td></td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["LiabilityEquityTotalComparative"]); ?>"><?php echo $currencySymbol . $tdata["EquityTotalComparative"]; ?></td>
		    <?php else: ?>
			<td colspan="5"  style="padding-top:20px;">TOTAL LIABILITIES & EQUITY</td>
			<td style="border-bottom:3px double black; <?php echo negativeStyle($tdata["LiabilityEquityTotal"]); ?>"><?php echo $currencySymbol . $tdata["LiabilityEquityTotal"]; ?>
		    <?php endif ?>
		</tr>
	    </tbody>
	</table>
    </div>
</div>
