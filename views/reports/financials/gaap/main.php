<!-- 
     Name of Page: financials gaap main page

     Method: render page with selecting gaap financials reports

     Date created: Nikita Zaharov, 26.04.2016

     Use: this model used for 
   - for loading data using stored procedures

     Input parameters:
     nothing

     Output parameters:
   - just redirect to other pages

     Called from:
     controllers/financials

     Calls:
     nothing, just make redirect

     Last Modified: 27.04.2016
     Last Modified by: Nikita Zaharov
   -->
<div id="report" class="row">
    <div class="col-md-12 col-xs-12">
	<h2 style="text-align:center">
	    <?php echo $translation->translateLabel("GAAP Financial Statements");?>
	</h2>
    </div>
    <div class="col-md-3 col-xs-12">
	<div class="form-group">
	    <label for="iyear"><?php echo $translation->translateLabel("Year");?></label>
	    <select id="iyear" class="form-control">
		<option value="1">
		    Previous Fiscal Year
		</option>
		<option value="0">
		    Current Fiscal Year
		</option>
	    </select>
	</div>
	<div class="form-group">
	    <label for="iperiod"><?php echo $translation->translateLabel("Period");?></label>
	    <select id="iperiod" class="form-control">
		<option>
		    1
		</option>
		<option>
		    2
		</option>
		<option>
		    3
		</option>
		<option>
		    4
		</option>
		<option>
		    5
		</option>
		<option>
		    6
		</option>
		<option>
		    7
		</option>
		<option>
		    8
		</option>
		<option>
		    9
		</option>
		<option>
		    10
		</option>
		<option>
		    11
		</option>
		<option>
		    12
		</option>
	    </select>
	</div>
	<div class="form-group">
	    <label for="itype">Report Type</label>
	    <select id="itype" class="form-control">
		<option>
		    Standard
		</option>
		<option>
		    YTD
		</option>
		<option>
		    Comparative
		</option>
	    </select>
	</div>
    </div>
    <div class="col-md-9 col-xs-12">
	<table class="table gaap-main-table">
	    <tbody>
		<tr class="top-row">
		    <td style="border: 0px;"></td>
		    <td>Standard</td>
		    <td>By Period</td>
		    <td>Division</td>
		    <td>Division by Period</td>
		    <td>Company</td>
		    <td>Company by Period</td>
		</tr>
		<tr>
		    <td>
			Balance Sheet
		    </td>
		    <td>
			<a id="bss"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="bsp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="bsd"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="bsdp"<span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="bsc"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="bscp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		</tr>
		<tr>
		    <td>
			Income Statement
		    </td>
		    <td>
			<a id="iss"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="isp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="isd"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="isdp"<span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="isc"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="iscp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		</tr>
		<tr>
		    <td>
			Direct Cash Flow
		    </td>
		    <td>
			<a id="dcs"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="dcp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="dcd"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="dcdp"<span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="dcc"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
			<a id="dccp"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		</tr>
		<tr>
		    <td>
			Trial Balance
		    </td>
		    <td>
			<a id="tbs"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
		    </td>
		    <td>
			<a id="tbd"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
		    </td>
		    <td>
			<a id="tbc"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		    </td>
		    <td>
		    </td>
		</tr>
	    </tbody>
	</table>
    </div>
</div>
<script>
 (function(){
     var basicUrls = {
	 bss : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetStandard/0" ?>",
	 bsp : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetPeriod/0" ?>",
	 bsd : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetDivision/0" ?>",
	 bsdp : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetDivisionPeriod/0" ?>",
	 bsc : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetCompany/0" ?>",
	 bscp : "<?php echo $public_prefix . "/financials/gaap/BalanceSheetCompanyPeriod/0" ?>",
	 
	 iss : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementStandard/0" ?>",
	 isp : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementPeriod/0" ?>",
	 isd : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementDivision/0" ?>",
	 isdp : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementDivisionPeriod/0" ?>",
	 isc : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementCompany/0" ?>",
	 iscp : "<?php echo $public_prefix . "/financials/gaap/IncomeStatementCompanyPeriod/0" ?>",
	 
	 dcs : "<?php echo $public_prefix . "/financials/gaap/CashFlowStandard/0" ?>",
	 dcp : "<?php echo $public_prefix . "/financials/gaap/CashFlowPeriod/0" ?>",
	 dcd : "<?php echo $public_prefix . "/financials/gaap/CashFlowDivision/0" ?>",
	 dcdp : "<?php echo $public_prefix . "/financials/gaap/CashFlowDivisionPeriod/0" ?>",
	 dcc : "<?php echo $public_prefix . "/financials/gaap/CashFlowCompany/0" ?>",
	 dccp : "<?php echo $public_prefix . "/financials/gaap/CashFlowCompanyPeriod/0" ?>",
	 
	 tbs : "<?php echo $public_prefix . "/financials/gaap/TrialBalanceStandard/0" ?>",
	 tbd : "<?php echo $public_prefix . "/financials/gaap/TrialBalanceDivision/0" ?>",
	 tbc : "<?php echo $public_prefix . "/financials/gaap/TrialBalanceCompany/0" ?>"
     }

     var urlParams = {
	 year : "0",
	 period : "0",
	 itype : "Standard"
     };

     function setUrls(){
	 var ind, elem;
	 for(ind in basicUrls){
	     elem = document.getElementById(ind);
	     elem.href = basicUrls[ind] + "?" + $.param(urlParams);
	     elem.target = "_Blank";
	 }
     }
     setUrls();

     $("#iyear").change(function(e){
	 urlParams.year = e.target.value;
	 setUrls();
     });
     $("#iperiod").change(function(e){
	 urlParams.period = e.target.value;
	 setUrls();
     });
     $("#itype").change(function(e){
	 urlParams.itype = e.target.value;
	 setUrls();
     });
     
 })()
</script>
