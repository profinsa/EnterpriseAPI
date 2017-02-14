<!-- Left navbar-header -->
<div class="navbar-default sidebar" role="navigation" style="position:absolute; top:-50px; z-index:5000">
    <div class="sidebar-nav navbar-collapse slimscrollsidebar">
	<?php include 'leftUser.php'; ?>
	<ul class="nav" id="side-menu">
	    
	    <li class="sidebar-search hidden-sm hidden-md hidden-lg">
		<!-- input-group -->
		<div class="input-group custom-search-form">
		    <input type="text" class="form-control" placeholder="Search...">
		    <span class="input-group-btn">
			<button class="btn btn-default" type="button"> <i class="fa fa-search"></i> </button>
		    </span> </div>
		<!-- /input-group -->
	    </li>
	    <li class="nav-small-cap m-t-10">--- My Menu</li>
	    <li> <a href="index.php?page=index" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Dashboard'); ?> </span></a></li>
	    
	    <li> <a href="index.php?page=index#tasks" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Dashboard');  ?> </span></a></li>
	    
	    <li>
		<a href="index.php?page=index#chat" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Chat');  ?> </span>
		</a>
	    </li>
	    
	    <li class="nav-small-cap">--- Main Menu</li>
	    
	    <li><a href="javascript:void(0);" class="waves-effect"><i class="icon-people fa-fw"></i> <span class="hide-menu"><?php echo $translation->translateLabel('General Ledger');  ?><span class="fa arrow"></span><span class="label label-rouded label-info pull-right">3</span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="index.php?page=GeneralLedger/chartsOfAccount"><?php echo $translation->translateLabel('Chart Of Accounts');  ?></a></li>
		    <li> <a href="crm-add-leads.html"><?php echo $translation->translateLabel('Ledger Transactions');  ?></a></li>
		    <li> <a href="crm-edit-leads.html"><?php echo $translation->translateLabel('Bank Accounts');  ?></a></li> 
		</ul>
	    </li>
	    
	    
	    <li><a href="javascript:void(0);" class="waves-effect"><i class="icon-people fa-fw"></i> <span class="hide-menu"><?php echo $translation->translateLabel('Receivables');  ?><span class="fa arrow"></span><span class="label label-rouded label-info pull-right">3</span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="crm-leads.html"><?php echo $translation->translateLabel('Quotes');  ?></a></li>
		    <li> <a href="crm-add-leads.html"><?php echo $translation->translateLabel('Orders');  ?></a></li>
		    <li> <a href="crm-edit-leads.html"><?php echo $translation->translateLabel('Invoices');  ?></a></li> 
		</ul>
	    </li>
	    
	    
	    <li><a href="javascript:void(0);" class="waves-effect"><i class="icon-people fa-fw"></i> <span class="hide-menu"><?php echo $translation->translateLabel('Payables');  ?><span class="fa arrow"></span><span class="label label-rouded label-info pull-right">3</span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="crm-leads.html"><?php echo $translation->translateLabel('Purchase Orders');  ?></a></li>
		    <li> <a href="crm-add-leads.html"><?php echo $translation->translateLabel('Vouchers');  ?></a></li>
		    <li> <a href="crm-edit-leads.html"><?php echo $translation->translateLabel('Vendors');  ?></a></li> 
		</ul>
	    </li>
	    
	    
	    
	    
	    
	    <li class="nav-small-cap">--- Support</li>
	    
	    <li> <a href="https://stfbinc.helpdocs.com" Target="_Blank">Help Documentation</a></li>
	    <li> <a href="https://stfbinc.teamwork.com/support/" Target="_Blank">Support Ticket</a></li> 
	    

	    <li><a href="index.php?page=index&logout=true" class="waves-effect"><i class="icon-logout fa-fw"></i> <span class="hide-menu"><?php echo $translation->translateLabel("Log out"); ?></span></a></li>

	    
	</ul>
    </div>
</div>
<!-- Left navbar-header end -->
