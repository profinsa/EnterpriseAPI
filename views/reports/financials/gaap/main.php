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
<div class="container-fluid">
    <?php
    require __DIR__ . '/../../../uiItems/dashboard.php';
    // require __DIR__ . '/format.php';
    ?>
    
    <div class="col-sm-12 white-box">
	<div id="report" class="row">
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
		 bss : "index.php?page=financials&type=gaap&module=BalanceSheetStandard",
		 bsp : "index.php?page=financials&type=gaap&module=BalanceSheetPeriod",
		 bsd : "index.php?page=financials&type=gaap&module=BalanceSheetDivision",
		 bsdp : "index.php?page=financials&type=gaap&module=BalanceSheetDivisionPeriod",
		 bsc : "index.php?page=financials&type=gaap&module=BalanceSheetCompany",
		 bscp : "index.php?page=financials&type=gaap&module=BalanceSheetCompanyPeriod",
		 
		 iss : "index.php?page=financials&type=gaap&module=IncomeStatementStandard",
		 isp : "index.php?page=financials&type=gaap&module=IncomeStatementPeriod",
		 isd : "index.php?page=financials&type=gaap&module=IncomeStatementDivision",
		 isdp : "index.php?page=financials&type=gaap&module=IncomeStatementDivisionPeriod",
		 isc : "index.php?page=financials&type=gaap&module=IncomeStatementCompany",
		 iscp : "index.php?page=financials&type=gaap&module=IncomeStatementCompanyPeriod",
		 
		 dcs : "index.php?page=financials&type=gaap&module=CashFlowStandard",
		 dcp : "index.php?page=financials&type=gaap&module=CashFlowPeriod",
		 dcd : "index.php?page=financials&type=gaap&module=CashFlowDivision",
		 dcdp : "index.php?page=financials&type=gaap&module=CashFlowDivisionPeriod",
		 dcc : "index.php?page=financials&type=gaap&module=CashFlowCompany",
		 dccp : "index.php?page=financials&type=gaap&module=CashFlowCompanyPeriod",
		 
		 tbs : "index.php?page=financials&type=gaap&module=TrialBalanceStandard",
		 tbd : "index.php?page=financials&type=gaap&module=TrialBalanceDivision",
		 tbc : "index.php?page=financials&type=gaap&module=TrialBalanceCompany"
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
		     elem.href = basicUrls[ind] + "&" + $.param(urlParams);
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
    </div>
</div>
