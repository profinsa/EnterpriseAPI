<?php
    $headerData = $data->getHeaderData();
    $detailData = $data->getDetailData();
    $user = $data->getUser();
    //echo json_encode($headerData);
    //echo "<br/><br/>";
    //echo json_encode($detailData);
    //return;
    //echo json_encode($user);
    $numberTitlesByType = [
	"payment" => "Payment"
    ];
    $titlesByType = [
	"payment" => "Payment Detail",
    ];
    $fieldsByType = [
	"payment" => [
	    "InvoiceDate" => "PaymentDate",
	    "InvoiceNumber" => "PaymentID",
	    
	    "CustomerName" => "VendorName",
	    "CustomerAddress1" => "VendorAddress1",
	    "CustomerAddress2" => "VendorAddress2",
	    "CustomerAddress3" => "VendorAddress3",
	    "CustomerCity" => "VendorCity",
	    "CustomerState" => "VendorState",
	    "CustomerZip" => "VendorZip",
	    "CustomerCountry" => "VendorCountry",
	    "CustomerEmail" => "VendorEmail",
	    "CustomerPhone" => "VendorPhone"
	]
    ];
?>
<div id="report" class="row">
    <div class="col-md-12" style="border: 1px solid black; padding:0px">
	<div class="row">
	    <div class="col-md-9 col-xs-9">
		<table class="col-md-12 col-xs-12">
		    <tr>
			<td rowspan="3" style="width:10%">
			    <img src="<?php echo  $user["company"]["CompanyLogoUrl"];?>">
			</td>
			<td style="width:90%; font-size:16pt; font-weight:bold;">
			    <?php echo  $user["company"]["CompanyName"];?>
			</td>
		    </tr>
		    <tr>
			<td style="width:90%">
			    <?php echo  $user["company"]["CompanyAddress1"] . ", " . $user["company"]["CompanyCity"] . ", " . $user["company"]["CompanyState"] . ", " . $user["company"]["CompanyZip"];?>
			</td>
		    </tr>
		    <tr>
			<td style="width:90%">
			    <?php echo  $user["company"]["CompanyPhone"] . ", " . $user["company"]["CompanyEmail"] . ", <span>" . $user["company"]["CompanyWebAddress"];?></span>
			</td>
		    </tr>
		</table>
	    </div>
	    <div class="col-md-3 col-xs-3 pull-right">
		<div class="col-md-12">
		    <div style="font-size:20pt; text-align:center;">
			<b><?php echo $titlesByType[$type]; ?></b>
		    </div>
		</div>
		<div class="col-md-6 col-xs-6" style="text-align:center">
		    <div><b>Date</b></div>
		    <div><?php echo  (key_exists($type, $fieldsByType) ? $headerData[$fieldsByType[$type]["InvoiceDate"]] : $headerData["InvoiceDate"]);?></div>
		</div>
		<div class="col-md-6 col-xs-6" style="text-align:center">
		    <div><b><?php echo (key_exists($type, $numberTitlesByType) ? $numberTitlesByType[$type] : $titlesByType[$type]); ?> #</b></div>
		    <div><?php echo  (key_exists($type, $fieldsByType) ? $headerData[$fieldsByType[$type]["InvoiceNumber"]] : $headerData["InvoiceNumber"]);?></div>
		</div>
	    </div>
	</div>
	<div class="col-md-12 col-xs-12" style="border:1px solid black;">
	</div>
	<div class="col-md-12 col-xs-12" style=margin-top:5px;">
	    <?php /*<div class="col-md-6 col-xs-6">
		     <div><b>Ship To</b></div>
		     <div><?php echo  $headerData["ShippingName"];?></div>
		     <div><?php echo  $headerData["ShippingAddress1"];?></div>		    
		     <div><?php echo  $headerData["ShippingAddress2"];?></div>		    
		     <div><?php echo  $headerData["ShippingAddress3"];?></div>		    
		     <div><?php echo  $headerData["ShippingCity"] . "  " . $headerData["ShippingState"] . "  " . $headerData["ShippingZip"] . "  " . $headerData["ShippingCountry"];?></div>		    
		     </div> */
	    ?>
	    <div class="col-md-6 col-xs-6">
	    </div>
	    <div class="col-md-6 col-xs-6">
		<div><b>Remitt To</b></div>
		<div><?php echo   $headerData["VendorName"];?></div>
		<div><?php echo  $headerData["VendorAddress1"];?></div>
		<div><?php echo  $headerData["VendorAddress2"];?></div>
		<div><?php echo  $headerData["VendorAddress3"];?></div>
		<div>
		    <?php echo  $headerData["VendorCity"] . "  " 
			     . $headerData["VendorState"] . ", "
			     . $headerData["VendorZip"] . "  " 
			     . $headerData["VendorCountry"];
		    ?>
		</div>   
		<div><?php echo $headerData["VendorEmail"];?></div>
		<div><?php echo $headerData["VendorPhone"];?></div>
	    </div>
	</div>
	<table class="col-md-12 col-xs-12 invoice-table-ship">
	    <tbody>
		<tr class="row-header">
		    <td>
			Payment Type
		    </td>
		    <td>
			Payment #
		    </td>
		    <td>
			Check Number
		    </td>
		    <td>
			Check Date
		    </td>
		    <td>
			Payment Date
		    </td>
		    <td>
			GL Bank Account
		    </td>
		    <td>
			Amount
		    </td>
		    <td>
			UnApplied Amount
		    </td>
		    <td>
			Credit Amount
		    </td>
		</tr>
		<tr>
		    <td>
			<?php echo  $headerData["PaymentTypeID"];?>
		    </td>
		    <td>
			<?php echo  $headerData["PaymentID"];?>
		    </td>
		    <td>
			<?php echo  $headerData["CheckNumber"];?>
		    </td>		
		    <td>
			<?php echo  $headerData["CheckDate"];?>
		    </td>		
		    <td>
			<?php echo  $headerData["PaymentDate"];?>
		    </td>		
		    <td>
			<?php echo  $headerData["GLBankAccount"];?>
		    </td>		
		    <td>
			<?php echo  $data->getCurrencySymbol()["symbol"] . $headerData["Amount"];?>
		    </td>		
		    <td>
			<?php echo  $data->getCurrencySymbol()["symbol"] . $headerData["UnAppliedAmount"];?>
		    </td>		
		    <td>
			<?php echo  $data->getCurrencySymbol()["symbol"] .$headerData["CreditAmount"];?>
		    </td>		 
		</tr>
	    </tbody>
	</table>
    </div>
    <div class="col-md-12 col-xs-12 invoice-table-detail" style="margin-top:20px; border:1px solid black;  height:300px; padding:0px">
	<table class="col-md-12 col-xs-12">
	    <thead>
		<tr class="row-header">
		    <th style="width:140px">
			Payment Detail ID
		    </th>
		    <th style="width: 140px">
			Sub Vendor ID
		    </th>
		    <th>
			Document Number
		    </th>
		    <th style="width:140px">
			Applied Amount
		    </th>
		    <th style="width:140px">
			Discount Taken
		    </th>
		</tr>
	    </thead>
	    <tbody>
		<?php if($detailData): ?>
		    <?php 
			foreach($detailData as $row){
			    echo "<tr style=\"height:10px;\">";
			    echo "<td>" . $row["PaymentDetailID"] . "</td>";
			    echo "<td>" . $row["PayedID"] . "</td>";
			    echo "<td>" . $row["DocumentNumber"] . "</td>";
			    echo "<td>" . $data->getCurrencySymbol()["symbol"] . $row["AppliedAmount"] . "</td>";
			    echo "<td>" . $data->getCurrencySymbol()["symbol"] . $row["DiscountTaken"] . "</td>";
			    echo "</tr>";
			}
		    ?>
		<?php else: ?>
		    <tr style="height:10px;">
			<td colspan="5" style="text-align:center;">
			    There is no records available.
			</td>
		    </tr>
		<?php endif; ?>
	    </tbody>
	</table>
    </div>
</div>
<!-- <script>
     function printPDF(){
     var doc = new jsPDF();          
     var elementHandler = {
     '#ignorePDF': function (element, renderer) {
     return true;
     }
     };
     var source =  window.document.getElementsByTagName("body")[0];
     doc.fromHTML(
     source,
     0,
     0,
     {
     'elementHandlers': elementHandler
     });
     doc.output("dataurlnewwindow"); 
     console.log(doc);
     }
     </script>
     <button onclick="printPDF()">
     PDF
     </button>
-->
