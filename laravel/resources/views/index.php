<!DOCTYPE html>
<!-- saved from url=(0046)http://demo.espocrm.com/basic/?lang=en_US#Lead -->
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><?php echo $app->title; ?></title>
 	<?php
	if(isset($header))
	    require $header;
	?>
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="description" content="">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
    </head>
    <?php
    $menuCategories = [];
/*    if($user["accesspermissions"]["GLView"]){
	$menuCategories["Ledger"] = [
	    "id" => "Ledger",
	    "full"=> $translation->translateLabel('Ledger'),
	    "short" => "GL",
	    "type" => "submenu",
	    "data" => [
		[
		    "id" => "GeneralLedger/chartOfAccounts",
		    "full" => $translation->translateLabel('Chart Of Accounts'),
		    "short" => "CO",
		    "href"=> "GeneralLedger/./chartOfAccounts"
		],
		[
		    "id" => "GeneralLedger/ledgerAccountGroup",
		    "full" => $translation->translateLabel('Ledger Account Group'),
		    "short" => "LA",
		    "href" => "GeneralLedger/./ledgerAccountGroup"
		],
		[
		    "id" => "GeneralLedger/bankTransactions",
		    "full" => $translation->translateLabel('Bank Transactions'),
		    "short" => "BT",
		    "href" => "GeneralLedger/./bankTransactions"
		],
		[
		    "id" => "GeneralLedger/bankAccounts",
		    "full" => $translation->translateLabel('Bank Accounts'),
		    "short" => "BA",
		    "href" => "GeneralLedger/./bankAccounts"
		]
	    ]
	];
    }*/
/*
    $menuCategories["Payables"] = [
	"type" => "submenu",
	"id" => "Payables",
	"full" => $translation->translateLabel('Accounts Payable'),
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
    ];*/

    require "menuCategoriesGenerated.php";

    $menuCategories["Documentation"] = [
	"type" => "item",
	"data" => [
	    "id" => "Documentation",
	    "full" => $translation->translateLabel('Help Documentation'),
	    "short" => "HD",
	    "href" => "https://stfbinc.helpdocs.com",
	    "Target" => "_Blank"
	]
    ];
    
    $menuCategories["SupportTicket"] = [
	"type" => "item",
	"data" => [
	    "id" => "Support",
	    "full" => $translation->translateLabel('Support Ticket'),
	    "short" => "ST",
	    "href" => "https://stfbinc.teamwork.com/support/",
	    "Target" => "_Blank"
	]
    ];
     
    ?>
    <body onload="main();" style="min-height: 800px;" class="">
	<script>
	 var menuCategories = <?php echo json_encode($menuCategories); ?>;
	 function findMenuItem(href){
	     var ind, sind, submenu, iind, items;
	     for(ind in menuCategories){
		 items = menuCategories[ind].data;
		 for(iind in items){
		     if(items[iind].type == "item"){
			 if(href.match(items[iind].href))
			     return {
				 menu : menuCategories[ind],
				 item : items[iind]
			     };
		     }else if(items[iind].type == "submenu"){
			 submenu = items[iind].data;
			 for(sind in submenu){
			     if(href.match(items[iind].href))
				 return {
				     menu : menuCategories[ind],
				     submenu : items[iind],
				     item : submenu[sind]
			     };
			 }
		     }
		 }
	     }
	     return undefined;
	 }
	 //	 console.log(JSON.stringify(menuCategories, null, 3));
	</script>
	<header id="header">
	    <div id="navbar">
		<div class="navbar navbar-inverse" role="navigation">
		    <div class="navbar-header top-bar logo-container">
			<a class="navbar-brand nav-link logo-link" href="<?php echo $public_prefix; ?>/index#/dashboard"><img id="logosection"  src="<?php echo $public_prefix; ?>/assets/images/logo.png" class="logo"><span class="home-icon glyphicon glyphicon-th-large" title="Home"></span></a>
			<button type="button" class="navbar-toggle hide-on-small" data-toggle="collapse" data-target=".navbar-body">
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			</button>
		    </div>

		    <div class="collapse navbar-collapse navbar-body">
			<?php  require "nav/sidebar.php"; ?>
			<?php  require "nav/topbar.php"; ?>
		    </div>
		</div>
	    </div>
	</header>
	<a class="minimizer top-bar-shower-off top-bar-toggler" href="javascript:toggleTopBar()">
	    <span id="topBarShower" class="glyphicon glyphicon glyphicon-menu-down"></span>
	</a>
	<?php require "footer.php"; ?>
	<div id="content" class="container content top-bar-offset" style="background: #ffffff">
	    <?php
	    if(isset($content))
		require $content;
	    ?>
	</div>
	<div id="popup-notifications-container" class="hidden"></div>
	<script>
	 /*
	    parsing window.location, loading page and insert to content section. Main entry point of SAP
	 */
	 function onlocation(location){
	     var path = new String(location);
	     var match;
	     if(path.search(/index\#\//) != -1){
		 path = path.replace(/index\#\//, "");
		 match = path.match(/grid\/(\w+)\/\w+\/(\w+)\//);
//		 console.log();
		 if(match)
		     sideBarSelectItem(findMenuItem(path));//match[1], match[2]);
		 else{
		     sideBarCloseAll();
		     sideBarDeselectAll();
		 }
		 $.get(path + "?partial=true")
		  .done(function(data){
		      setTimeout(function(){
			  $("#content").html(data);
			  window.scrollTo(0,0);
		      },0);
		  })
		  .error(function(){
//		      window.location = "<?php echo $public_prefix; ?>/login";
		      window.location = "<?php echo $public_prefix; ?>/ByPassLogin";
		  });
	     }
	 }

	 onlocation(window.location);
	 $(window).on('hashchange', function() {
	     onlocation(window.location);
	 });

	 //select sidebar item if application loaded in separated pages mode, like that: grid/GeneralLedger/ledgerAccountGroup/grid/main/all, without index#/
	 function main(){
	     <?php if(isset($scope)): ?>
	     sideBarSelectItem("<?php echo  $scope["pathFolder"] . "\",\"" . $scope["pathPage"];?>");
	     <?php endif; ?>
	 }
	</script>
    </body>
</html>
