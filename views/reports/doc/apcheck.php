<?php
    $headerData = $data->getHeaderData();
?>
<?php if($headerData == false):?>
    <b>There is no valid checks to print. Only payments having check numbers and valid bank accounts can be printed.</b><?php else: ?>
    <?php
	$detailData = $data->getDetailData();
	$user = $data->getUser();
	if($headerData["BankAccountNumber"] != '110000'){
	    $bank = $data->getBankAccount($headerData["BankAccountNumber"]);
	    //	    $balance = $data->getBankBalance($headerData["BankAccountNumber"]);
	    $balance = '0.00';
	}else{
	    $bank = '110000';
	    $balance = '0.00';
	}
//	echo json_encode($headerData);
	$vendor = $data->getVendorAddress($headerData["VendorName"]);	
    ?>
    <div id="report" class="row">
	<div class="col-md-12" style="padding:0px">
	    <!-- <div class="row">
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

		 </div> -->
	    <div class="row">
		<div class="col-md-8">
		    <div class="col-md-6 form-inline">
			<div >
			    <label for="Bank Account">
				Bank Account
			    </label>
			    <span>
				<?php
				    echo ($bank != '110000' ? $bank->BankName : $bank);
				?>
				<span/>
			</div>
		    </div>
		    
		    <!--         <div class="col-md-6 form-inline" style="text-align: right">
			 <div>
			 <label for="Ending Balance">
			 Ending Balance
			 </label>
			 <?php
			     echo $balance;
			     ?>
			 </div>
			 </div> -->
		</div>
	    </div>
	    <div class="row" style="position: relative">
		<div class="col-md-8" style="position: relative; margin-left:20px; margin-top: 10px; border: solid black;">
		    <div style="position: relative">
			<div class="row" style="position: relative; margin-top: 120px">
			    <div class="col-md-6 form-inline" style="position: absolute; left: 0; bottom: 0">
				<div >
				    <label for="Pay to the Order of">
					Pay to the Order of
				    </label>
				    <?php
					echo $headerData["VendorName"];
				    ?>
				</div>
			    </div>
			    <div class="col-md-6 form-inline" style="position: absolute; right: 0; bottom: 0">
				<?php foreach($data->headTableOne as $key=>$value): ?>
				    <div class="row" style="margin-top: 10px">
					<div class="col-md-4">
					    <label for="<?php echo $key; ?>">
						<?php echo $key; ?>
					    </label>
					</div>
					<div class="col-md-2 style-5">
					    <?php echo $headerData[$value]; ?>
					</div>
				    </div>
				<?php endforeach; ?>
			    </div>
			</div>
		    </div>
		    <div class="row" style="margin-top: 50px">
			<div class="col-md-9" style="margin-left: 15px;">
			    <span id="towords"></span>
			</div>
			<div class="col-md-9" style="margin-left: 15px; height: 15px; border-bottom: solid black;">
			</div>
			<div class="col-md-2">
			    <b><?php echo strtoupper($headerData["MajorUnits"]); ?></b>
			</div>
		    </div>
		    <div class="row" style="margin-top: 20px">
			<div class="col-md-5">
			    <div  style="padding: 5px;">
				<div>
				    <table>
					<tbody>
					    <?php 
						foreach($data->vendorAddress as $key =>$value) {
						    echo '<tr>';
						    echo '<td class="title" style="width: 150px;margin: 7px"><b>' . $key . '</b></td>';
						    echo '<td style="width: 250px;margin: 7px"><span  style="margin: 7px" id="' . $vendor->$value . '">'  . $vendor->$value . '</span></td>';
						    echo '</tr>';
						}
					    ?>
					</tbody>
				    </table>
				</div>
			    </div>
			</div>
		    </div>
		    <!-- 		<div class="row" style="margin-top:30px;margin-bottom:10px;">
			 <div class="col-md-12 form-inline" style="width: 100%">
			 <div class="col-md-12 form-group"  style="width: 100%">
			 <label class="col-md-1" for="Notes">
			 Memo
			 </label>
			 <?php
			     //				echo $headerData->Notes;
                             ?>
			 </div>
			 </div>
			 </div> -->
		</div>
	    </div>
	    <?php /* 
		     <table border="0" cellpadding="0" cellspacing="0" width="759" background="/EnterpriseASP/Images/checkbackground.gif">
		     <tr>
		     <td width="25"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="520" colspan="3" valign="bottom" align="left"><b><font face="Arial" size="3"><br>
		     <!-- <%# DataBinder.Eval(Container, "DataItem.CompanyName")%> --></font></b></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right" valign="bottom">
		     <p align="right"><b><font face="Arial" size="3"><!-- <%# GetCheckNumber(Container)%> --></font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="520" colspan="3"><font face="Arial" size="2"><b><?php echo  $user["company"]["CompanyPhone"];?><!-- <%# DataBinder.Eval(Container, "DataItem.CompanyPhone")%> --></b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="520" colspan="3"><font face="Arial" size="2"><b><?php echo  $user["company"]["CompanyAddress1"];?> <?php echo  $user["company"]["CompanyState"];?> <?php echo  $user["company"]["CompanyCountry"];?><!-- <%# DataBinder.Eval(Container, "DataItem.CompanyAddress1")%> <%# DataBinder.Eval(Container, "DataItem.CompanyState")%> <%# DataBinder.Eval(Container, "DataItem.CompanyCountry")%> --></b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right">
		     <p align="right"><b><font face="Arial" size="3"><!-- <%# FormatDate(DataBinder.Eval(Container, "DataItem.CheckDate")) %> --></font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25" valign="bottom"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123" valign="bottom"><b><font face="Arial" size="3">Pay to <br>
		     the Order of:</font></b></td>
		     <td width="1" valign="bottom"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396" valign="bottom"><font face="Arial" size="2"><b>&nbsp;<?php echo $headerData->VendorID; ?>
		     <!-- <%# DataBinder.Eval(Container, "DataItem.VendorName")%> --></b></font></td>
		     <td width="5" valign="bottom"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right" valign="bottom">
		     <p align="right"><b><font face="Arial" size="3">$ <?php echo $headerData->Amount ?><!-- <%#CurrencySymbol & DataBinder.Eval(Container, "DataItem.CheckAmount", "{0:c}").Replace(_config.SystemCurrency, "")%> --></font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="507" colspan="3"><font face="Arial" size="2"><b class="towords">&nbsp;
		     <!-- <%# convert_number( DataBinder.Eval(Container, "DataItem.CheckAmount"), DataBinder.Eval(Container, "DataItem.MajorUnits"), DataBinder.Eval(Container, "DataItem.MinorUnits") )%> -->
		     </b></font></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><b><font face="Arial" size="2"><!-- <%# DataBinder.Eval(Container, "DataItem.BankName")%> --><br>
		     </font><font face="Arial" size="1">ACH R/T &nbsp;<!-- <%# DataBinder.Eval(Container, "DataItem.RoutingCode")%> --></font></b></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="2"><b>&nbsp;</b></font></td>
		     <td width="520" colspan="3"><font face="Arial" size="2"><b>For Account:&nbsp;			    <?php
		     echo ($bank != '110000' ? $bank->BankName : $bank);
		     ?>
		     <!-- <%# DataBinder.Eval(Container, "DataItem.AccountNumber")%> --></b></font></td>
		     <td width="5"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="396"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="5"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     <td width="106" align="right"><b><font face="Arial" size="2">&nbsp;</font></b></td>
		     <td width="6"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     </tr>
		     <tr>
		     <td width="25"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="123"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="1"><font face="Arial" size="1"><b>&nbsp;</b></font></td>
		     <td width="507" colspan="3">
		     <p align="right"><font face="Arial" size="1"><b>________________________________________</b></font></td>
		     <td width="6"><b><font face="Arial" size="1">&nbsp;</font></b></td>
		     </tr>
		     <tr valgin="top">
		     <td width="453" colspan="7"><font face="Arial" size="1"><b>&nbsp;</b></font><font face="MICR US" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c<!-- <%# DataBinder.Eval(Container, "DataItem.CheckNumber")%>c&nbsp;&nbsp;a<%# DataBinder.Eval(Container, "DataItem.RoutingCode")%>a&nbsp;<%# DataBinder.Eval(Container, "DataItem.BankAccountNumber")%> -->c</font></td>
		     </tr>
		     <tr>
		     <td width="25">&nbsp;</td>
		     <td width="123">&nbsp;</td>
		     <td width="1">&nbsp;</td>
		     <td width="396">&nbsp;</td>
		     <td width="5">&nbsp;</td>
		     <td width="106" align="right">&nbsp;</td>
		     <td width="6">&nbsp;</td>
		     </tr>
		     </table>
		   */ ?>
	    <div class="col-md-12 col-xs-12 invoice-table-detail" style="margin-top:20px; border:1px solid black;  height:300px; padding:0px">

		<table class="col-md-12 col-xs-12">
		    <thead>
			<tr class="row-header">
			    <th style="width:140px">
				Invoice Number
			    </th>
			    <th style="width: 80px">
				Invoice Date
			    </th>
			    <th style="width:80px">
				Invoice Amount
			    </th>
			</tr>
		    </thead>
		    <tbody>
			<?php if($detailData): ?>
			    <?php foreach($detailData as $row): ?>
				<tr>
				    <td>
					<?php echo $row["InvoiceNumber"]; ?>
				    </td>
				    <td>
					<?php echo $row["InvoiceDate"]; ?>
				    </td>
				    <td>
					<?php echo $data->getCurrencySymbol()["symbol"] . $row["InvoiceAmount"]; ?>
				    </td>
				</tr>
			    <?php endforeach; ?>
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
    </div>
    <script>
     var amount = "<?php echo $headerData["CheckAmount"]; ?>";
     var am = amount.replace(/\,/g,'').split('.');
     $('#towords').text(numberToWords.toWords(am[0]) + " and " + (am[1] ? am[1] + "/100" : "00/100"));
     $('.towords').text(numberToWords.toWords(am[0]) + " and " + (am[1] ? am[1] + "/100" : "00/100"));
    </script>
<?php endif; ?>
