<!-- Left navbar-header -->
<div class="navbar-default sidebar" role="navigation" style="position:absolute; top:-50px; z-index:5000">
    <div class="sidebar-nav navbar-collapse slimscrollsidebar">
	<?php include './views/nav/leftUser.php'; ?>
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
	    
	    <li> <a href="index.php?page=index#tasks" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Tasks');  ?> </span></a></li>
	    
	    <li>
		<a href="index.php?page=index#chat" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Chat');  ?> </span>
		</a>
	    </li>

	    <li class="nav-small-cap">--- Main Menu</li>
	    <?php
	    $menuCategories = [];
	    if($scope->user["accesspermissions"]["GLView"]){
		$menuCategories["GeneralLedger"] = [
		    "id" => "GeneralLedger",
		    "full"=> $translation->translateLabel('General Ledger'),
		    "short" => "GL",
		    "type" => "submenu",
		    "data" => [
			[
			    "id" => "GeneralLedger/chartOfAccounts",
			    "full" => $translation->translateLabel('Chart Of Accounts'),
			    "short" => "CO",
			    "href"=> $public_prefix . "GeneralLedger/chartOfAccounts"
			],
			[
			    "id" => "GeneralLedger/ledgerAccountGroup",
			    "full" => $translation->translateLabel('Ledger Account Group'),
			    "short" => "LA",
			    "href" => $public_prefix . "GeneralLedger/ledgerAccountGroup"
			],
			[
			    "id" => "GeneralLedger/bankTransactions",
			    "full" => $translation->translateLabel('Bank Transactions'),
			    "short" => "BT",
			    "href" => $public_prefix . "GeneralLedger/bankTransactions"
			],
			[
			    "id" => "GeneralLedger/bankAccounts",
			    "full" => $translation->translateLabel('Bank Accounts'),
			    "short" => "BA",
			    "href" => $public_prefix . "GeneralLedger/bankAccounts"
			]
		    ]
		];
	    }

	    $menuCategories['Receivables'] = [
		"type" => "submenu",
		"id" => "Receivables",
		"full" => $translation->translateLabel('Receivables'),
		"short" => "AR",
		"data" => [
		    [
			"id" => "Receivables/Quotes",
			"full" => $translation->translateLabel('Quotes'),
			"short" => "Qu",
			"href"=> "#"
		    ],
		    [
			"id" => "Receivables/Orders",
			"full" => $translation->translateLabel('Orders'),
			"short" => "Or",
			"href" => "#"
		    ],
		    [
			"id" => "Receivables/Invoices",
			"full" => $translation->translateLabel('Invoices'),
			"short" => "In",
			"href" => "#"
		    ]
		]
	    ];
	    
	    $menuCategories["Payables"] = [
		"type" => "submenu",
		"id" => "Payables",
		"full" => $translation->translateLabel('Payables'),
		"short" => "AP",
		"data" => [
		    [
			"id" => "Payables/PurchaseOrders",
			"full" => $translation->translateLabel('Purchase Orders'),
			"href"=> "#",
			"short" => "PO"
		    ],
		    [
			"id" => "Payables/Vouchers",
			"full" => $translation->translateLabel('Vouchers'),
			"href" => "#",
			"short" => "Vo"
		    ],
		    [
			"id" => "Payables/Vendors",
			"full" => $translation->translateLabel('Vendors'),
			"href" => "#",
			"short" => "Ve"
		    ]
		]
	    ];
	    ?>

	    <?php
	    foreach ($menuCategories as $key=>$item){
		if($item["type"] == "item")
		    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $item["data"]["href"] . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
		else if($item["type"] == "submenu"){			

		    echo "<li  id=\"list" . $item["id"] . "\"><a href=\"javascript:void(0);\" class=\"waves-effect\"><i class=\"icon-people fa-fw\"></i> <span class=\"hide-menu\">" . $item["full"] . "<span class=\"fa arrow\"></span></span></a>";
		    echo "<ul class=\"nav nav-second-level\">";
		    foreach($item["data"] as $key=>$subitem){
			echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\"><a href=\"index.php?page=grid&action=" . $subitem["href"] . "\">" . $subitem["full"] . "</a></li>";
		    }
		    echo "</ul></li>";
		}
	    }
	    ?>

	    <li class="nav-small-cap">--- Support</li>
	    <li>
		<a href="https://stfbinc.helpdocs.com" Target="_Blank" class="waves-effect">
		    <i class="icon-docs fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Help Documentation"); ?></span>
		</a>
	    </li>
	    <li>
		<a href="https://stfbinc.teamwork.com/support/" Target="_Blank" class="waves-effect">
		    <i class="icon-support fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Support Ticket"); ?></span>
		</a>
	    </li> 
	    

	    <li>
		<a href="index.php?page=index&logout=true" class="waves-effect">
		    <i class="icon-logout fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Log out"); ?></span>
		</a>
	    </li>
	    
	</ul>
    </div>
    <script>
     function changeLanguage(event){
	 $.getJSON("index.php?page=language&setLanguage=" + event.target.value)
	  .success(function(data) {
	      location.reload();
	  })
	  .error(function(err){
	      console.log('something going wrong');
	  });
     }
    </script>
</div>
<!-- Left navbar-header end -->
