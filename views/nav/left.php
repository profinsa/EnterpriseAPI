<!-- Left navbar-header -->
<div class="navbar-default sidebar" role="navigation">
    
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
	    <li class="nav-small-cap m-t-10">--- Main Menu</li>
	    <li> <a href="index.html" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> Dashboard </span></a></li>
	    <li><a href="javascript:void(0);" class="waves-effect"><i data-icon=")" class="linea-icon linea-basic fa-fw"></i> <span class="hide-menu">Mailbox<span class="fa arrow"></span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="inbox.html">Inbox</a></li>
		    <li> <a href="inbox-detail.html">Inbox detail</a></li>
		    <li> <a href="compose.html">Compose mail</a></li> 
		</ul>
	    </li>
	    <li class="nav-small-cap">--- Proffessional</li>
	    <li><a href="javascript:void(0);" class="waves-effect"><i class="icon-people fa-fw"></i> <span class="hide-menu">Leads<span class="fa arrow"></span><span class="label label-rouded label-info pull-right">3</span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="crm-leads.html">All Leads</a></li>
		    <li> <a href="crm-add-leads.html">Add Leads</a></li>
		    <li> <a href="crm-edit-leads.html">Edit Leads</a></li> 
		</ul>
	    </li>
	    <li class="nav-small-cap">--- Support</li>
	    <!-- <li> <a href="javascript:void(0)" class="waves-effect"><i data-icon="F" class="linea-icon linea-software fa-fw"></i> <span class="hide-menu">Multi-Level Dropdown<span class="fa arrow"></span></span></a>
		<ul class="nav nav-second-level">
		    <li> <a href="javascript:void(0)">Second Level Item</a> </li>
		    <li> <a href="javascript:void(0)">Second Level Item</a> </li>
		    <li> <a href="javascript:void(0)" class="waves-effect">Third Level <span class="fa arrow"></span></a>
			<ul class="nav nav-third-level">
			    <li> <a href="javascript:void(0)">Third Level Item</a> </li>
			    <li> <a href="javascript:void(0)">Third Level Item</a> </li>
			    <li> <a href="javascript:void(0)">Third Level Item</a> </li>
			    <li> <a href="javascript:void(0)">Third Level Item</a> </li>
			</ul>
		    </li>
		</ul>
	    </li> -->
	    <li><a href="index.php?page=login" class="waves-effect"><i class="icon-logout fa-fw"></i> <span class="hide-menu"><?php echo $translation->translateLabel("Log out"); ?></span></a></li>
	    <!-- <li class="hide-menu">
		<a href="javacript:void(0);">         
		    <span>Progress Report</span>
		    <div class="progress">
			<div class="progress-bar progress-bar-info" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%" role="progressbar"> <span class="sr-only">85% Complete (success)</span> </div>
		    </div>
		    <span>Leads Report</span>
		    <div class="progress">
			<div class="progress-bar progress-bar-danger" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%" role="progressbar"> <span class="sr-only">85% Complete (success)</span> </div>
		    </div>
		</a> 
	    </li> -->
	</ul>
    </div>
</div>
<!-- Left navbar-header end -->
